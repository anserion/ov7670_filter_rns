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
-- Description: generate 8-char text box for a VGA controller
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;

entity bin24_to_bcd is
    Port ( 
		clk        : in  STD_LOGIC;
      en         : in std_logic;
      bin        : in std_logic_vector(23 downto 0);
      bcd        : out std_logic_vector(31 downto 0)
	 );
end bin24_to_bcd;

architecture Behavioral of bin24_to_bcd is
signal N: natural range 0 to 2**24-1;
signal K: natural range 0 to 9;
signal bin_reg: std_logic_vector(23 downto 0);
signal fsm: natural range 0 to 31:=0;
begin
   process(clk)
   begin
      if rising_edge(clk) then
         if en='1' then
            case fsm is
            when 0=> 
                     N<=10000000; k<=1;
                     bin_reg<=bin;
                     fsm<=1;
            when 1=>
                     if bin_reg>=N then
                        fsm<=2;
                     else
                        N<=N-10000000;
                        k<=k-1;
                     end if;
            when 2=>
                     bcd(31 downto 28)<=conv_std_logic_vector(k,4);
                     fsm<=3;

            when 3=>
                     bin_reg<=bin_reg-N;
                     N<=9000000; k<=9;
                     fsm<=4;
            when 4=>
                     if bin_reg>=N then
                        fsm<=5;
                     else
                        N<=N-1000000;
                        k<=k-1;
                     end if;
            when 5=>
                     bcd(27 downto 24)<=conv_std_logic_vector(k,4);
                     fsm<=6;

            when 6=>
                     bin_reg<=bin_reg-N;
                     N<=900000; k<=9;
                     fsm<=7;
            when 7=>
                     if bin_reg>=N then
                        fsm<=8;
                     else
                        N<=N-100000;
                        k<=k-1;
                     end if;
            when 8=>
                     bcd(23 downto 20)<=conv_std_logic_vector(k,4);
                     fsm<=9;

            when 9=>
                     bin_reg<=bin_reg-N;
                     N<=90000; k<=9;
                     fsm<=10;
            when 10=>
                     if bin_reg>=N then
                        fsm<=11;
                     else
                        N<=N-10000;
                        k<=k-1;
                     end if;
            when 11=>
                     bcd(19 downto 16)<=conv_std_logic_vector(k,4);
                     fsm<=12;
                     
            when 12=>
                     bin_reg<=bin_reg-N;
                     N<=9000; k<=9;
                     fsm<=13;
            when 13=>
                     if bin_reg>=N then
                        fsm<=14;
                     else
                        N<=N-1000;
                        k<=k-1;
                     end if;
            when 14=>
                     bcd(15 downto 12)<=conv_std_logic_vector(k,4);
                     fsm<=15;

            when 15=>
                     bin_reg<=bin_reg-N;
                     N<=900; k<=9;
                     fsm<=16;
            when 16=>
                     if bin_reg>=N then
                        fsm<=17;
                     else
                        N<=N-100;
                        k<=k-1;
                     end if;
            when 17=>
                     bcd(11 downto 8)<=conv_std_logic_vector(k,4);
                     fsm<=18;

            when 18=>
                     bin_reg<=bin_reg-N;
                     N<=90; k<=9;
                     fsm<=19;
            when 19=>
                     if bin_reg>=N then
                        fsm<=20;
                     else
                        N<=N-10;
                        k<=k-1;
                     end if;
            when 20=>
                     bcd(7 downto 4)<=conv_std_logic_vector(k,4);
                     fsm<=21;
                     
            when 21=>
                     bin_reg<=bin_reg-N;
                     fsm<=22;
            when 22=>
                     bcd(3 downto 0)<=bin_reg(3 downto 0);
                     fsm<=0;
            when others=> null;
            end case;
         end if;
      end if;
   end process;
end;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;

