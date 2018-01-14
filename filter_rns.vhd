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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity full_adder is
	port (
		a,b,c_in: in std_logic;
		s,c_out : out std_logic
	);
end full_adder;

architecture Behavioral of full_adder is
	component half_adder is
	port (
		a,b: in std_logic;
		s,c : out std_logic
	);
	end component;
signal s1,c1,c2: std_logic;
begin
	s1<=a xor b; c1<=a and b;        --half_adder(a,b,s1,c1);
	s<=s1 xor c_in; c2<=s1 and c_in; --half_adder(s1,c_in,s,c2);
	c_out<=c1 or c2;
end Behavioral;
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Engineer: Andrey S. Ionisyan <anserion@gmail.com>
-- 
-- Description: RNS(7,15,31,16) filter of 8-bit grayscale image
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity neg_mod_7 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(2 downto 0);
		res: out std_logic_vector(2 downto 0)
	);
end neg_mod_7;

architecture Behavioral of neg_mod_7 is
type rom_type is array (0 to 7) of std_logic_vector(2 downto 0);
constant ROM: rom_type :=("000","110","101","100","011","010","001","000");
signal res_reg: std_logic_vector(2 downto 0);
begin
   res_reg<=ROM(conv_integer(a));
	process (clk)
	begin
		if rising_edge(clk) then
         if en='1' then
            res<=res_reg;
         end if;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity neg_mod_15 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
end neg_mod_15;

architecture Behavioral of neg_mod_15 is
type rom_type is array (0 to 15) of std_logic_vector(3 downto 0);
constant ROM: rom_type :=(x"0",x"E",x"D",x"C",x"B",x"A",x"9",x"8",x"7",x"6",x"5",x"4",x"3",x"2",x"1",x"0");
signal res_reg: std_logic_vector(3 downto 0);
begin
   res_reg<=ROM(conv_integer(a));
	process (clk)
	begin
		if rising_edge(clk) then
         if en='1' then
            res<=res_reg;
         end if;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity neg_mod_16 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
end neg_mod_16;

architecture Behavioral of neg_mod_16 is
type rom_type is array (0 to 15) of std_logic_vector(3 downto 0);
constant ROM: rom_type :=(x"0",x"F",x"E",x"D",x"C",x"B",x"A",x"9",x"8",x"7",x"6",x"5",x"4",x"3",x"2",x"1");
signal res_reg: std_logic_vector(3 downto 0);
begin
   res_reg<=ROM(conv_integer(a));
	process (clk)
	begin
		if rising_edge(clk) then
         if en='1' then
            res<=res_reg;
         end if;
		end if;
	end process;
end Behavioral;

----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity neg_mod_31 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(4 downto 0);
		res: out std_logic_vector(4 downto 0)
	);
end neg_mod_31;

architecture Behavioral of neg_mod_31 is
type rom_type is array (0 to 31) of std_logic_vector(4 downto 0);
constant ROM: rom_type :=("00000","11110","11101","11100","11011","11010","11001","11000",
                          "10111","10110","10101","10100","10011","10010","10001","10000",
                          "01111","01110","01101","01100","01011","01010","01001","01000",
                          "00111","00110","00101","00100","00011","00010","00001","00000");
signal res_reg: std_logic_vector(4 downto 0);
begin
   res_reg<=ROM(conv_integer(a));
	process (clk)
	begin
		if rising_edge(clk) then
         if en='1' then
            res<=res_reg;
         end if;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity add_mod_7 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(2 downto 0);
		res: out std_logic_vector(2 downto 0)
	);
end add_mod_7;

architecture Behavioral of add_mod_7 is
type rom_type is array (0 to 63) of std_logic_vector(2 downto 0);
constant ROM: rom_type :=("000","001","010","011","100","101","110","000",
                          "001","010","011","100","101","110","000","001",
                          "010","011","100","101","110","000","001","010",
                          "011","100","101","110","000","001","010","011",
                          "100","101","110","000","001","010","011","100",
                          "101","110","000","001","010","011","100","101",
                          "110","000","001","010","011","100","101","110",
                          "000","001","010","011","100","101","110","111");
signal res_reg: std_logic_vector(2 downto 0);
begin
   res_reg<=ROM(conv_integer(a&b));
	process (clk)
	begin
		if rising_edge(clk) then
         if en='1' then
            res<=res_reg;
         end if;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity add_mod_15 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
end add_mod_15;

architecture Behavioral of add_mod_15 is
	component full_adder is
	port (
		a,b,c_in: in std_logic;
		s,c_out : out std_logic
	);
	end component;
signal res_reg: std_logic_vector(3 downto 0);
signal p0,p1,p2,p3:std_logic:='0';
begin
	FA0: full_adder port map(a(0),b(0),p3,res_reg(0),p0);
	FA1: full_adder port map(a(1),b(1),p0,res_reg(1),p1);
	FA2: full_adder port map(a(2),b(2),p1,res_reg(2),p2);
	FA3: full_adder port map(a(3),b(3),p2,res_reg(3),p3);
	process (clk)
	begin
		if rising_edge(clk) then
         if en='1' then
            if res_reg="1111" then
					res<="0000";
				else
					res<=res_reg;
				end if;
         end if;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity add_mod_16 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
end add_mod_16;

architecture Behavioral of add_mod_16 is
	component full_adder is
	port (
		a,b,c_in: in std_logic;
		s,c_out : out std_logic
	);
	end component;
signal res_reg: std_logic_vector(3 downto 0);
signal p0,p1,p2,p3:std_logic;
begin
	FA0: full_adder port map(a(0),b(0),'0',res_reg(0),p0);
	FA1: full_adder port map(a(1),b(1),p0,res_reg(1),p1);
	FA2: full_adder port map(a(2),b(2),p1,res_reg(2),p2);
	FA3: full_adder port map(a(3),b(3),p2,res_reg(3),p3);
	process (clk)
	begin
		if rising_edge(clk) then
         if en='1' then
            res<=res_reg;
         end if;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity add_mod_31 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(4 downto 0);
		res: out std_logic_vector(4 downto 0)
	);
end add_mod_31;

architecture Behavioral of add_mod_31 is
	component full_adder is
	port (
		a,b,c_in: in std_logic;
		s,c_out : out std_logic
	);
	end component;
signal res_reg: std_logic_vector(4 downto 0);
signal p0,p1,p2,p3,p4:std_logic:='0';
begin
	FA0: full_adder port map(a(0),b(0),p4,res_reg(0),p0);
	FA1: full_adder port map(a(1),b(1),p0,res_reg(1),p1);
	FA2: full_adder port map(a(2),b(2),p1,res_reg(2),p2);
	FA3: full_adder port map(a(3),b(3),p2,res_reg(3),p3);
	FA4: full_adder port map(a(4),b(4),p3,res_reg(4),p4);
	process (clk)
	begin
		if rising_edge(clk) then
         if en='1' then
            if res_reg="11111" then
					res<="00000";
				else
					res<=res_reg;
				end if;
         end if;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mul_mod_7 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(2 downto 0);
		res: out std_logic_vector(2 downto 0)
	);
end mul_mod_7;

architecture Behavioral of mul_mod_7 is
type rom_type is array (0 to 63) of std_logic_vector(2 downto 0);
constant ROM: rom_type :=("000","000","000","000","000","000","000","000",
                          "000","001","010","011","100","101","110","000",
                          "000","010","100","110","001","011","101","000",
                          "000","011","110","010","101","001","100","000",
                          "000","100","001","101","010","110","011","000",
                          "000","101","011","001","110","100","010","000",
                          "000","110","101","100","011","010","001","000",
                          "000","000","000","000","000","000","000","000");
signal res_reg: std_logic_vector(2 downto 0);
begin
   res_reg<=ROM(conv_integer(a&b));
	process (clk)
	begin
		if rising_edge(clk) then
         if en='1' then
            res<=res_reg;
         end if;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mul_mod_15 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
end mul_mod_15;

architecture Behavioral of mul_mod_15 is
	component add_mod_15 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
	end component;
	signal a0,a1,a2,a3: std_logic_vector(3 downto 0);
	signal sum01,sum23,res_reg: std_logic_vector(3 downto 0);
begin
	a0<=a when b(0)='1' else (others=>'0');
	
	a1(3 downto 1)<=a(2 downto 0) when b(1)='1' else (others=>'0');
	a1(0)<=a(3) when b(1)='1' else '0';
	
	a2(3 downto 2)<=a(1 downto 0) when b(2)='1' else (others=>'0');
	a2(1 downto 0)<=a(3 downto 2) when b(2)='1' else (others=>'0');
	
	a3(3)<=a(0) when b(3)='1' else '0';
	a3(2 downto 0)<=a(3 downto 1) when b(3)='1' else (others=>'0');
	
	ADD_MOD15_01: add_mod_15 port map(clk,en,a0,a1,sum01);
	ADD_MOD15_23: add_mod_15 port map(clk,en,a2,a3,sum23);
	ADD_MOD15_0123: add_mod_15 port map(clk,en,sum01,sum23,res_reg);
	
	process (clk)
	begin
		if rising_edge(clk) then
         if en='1' then
            res<=res_reg;
         end if;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mul_mod_16 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
end mul_mod_16;

architecture Behavioral of mul_mod_16 is
signal a0:std_logic_vector(3 downto 0);
signal a1:std_logic_vector(2 downto 0);
signal a2:std_logic_vector(1 downto 0);
signal a3:std_logic;
signal c2,c3:std_logic;
signal res_reg: std_logic_vector(3 downto 0);
begin
	a0<=a when b(0)='1' else (others=>'0');
	a1<=a(2 downto 0) when b(1)='1' else (others=>'0');
	a2<=a(1 downto 0) when b(2)='1' else (others=>'0');
	a3<=a(0) when b(3)='1' else '0';
	
	res_reg(0)<=a0(0);
	res_reg(1)<=a0(1) xor a1(0);

	c2<=a0(1) and a1(0);
	res_reg(2)<=(a0(2) xor a1(1)) xor (a2(0) xor c2);

	c3<= (not(a0(2)) and not(a1(1)) and a2(0) and c2) or
		  (not(a0(2)) and a1(1) and not(a2(0)) and c2) or
		  (not(a0(2)) and a1(1) and a2(0) and not(c2)) or
		  (not(a0(2)) and a1(1) and a2(0) and c2) or
		  (a0(2) and not(a1(1)) and not(a2(0)) and c2) or
		  (a0(2) and not(a1(1)) and a2(0) and not(c2)) or
		  (a0(2) and not(a1(1)) and a2(0) and c2) or
		  (a0(2) and a1(1) and not(a2(0)) and not(c2)) or
		  (a0(2) and a1(1) and not(a2(0)) and c2) or
		  (a0(2) and a1(1) and a2(0) and not(c2));
		 
	res_reg(3)<=(a0(3) xor a1(2)) xor (a2(1) xor a3) xor c3;
	process(clk)
	begin
		if rising_edge(clk) then
         if en='1' then
            res<=res_reg;
         end if;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mul_mod_31 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(4 downto 0);
		res: out std_logic_vector(4 downto 0)
	);
