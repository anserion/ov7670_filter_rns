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
-- Description: filter bss supervisor
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity filter_bss_supervisor is
   generic (
      x_min : natural range 0 to 1023 := 0;
      y_min : natural range 0 to 1023 := 0;
      x_max : natural range 0 to 1023 := 639;
      y_max : natural range 0 to 1023 := 479;
		k1: integer :=0;
		k2: integer :=0;
		k3: integer :=0;
		k4: integer :=0;
		k5: integer :=1;
		k6: integer :=0;
		k7: integer :=0;
		k8: integer :=0;
		k9: integer :=0;
		pow2_divider: integer :=0
      );
    Port ( 
      clk : in std_logic;
      en  : in std_logic;
      reset_cnt : in std_logic;
      filter_res_y   : out std_logic_vector(9 downto 0);
      filter_res_addr   : out std_logic_vector(9 downto 0);
      filter_res_data   : out std_logic_vector(15 downto 0);
      filter_scanline_y   : out std_logic_vector(9 downto 0);
      filter_scanline_ask    : out std_logic;
      filter_scanline_ack    : in std_logic;
      filter_scanline_ready  : in std_logic;
      filter_scanline_addr   : out std_logic_vector(9 downto 0);
      filter_scanline_data   : in std_logic_vector(15 downto 0);
      filter_cnt : out std_logic_vector(23 downto 0)
	 );
end filter_bss_supervisor;

architecture Behavioral of filter_bss_supervisor is

	COMPONENT filter_3x3_bss is
   GENERIC (
		k1: integer :=0;
		k2: integer :=0;
		k3: integer :=0;
		k4: integer :=0;
		k5: integer :=1;
		k6: integer :=0;
		k7: integer :=0;
		k8: integer :=0;
		k9: integer :=0;
		pow2_divider: integer :=0
	 );	
   PORT ( 
		clk   : in  STD_LOGIC;
      en    : in std_logic;
      p1  	: in STD_LOGIC_VECTOR(7 downto 0);
      p2  	: in STD_LOGIC_VECTOR(7 downto 0);
      p3  	: in STD_LOGIC_VECTOR(7 downto 0);
      p4  	: in STD_LOGIC_VECTOR(7 downto 0);
      p5 	: in STD_LOGIC_VECTOR(7 downto 0);
      p6  	: in STD_LOGIC_VECTOR(7 downto 0);
      p7  	: in STD_LOGIC_VECTOR(7 downto 0);
      p8  	: in STD_LOGIC_VECTOR(7 downto 0);
      p9  	: in STD_LOGIC_VECTOR(7 downto 0);
      res   : out STD_LOGIC_VECTOR(7 downto 0);
      start : in std_logic;
      ack   : out std_logic;
      ready : out STD_LOGIC
		);
	END COMPONENT;

   COMPONENT vram_scanline
   PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    clkb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
   );
   END COMPONENT;

   ----------------------------------------
   signal fsm: natural range 0 to 31:=0;
   signal stop_fsm: std_logic:='0';

   signal cnt : std_logic_vector(23 downto 0) := (others => '0');

   signal x     : std_logic_vector(9 downto 0) := conv_std_logic_vector(x_min,10);
   signal y     : std_logic_vector(9 downto 0) := conv_std_logic_vector(y_min,10);

   signal wea0,wea1,wea2: std_logic_vector(0 downto 0):=(others=>'0');
   signal wr_addr,rd_addr: std_logic_vector(9 downto 0):=(others=>'0');
   signal wr_data: std_logic_vector(15 downto 0):=(others=>'0');
   signal rd0_data,rd1_data,rd2_data: std_logic_vector(15 downto 0):=(others=>'0');
   
   signal upper_line: std_logic_vector(1 downto 0):="00";
   signal active_line: std_logic_vector(1 downto 0):="01";
   signal lower_line: std_logic_vector(1 downto 0):="10";

   signal p1,p2,p3,p4,p5,p6,p7,p8,p9: std_logic_vector(7 downto 0) := (others => '0');

   signal filter_ready : std_logic := '0';
   signal filter_start : std_logic := '0';
   signal filter_ack   : std_logic := '0';
   signal filter_res   : std_logic_vector(7 downto 0):=(others=>'0');
begin