entity msg_center is
    Port ( 
		clk        : in  STD_LOGIC;
      en         : in std_logic;
      filter1_cnt: in std_logic_vector(23 downto 0);
      filter2_cnt: in std_logic_vector(23 downto 0);
      capture_en : in std_logic;
		msg_char_x : out STD_LOGIC_VECTOR(6 downto 0);
		msg_char_y : out STD_LOGIC_VECTOR(4 downto 0);
		msg_char   : out STD_LOGIC_VECTOR(7 downto 0)
	 );
end msg_center;

architecture Behavioral of msg_center is
   component msg_box is
    Port ( 
		clk       : in  STD_LOGIC;
      x         : in  STD_LOGIC_VECTOR(7 downto 0);
      y         : in  STD_LOGIC_VECTOR(7 downto 0);
		msg       : in  STD_LOGIC_VECTOR(63 downto 0);
		char_x    : out STD_LOGIC_VECTOR(7 downto 0);
		char_y	 : out STD_LOGIC_VECTOR(7 downto 0);
		char_code : out STD_LOGIC_VECTOR(7 downto 0)
	 );
   end component;

   component bin24_to_bcd is
    Port ( 
		clk        : in  STD_LOGIC;
      en         : in std_logic;
      bin        : in std_logic_vector(23 downto 0);
      bcd        : out std_logic_vector(31 downto 0)
	 );
   end component;

   signal filter1_cnt_reg: std_logic_vector(23 downto 0);
   signal filter2_cnt_reg: std_logic_vector(23 downto 0);
   
   signal f1_cnt_bcd: std_logic_vector(31 downto 0);
   signal msg_fsm: natural range 0 to 65535:=0;
   signal msg_clk         : std_logic;
   signal msg_clk_cnt     : natural range 0 to 65535:=0;
   
   signal msg1_x: std_logic_vector(7 downto 0):=conv_std_logic_vector(17,8);
   signal msg1_y: std_logic_vector(7 downto 0):=conv_std_logic_vector(0,8);
   signal msg1_char_x: std_logic_vector(7 downto 0);
   signal msg1_char_y: std_logic_vector(7 downto 0);
   signal msg1_char: std_logic_vector(7 downto 0);
   signal msg1: std_logic_vector(63 downto 0) := conv_std_logic_vector(145,8)&
                                                 conv_std_logic_vector(142,8)&
                                                 conv_std_logic_vector(138,8)&
                                                 conv_std_logic_vector(48,8)&
                                                 conv_std_logic_vector(48,8)&
                                                 conv_std_logic_vector(48,8)&
                                                 conv_std_logic_vector(48,8)&
                                                 conv_std_logic_vector(48,8);
   
   signal msg2_x: std_logic_vector(7 downto 0):=conv_std_logic_vector(29,8);
   signal msg2_y: std_logic_vector(7 downto 0):=conv_std_logic_vector(0,8);
   signal msg2_char_x: std_logic_vector(7 downto 0);
   signal msg2_char_y: std_logic_vector(7 downto 0);
   signal msg2_char: std_logic_vector(7 downto 0);
   signal msg2: std_logic_vector(63 downto 0) := conv_std_logic_vector(138,8)&
                                                 conv_std_logic_vector(128,8)&
                                                 conv_std_logic_vector(140,8)&
                                                 conv_std_logic_vector(32,8)&
                                                 conv_std_logic_vector(130,8)&
                                                 conv_std_logic_vector(138,8)&
                                                 conv_std_logic_vector(139,8)&
                                                 conv_std_logic_vector(32,8);

   signal f2_cnt_bcd: std_logic_vector(31 downto 0);
   signal msg3_x: std_logic_vector(7 downto 0):=conv_std_logic_vector(40,8);
   signal msg3_y: std_logic_vector(7 downto 0):=conv_std_logic_vector(0,8);
   signal msg3_char_x: std_logic_vector(7 downto 0);
   signal msg3_char_y: std_logic_vector(7 downto 0);
   signal msg3_char: std_logic_vector(7 downto 0);
   signal msg3: std_logic_vector(63 downto 0) := conv_std_logic_vector(143,8)&
                                                 conv_std_logic_vector(145,8)&
                                                 conv_std_logic_vector(145,8)&
                                                 conv_std_logic_vector(48,8)&
                                                 conv_std_logic_vector(48,8)&
                                                 conv_std_logic_vector(48,8)&
                                                 conv_std_logic_vector(48,8)&
                                                 conv_std_logic_vector(48,8);

   signal msg4_x: std_logic_vector(7 downto 0):=conv_std_logic_vector(20,8);
   signal msg4_y: std_logic_vector(7 downto 0):=conv_std_logic_vector(16,8);
   signal msg4_char_x: std_logic_vector(7 downto 0);
   signal msg4_char_y: std_logic_vector(7 downto 0);
   signal msg4_char: std_logic_vector(7 downto 0);
   signal msg4: std_logic_vector(63 downto 0) := conv_std_logic_vector(150,8)&
                                                 conv_std_logic_vector(136,8)&
                                                 conv_std_logic_vector(148,8)&
                                                 conv_std_logic_vector(144,8)&
                                                 conv_std_logic_vector(142,8)&
                                                 conv_std_logic_vector(130,8)&
                                                 conv_std_logic_vector(128,8)&
                                                 conv_std_logic_vector(159,8);

   signal msg5_x: std_logic_vector(7 downto 0):=conv_std_logic_vector(29,8);
   signal msg5_y: std_logic_vector(7 downto 0):=conv_std_logic_vector(16,8);
   signal msg5_char_x: std_logic_vector(7 downto 0);
   signal msg5_char_y: std_logic_vector(7 downto 0);
   signal msg5_char: std_logic_vector(7 downto 0);
   signal msg5: std_logic_vector(63 downto 0) := conv_std_logic_vector(148,8)&
                                                 conv_std_logic_vector(136,8)&
                                                 conv_std_logic_vector(139,8)&
                                                 conv_std_logic_vector(156,8)&
                                                 conv_std_logic_vector(146,8)&
                                                 conv_std_logic_vector(144,8)&
                                                 conv_std_logic_vector(128,8)&
                                                 conv_std_logic_vector(150,8);

   signal msg6_x: std_logic_vector(7 downto 0):=conv_std_logic_vector(37,8);
   signal msg6_y: std_logic_vector(7 downto 0):=conv_std_logic_vector(16,8);
   signal msg6_char_x: std_logic_vector(7 downto 0);
   signal msg6_char_y: std_logic_vector(7 downto 0);
   signal msg6_char: std_logic_vector(7 downto 0);
   signal msg6: std_logic_vector(63 downto 0) := conv_std_logic_vector(136,8)&
                                                 conv_std_logic_vector(159,8)&
                                                 conv_std_logic_vector(32,8)&
                                                 conv_std_logic_vector(130,8)&
                                                 conv_std_logic_vector(136,8)&
                                                 conv_std_logic_vector(132,8)&
                                                 conv_std_logic_vector(133,8)&
                                                 conv_std_logic_vector(142,8);

   signal msg7_x: std_logic_vector(7 downto 0):=conv_std_logic_vector(23,8);
   signal msg7_y: std_logic_vector(7 downto 0):=conv_std_logic_vector(14,8);
   signal msg7_char_x: std_logic_vector(7 downto 0);
   signal msg7_char_y: std_logic_vector(7 downto 0);
   signal msg7_char: std_logic_vector(7 downto 0);
   signal msg7: std_logic_vector(63 downto 0) := conv_std_logic_vector(145,8)&
                                                 conv_std_logic_vector(142,8)&
                                                 conv_std_logic_vector(138,8)&
                                                 conv_std_logic_vector(0,8)&
                                                 conv_std_logic_vector(0,8)&
                                                 conv_std_logic_vector(0,8)&
                                                 conv_std_logic_vector(0,8)&
                                                 conv_std_logic_vector(0,8);

   signal msg8_x: std_logic_vector(7 downto 0):=conv_std_logic_vector(38,8);
   signal msg8_y: std_logic_vector(7 downto 0):=conv_std_logic_vector(14,8);
   signal msg8_char_x: std_logic_vector(7 downto 0);
   signal msg8_char_y: std_logic_vector(7 downto 0);
   signal msg8_char: std_logic_vector(7 downto 0);
   signal msg8: std_logic_vector(63 downto 0) := conv_std_logic_vector(143,8)&
                                                 conv_std_logic_vector(145,8)&
                                                 conv_std_logic_vector(145,8)&
                                                 conv_std_logic_vector(0,8)&
                                                 conv_std_logic_vector(0,8)&
                                                 conv_std_logic_vector(0,8)&
                                                 conv_std_logic_vector(0,8)&
                                                 conv_std_logic_vector(0,8);