end mul_mod_31;

architecture Behavioral of mul_mod_31 is
type rom_idx is array (0 to 31) of std_logic_vector(4 downto 0);
type rom_inv_idx is array (0 to 63) of std_logic_vector(4 downto 0);
constant a_idx31: rom_idx :=(
conv_std_logic_vector( 0,5),conv_std_logic_vector(30,5),conv_std_logic_vector(24,5),conv_std_logic_vector( 1,5),
conv_std_logic_vector(18,5),conv_std_logic_vector(20,5),conv_std_logic_vector(25,5),conv_std_logic_vector(28,5),
conv_std_logic_vector(12,5),conv_std_logic_vector( 2,5),conv_std_logic_vector(14,5),conv_std_logic_vector(23,5),
conv_std_logic_vector(19,5),conv_std_logic_vector(11,5),conv_std_logic_vector(22,5),conv_std_logic_vector(21,5),
conv_std_logic_vector( 6,5),conv_std_logic_vector( 7,5),conv_std_logic_vector(26,5),conv_std_logic_vector( 4,5),
conv_std_logic_vector( 8,5),conv_std_logic_vector(29,5),conv_std_logic_vector(17,5),conv_std_logic_vector(27,5),
conv_std_logic_vector(13,5),conv_std_logic_vector(10,5),conv_std_logic_vector( 5,5),conv_std_logic_vector( 3,5),
conv_std_logic_vector(16,5),conv_std_logic_vector( 9,5),conv_std_logic_vector(15,5),conv_std_logic_vector( 0,5));

constant b_idx31: rom_idx :=(
conv_std_logic_vector( 0,5),conv_std_logic_vector(30,5),conv_std_logic_vector(24,5),conv_std_logic_vector( 1,5),
conv_std_logic_vector(18,5),conv_std_logic_vector(20,5),conv_std_logic_vector(25,5),conv_std_logic_vector(28,5),
conv_std_logic_vector(12,5),conv_std_logic_vector( 2,5),conv_std_logic_vector(14,5),conv_std_logic_vector(23,5),
conv_std_logic_vector(19,5),conv_std_logic_vector(11,5),conv_std_logic_vector(22,5),conv_std_logic_vector(21,5),
conv_std_logic_vector( 6,5),conv_std_logic_vector( 7,5),conv_std_logic_vector(26,5),conv_std_logic_vector( 4,5),
conv_std_logic_vector( 8,5),conv_std_logic_vector(29,5),conv_std_logic_vector(17,5),conv_std_logic_vector(27,5),
conv_std_logic_vector(13,5),conv_std_logic_vector(10,5),conv_std_logic_vector( 5,5),conv_std_logic_vector( 3,5),
conv_std_logic_vector(16,5),conv_std_logic_vector( 9,5),conv_std_logic_vector(15,5),conv_std_logic_vector( 0,5));

constant inv_idx31: rom_inv_idx :=(
conv_std_logic_vector( 0,5),conv_std_logic_vector( 3,5),
conv_std_logic_vector( 9,5),conv_std_logic_vector(27,5),
conv_std_logic_vector(19,5),conv_std_logic_vector(26,5),
conv_std_logic_vector(16,5),conv_std_logic_vector(17,5),
conv_std_logic_vector(20,5),conv_std_logic_vector(29,5),
conv_std_logic_vector(25,5),conv_std_logic_vector(13,5),
conv_std_logic_vector( 8,5),conv_std_logic_vector(24,5),
conv_std_logic_vector(10,5),conv_std_logic_vector(30,5),
conv_std_logic_vector(28,5),conv_std_logic_vector(22,5),
conv_std_logic_vector( 4,5),conv_std_logic_vector(12,5),
conv_std_logic_vector( 5,5),conv_std_logic_vector(15,5),
conv_std_logic_vector(14,5),conv_std_logic_vector(11,5),
conv_std_logic_vector( 2,5),conv_std_logic_vector( 6,5),
conv_std_logic_vector(18,5),conv_std_logic_vector(23,5),
conv_std_logic_vector( 7,5),conv_std_logic_vector(21,5),
conv_std_logic_vector( 1,5),conv_std_logic_vector( 3,5),
conv_std_logic_vector( 9,5),conv_std_logic_vector(27,5),
conv_std_logic_vector(19,5),conv_std_logic_vector(26,5),
conv_std_logic_vector(16,5),conv_std_logic_vector(17,5),
conv_std_logic_vector(20,5),conv_std_logic_vector(29,5),
conv_std_logic_vector(25,5),conv_std_logic_vector(13,5),
conv_std_logic_vector( 8,5),conv_std_logic_vector(24,5),
conv_std_logic_vector(10,5),conv_std_logic_vector(30,5),
conv_std_logic_vector(28,5),conv_std_logic_vector(22,5),
conv_std_logic_vector( 4,5),conv_std_logic_vector(12,5),
conv_std_logic_vector( 5,5),conv_std_logic_vector(15,5),
conv_std_logic_vector(14,5),conv_std_logic_vector(11,5),
conv_std_logic_vector( 2,5),conv_std_logic_vector( 6,5),
conv_std_logic_vector(18,5),conv_std_logic_vector(23,5),
conv_std_logic_vector( 7,5),conv_std_logic_vector(21,5),
conv_std_logic_vector( 1,5),conv_std_logic_vector( 3,5),
conv_std_logic_vector( 9,5),conv_std_logic_vector(27,5));

component add_6bit is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(5 downto 0);
		res: out std_logic_vector(5 downto 0)
	);
end component;

signal res_reg,a_idx,b_idx: std_logic_vector(4 downto 0);
signal a_plus_b_idx: std_logic_vector(5 downto 0);
begin
   a_plus_b_idx_chip: add_6bit port map(clk,en,"0"&a_idx,"0"&b_idx,a_plus_b_idx);
   a_idx<=a_idx31(conv_integer(a));
   b_idx<=b_idx31(conv_integer(b));
   res_reg<=inv_idx31(conv_integer(a_plus_b_idx));
	process (clk)
	begin
		if rising_edge(clk) then
         if en='1' then
            if a="00000" or b="00000" then res<="00000";
            else
               res<=res_reg;
            end if;
         end if;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bss8_mod_7 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(7 downto 0);
		res: out std_logic_vector(2 downto 0);
		start: in std_logic;
		ack: out std_logic;
		ready: out std_logic
	);
end bss8_mod_7;

architecture Behavioral of bss8_mod_7 is
signal tmp1: std_logic_vector(4 downto 0);
signal tmp2: std_logic_vector(3 downto 0);
signal tmp3: std_logic_vector(2 downto 0);
signal ack_reg: std_logic :='0';
signal fsm: natural range 0 to 7 := 0;
begin
	ack<=ack_reg;
	process(clk)
	begin
		if rising_edge(clk) then
         if en='1' then
				case fsm is
				when 0 =>
					if start='1' and ack_reg='0' then
						ready<='0';	ack_reg<='1';
						fsm<=1;
					else ack_reg<='0';
					end if;
				when 1=>
					tmp1<=("000"&a(7 downto 6))+("00"&a(5 downto 3))+("00"&a(2 downto 0));
               fsm<=2;
            when 2=>
					tmp2<=("00"&tmp1(4 downto 3))+("0"&tmp1(2 downto 0));
               fsm<=3;
            when 3=>
					if tmp2(3)='0' then tmp3<=tmp2(2 downto 0); else tmp3<=tmp2(2 downto 0)+1; end if;
					fsm<=4;
				when 4=>
						if tmp3="111" then res<="000"; else res<=tmp3; end if;
						ready<='1';
						fsm<=0;
			when others=>null;
			end case;
			else ready<='0'; ack_reg<='0'; res<=(others=>'0');
         end if;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bss8_mod_16 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(7 downto 0);
		res: out std_logic_vector(3 downto 0);
		start: in std_logic;
		ack: out std_logic;
		ready: out std_logic
	);
end bss8_mod_16;

architecture Behavioral of bss8_mod_16 is
signal fsm: natural range 0 to 3 := 0;
signal ack_reg: std_logic := '0';
begin
	ack<=ack_reg;
	process(clk)
	begin
		if rising_edge(clk) then
         if en='1' then
				case fsm is
				when 0 =>
					if start='1' and ack_reg='0' then
						ready<='0';	ack_reg<='1';
						fsm<=1;
					else ack_reg<='0';
					end if;
				when 1=>
						res<=a(3 downto 0);
						ready<='1';
						fsm<=0;
			when others=>null;
			end case;
			else ready<='0'; ack_reg<='0'; res<=(others=>'0');
         end if;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bss8_mod_15 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(7 downto 0);
		res: out std_logic_vector(3 downto 0);
		start: in std_logic;
		ack: out std_logic;
		ready: out std_logic
	);
end bss8_mod_15;

architecture Behavioral of bss8_mod_15 is
signal tmp1: std_logic_vector(4 downto 0);
signal tmp3: std_logic_vector(3 downto 0);
signal ack_reg: std_logic := '0';
signal fsm: natural range 0 to 3:=0;
begin
	ack<=ack_reg;
	process(clk)
	begin
		if rising_edge(clk) then
         if en='1' then
				case fsm is
				when 0 =>
					if start='1' and ack_reg='0' then
						ready<='0';	ack_reg<='1';
						fsm<=1;
					else ack_reg<='0';
					end if;
				when 1=>
					tmp1<=("0"&a(7 downto 4))+("0"&a(3 downto 0));
					fsm<=2;
				when 2=>
					if tmp1(4)='0' then tmp3<=tmp1(3 downto 0); else tmp3<=tmp1(3 downto 0)+1; end if;
					fsm<=3;
				when 3=>
						if tmp3="1111" then res<="0000"; else res<=tmp3; end if;
						ready<='1';
						fsm<=0;
			when others=>null;
			end case;
			else ready<='0'; ack_reg<='0'; res<=(others=>'0');
         end if;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bss8_mod_31 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(7 downto 0);
		res: out std_logic_vector(4 downto 0);
		start: in std_logic;
		ack: out std_logic;
		ready: out std_logic
	);
