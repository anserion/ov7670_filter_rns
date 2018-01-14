------------------------------------------------------------------
--Copyright 2017 Andrey S. Ionisyan (anserion@gmail.com)
--Licensed under the Apache License, Version 2.0 (the "License");
--you may not use this file except in compliance with the License.
--You may obtain a copy of the License at
--    http://www.apache.org/licenses/LICENSE-2.0
--Unless required by applicable law or agreed to in writing, software
--distributed under the License is distributed on an "AS IS" BASIS,
--WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--See the License for the specific language governing permissions and
--limitations under the License.
------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Engineer: Andrey S. Ionisyan <anserion@gmail.com>
-- 
-- Description: sdram supervisor.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sdram_supervisor is
   generic(
      filter1_x_min: natural range 0 to 1023 := 128;
      filter1_y_min: natural range 0 to 1023 := 16;
      filter1_x_max: natural range 0 to 1023 := 255;
      filter1_y_max: natural range 0 to 1023 := 248;

      filter2_x_min: natural range 0 to 1023 := 256;
      filter2_y_min: natural range 0 to 1023 := 16;
      filter2_x_max: natural range 0 to 1023 := 384;
      filter2_y_max: natural range 0 to 1023 := 248
      );
   Port ( 
      clk : in std_logic;
      en  : in std_logic;
      vga_en    : in std_logic;
      lcd_en    : in std_logic;
      cam_en    : in std_logic;
      filter1_en              : in std_logic;
      filter2_en              : in std_logic;

      sdram_rd_req   : out std_logic; 
      sdram_rd_valid : in std_logic;
      sdram_wr_req   : out std_logic;
      sdram_rd_addr  : out std_logic_vector(23 downto 0);
      sdram_wr_addr  : out std_logic_vector(23 downto 0);
      sdram_rd_data  : in std_logic_vector(15 downto 0);
      sdram_wr_data  : out std_logic_vector(15 downto 0);

      vga_width : in std_logic_vector(9 downto 0);
      vga_y     : in std_logic_vector(9 downto 0);
      vga_vsync : in std_logic;
      vga_wr_en : out std_logic;
      vga_wr_addr: out std_logic_vector(9 downto 0);
      vga_wr_data: out std_logic_vector(15 downto 0);

      lcd_width : in std_logic_vector(9 downto 0);
      lcd_y     : in std_logic_vector(9 downto 0);
      lcd_vsync : in std_logic;
      lcd_wr_en : out std_logic;
      lcd_wr_addr: out std_logic_vector(9 downto 0);
      lcd_wr_data: out std_logic_vector(15 downto 0);

      filter1_scanline_ask    : in std_logic;
      filter1_scanline_ack    : out std_logic;
      filter1_scanline_ready  : out std_logic;
      filter1_scanline_wr_addr: out std_logic_vector(9 downto 0);
      filter1_scanline_y      : in std_logic_vector(9 downto 0);
      filter1_scanline_wr_data: out std_logic_vector(15 downto 0);
      filter1_scanline_we     : out std_logic;

      filter2_scanline_ask    : in std_logic;
      filter2_scanline_ack    : out std_logic;
      filter2_scanline_ready  : out std_logic;
      filter2_scanline_wr_addr: out std_logic_vector(9 downto 0);
      filter2_scanline_y      : in std_logic_vector(9 downto 0);
      filter2_scanline_wr_data: out std_logic_vector(15 downto 0);
      filter2_scanline_we     : out std_logic;
      
      cam_width : in std_logic_vector(9 downto 0);
      cam_y     : in std_logic_vector(9 downto 0);
      cam_rd_addr  : out std_logic_vector(9 downto 0);
      cam_rd_data0 : in std_logic_vector(15 downto 0);
      cam_rd_data1 : in std_logic_vector(15 downto 0);

      filter1_res_y       : in std_logic_vector(9 downto 0);
      filter1_res_rd_addr : out std_logic_vector(9 downto 0);
      filter1_res_rd_data0: in std_logic_vector(15 downto 0);
      filter1_res_rd_data1: in std_logic_vector(15 downto 0);
      
      filter2_res_y       : in std_logic_vector(9 downto 0);
      filter2_res_rd_addr : out std_logic_vector(9 downto 0);
      filter2_res_rd_data0: in std_logic_vector(15 downto 0);
      filter2_res_rd_data1: in std_logic_vector(15 downto 0)
	);
end sdram_supervisor;

architecture Behavioral of sdram_supervisor is

   signal fsm: natural range 0 to 31 := 0;
   signal sdram_x : std_logic_vector(9 downto 0) := (others => '0');
   signal sdram_y : std_logic_vector(9 downto 0) := (others => '0');
   signal vga_parity,lcd_parity,cam_parity,filter1_parity,filter2_parity: std_logic:='0';
   signal filter1_scanline_ack_reg,filter2_scanline_ack_reg: std_logic:='0';