begin
   process (clk)
   begin
      if rising_edge(clk) then
         if msg_clk_cnt=0 then msg_clk<='1'; end if;
         if msg_clk_cnt=1023 then msg_clk<='0'; end if;
         if msg_clk_cnt=2047 then
            msg_clk_cnt<=0;
         else
            msg_clk_cnt<=msg_clk_cnt+1;
         end if;
      end if;
   end process;
---------------------------------------------------
   f1_bcd_chip: bin24_to_bcd port map (clk,'1',filter1_cnt_reg,f1_cnt_bcd);
   f2_bcd_chip: bin24_to_bcd port map (clk,'1',filter2_cnt_reg,f2_cnt_bcd);
   
   msg1_chip: msg_box
   port map (
      clk => msg_clk,
      x => msg1_x,
      y => msg1_y,
      msg => msg1,
      char_x => msg1_char_x,
      char_y => msg1_char_y,
      char_code => msg1_char
   );
   msg1<=conv_std_logic_vector(conv_integer(f1_cnt_bcd(31 downto 28))+48,8) &
         conv_std_logic_vector(conv_integer(f1_cnt_bcd(27 downto 24))+48,8) &
         conv_std_logic_vector(conv_integer(f1_cnt_bcd(23 downto 20))+48,8) &
         conv_std_logic_vector(conv_integer(f1_cnt_bcd(19 downto 16))+48,8) &
         conv_std_logic_vector(conv_integer(f1_cnt_bcd(15 downto 12))+48,8) &
         conv_std_logic_vector(conv_integer(f1_cnt_bcd(11 downto 8))+48,8) &
         conv_std_logic_vector(conv_integer(f1_cnt_bcd(7 downto 4))+48,8) &
         conv_std_logic_vector(conv_integer(f1_cnt_bcd(3 downto 0))+48,8);