end bss8_mod_31;

architecture Behavioral of bss8_mod_31 is
signal tmp1: std_logic_vector(5 downto 0);
signal tmp3: std_logic_vector(4 downto 0);
signal ack_reg: std_logic := '0';
signal fsm: natural range 0 to 3:=0;
begin
	ack<=ack_reg;
	process(clk)
	begin
		if rising_edge(clk) then
         if en='1' then
				case fsm is
				when 0 =>
					if start='1' and ack_reg='0' then
						ready<='0';	ack_reg<='1';
						fsm<=1;
					else ack_reg<='0';
					end if;
				when 1=>
					tmp1<=("00"&a(7 downto 5))+("0"&a(4 downto 0));
					fsm<=2;
				when 2=>
					if tmp1(5)='0' then tmp3<=tmp1(4 downto 0); else tmp3<=tmp1(4 downto 0)+1; end if;
					fsm<=3;
				when 3=>
						if tmp3="11111" then res<="00000"; else res<=tmp3; end if;
						ready<='1';
						fsm<=0;
			when others=>null;
			end case;
			else ready<='0'; ack_reg<='0'; res<=(others=>'0');
         end if;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity filter_3x3_mod_7 is
    generic (
		k1: integer :=0;
		k2: integer :=0;
		k3: integer :=0;
		k4: integer :=0;
		k5: integer :=1;
		k6: integer :=0;
		k7: integer :=0;
		k8: integer :=0;
		k9: integer :=0
	 );
    Port ( 
		clk   : in STD_LOGIC;
      en    : in std_logic;
      p1  	: in STD_LOGIC_VECTOR(2 downto 0);
      p2  	: in STD_LOGIC_VECTOR(2 downto 0);
      p3  	: in STD_LOGIC_VECTOR(2 downto 0);
      p4  	: in STD_LOGIC_VECTOR(2 downto 0);
      p5 	: in STD_LOGIC_VECTOR(2 downto 0);
      p6  	: in STD_LOGIC_VECTOR(2 downto 0);
      p7  	: in STD_LOGIC_VECTOR(2 downto 0);
      p8  	: in STD_LOGIC_VECTOR(2 downto 0);
      p9  	: in STD_LOGIC_VECTOR(2 downto 0);
      res   : out STD_LOGIC_VECTOR(2 downto 0);
      start : in std_logic;
      ack   : out std_logic;
      ready : out std_logic
		);
end filter_3x3_mod_7;

architecture Behavioral of filter_3x3_mod_7 is
signal sum_reg:std_logic_vector(2 downto 0) := (others=>'0');
signal k1_mul_p1,k2_mul_p2,k3_mul_p3,
       k4_mul_p4,k5_mul_p5,k6_mul_p6,
       k7_mul_p7,k8_mul_p8,k9_mul_p9:std_logic_vector(2 downto 0) := (others=>'0');
signal k1p1_add_k2p2,k3p3_add_k4p4,k5p5_add_k6p6,k7p7_add_k8p8:std_logic_vector(2 downto 0) := (others=>'0');
signal kp12_add_kp34,kp56_add_kp78,kp1234_add_kp5678:std_logic_vector(2 downto 0) := (others=>'0');
signal ack_reg: std_logic:='0';
signal fsm: natural range 0 to 3:=0;
signal cnt_reg:natural range 0 to 31:=0;
constant max_cnt_reg:natural range 0 to 31:=10;

constant k1_7: std_logic_vector(2 downto 0) := conv_std_logic_vector(k1 mod 7,3);
constant k2_7: std_logic_vector(2 downto 0) := conv_std_logic_vector(k2 mod 7,3);
constant k3_7: std_logic_vector(2 downto 0) := conv_std_logic_vector(k3 mod 7,3);
constant k4_7: std_logic_vector(2 downto 0) := conv_std_logic_vector(k4 mod 7,3);
constant k5_7: std_logic_vector(2 downto 0) := conv_std_logic_vector(k5 mod 7,3);
constant k6_7: std_logic_vector(2 downto 0) := conv_std_logic_vector(k6 mod 7,3);
constant k7_7: std_logic_vector(2 downto 0) := conv_std_logic_vector(k7 mod 7,3);
constant k8_7: std_logic_vector(2 downto 0) := conv_std_logic_vector(k8 mod 7,3);
constant k9_7: std_logic_vector(2 downto 0) := conv_std_logic_vector(k9 mod 7,3);

component add_mod_7
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(2 downto 0);
		res: out std_logic_vector(2 downto 0)
	);
end component;

component mul_mod_7
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(2 downto 0);
		res: out std_logic_vector(2 downto 0)
	);
end component;

begin
	ack<=ack_reg;
	process (clk)
	begin
		if rising_edge(clk) then
			if en='1' then
			case fsm is
			when 0=>
				if start='1' and ack_reg='0' then
					ready<='0';
					ack_reg<='1';
					cnt_reg<=0;
					fsm<=1;
				else ack_reg<='0';
				end if;
			when 1=>
				if cnt_reg=max_cnt_reg then
					res<=sum_reg;
					ready<='1';
					fsm<=0;
				else cnt_reg<=cnt_reg+1;
				end if;
			when others=>null;
			end case;
			else ready<='0'; ack_reg<='0'; res<=(others=>'0');
			end if;
		end if;
	end process;
	
   k1_mul_p1_chip: mul_mod_7 port map(clk,en,k1_7,p1,k1_mul_p1);
   k2_mul_p2_chip: mul_mod_7 port map(clk,en,k2_7,p2,k2_mul_p2);
   k3_mul_p3_chip: mul_mod_7 port map(clk,en,k3_7,p3,k3_mul_p3);
   k4_mul_p4_chip: mul_mod_7 port map(clk,en,k4_7,p4,k4_mul_p4);
   k5_mul_p5_chip: mul_mod_7 port map(clk,en,k5_7,p5,k5_mul_p5);
   k6_mul_p6_chip: mul_mod_7 port map(clk,en,k6_7,p6,k6_mul_p6);
   k7_mul_p7_chip: mul_mod_7 port map(clk,en,k7_7,p7,k7_mul_p7);
   k8_mul_p8_chip: mul_mod_7 port map(clk,en,k8_7,p8,k8_mul_p8);
   k9_mul_p9_chip: mul_mod_7 port map(clk,en,k9_7,p9,k9_mul_p9);
   
   k1p1_add_k2p2_chip: add_mod_7 port map(clk,en,k1_mul_p1,k2_mul_p2,k1p1_add_k2p2);
   k3p3_add_k4p4_chip: add_mod_7 port map(clk,en,k3_mul_p3,k4_mul_p4,k3p3_add_k4p4);
   k5p5_add_k6p6_chip: add_mod_7 port map(clk,en,k5_mul_p5,k6_mul_p6,k5p5_add_k6p6);
   k7p7_add_k8p8_chip: add_mod_7 port map(clk,en,k7_mul_p7,k8_mul_p8,k7p7_add_k8p8);
   
   kp12_add_kp34_chip: add_mod_7 port map(clk,en,k1p1_add_k2p2,k3p3_add_k4p4,kp12_add_kp34);
   kp56_add_kp78_chip: add_mod_7 port map(clk,en,k5p5_add_k6p6,k7p7_add_k8p8,kp56_add_kp78);
   
   kp1234_add_kp5678_chip: add_mod_7 port map(clk,en,kp12_add_kp34,kp56_add_kp78,kp1234_add_kp5678);
   
   sum_chip: add_mod_7 port map(clk,en,k9_mul_p9,kp1234_add_kp5678,sum_reg);
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity filter_3x3_mod_15 is
    generic (
		k1: integer :=0;
		k2: integer :=0;
		k3: integer :=0;
		k4: integer :=0;
		k5: integer :=1;
		k6: integer :=0;
		k7: integer :=0;
		k8: integer :=0;
		k9: integer :=0
	 );
    Port ( 
		clk   : in STD_LOGIC;
      en    : in std_logic;
      p1  	: in STD_LOGIC_VECTOR(3 downto 0);
      p2  	: in STD_LOGIC_VECTOR(3 downto 0);
      p3  	: in STD_LOGIC_VECTOR(3 downto 0);
      p4  	: in STD_LOGIC_VECTOR(3 downto 0);
      p5 	: in STD_LOGIC_VECTOR(3 downto 0);
      p6  	: in STD_LOGIC_VECTOR(3 downto 0);
      p7  	: in STD_LOGIC_VECTOR(3 downto 0);
      p8  	: in STD_LOGIC_VECTOR(3 downto 0);
      p9  	: in STD_LOGIC_VECTOR(3 downto 0);
      res   : out STD_LOGIC_VECTOR(3 downto 0);
      start : in std_logic;
      ack   : out std_logic;
      ready : out std_logic
		);
end filter_3x3_mod_15;

architecture Behavioral of filter_3x3_mod_15 is
signal sum_reg:std_logic_vector(3 downto 0) := (others=>'0');
signal k1_mul_p1,k2_mul_p2,k3_mul_p3,
       k4_mul_p4,k5_mul_p5,k6_mul_p6,
       k7_mul_p7,k8_mul_p8,k9_mul_p9:std_logic_vector(3 downto 0) := (others=>'0');
signal k1p1_add_k2p2,k3p3_add_k4p4,k5p5_add_k6p6,k7p7_add_k8p8:std_logic_vector(3 downto 0) := (others=>'0');
signal kp12_add_kp34,kp56_add_kp78,kp1234_add_kp5678:std_logic_vector(3 downto 0) := (others=>'0');
signal ack_reg: std_logic:='0';
signal fsm: natural range 0 to 3:=0;
signal cnt_reg:natural range 0 to 31:=0;
constant max_cnt_reg:natural range 0 to 31:=10;