-----------------------------------------------------------
	filter_bss: filter_3x3_bss
	GENERIC MAP (k1,k2,k3,k4,k5,k6,k7,k8,k9,pow2_divider)
	PORT MAP (clk,stop_fsm,p1,p2,p3,p4,p5,p6,p7,p8,p9,filter_res,filter_start,filter_ack,filter_ready);

   scanline0: vram_scanline PORT MAP (clk,wea0,wr_addr,wr_data,clk,rd_addr,rd0_data);
   scanline1: vram_scanline PORT MAP (clk,wea1,wr_addr,wr_data,clk,rd_addr,rd1_data);
   scanline2: vram_scanline PORT MAP (clk,wea2,wr_addr,wr_data,clk,rd_addr,rd2_data);
   
   stop_fsm<='0' when en='0' and fsm=0 else '1';
   process(clk)
   begin
      if rising_edge(clk) and stop_fsm='1' then
         case FSM is
            when 0 =>
               rd_addr<=x+1;
               if reset_cnt='0' then cnt<=cnt+1; else cnt<=(others=>'0'); end if;
               fsm<=1;
            when 1 =>
               p1<=p2; p4<=p5; p7<=p8;
               fsm<=2;
            when 2 =>
               p2<=p3; p5<=p6; p8<=p9;
               fsm<=3;
            when 3=>
               case active_line is
               when "00" => p3<=rd2_data(7 downto 0); p6<=rd0_data(7 downto 0); p9<=rd1_data(7 downto 0);
               when "01" => p3<=rd0_data(7 downto 0); p6<=rd1_data(7 downto 0); p9<=rd2_data(7 downto 0);
               when "10" => p3<=rd1_data(7 downto 0); p6<=rd2_data(7 downto 0); p9<=rd0_data(7 downto 0);
               when others => null;
               end case;
               fsm<=4;
               
            when 4 => filter_start<='1'; fsm<=5;
            when 5 => if filter_ack='1' then filter_start<='0'; fsm<=6; end if;
            when 6 =>
               if filter_ready='1' then
                  filter_res_addr<=x;
                  filter_res_data(15 downto 8)<=(others=>'0');
                  if x=x_min+1 or x=x_max-1 or y=y_min+1 or y=y_max-1
                     or x=x_min+2 or x=x_max-2 or y=y_min+2 or y=y_max-2
                  then filter_res_data(7 downto 0)<=(others=>'1');
                  else filter_res_data(7 downto 0)<=filter_res;
                  end if;
                  FSM<=7;
               end if;
            when 7 =>
               if x=x_max-1 then
                  filter_res_y<=y;
                  x<=conv_std_logic_vector(x_min,10);
                  if y=y_max-1
                  then y<=conv_std_logic_vector(y_min,10);
                  else y<=y+1;
                  end if;
                  fsm <= 13;
                  else
                  x<=x+1;
                  fsm<=0;
               end if;

            when 13 =>
               upper_line<=active_line;
               fsm<=14;
            when 14 =>
               active_line<=lower_line;
               fsm<=15;
            when 15 =>
               if lower_line="00" then lower_line<="01";
               elsif lower_line="01" then lower_line<="10";
               else lower_line<="00";
               end if;
               fsm<=16;
            when 16 =>
               filter_scanline_y<=y;
               filter_scanline_ask<='1';
               fsm<=17;
            when 17 =>
               if filter_scanline_ack='1' then
                  filter_scanline_ask<='0';
                  fsm<=18;
               end if;
            when 18 =>
               if filter_scanline_ready='1' then fsm<=19; end if;
            when 19 =>
               filter_scanline_addr<=x;
               wr_addr<=x;
               FSM<=20;
            when 20 =>
               wr_data<=filter_scanline_data;
               case active_line is
               when "00" => wea0(0)<='1';
               when "01" => wea1(0)<='1';
               when "10" => wea2(0)<='1';
               when others => null;
               end case;
               FSM<=21;
            when 21 =>
               wea0(0)<='0'; wea1(0)<='0'; wea2(0)<='0';
               if x=x_max-1 then
                  x<=conv_std_logic_vector(x_min,10);
                  fsm<=0;
               else
                  x<=x+1;
                  fsm<=19;
               end if;
            when others=>null;
         end case;
      end if;
   end process;

   filter_cnt<=cnt;
   
end Behavioral;