---------------------------------------------------

   msg2_chip: msg_box
   port map (
      clk => msg_clk,
      x => msg2_x,
      y => msg2_y,
      msg => msg2,
      char_x => msg2_char_x,
      char_y => msg2_char_y,
      char_code => msg2_char
   );
   msg2(31 downto 24)<=conv_std_logic_vector(130,8) when capture_en='1' else conv_std_logic_vector(130,8);
   msg2(23 downto 16)<=conv_std_logic_vector(138,8) when capture_en='1' else conv_std_logic_vector(155,8);
   msg2(15 downto 8)<=conv_std_logic_vector(139,8) when capture_en='1' else conv_std_logic_vector(138,8);
   msg2(7 downto 0)<=conv_std_logic_vector(32,8) when capture_en='1' else conv_std_logic_vector(139,8);
---------------------------------------------------

   msg3_chip: msg_box
   port map (
      clk => msg_clk,
      x => msg3_x,
      y => msg3_y,
      msg => msg3,
      char_x => msg3_char_x,
      char_y => msg3_char_y,
      char_code => msg3_char
   );
   msg3<=conv_std_logic_vector(conv_integer(f2_cnt_bcd(31 downto 28))+48,8) &
         conv_std_logic_vector(conv_integer(f2_cnt_bcd(27 downto 24))+48,8) &
         conv_std_logic_vector(conv_integer(f2_cnt_bcd(23 downto 20))+48,8) &
         conv_std_logic_vector(conv_integer(f2_cnt_bcd(19 downto 16))+48,8) &
         conv_std_logic_vector(conv_integer(f2_cnt_bcd(15 downto 12))+48,8) &
         conv_std_logic_vector(conv_integer(f2_cnt_bcd(11 downto 8))+48,8) &
         conv_std_logic_vector(conv_integer(f2_cnt_bcd(7 downto 4))+48,8) &
         conv_std_logic_vector(conv_integer(f2_cnt_bcd(3 downto 0))+48,8);