constant k1_15: std_logic_vector(3 downto 0) := conv_std_logic_vector(k1 mod 15,4);
constant k2_15: std_logic_vector(3 downto 0) := conv_std_logic_vector(k2 mod 15,4);
constant k3_15: std_logic_vector(3 downto 0) := conv_std_logic_vector(k3 mod 15,4);
constant k4_15: std_logic_vector(3 downto 0) := conv_std_logic_vector(k4 mod 15,4);
constant k5_15: std_logic_vector(3 downto 0) := conv_std_logic_vector(k5 mod 15,4);
constant k6_15: std_logic_vector(3 downto 0) := conv_std_logic_vector(k6 mod 15,4);
constant k7_15: std_logic_vector(3 downto 0) := conv_std_logic_vector(k7 mod 15,4);
constant k8_15: std_logic_vector(3 downto 0) := conv_std_logic_vector(k8 mod 15,4);
constant k9_15: std_logic_vector(3 downto 0) := conv_std_logic_vector(k9 mod 15,4);

component add_mod_15
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
end component;

component mul_mod_15
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
end component;

begin
	ack<=ack_reg;
	process (clk)
	begin
		if rising_edge(clk) then
			if en='1' then
			case fsm is
			when 0=>
				if start='1' and ack_reg='0' then
					ready<='0';
					ack_reg<='1';
					cnt_reg<=0;
					fsm<=1;
				else ack_reg<='0';
				end if;
			when 1=>
				if cnt_reg=max_cnt_reg then
					res<=sum_reg;
					ready<='1';
					fsm<=0;
				else cnt_reg<=cnt_reg+1;
				end if;
			when others=>null;
			end case;
			else ready<='0'; ack_reg<='0'; res<=(others=>'0');
			end if;
		end if;
	end process;
	
   k1_mul_p1_chip: mul_mod_15 port map(clk,en,k1_15,p1,k1_mul_p1);
   k2_mul_p2_chip: mul_mod_15 port map(clk,en,k2_15,p2,k2_mul_p2);
   k3_mul_p3_chip: mul_mod_15 port map(clk,en,k3_15,p3,k3_mul_p3);
   k4_mul_p4_chip: mul_mod_15 port map(clk,en,k4_15,p4,k4_mul_p4);
   k5_mul_p5_chip: mul_mod_15 port map(clk,en,k5_15,p5,k5_mul_p5);
   k6_mul_p6_chip: mul_mod_15 port map(clk,en,k6_15,p6,k6_mul_p6);
   k7_mul_p7_chip: mul_mod_15 port map(clk,en,k7_15,p7,k7_mul_p7);
   k8_mul_p8_chip: mul_mod_15 port map(clk,en,k8_15,p8,k8_mul_p8);
   k9_mul_p9_chip: mul_mod_15 port map(clk,en,k9_15,p9,k9_mul_p9);
   
   k1p1_add_k2p2_chip: add_mod_15 port map(clk,en,k1_mul_p1,k2_mul_p2,k1p1_add_k2p2);
   k3p3_add_k4p4_chip: add_mod_15 port map(clk,en,k3_mul_p3,k4_mul_p4,k3p3_add_k4p4);
   k5p5_add_k6p6_chip: add_mod_15 port map(clk,en,k5_mul_p5,k6_mul_p6,k5p5_add_k6p6);
   k7p7_add_k8p8_chip: add_mod_15 port map(clk,en,k7_mul_p7,k8_mul_p8,k7p7_add_k8p8);
   
   kp12_add_kp34_chip: add_mod_15 port map(clk,en,k1p1_add_k2p2,k3p3_add_k4p4,kp12_add_kp34);
   kp56_add_kp78_chip: add_mod_15 port map(clk,en,k5p5_add_k6p6,k7p7_add_k8p8,kp56_add_kp78);
   
   kp1234_add_kp5678_chip: add_mod_15 port map(clk,en,kp12_add_kp34,kp56_add_kp78,kp1234_add_kp5678);
   
   sum_chip: add_mod_15 port map(clk,en,k9_mul_p9,kp1234_add_kp5678,sum_reg);
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity filter_3x3_mod_16 is
    generic (
		k1: integer :=0;
		k2: integer :=0;
		k3: integer :=0;
		k4: integer :=0;
		k5: integer :=1;
		k6: integer :=0;
		k7: integer :=0;
		k8: integer :=0;
		k9: integer :=0
	 );
    Port ( 
		clk   : in STD_LOGIC;
      en    : in std_logic;
      p1  	: in STD_LOGIC_VECTOR(3 downto 0);
      p2  	: in STD_LOGIC_VECTOR(3 downto 0);
      p3  	: in STD_LOGIC_VECTOR(3 downto 0);
      p4  	: in STD_LOGIC_VECTOR(3 downto 0);
      p5 	: in STD_LOGIC_VECTOR(3 downto 0);
      p6  	: in STD_LOGIC_VECTOR(3 downto 0);
      p7  	: in STD_LOGIC_VECTOR(3 downto 0);
      p8  	: in STD_LOGIC_VECTOR(3 downto 0);
      p9  	: in STD_LOGIC_VECTOR(3 downto 0);
      res   : out STD_LOGIC_VECTOR(3 downto 0);
      start : in std_logic;
      ack   : out std_logic;
      ready : out std_logic
		);
end filter_3x3_mod_16;

architecture Behavioral of filter_3x3_mod_16 is
signal sum_reg: std_logic_vector(3 downto 0) := (others=>'0');
signal k1_mul_p1,k2_mul_p2,k3_mul_p3,
       k4_mul_p4,k5_mul_p5,k6_mul_p6,
       k7_mul_p7,k8_mul_p8,k9_mul_p9:std_logic_vector(3 downto 0) := (others=>'0');
signal k1p1_add_k2p2,k3p3_add_k4p4,k5p5_add_k6p6,k7p7_add_k8p8:std_logic_vector(3 downto 0) := (others=>'0');
signal kp12_add_kp34,kp56_add_kp78,kp1234_add_kp5678:std_logic_vector(3 downto 0) := (others=>'0');
signal ack_reg: std_logic:='0';
signal fsm: natural range 0 to 3:=0;
signal cnt_reg:natural range 0 to 31:=0;
constant max_cnt_reg:natural range 0 to 31:=10;

constant k1_16: std_logic_vector(3 downto 0) := conv_std_logic_vector(k1 mod 16,4);
constant k2_16: std_logic_vector(3 downto 0) := conv_std_logic_vector(k2 mod 16,4);
constant k3_16: std_logic_vector(3 downto 0) := conv_std_logic_vector(k3 mod 16,4);
constant k4_16: std_logic_vector(3 downto 0) := conv_std_logic_vector(k4 mod 16,4);
constant k5_16: std_logic_vector(3 downto 0) := conv_std_logic_vector(k5 mod 16,4);
constant k6_16: std_logic_vector(3 downto 0) := conv_std_logic_vector(k6 mod 16,4);
constant k7_16: std_logic_vector(3 downto 0) := conv_std_logic_vector(k7 mod 16,4);
constant k8_16: std_logic_vector(3 downto 0) := conv_std_logic_vector(k8 mod 16,4);
constant k9_16: std_logic_vector(3 downto 0) := conv_std_logic_vector(k9 mod 16,4);

component add_mod_16
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
end component;

component mul_mod_16
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
end component;

begin
	ack<=ack_reg;
	process (clk)
	begin
		if rising_edge(clk) then
			if en='1' then
			case fsm is
			when 0=>
				if start='1' and ack_reg='0' then
					ready<='0';
					ack_reg<='1';
					cnt_reg<=0;
					fsm<=1;
				else ack_reg<='0';
				end if;
			when 1=>
				if cnt_reg=max_cnt_reg then
					res<=sum_reg;
					ready<='1';
					fsm<=0;
				else cnt_reg<=cnt_reg+1;
				end if;
			when others=>null;
			end case;
			else ready<='0'; ack_reg<='0'; res<=(others=>'0');
			end if;
		end if;
	end process;

   k1_mul_p1_chip: mul_mod_16 port map(clk,en,k1_16,p1,k1_mul_p1);
   k2_mul_p2_chip: mul_mod_16 port map(clk,en,k2_16,p2,k2_mul_p2);
   k3_mul_p3_chip: mul_mod_16 port map(clk,en,k3_16,p3,k3_mul_p3);
   k4_mul_p4_chip: mul_mod_16 port map(clk,en,k4_16,p4,k4_mul_p4);
   k5_mul_p5_chip: mul_mod_16 port map(clk,en,k5_16,p5,k5_mul_p5);
   k6_mul_p6_chip: mul_mod_16 port map(clk,en,k6_16,p6,k6_mul_p6);
   k7_mul_p7_chip: mul_mod_16 port map(clk,en,k7_16,p7,k7_mul_p7);
   k8_mul_p8_chip: mul_mod_16 port map(clk,en,k8_16,p8,k8_mul_p8);
   k9_mul_p9_chip: mul_mod_16 port map(clk,en,k9_16,p9,k9_mul_p9);
   
   k1p1_add_k2p2_chip: add_mod_16 port map(clk,en,k1_mul_p1,k2_mul_p2,k1p1_add_k2p2);
   k3p3_add_k4p4_chip: add_mod_16 port map(clk,en,k3_mul_p3,k4_mul_p4,k3p3_add_k4p4);
   k5p5_add_k6p6_chip: add_mod_16 port map(clk,en,k5_mul_p5,k6_mul_p6,k5p5_add_k6p6);
   k7p7_add_k8p8_chip: add_mod_16 port map(clk,en,k7_mul_p7,k8_mul_p8,k7p7_add_k8p8);
   
   kp12_add_kp34_chip: add_mod_16 port map(clk,en,k1p1_add_k2p2,k3p3_add_k4p4,kp12_add_kp34);
   kp56_add_kp78_chip: add_mod_16 port map(clk,en,k5p5_add_k6p6,k7p7_add_k8p8,kp56_add_kp78);
   
   kp1234_add_kp5678_chip: add_mod_16 port map(clk,en,kp12_add_kp34,kp56_add_kp78,kp1234_add_kp5678);
   
   sum_chip: add_mod_16 port map(clk,en,k9_mul_p9,kp1234_add_kp5678,sum_reg);
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity filter_3x3_mod_31 is
    generic (
		k1: integer :=0;
		k2: integer :=0;
		k3: integer :=0;
		k4: integer :=0;
		k5: integer :=1;
		k6: integer :=0;
		k7: integer :=0;
		k8: integer :=0;
		k9: integer :=0
	 );
    Port ( 
		clk   : in STD_LOGIC;
      en    : in std_logic;
      p1  	: in STD_LOGIC_VECTOR(4 downto 0);
      p2  	: in STD_LOGIC_VECTOR(4 downto 0);
      p3  	: in STD_LOGIC_VECTOR(4 downto 0);
      p4  	: in STD_LOGIC_VECTOR(4 downto 0);
      p5 	: in STD_LOGIC_VECTOR(4 downto 0);
      p6  	: in STD_LOGIC_VECTOR(4 downto 0);
      p7  	: in STD_LOGIC_VECTOR(4 downto 0);
      p8  	: in STD_LOGIC_VECTOR(4 downto 0);
      p9  	: in STD_LOGIC_VECTOR(4 downto 0);
      res   : out STD_LOGIC_VECTOR(4 downto 0);
      start : in std_logic;
      ack   : out std_logic;
      ready : out std_logic
		);