begin
   filter1_scanline_ack<=filter1_scanline_ack_reg;
   filter2_scanline_ack<=filter2_scanline_ack_reg;

   process(clk)
   begin
      if rising_edge(clk) and en='1' then
         case fsm is
         --------------------------------
         -- sdram to vga device section
         --------------------------------
         when 0 => 
            if vga_en='1' and vga_vsync='0' and vga_y(0)=vga_parity
            then
               sdram_x<=(others=>'0');
               sdram_y<=vga_y;
               sdram_rd_req<='1';
               sdram_wr_req<='0';
               vga_wr_en<='1';
               vga_parity<=not(vga_parity);
               fsm<=1;
            else 
               sdram_rd_req<='0';
               sdram_wr_req<='0';
               fsm <= 3;
            end if;
         when 1 =>
            if sdram_x/=vga_width
            then
               sdram_x<=sdram_x+1;
               if (sdram_x>=filter1_x_min and sdram_x<filter1_x_max 
                  and sdram_y>=filter1_y_min and sdram_y<filter1_y_max)
                  or
                  (sdram_x>=filter2_x_min and sdram_x<filter2_x_max 
                  and sdram_y>=filter2_y_min and sdram_y<filter2_y_max)
               then
                  sdram_rd_addr <= "01" & "00" & sdram_y & sdram_x;
               else
                  sdram_rd_addr <= "00" & "00" & sdram_y & sdram_x;
               end if;
               fsm<=2;
            else
               sdram_rd_req<='0';
               sdram_wr_req<='0';
               vga_wr_en<='0';
               fsm<=6;
            end if;
         when 2 =>
            if sdram_rd_valid='1' then
               vga_wr_addr<=sdram_x;
               vga_wr_data<=sdram_rd_data;
               fsm<=1;
            end if;

         --------------------------------
         -- sdram to lcd device section
         --------------------------------
         when 3 => 
            if lcd_en='1' and lcd_vsync='0' and lcd_y(0)=lcd_parity
            then
               sdram_x<=(others=>'0');
               sdram_y<=lcd_y;
               sdram_rd_req<='1';
               sdram_wr_req<='0';
               lcd_wr_en<='1';
               lcd_parity<=not(lcd_parity);
               fsm<=4;
            else 
               sdram_rd_req<='0';
               sdram_wr_req<='0';
               fsm <= 6;
            end if;
         when 4 =>
            if sdram_x/=lcd_width
            then
               sdram_x<=sdram_x+1;
               if (sdram_x>=filter1_x_min and sdram_x<filter1_x_max 
                  and sdram_y>=filter1_y_min and sdram_y<filter1_y_max)
                  or
                  (sdram_x>=filter2_x_min and sdram_x<filter2_x_max 
                  and sdram_y>=filter2_y_min and sdram_y<filter2_y_max)
               then
                  sdram_rd_addr <= "01" & "00" & sdram_y & sdram_x;
               else
                  sdram_rd_addr <= "00" & "00" & sdram_y & sdram_x;
               end if;
               fsm<=5;
            else
               sdram_rd_req<='0';
               sdram_wr_req<='0';
               lcd_wr_en<='0';
               fsm<=6;
            end if;
         when 5 =>
            if sdram_rd_valid='1' then
               lcd_wr_addr<=sdram_x;
               lcd_wr_data<=sdram_rd_data;
               fsm<=4;
            end if;
            
         -------------------------------------
         -- camera to sdram section
         -------------------------------------
         when 6 =>
            if cam_en='1' and cam_y(0)=cam_parity then
               sdram_x<=(others=>'0');
               cam_rd_addr<=(others=>'0');
               sdram_y<=cam_y;
               sdram_rd_req<='0';
               sdram_wr_req<='1';
               cam_parity<=not(cam_parity);
               fsm<=7;
            else
               sdram_rd_req<='0';
               sdram_wr_req<='0';
               fsm<=11;
            end if;
         when 7 =>
            if sdram_x/=cam_width then
               if cam_parity='0' then sdram_wr_data <= cam_rd_data0;
               else sdram_wr_data <= cam_rd_data1;
               end if;
               sdram_wr_addr <= "00" & "00" & sdram_y & sdram_x;
               fsm <= 8;
            else
               sdram_rd_req<='0';
               sdram_wr_req<='0';
               fsm<=11;
            end if;
         when 8 =>
            sdram_x<=sdram_x+1;
            fsm<=9;
         when 9 =>
            cam_rd_addr<=sdram_x;
            fsm<=10;
         when 10 => fsm<=7;

         ----------------------------
         -- filter1 to sdram section
         ----------------------------
         when 11 =>
            if filter1_en='1' and filter1_res_y(0)=filter1_parity
            then
               sdram_x<=conv_std_logic_vector(filter1_x_min,10);
               sdram_y<=filter1_res_y;
               filter1_res_rd_addr<=conv_std_logic_vector(filter1_x_min,10);
               filter1_parity<=not(filter1_parity);
               sdram_rd_req<='0';
               sdram_wr_req<='1';
               fsm<=12;
            else
               sdram_rd_req<='0';
               sdram_wr_req<='0';
               fsm<=17;
            end if;
         when 12 =>
            if sdram_x/=filter1_x_max then
               if filter1_parity='0' then sdram_wr_data <= filter1_res_rd_data0;
               else sdram_wr_data <= filter1_res_rd_data1;
               end if;
               sdram_wr_addr <= "01" & "00" & sdram_y & sdram_x;
               fsm <= 13;
            else
               sdram_rd_req<='0';
               sdram_wr_req<='0';
               fsm<=17;
            end if;
         when 13 =>
            sdram_x<=sdram_x+1;
            fsm<=14;
         when 14 =>
            filter1_res_rd_addr<=sdram_x;
            fsm<=15;
         when 15 => fsm<=16;
         when 16 => fsm<=12;
         
         ----------------------------
         -- filter2 to sdram section
         ----------------------------
         when 17 =>
            if filter2_en='1' and filter2_res_y(0)=filter2_parity
            then
               sdram_x<=conv_std_logic_vector(filter2_x_min,10);
               sdram_y<=filter2_res_y;
               filter2_parity<=not(filter2_parity);
               filter2_res_rd_addr<=conv_std_logic_vector(filter2_x_min,10);
               sdram_rd_req<='0';
               sdram_wr_req<='1';
               fsm<=18;
            else
               sdram_rd_req<='0';
               sdram_wr_req<='0';
               fsm<=24;
            end if;
         when 18 =>
            if sdram_x/=filter2_x_max then
               if filter2_parity='0' then sdram_wr_data <= filter2_res_rd_data0;
               else sdram_wr_data <= filter2_res_rd_data1;
               end if;
               sdram_wr_addr <= "01" & "00" & sdram_y & sdram_x;
               fsm <= 19;
            else
               sdram_rd_req<='0';
               sdram_wr_req<='0';
               fsm<=24;
            end if;
         when 19 =>
            sdram_x<=sdram_x+1;
            fsm<=20;
         when 20 =>
            filter2_res_rd_addr<=sdram_x;
            fsm<=21;
         when 21 => fsm<=22;
         when 22 => fsm<=18;

         ------------------------------------
         -- sdram to filter1_scanline section
         ------------------------------------
         when 24 =>
            if filter1_en='1' and  filter1_scanline_ask='1' and filter1_scanline_ack_reg='0' then
               sdram_x<=conv_std_logic_vector(filter1_x_min,10);
               sdram_y<=filter1_scanline_y;
               filter1_scanline_ack_reg<='1';
               filter1_scanline_ready<='0';
               fsm<=25;
            else
               sdram_rd_req<='0';
               sdram_wr_req<='0';
               filter1_scanline_ack_reg<='0';
               fsm<=28;
            end if;
         when 25 =>
            if sdram_x/=filter1_x_max
            then
               sdram_rd_addr <= "00" & "00" & sdram_y & sdram_x;
               sdram_rd_req<='1';
               sdram_wr_req<='0';
               fsm<=26;
            else
               sdram_rd_req<='0';
               sdram_wr_req<='0';
               filter1_scanline_ready<='1';
               fsm<=28;
            end if;
         when 26 =>
            if sdram_rd_valid='1' then
               filter1_scanline_wr_data<=sdram_rd_data;
               filter1_scanline_wr_addr<=sdram_x;
               filter1_scanline_we<='1';
               fsm<=27;
            end if;
         when 27 =>
            filter1_scanline_we<='0';
            sdram_x<=sdram_x+1;
            fsm<=25;

         ------------------------------------
         -- sdram to filter2_scanline section
         ------------------------------------
         when 28 =>
            if filter2_en='1' and filter2_scanline_ask='1' and filter2_scanline_ack_reg='0' then
               sdram_x<=conv_std_logic_vector(filter2_x_min,10);
               sdram_y<=filter2_scanline_y;
               filter2_scanline_ack_reg<='1';
               filter2_scanline_ready<='0';
               fsm<=29;
            else
               sdram_rd_req<='0';
               sdram_wr_req<='0';
               filter2_scanline_ack_reg<='0';
               fsm<=0;
            end if;
         when 29 =>
            if sdram_x/=filter2_x_max
            then
               sdram_rd_addr <= "00" & "00" & sdram_y & sdram_x;
               sdram_rd_req<='1';
               sdram_wr_req<='0';
               fsm<=30;
            else
               sdram_rd_req<='0';
               sdram_wr_req<='0';
               filter2_scanline_ready<='1';
               fsm<=0;
            end if;
         when 30 =>
            if sdram_rd_valid='1' then
               filter2_scanline_wr_data<=sdram_rd_data;
               filter2_scanline_wr_addr<=sdram_x;
               filter2_scanline_we<='1';
               fsm<=31;
            end if;
         when 31 =>
            filter2_scanline_we<='0';
            sdram_x<=sdram_x+1;         
            fsm<=29;
         when others => null;
         end case;
      end if;
   end process;
end Behavioral;