---------------------------------------------------

   msg4_chip: msg_box
   port map (
      clk => msg_clk,
      x => msg4_x,
      y => msg4_y,
      msg => msg4,
      char_x => msg4_char_x,
      char_y => msg4_char_y,
      char_code => msg4_char
   );

   msg5_chip: msg_box
   port map (
      clk => msg_clk,
      x => msg5_x,
      y => msg5_y,
      msg => msg5,
      char_x => msg5_char_x,
      char_y => msg5_char_y,
      char_code => msg5_char
   );

   msg6_chip: msg_box
   port map (
      clk => msg_clk,
      x => msg6_x,
      y => msg6_y,
      msg => msg6,
      char_x => msg6_char_x,
      char_y => msg6_char_y,
      char_code => msg6_char
   );

   msg7_chip: msg_box
   port map (
      clk => msg_clk,
      x => msg7_x,
      y => msg7_y,
      msg => msg7,
      char_x => msg7_char_x,
      char_y => msg7_char_y,
      char_code => msg7_char
   );

   msg8_chip: msg_box
   port map (
      clk => msg_clk,
      x => msg8_x,
      y => msg8_y,
      msg => msg8,
      char_x => msg8_char_x,
      char_y => msg8_char_y,
      char_code => msg8_char
   );

   process (msg_clk)
   begin
      if rising_edge(msg_clk) then
         filter1_cnt_reg<=filter1_cnt;
         filter2_cnt_reg<=filter2_cnt;
         if msg_fsm=0 then
            msg_char_x<=msg1_char_x(6 downto 0);
            msg_char_y<=msg1_char_y(4 downto 0);
            msg_char<=msg1_char;
         end if;
         if msg_fsm=8 then
            msg_char_x<=msg2_char_x(6 downto 0);
            msg_char_y<=msg2_char_y(4 downto 0);
            msg_char<=msg2_char;
         end if;
         if msg_fsm=16 then
            msg_char_x<=msg3_char_x(6 downto 0);
            msg_char_y<=msg3_char_y(4 downto 0);
            msg_char<=msg3_char;
         end if;
         if msg_fsm=24 then
            msg_char_x<=msg4_char_x(6 downto 0);
            msg_char_y<=msg4_char_y(4 downto 0);
            msg_char<=msg4_char;
         end if;
         if msg_fsm=32 then
            msg_char_x<=msg5_char_x(6 downto 0);
            msg_char_y<=msg5_char_y(4 downto 0);
            msg_char<=msg5_char;
         end if;
         if msg_fsm=40 then
            msg_char_x<=msg6_char_x(6 downto 0);
            msg_char_y<=msg6_char_y(4 downto 0);
            msg_char<=msg6_char;
         end if;
         if msg_fsm=48 then
            msg_char_x<=msg7_char_x(6 downto 0);
            msg_char_y<=msg7_char_y(4 downto 0);
            msg_char<=msg7_char;
         end if;
         if msg_fsm=56 then
            msg_char_x<=msg8_char_x(6 downto 0);
            msg_char_y<=msg8_char_y(4 downto 0);
            msg_char<=msg8_char;
         end if;
         if msg_fsm=64 then msg_fsm<=0; else msg_fsm<=msg_fsm+1; end if;
      end if;
   end process;

end Behavioral;