end filter_3x3_mod_31;

architecture Behavioral of filter_3x3_mod_31 is
signal sum_reg:std_logic_vector(4 downto 0) := (others=>'0');
signal k1_mul_p1,k2_mul_p2,k3_mul_p3,
       k4_mul_p4,k5_mul_p5,k6_mul_p6,
       k7_mul_p7,k8_mul_p8,k9_mul_p9:std_logic_vector(4 downto 0) := (others=>'0');
signal k1p1_add_k2p2,k3p3_add_k4p4,k5p5_add_k6p6,k7p7_add_k8p8:std_logic_vector(4 downto 0) := (others=>'0');
signal kp12_add_kp34,kp56_add_kp78,kp1234_add_kp5678:std_logic_vector(4 downto 0) := (others=>'0');
signal ack_reg: std_logic:='0';
signal fsm: natural range 0 to 3:=0;
signal cnt_reg:natural range 0 to 31:=0;
constant max_cnt_reg:natural range 0 to 31:=10;

constant k1_31: std_logic_vector(4 downto 0) := conv_std_logic_vector(k1 mod 31,5);
constant k2_31: std_logic_vector(4 downto 0) := conv_std_logic_vector(k2 mod 31,5);
constant k3_31: std_logic_vector(4 downto 0) := conv_std_logic_vector(k3 mod 31,5);
constant k4_31: std_logic_vector(4 downto 0) := conv_std_logic_vector(k4 mod 31,5);
constant k5_31: std_logic_vector(4 downto 0) := conv_std_logic_vector(k5 mod 31,5);
constant k6_31: std_logic_vector(4 downto 0) := conv_std_logic_vector(k6 mod 31,5);
constant k7_31: std_logic_vector(4 downto 0) := conv_std_logic_vector(k7 mod 31,5);
constant k8_31: std_logic_vector(4 downto 0) := conv_std_logic_vector(k8 mod 31,5);
constant k9_31: std_logic_vector(4 downto 0) := conv_std_logic_vector(k9 mod 31,5);

component add_mod_31
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(4 downto 0);
		res: out std_logic_vector(4 downto 0)
	);
end component;

component mul_mod_31
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(4 downto 0);
		res: out std_logic_vector(4 downto 0)
	);
end component;

begin
	ack<=ack_reg;
	process (clk)
	begin
		if rising_edge(clk) then
			if en='1' then
			case fsm is
			when 0=>
				if start='1' and ack_reg='0' then
					ready<='0';
					ack_reg<='1';
					cnt_reg<=0;
					fsm<=1;
				else ack_reg<='0';
				end if;
			when 1=>
				if cnt_reg=max_cnt_reg then
					res<=sum_reg;
					ready<='1';
					fsm<=0;
				else cnt_reg<=cnt_reg+1;
				end if;
			when others=>null;
			end case;
			else ready<='0'; ack_reg<='0'; res<=(others=>'0');
			end if;
		end if;
	end process;

   k1_mul_p1_chip: mul_mod_31 port map(clk,en,k1_31,p1,k1_mul_p1);
   k2_mul_p2_chip: mul_mod_31 port map(clk,en,k2_31,p2,k2_mul_p2);
   k3_mul_p3_chip: mul_mod_31 port map(clk,en,k3_31,p3,k3_mul_p3);
   k4_mul_p4_chip: mul_mod_31 port map(clk,en,k4_31,p4,k4_mul_p4);
   k5_mul_p5_chip: mul_mod_31 port map(clk,en,k5_31,p5,k5_mul_p5);
   k6_mul_p6_chip: mul_mod_31 port map(clk,en,k6_31,p6,k6_mul_p6);
   k7_mul_p7_chip: mul_mod_31 port map(clk,en,k7_31,p7,k7_mul_p7);
   k8_mul_p8_chip: mul_mod_31 port map(clk,en,k8_31,p8,k8_mul_p8);
   k9_mul_p9_chip: mul_mod_31 port map(clk,en,k9_31,p9,k9_mul_p9);
   
   k1p1_add_k2p2_chip: add_mod_31 port map(clk,en,k1_mul_p1,k2_mul_p2,k1p1_add_k2p2);
   k3p3_add_k4p4_chip: add_mod_31 port map(clk,en,k3_mul_p3,k4_mul_p4,k3p3_add_k4p4);
   k5p5_add_k6p6_chip: add_mod_31 port map(clk,en,k5_mul_p5,k6_mul_p6,k5p5_add_k6p6);
   k7p7_add_k8p8_chip: add_mod_31 port map(clk,en,k7_mul_p7,k8_mul_p8,k7p7_add_k8p8);
   
   kp12_add_kp34_chip: add_mod_31 port map(clk,en,k1p1_add_k2p2,k3p3_add_k4p4,kp12_add_kp34);
   kp56_add_kp78_chip: add_mod_31 port map(clk,en,k5p5_add_k6p6,k7p7_add_k8p8,kp56_add_kp78);
   
   kp1234_add_kp5678_chip: add_mod_31 port map(clk,en,kp12_add_kp34,kp56_add_kp78,kp1234_add_kp5678);
   
   sum_chip: add_mod_31 port map(clk,en,k9_mul_p9,kp1234_add_kp5678,sum_reg);
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity rns_7_15_31_16_mrs is
	port (
		clk: in std_logic;
		en : in std_logic;
		a7: in std_logic_vector(2 downto 0);
      a15: in std_logic_vector(3 downto 0);
      a31: in std_logic_vector(4 downto 0);
      a16: in std_logic_vector(3 downto 0);
		res7: out std_logic_vector(2 downto 0);
		res15: out std_logic_vector(3 downto 0);
		res31: out std_logic_vector(4 downto 0);
		res16: out std_logic_vector(3 downto 0);
      start: in std_logic;
      ack: out std_logic;
      ready: out std_logic
	);
end rns_7_15_31_16_mrs;

architecture Behavioral of rns_7_15_31_16_mrs is
signal fsm: natural range 0 to 31 :=0;
signal ack_reg:std_logic := '0';
signal cnt_reg:natural range 0 to 31:=0;
constant max_cnt_reg:natural range 0 to 31:=8;

signal x1_7,x1s_7,x2_7,x2s_7,x3_7,x3s_7: std_logic_vector(2 downto 0) := (others=>'0');
signal x1_15,x1s_15,x2_15,x2s_15,x3_15,x3s_15: std_logic_vector(3 downto 0) := (others=>'0');
signal x1_31,x1s_31,x2_31,x2s_31,x3_31,x3s_31: std_logic_vector(4 downto 0) := (others=>'0');
signal x1_16,x1s_16,x2_16,x2s_16,x3_16,x3s_16: std_logic_vector(3 downto 0) := (others=>'0');

signal d1_7,d2_7,d3_7,neg_d1_7,neg_d2_7,neg_d3_7: std_logic_vector(2 downto 0) := (others=>'0');
signal d1_15,d2_15,d3_15,neg_d1_15,neg_d2_15,neg_d3_15: std_logic_vector(3 downto 0) := (others=>'0');
signal d1_31,d2_31,d3_31,neg_d1_31,neg_d2_31,neg_d3_31: std_logic_vector(4 downto 0) := (others=>'0');
signal d1_16,d2_16,d3_16,neg_d1_16,neg_d2_16,neg_d3_16: std_logic_vector(3 downto 0) := (others=>'0');

constant inv_7_7: std_logic_vector(2 downto 0) := (others=>'0');
constant inv_7_15: std_logic_vector(3 downto 0) := conv_std_logic_vector(13,4);
constant inv_7_31: std_logic_vector(4 downto 0) := conv_std_logic_vector(9,5);
constant inv_7_16: std_logic_vector(3 downto 0) := conv_std_logic_vector(7,4);

constant inv_15_7: std_logic_vector(2 downto 0) := conv_std_logic_vector(1,3);
constant inv_15_15: std_logic_vector(3 downto 0) := (others=>'0');
constant inv_15_31: std_logic_vector(4 downto 0) := conv_std_logic_vector(29,5);
constant inv_15_16: std_logic_vector(3 downto 0) := conv_std_logic_vector(15,4);

constant inv_31_7: std_logic_vector(2 downto 0) := conv_std_logic_vector(5,3);
constant inv_31_15: std_logic_vector(3 downto 0) := conv_std_logic_vector(1,4);
constant inv_31_31: std_logic_vector(4 downto 0) := (others=>'0');
constant inv_31_16: std_logic_vector(3 downto 0) := conv_std_logic_vector(15,4);

type rom_type is array (0 to 127) of std_logic_vector(4 downto 0);
constant n_rom : rom_type := (
conv_std_logic_vector(0,5),conv_std_logic_vector(0,5),conv_std_logic_vector(0,5),conv_std_logic_vector(0,5),
conv_std_logic_vector(1,5),conv_std_logic_vector(1,5),conv_std_logic_vector(1,5),conv_std_logic_vector(1,5),
conv_std_logic_vector(2,5),conv_std_logic_vector(2,5),conv_std_logic_vector(2,5),conv_std_logic_vector(2,5),
conv_std_logic_vector(3,5),conv_std_logic_vector(3,5),conv_std_logic_vector(3,5),conv_std_logic_vector(3,5),
conv_std_logic_vector(4,5),conv_std_logic_vector(4,5),conv_std_logic_vector(4,5),conv_std_logic_vector(4,5),
conv_std_logic_vector(5,5),conv_std_logic_vector(5,5),conv_std_logic_vector(5,5),conv_std_logic_vector(5,5),
conv_std_logic_vector(6,5),conv_std_logic_vector(6,5),conv_std_logic_vector(6,5),conv_std_logic_vector(6,5),
conv_std_logic_vector(0,5),conv_std_logic_vector(7,5),conv_std_logic_vector(7,5),conv_std_logic_vector(7,5),
conv_std_logic_vector(1,5),conv_std_logic_vector(8,5),conv_std_logic_vector(8,5),conv_std_logic_vector(8,5),
conv_std_logic_vector(2,5),conv_std_logic_vector(9,5),conv_std_logic_vector(9,5),conv_std_logic_vector(9,5),
conv_std_logic_vector(3,5),conv_std_logic_vector(10,5),conv_std_logic_vector(10,5),conv_std_logic_vector(10,5),
conv_std_logic_vector(4,5),conv_std_logic_vector(11,5),conv_std_logic_vector(11,5),conv_std_logic_vector(11,5),
conv_std_logic_vector(5,5),conv_std_logic_vector(12,5),conv_std_logic_vector(12,5),conv_std_logic_vector(12,5),
conv_std_logic_vector(6,5),conv_std_logic_vector(13,5),conv_std_logic_vector(13,5),conv_std_logic_vector(13,5),
conv_std_logic_vector(0,5),conv_std_logic_vector(14,5),conv_std_logic_vector(14,5),conv_std_logic_vector(14,5),
conv_std_logic_vector(1,5),conv_std_logic_vector(0,5),conv_std_logic_vector(15,5),conv_std_logic_vector(15,5),
conv_std_logic_vector(2,5),conv_std_logic_vector(1,5),conv_std_logic_vector(16,5),conv_std_logic_vector(0,5),
conv_std_logic_vector(3,5),conv_std_logic_vector(2,5),conv_std_logic_vector(17,5),conv_std_logic_vector(1,5),
conv_std_logic_vector(4,5),conv_std_logic_vector(3,5),conv_std_logic_vector(18,5),conv_std_logic_vector(2,5),
conv_std_logic_vector(5,5),conv_std_logic_vector(4,5),conv_std_logic_vector(19,5),conv_std_logic_vector(3,5),
conv_std_logic_vector(6,5),conv_std_logic_vector(5,5),conv_std_logic_vector(20,5),conv_std_logic_vector(4,5),
conv_std_logic_vector(0,5),conv_std_logic_vector(6,5),conv_std_logic_vector(21,5),conv_std_logic_vector(5,5),
conv_std_logic_vector(1,5),conv_std_logic_vector(7,5),conv_std_logic_vector(22,5),conv_std_logic_vector(6,5),
conv_std_logic_vector(2,5),conv_std_logic_vector(8,5),conv_std_logic_vector(23,5),conv_std_logic_vector(7,5),
conv_std_logic_vector(3,5),conv_std_logic_vector(9,5),conv_std_logic_vector(24,5),conv_std_logic_vector(8,5),
conv_std_logic_vector(4,5),conv_std_logic_vector(10,5),conv_std_logic_vector(25,5),conv_std_logic_vector(9,5),
conv_std_logic_vector(5,5),conv_std_logic_vector(11,5),conv_std_logic_vector(26,5),conv_std_logic_vector(10,5),
conv_std_logic_vector(6,5),conv_std_logic_vector(12,5),conv_std_logic_vector(27,5),conv_std_logic_vector(11,5),
conv_std_logic_vector(0,5),conv_std_logic_vector(13,5),conv_std_logic_vector(28,5),conv_std_logic_vector(12,5),
conv_std_logic_vector(1,5),conv_std_logic_vector(14,5),conv_std_logic_vector(29,5),conv_std_logic_vector(13,5),
conv_std_logic_vector(2,5),conv_std_logic_vector(0,5),conv_std_logic_vector(30,5),conv_std_logic_vector(14,5),
conv_std_logic_vector(3,5),conv_std_logic_vector(1,5),conv_std_logic_vector(0,5),conv_std_logic_vector(15,5)
);

component neg_mod_7
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(2 downto 0);
		res: out std_logic_vector(2 downto 0)
	);
end component;

component add_mod_7
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(2 downto 0);
		res: out std_logic_vector(2 downto 0)
	);
end component;

component mul_mod_7
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(2 downto 0);
		res: out std_logic_vector(2 downto 0)
	);
end component;

component neg_mod_15
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
end component;

component add_mod_15
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
end component;

component mul_mod_15
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
end component;

component neg_mod_31
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(4 downto 0);
		res: out std_logic_vector(4 downto 0)
	);
end component;

component add_mod_31
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(4 downto 0);
		res: out std_logic_vector(4 downto 0)
	);
end component;

component mul_mod_31
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(4 downto 0);
		res: out std_logic_vector(4 downto 0)
	);
end component;

component neg_mod_16
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
end component;

component add_mod_16
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
end component;

component mul_mod_16
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(3 downto 0)
	);
end component;

begin
	ack<=ack_reg;
	process (clk)
	begin
		if rising_edge(clk) then
			if en='1' then
			case fsm is
			when 0=>
				if start='1' and ack_reg='0' then
					ready<='0';
					ack_reg<='1';
					cnt_reg<=0;
					fsm<=1;
				else ack_reg<='0';
				end if;
			when 1=>
				if cnt_reg=max_cnt_reg then
					res7<=a7;
					res15<=x1s_15;
					res31<=x2s_31;
					res16<=x3s_16;
					ready<='1';
					fsm<=0;
				else cnt_reg<=cnt_reg+1;
				end if;
			when others=>null;
			end case;
			else ready<='0'; ack_reg<='0';
				  res7<="000"; res15<="0000";
				  res31<="00000"; res16<="0000";
			end if;
		end if;
	end process;
	
   d1_7 <=n_rom(conv_integer(a7)*4)(2 downto 0);
   d1_15<=n_rom(conv_integer(a7)*4+1)(3 downto 0);
   d1_31<=n_rom(conv_integer(a7)*4+2);
   d1_16<=n_rom(conv_integer(a7)*4+3)(3 downto 0);

   --   d2_7<=n_rom(conv_integer(x1s_15)*4)(2 downto 0);
   d2_15<=n_rom(conv_integer(x1s_15)*4+1)(3 downto 0);
   d2_31<=n_rom(conv_integer(x1s_15)*4+2);
   d2_16<=n_rom(conv_integer(x1s_15)*4+3)(3 downto 0);

   --   d3_7<=n_rom(conv_integer(x2s_31)*4)(2 downto 0);
   --   d3_15<=n_rom(conv_integer(x2s_31)*4+1)(3 downto 0);
   d3_31<=n_rom(conv_integer(x2s_31)*4+2);
   d3_16<=n_rom(conv_integer(x2s_31)*4+3)(3 downto 0);

   neg_d1_7_chip: neg_mod_7 port map (clk,en,d1_7,neg_d1_7);
   neg_d1_15_chip: neg_mod_15 port map (clk,en,d1_15,neg_d1_15);
   neg_d1_31_chip: neg_mod_31 port map (clk,en,d1_31,neg_d1_31);
   neg_d1_16_chip: neg_mod_16 port map (clk,en,d1_16,neg_d1_16);
   
   sub_A_d1_7_chip: add_mod_7 port map (clk,en,a7,neg_d1_7,x1_7);
   sub_A_d1_15_chip: add_mod_15 port map (clk,en,a15,neg_d1_15,x1_15);
   sub_A_d1_31_chip: add_mod_31 port map (clk,en,a31,neg_d1_31,x1_31);
   sub_A_d1_16_chip: add_mod_16 port map (clk,en,a16,neg_d1_16,x1_16);
   
--   div_x1_7_7_chip: mul_mod_7 port map (clk,en,x1_7,inv_7_7,x1s_7);
   div_x1_7_15_chip: mul_mod_15 port map (clk,en,x1_15,inv_7_15,x1s_15);
   div_x1_7_31_chip: mul_mod_31 port map (clk,en,x1_31,inv_7_31,x1s_31);
   div_x1_7_16_chip: mul_mod_16 port map (clk,en,x1_16,inv_7_16,x1s_16);


--   neg_d2_7_chip: neg_mod_7 port map (clk,en,d2_7,neg_d2_7);
   neg_d2_15_chip: neg_mod_15 port map (clk,en,d2_15,neg_d2_15);
   neg_d2_31_chip: neg_mod_31 port map (clk,en,d2_31,neg_d2_31);
   neg_d2_16_chip: neg_mod_16 port map (clk,en,d2_16,neg_d2_16);
   
--   sub_x1s_d2_7_chip: add_mod_7 port map (clk,en,x1s_7,neg_d2_7,x2_7);
   sub_x1s_d2_15_chip: add_mod_15 port map (clk,en,x1s_15,neg_d2_15,x2_15);
   sub_x1s_d2_31_chip: add_mod_31 port map (clk,en,x1s_31,neg_d2_31,x2_31);
   sub_x1s_d2_16_chip: add_mod_16 port map (clk,en,x1s_16,neg_d2_16,x2_16);
   
--   div_x2_15_7_chip: mul_mod_7 port map (clk,en,x2_7,inv_15_7,x2s_7);
--   div_x2_15_15_chip: mul_mod_15 port map (clk,en,x2_15,inv_15_15,x2s_15);
   div_x2_15_31_chip: mul_mod_31 port map (clk,en,x2_31,inv_15_31,x2s_31);
   div_x2_15_16_chip: mul_mod_16 port map (clk,en,x2_16,inv_15_16,x2s_16);
   

--   neg_d3_7_chip: neg_mod_7 port map (clk,en,d3_7,neg_d3_7);
--   neg_d3_15_chip: neg_mod_15 port map (clk,en,d3_15,neg_d3_15);
   neg_d3_31_chip: neg_mod_31 port map (clk,en,d3_31,neg_d3_31);
   neg_d3_16_chip: neg_mod_16 port map (clk,en,d3_16,neg_d3_16);
   
--   sub_x2s_d3_7_chip: add_mod_7 port map (clk,en,x2s_7,neg_d3_7,x3_7);
--   sub_x2s_d3_15_chip: add_mod_15 port map (clk,en,x2s_15,neg_d3_15,x3_15);
   sub_x2s_d3_31_chip: add_mod_31 port map (clk,en,x2s_31,neg_d3_31,x3_31);
   sub_x2s_d3_16_chip: add_mod_16 port map (clk,en,x2s_16,neg_d3_16,x3_16);
   
--   div_x3_31_7_chip: mul_mod_7 port map (clk,en,x3_7,inv_31_7,x3s_7);
--   div_x3_31_15_chip: mul_mod_15 port map (clk,en,x3_15,inv_31_15,x3s_15);
--   div_x3_31_31_chip: mul_mod_31 port map (clk,en,x3_31,inv_31_31,x3s_31);
   div_x3_31_16_chip: mul_mod_16 port map (clk,en,x3_16,inv_31_16,x3s_16);
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity rns_7_15_31_16_bss_16bit is
	port (
		clk: in std_logic;
		en : in std_logic;
		a7: in std_logic_vector(2 downto 0);
      a15: in std_logic_vector(3 downto 0);
      a31: in std_logic_vector(4 downto 0);
      a16: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(15 downto 0);
      start: in std_logic;
      ack: out std_logic;
      ready: out std_logic
	);
end rns_7_15_31_16_bss_16bit;

architecture Behavioral of rns_7_15_31_16_bss_16bit is
	component rns_7_15_31_16_mrs is
	port (
		clk: in std_logic;
		en : in std_logic;
		a7: in std_logic_vector(2 downto 0);
      a15: in std_logic_vector(3 downto 0);
      a31: in std_logic_vector(4 downto 0);
      a16: in std_logic_vector(3 downto 0);
		res7: out std_logic_vector(2 downto 0);
		res15: out std_logic_vector(3 downto 0);
		res31: out std_logic_vector(4 downto 0);
		res16: out std_logic_vector(3 downto 0);
      start: in std_logic;
      ack: out std_logic;
      ready: out std_logic
	);
	end component;

   component sub_16bit is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(15 downto 0);
		res: out std_logic_vector(15 downto 0)
	);
   end component;

   component add_16bit is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(15 downto 0);
		res: out std_logic_vector(15 downto 0)
	);
   end component;
   
	signal fsm: natural range 0 to 15 :=0;
	signal d4_mul_31,tmp1,tmp1_mul_15,tmp2,tmp2_mul_7:std_logic_vector(15 downto 0) := (others=>'0');
	signal ack_reg:std_logic := '0';
	signal d1,d2,d3,d4,res_reg: std_logic_vector(15 downto 0) := (others=>'0');
	signal rns_mrs_start,rns_mrs_ack,rns_mrs_ready: std_logic:='0';

begin
	rns_7_15_31_16_mrs_chip: rns_7_15_31_16_mrs
	port map (
		clk=>clk,
		en=>en,
		a7=>a7,
		a15=>a15,
		a31=>a31,
		a16=>a16,
		res7=>d1(2 downto 0),
		res15=>d2(3 downto 0),
		res31=>d3(4 downto 0),
		res16=>d4(3 downto 0),
		start=>rns_mrs_start,
		ack=>rns_mrs_ack,
		ready=>rns_mrs_ready
	);
   d1(15 downto 3)<=(others=>'0');
   d2(15 downto 4)<=(others=>'0');
   d3(15 downto 5)<=(others=>'0');
   d4(15 downto 4)<=(others=>'0');
	
   ack<=ack_reg;
   process (clk)
   begin
      if rising_edge(clk) then
      if en='1' then
case fsm is
         when 0=>
            if start='1' and ack_reg='0' then
				   ready<='0';
					ack_reg<='1';
					rns_mrs_start<='1';
					fsm<=1;
				else ack_reg<='0';
				end if;

         when 1=>
				if rns_mrs_ack='1' then
					rns_mrs_start<='0';
					fsm<=2;
				end if;
			when 2=>
				if rns_mrs_ready='1' then
					fsm<=3;
				end if;
            
         when 3=> fsm<=4;
         when 4=> fsm<=5;
         when 5=> fsm<=6;
         when 6=> fsm<=7;
         when 7=> fsm<=8;
         when 8=> fsm<=9;
         when 9=> res<=res_reg;
                  ready<='1';
                  fsm<=0;
         when others=> null;
         end case;
         else
         ready<='0'; ack_reg<='0'; res<=(others=>'0');
      end if;
      end if;
   end process;
   
   d4_mul_31_chip: sub_16bit port map(clk,en,d4(10 downto 0)&"00000",d4,d4_mul_31);
   tmp1_chip: add_16bit port map(clk,en,d4_mul_31,d3,tmp1);
   
   tmp1_mul_15_chip: sub_16bit port map(clk,en,tmp1(11 downto 0)&"0000",tmp1,tmp1_mul_15);
   tmp2_chip: add_16bit port map(clk,en,tmp1_mul_15,d2,tmp2);

   tmp2_mul_7_chip: sub_16bit port map(clk,en,tmp2(12 downto 0)&"000",tmp2,tmp2_mul_7);
   res_chip: add_16bit port map(clk,en,tmp2_mul_7,d1,res_reg);
   
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bss_8bit_rns_7_15_31_16 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(7 downto 0);
		res_7: out std_logic_vector(2 downto 0);
      res_15: out std_logic_vector(3 downto 0);
      res_31: out std_logic_vector(4 downto 0);
      res_16: out std_logic_vector(3 downto 0);
      start: in std_logic;
      ack: out std_logic;
      ready: out std_logic
	);
end bss_8bit_rns_7_15_31_16;

architecture Behavioral of bss_8bit_rns_7_15_31_16 is
   component bss8_mod_7 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(7 downto 0);
		res: out std_logic_vector(2 downto 0);
		start: in std_logic;
		ack: out std_logic;
		ready: out std_logic		
	);
   end component;

   component bss8_mod_15 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(7 downto 0);
		res: out std_logic_vector(3 downto 0);
		start: in std_logic;
		ack: out std_logic;
		ready: out std_logic		
	);
   end component;

   component bss8_mod_31 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(7 downto 0);
		res: out std_logic_vector(4 downto 0);
		start: in std_logic;
		ack: out std_logic;
		ready: out std_logic
	);
   end component;

   component bss8_mod_16 is
	port (
		clk: in std_logic;
		en : in std_logic;
		a: in std_logic_vector(7 downto 0);
		res: out std_logic_vector(3 downto 0);
		start: in std_logic;
		ack: out std_logic;
		ready: out std_logic
	);
   end component;

   signal ack_reg: std_logic:='0';
   signal fsm: natural range 0 to 3:=0;
   signal res7_reg: std_logic_vector(2 downto 0);
   signal res15_reg: std_logic_vector(3 downto 0);
   signal res31_reg: std_logic_vector(4 downto 0);
   signal res16_reg: std_logic_vector(3 downto 0);
   signal mod7_start,mod15_start,mod31_start,mod16_start:std_logic:='0';
   signal mod7_ack,mod15_ack,mod31_ack,mod16_ack:std_logic:='0';
   signal mod7_ready,mod15_ready,mod31_ready,mod16_ready:std_logic:='0';
begin
   ack<=ack_reg;
   process (clk)
   begin
      if rising_edge(clk) then
      if en='1' then
         case fsm is
         when 0=>
            if start='1' and ack_reg='0' then
				   ready<='0';
					ack_reg<='1';
					mod7_start<='1';
               mod15_start<='1';
               mod31_start<='1';
               mod16_start<='1';
					fsm<=1;
				else ack_reg<='0';
				end if;

         when 1=>
				if mod7_ack='1' then	mod7_start<='0'; end if;
            if mod15_ack='1' then mod15_start<='0'; end if;
            if mod31_ack='1' then mod31_start<='0'; end if;
            if mod16_ack='1' then mod16_start<='0'; end if;
            if (mod7_start or mod15_start or mod31_start or mod16_start)='0'
            then fsm<=2;
            else fsm<=1;
            end if;
			when 2=>
            if (mod7_ready and mod15_ready and mod31_ready and mod16_ready)='1' then
               res_7<=res7_reg;
               res_15<=res15_reg;
               res_31<=res31_reg;
               res_16<=res16_reg;
               ready<='1';
               fsm<=0;
            else
               fsm<=1;
            end if;
         when others=> null;
         end case;
         else
         ready<='0'; ack_reg<='0';
         res_7<=(others=>'0');
         res_15<=(others=>'0');
         res_31<=(others=>'0');
         res_16<=(others=>'0');
      end if;
      end if;
   end process;
   
   mod_7_chip: bss8_mod_7 port map(clk,en,a,res7_reg,mod7_start,mod7_ack,mod7_ready);
   mod_15_chip: bss8_mod_15 port map(clk,en,a,res15_reg,mod15_start,mod15_ack,mod15_ready);
   mod_31_chip: bss8_mod_31 port map(clk,en,a,res31_reg,mod31_start,mod31_ack,mod31_ready);
   mod_16_chip: bss8_mod_16 port map(clk,en,a,res16_reg,mod16_start,mod16_ack,mod16_ready);
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity filter_3x3_rns is
    generic (
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
		clk   : in STD_LOGIC;
      en    : in std_logic;
      p1  	: in STD_LOGIC_VECTOR(15 downto 0);
      p2  	: in STD_LOGIC_VECTOR(15 downto 0);
      p3  	: in STD_LOGIC_VECTOR(15 downto 0);
      p4  	: in STD_LOGIC_VECTOR(15 downto 0);
      p5 	: in STD_LOGIC_VECTOR(15 downto 0);
      p6  	: in STD_LOGIC_VECTOR(15 downto 0);
      p7  	: in STD_LOGIC_VECTOR(15 downto 0);
      p8  	: in STD_LOGIC_VECTOR(15 downto 0);
      p9  	: in STD_LOGIC_VECTOR(15 downto 0);
      res   : out STD_LOGIC_VECTOR(7 downto 0);
      start : in std_logic;
      ack   : out std_logic;
      ready : out std_logic
		);
end filter_3x3_rns;

architecture Behavioral of filter_3x3_rns is
   signal fsm: natural range 0 to 15 :=0;
   signal ack_reg: std_logic :='0';

   signal sum7: std_logic_vector(2 downto 0) := (others => '0');
	signal filter_mod7_start,filter_mod7_ack,filter_mod7_ready:std_logic:='0';
	
   signal sum15: std_logic_vector(3 downto 0) := (others => '0');
	signal filter_mod15_start,filter_mod15_ack,filter_mod15_ready:std_logic:='0';
	
   signal sum31: std_logic_vector(4 downto 0) := (others => '0');
	signal filter_mod31_start,filter_mod31_ack,filter_mod31_ready:std_logic:='0';
	
   signal sum16: std_logic_vector(3 downto 0) := (others => '0');
	signal filter_mod16_start,filter_mod16_ack,filter_mod16_ready:std_logic:='0';

   signal rns_bss_start,rns_bss_ack,rns_bss_ready: std_logic:='0';
	signal sum_bss: STD_LOGIC_VECTOR(15 downto 0):=(others=>'0');   

   component rns_7_15_31_16_bss_16bit is
	port (
		clk: in std_logic;
		en : in std_logic;
		a7: in std_logic_vector(2 downto 0);
      a15: in std_logic_vector(3 downto 0);
      a31: in std_logic_vector(4 downto 0);
      a16: in std_logic_vector(3 downto 0);
		res: out std_logic_vector(15 downto 0);
      start: in std_logic;
      ack: out std_logic;
      ready: out std_logic
	);
   end component;

	COMPONENT filter_3x3_mod_7 is
   GENERIC (
		k1: integer :=0;
		k2: integer :=0;
		k3: integer :=0;
		k4: integer :=0;
		k5: integer :=1;
		k6: integer :=0;
		k7: integer :=0;
		k8: integer :=0;
		k9: integer :=0
	 );	
   PORT ( 
		clk   : in  STD_LOGIC;
      en    : in std_logic;
      p1  	: in STD_LOGIC_VECTOR(2 downto 0);
      p2  	: in STD_LOGIC_VECTOR(2 downto 0);
      p3  	: in STD_LOGIC_VECTOR(2 downto 0);
      p4  	: in STD_LOGIC_VECTOR(2 downto 0);
      p5 	: in STD_LOGIC_VECTOR(2 downto 0);
      p6  	: in STD_LOGIC_VECTOR(2 downto 0);
      p7  	: in STD_LOGIC_VECTOR(2 downto 0);
      p8  	: in STD_LOGIC_VECTOR(2 downto 0);
      p9  	: in STD_LOGIC_VECTOR(2 downto 0);
      res   : out STD_LOGIC_VECTOR(2 downto 0);
      start : in std_logic;
      ack   : out std_logic;
      ready : out std_logic
		);
	END COMPONENT;

	COMPONENT filter_3x3_mod_15 is
   GENERIC (
		k1: integer :=0;
		k2: integer :=0;
		k3: integer :=0;
		k4: integer :=0;
		k5: integer :=1;
		k6: integer :=0;
		k7: integer :=0;
		k8: integer :=0;
		k9: integer :=0
	 );	
   PORT ( 
		clk   : in  STD_LOGIC;
      en    : in std_logic;
      p1  	: in STD_LOGIC_VECTOR(3 downto 0);
      p2  	: in STD_LOGIC_VECTOR(3 downto 0);
      p3  	: in STD_LOGIC_VECTOR(3 downto 0);
      p4  	: in STD_LOGIC_VECTOR(3 downto 0);
      p5 	: in STD_LOGIC_VECTOR(3 downto 0);
      p6  	: in STD_LOGIC_VECTOR(3 downto 0);
      p7  	: in STD_LOGIC_VECTOR(3 downto 0);
      p8  	: in STD_LOGIC_VECTOR(3 downto 0);
      p9  	: in STD_LOGIC_VECTOR(3 downto 0);
      res   : out STD_LOGIC_VECTOR(3 downto 0);
      start : in std_logic;
      ack   : out std_logic;
      ready : out std_logic
	);
	END COMPONENT;

	COMPONENT filter_3x3_mod_31 is
   GENERIC (
		k1: integer :=0;
		k2: integer :=0;
		k3: integer :=0;
		k4: integer :=0;
		k5: integer :=1;
		k6: integer :=0;
		k7: integer :=0;
		k8: integer :=0;
		k9: integer :=0
	 );	
   PORT ( 
		clk   : in  STD_LOGIC;
      en    : in std_logic;
      p1  	: in STD_LOGIC_VECTOR(4 downto 0);
      p2  	: in STD_LOGIC_VECTOR(4 downto 0);
      p3  	: in STD_LOGIC_VECTOR(4 downto 0);
      p4  	: in STD_LOGIC_VECTOR(4 downto 0);
      p5 	: in STD_LOGIC_VECTOR(4 downto 0);
      p6  	: in STD_LOGIC_VECTOR(4 downto 0);
      p7  	: in STD_LOGIC_VECTOR(4 downto 0);
      p8  	: in STD_LOGIC_VECTOR(4 downto 0);
      p9  	: in STD_LOGIC_VECTOR(4 downto 0);
      res   : out STD_LOGIC_VECTOR(4 downto 0);
      start : in std_logic;
      ack   : out std_logic;
      ready : out std_logic
		);
	END COMPONENT;

	COMPONENT filter_3x3_mod_16 is
   GENERIC (
		k1: integer :=0;
		k2: integer :=0;
		k3: integer :=0;
		k4: integer :=0;
		k5: integer :=1;
		k6: integer :=0;
		k7: integer :=0;
		k8: integer :=0;
		k9: integer :=0
	 );	
   PORT ( 
		clk   : in  STD_LOGIC;
      en    : in std_logic;
      p1  	: in STD_LOGIC_VECTOR(3 downto 0);
      p2  	: in STD_LOGIC_VECTOR(3 downto 0);
      p3  	: in STD_LOGIC_VECTOR(3 downto 0);
      p4  	: in STD_LOGIC_VECTOR(3 downto 0);
      p5 	: in STD_LOGIC_VECTOR(3 downto 0);
      p6  	: in STD_LOGIC_VECTOR(3 downto 0);
      p7  	: in STD_LOGIC_VECTOR(3 downto 0);
      p8  	: in STD_LOGIC_VECTOR(3 downto 0);
      p9  	: in STD_LOGIC_VECTOR(3 downto 0);
      res   : out STD_LOGIC_VECTOR(3 downto 0);
      start : in std_logic;
      ack   : out std_logic;
      ready : out std_logic
		);
	END COMPONENT;
 
begin
   rns_bss_16: rns_7_15_31_16_bss_16bit
   port map (clk,en,sum7,sum15,sum31,sum16,sum_bss,rns_bss_start,rns_bss_ack,rns_bss_ready);
   
	filter_mod_7: filter_3x3_mod_7
	GENERIC MAP (k1,k2,k3,k4,k5,k6,k7,k8,k9)
	PORT MAP (clk,en,
				 p1(2 downto 0),p2(2 downto 0),p3(2 downto 0),
             p4(2 downto 0),p5(2 downto 0),p6(2 downto 0),
             p7(2 downto 0),p8(2 downto 0),p9(2 downto 0),
             sum7,
				 filter_mod7_start,filter_mod7_ack,filter_mod7_ready);

	filter_mod_15: filter_3x3_mod_15
	GENERIC MAP (k1,k2,k3,k4,k5,k6,k7,k8,k9)
	PORT MAP (clk,en,
             p1(6 downto 3),p2(6 downto 3),p3(6 downto 3),
             p4(6 downto 3),p5(6 downto 3),p6(6 downto 3),
             p7(6 downto 3),p8(6 downto 3),p9(6 downto 3),
             sum15,
				 filter_mod15_start,filter_mod15_ack,filter_mod15_ready);

	filter_mod_31: filter_3x3_mod_31
	GENERIC MAP (k1,k2,k3,k4,k5,k6,k7,k8,k9)
	PORT MAP (clk,en,
             p1(11 downto 7),p2(11 downto 7),p3(11 downto 7),
             p4(11 downto 7),p5(11 downto 7),p6(11 downto 7),
             p7(11 downto 7),p8(11 downto 7),p9(11 downto 7),
             sum31,
				 filter_mod31_start,filter_mod31_ack,filter_mod31_ready);

	filter_mod_16: filter_3x3_mod_16
	GENERIC MAP (k1,k2,k3,k4,k5,k6,k7,k8,k9)
	PORT MAP (clk,en,
             p1(15 downto 12),p2(15 downto 12),p3(15 downto 12),
             p4(15 downto 12),p5(15 downto 12),p6(15 downto 12),
             p7(15 downto 12),p8(15 downto 12),p9(15 downto 12),
             sum16,
				 filter_mod16_start,filter_mod16_ack,filter_mod16_ready);

	ack<=ack_reg;
   process (clk)
   begin
      if rising_edge(clk) then
      if en='1' then
         case fsm is
         when 0 =>
				if start='1' and ack_reg='0' then
					ready<='0';
					ack_reg<='1';
					fsm<=4;
				else ack_reg<='0';
				end if;
         when 4 =>
				filter_mod7_start<='1';
				filter_mod15_start<='1';
				filter_mod31_start<='1';
				filter_mod16_start<='1';
				fsm<=5;
         when 5=>
				if filter_mod7_ack='1' then filter_mod7_start<='0'; end if;
				if filter_mod15_ack='1' then filter_mod15_start<='0'; end if;
				if filter_mod31_ack='1' then filter_mod31_start<='0'; end if;
				if filter_mod16_ack='1' then filter_mod16_start<='0'; end if;
            if (
               filter_mod7_start or
               filter_mod15_start or
               filter_mod31_start or
               filter_mod16_start
               )='0'
            then fsm<=6;
            else fsm<=5;
            end if;
         when 6 =>
				if (
					filter_mod7_ready and
					filter_mod15_ready and
					filter_mod31_ready and
					filter_mod16_ready
					)='1'
				then fsm<=7;
				else fsm<=5;
				end if;

         when 7=>
            rns_bss_start<='1';
            fsm<=8;
         when 8 =>
            if rns_bss_ack='1' then 
               rns_bss_start<='0';
               fsm<=9;
            end if;
         when 9 =>
			   if rns_bss_ready='1' then fsm<=10; end if;
				
         when 10 =>
               if (sum_bss(15) or sum_bss(14))='1' then res<=(others=>'0');
               elsif sum_bss(13 downto 8+pow2_divider)/=0 then res<=(others=>'1');
               else res<=sum_bss(7+pow2_divider downto pow2_divider);
               end if;
               ready<='1';
               fsm<=0;
         when others => null;
         end case;
		else ready<='0'; ack_reg<='0'; res<=(others=>'0');
      end if;
      end if;
   end process;
end Behavioral;
