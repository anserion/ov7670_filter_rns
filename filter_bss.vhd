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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity LFSR_16bit is
	port (
		clk: in std_logic;
		en : in std_logic;
      reset: in std_logic;
		res: out std_logic_vector(15 downto 0)
	);
end LFSR_16bit;

architecture Behavioral of LFSR_16bit is
signal b: std_logic_vector(15 downto 0):=(0=>'1', others=>'0');
begin
   res<=b;
	process (clk)
	begin
      if reset='1' then b<=(0=>'1', others=>'0');
		elsif rising_edge(clk) then
         if en='1' then
            b<=b(15 downto 1) & (b(15) xor b(13) xor b(12) xor b(10));
         end if;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity add_6bit is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(5 downto 0);
		res: out std_logic_vector(5 downto 0)
	);
end add_6bit;

architecture Behavioral of add_6bit is
	component full_adder is
	port (
		a,b,c_in: in std_logic;
		s,c_out : out std_logic
	);
	end component;
signal res_reg: std_logic_vector(5 downto 0);
signal p:std_logic_vector(5 downto 0);
begin
	FA0: full_adder port map(a(0),b(0),'0',res_reg(0),p(0));
	FA1: full_adder port map(a(1),b(1),p(0),res_reg(1),p(1));
	FA2: full_adder port map(a(2),b(2),p(1),res_reg(2),p(2));
	FA3: full_adder port map(a(3),b(3),p(2),res_reg(3),p(3));
	FA4: full_adder port map(a(4),b(4),p(3),res_reg(4),p(4));
	FA5: full_adder port map(a(5),b(5),p(4),res_reg(5),p(5));
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

entity add_16bit is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(15 downto 0);
		res: out std_logic_vector(15 downto 0)
	);
end add_16bit;

architecture Behavioral of add_16bit is
	component full_adder is
	port (
		a,b,c_in: in std_logic;
		s,c_out : out std_logic
	);
	end component;
signal res_reg: std_logic_vector(15 downto 0);
signal p:std_logic_vector(15 downto 0);
begin
	FA0: full_adder port map(a(0),b(0),'0',res_reg(0),p(0));
	FA1: full_adder port map(a(1),b(1),p(0),res_reg(1),p(1));
	FA2: full_adder port map(a(2),b(2),p(1),res_reg(2),p(2));
	FA3: full_adder port map(a(3),b(3),p(2),res_reg(3),p(3));
	FA4: full_adder port map(a(4),b(4),p(3),res_reg(4),p(4));
	FA5: full_adder port map(a(5),b(5),p(4),res_reg(5),p(5));
	FA6: full_adder port map(a(6),b(6),p(5),res_reg(6),p(6));
	FA7: full_adder port map(a(7),b(7),p(6),res_reg(7),p(7));
	FA8: full_adder port map(a(8),b(8),p(7),res_reg(8),p(8));
	FA9: full_adder port map(a(9),b(9),p(8),res_reg(9),p(9));
	FA10: full_adder port map(a(10),b(10),p(9),res_reg(10),p(10));
	FA11: full_adder port map(a(11),b(11),p(10),res_reg(11),p(11));
	FA12: full_adder port map(a(12),b(12),p(11),res_reg(12),p(12));
	FA13: full_adder port map(a(13),b(13),p(12),res_reg(13),p(13));
	FA14: full_adder port map(a(14),b(14),p(13),res_reg(14),p(14));
	FA15: full_adder port map(a(15),b(15),p(14),res_reg(15),p(15));
	
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

entity sub_16bit is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(15 downto 0);
		res: out std_logic_vector(15 downto 0)
	);
end sub_16bit;

architecture Behavioral of sub_16bit is
	component full_adder is
	port (
		a,b,c_in: in std_logic;
		s,c_out : out std_logic
	);
	end component;
signal res_reg: std_logic_vector(15 downto 0);
signal p:std_logic_vector(15 downto 0);
begin
	FA0: full_adder port map(a(0),not(b(0)),'1',res_reg(0),p(0));
	FA1: full_adder port map(a(1),not(b(1)),p(0),res_reg(1),p(1));
	FA2: full_adder port map(a(2),not(b(2)),p(1),res_reg(2),p(2));
	FA3: full_adder port map(a(3),not(b(3)),p(2),res_reg(3),p(3));
	FA4: full_adder port map(a(4),not(b(4)),p(3),res_reg(4),p(4));
	FA5: full_adder port map(a(5),not(b(5)),p(4),res_reg(5),p(5));
	FA6: full_adder port map(a(6),not(b(6)),p(5),res_reg(6),p(6));
	FA7: full_adder port map(a(7),not(b(7)),p(6),res_reg(7),p(7));
	FA8: full_adder port map(a(8),not(b(8)),p(7),res_reg(8),p(8));
	FA9: full_adder port map(a(9),not(b(9)),p(8),res_reg(9),p(9));
	FA10: full_adder port map(a(10),not(b(10)),p(9),res_reg(10),p(10));
	FA11: full_adder port map(a(11),not(b(11)),p(10),res_reg(11),p(11));
	FA12: full_adder port map(a(12),not(b(12)),p(11),res_reg(12),p(12));
	FA13: full_adder port map(a(13),not(b(13)),p(12),res_reg(13),p(13));
	FA14: full_adder port map(a(14),not(b(14)),p(13),res_reg(14),p(14));
	FA15: full_adder port map(a(15),not(b(15)),p(14),res_reg(15),p(15));
	
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

entity mul_8bit is
	port (
		clk: in std_logic;
		en : in std_logic;
		a_sgn: in std_logic_vector(7 downto 0);
      b  : in std_logic_vector(7 downto 0);
		res: out std_logic_vector(15 downto 0)
	);
end mul_8bit;

architecture Behavioral of mul_8bit is
	component add_16bit is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(15 downto 0);
		res: out std_logic_vector(15 downto 0)
	);
	end component;

	signal res_reg: std_logic_vector(15 downto 0);
   signal a0,a1,a2,a3,a4,a5,a6,a7: std_logic_vector(15 downto 0);
	signal s01,s23,s45,s67,s0123,s4567:std_logic_vector(15 downto 0);
begin
	a0(15 downto 8)<=(others=>a_sgn(7)) when b(0)='1' else (others=>'0'); a0(7 downto 0)<=a_sgn when b(0)='1' else (others=>'0');
	a1(15 downto 9)<=(others=>a_sgn(7)) when b(1)='1' else (others=>'0'); a1(8 downto 1)<=a_sgn when b(1)='1' else (others=>'0'); a1(0)<='0';
	a2(15 downto 10)<=(others=>a_sgn(7)) when b(2)='1' else (others=>'0'); a2(9 downto 2)<=a_sgn when b(2)='1' else (others=>'0'); a2(1 downto 0)<=(others=>'0');
	a3(15 downto 11)<=(others=>a_sgn(7)) when b(3)='1' else (others=>'0'); a3(10 downto 3)<=a_sgn when b(3)='1' else (others=>'0'); a3(2 downto 0)<=(others=>'0');
	a4(15 downto 12)<=(others=>a_sgn(7)) when b(4)='1' else (others=>'0'); a4(11 downto 4)<=a_sgn when b(4)='1' else (others=>'0'); a4(3 downto 0)<=(others=>'0');
	a5(15 downto 13)<=(others=>a_sgn(7)) when b(5)='1' else (others=>'0'); a5(12 downto 5)<=a_sgn when b(5)='1' else (others=>'0'); a5(4 downto 0)<=(others=>'0');
	a6(15 downto 14)<=(others=>a_sgn(7)) when b(6)='1' else (others=>'0'); a6(13 downto 6)<=a_sgn when b(6)='1' else (others=>'0'); a6(5 downto 0)<=(others=>'0');
	a7(15)<=a_sgn(7) when b(7)='1' else '0'; a7(14 downto 7)<=a_sgn when b(7)='1' else (others=>'0'); a7(6 downto 0)<=(others=>'0');

	s01_chip: add_16bit port map(clk,en,a0,a1,s01);
	s23_chip: add_16bit port map(clk,en,a2,a3,s23);
	s45_chip: add_16bit port map(clk,en,a4,a5,s45);
	s67_chip: add_16bit port map(clk,en,a6,a7,s67);
	
	s0123_chip: add_16bit port map(clk,en,s01,s23,s0123);
	s4567_chip: add_16bit port map(clk,en,s45,s67,s4567);
	
	res_chip: add_16bit port map(clk,en,s0123,s4567,res_reg);
	
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

----------------------------------------------------------------------------------
-- Engineer: Andrey S. Ionisyan <anserion@gmail.com>
-- 
-- Description: BSS filter of 8-bit grayscale image
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity filter_3x3_bss is
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
end filter_3x3_bss;

architecture Behavioral of filter_3x3_bss is
	component add_16bit is
	port (
		clk: in std_logic;
		en : in std_logic;
		a,b: in std_logic_vector(15 downto 0);
		res: out std_logic_vector(15 downto 0)
	);
	end component;
   
   component mul_8bit is
	port (
		clk: in std_logic;
		en : in std_logic;
		a_sgn: in std_logic_vector(7 downto 0);
      b  : in std_logic_vector(7 downto 0);
		res: out std_logic_vector(15 downto 0)
	);
   end component;
   
signal k1p1,k2p2,k3p3,k4p4,k5p5,k6p6,k7p7,k8p8,k9p9: std_logic_vector(15 downto 0) := (others=>'0');
signal s12,s34,s56,s78,s1234,s5678,s12345678,sum_reg: std_logic_vector(15 downto 0) := (others=>'0');
signal fsm: natural range 0 to 15 := 0;
signal sum_cnt: natural range 0 to 65535 := 0;
signal ack_reg: std_logic :='0';

begin
   k1p1_chip: mul_8bit port map(clk,en,conv_std_logic_vector(k1,8),p1,k1p1);
   k2p2_chip: mul_8bit port map(clk,en,conv_std_logic_vector(k2,8),p2,k2p2);
   k3p3_chip: mul_8bit port map(clk,en,conv_std_logic_vector(k3,8),p3,k3p3);
   k4p4_chip: mul_8bit port map(clk,en,conv_std_logic_vector(k4,8),p4,k4p4);
   k5p5_chip: mul_8bit port map(clk,en,conv_std_logic_vector(k5,8),p5,k5p5);
   k6p6_chip: mul_8bit port map(clk,en,conv_std_logic_vector(k6,8),p6,k6p6);
   k7p7_chip: mul_8bit port map(clk,en,conv_std_logic_vector(k7,8),p7,k7p7);
   k8p8_chip: mul_8bit port map(clk,en,conv_std_logic_vector(k8,8),p8,k8p8);
   k9p9_chip: mul_8bit port map(clk,en,conv_std_logic_vector(k9,8),p9,k9p9);
   
   s12_chip: add_16bit port map(clk,en,k1p1,k2p2,s12);
   s34_chip: add_16bit port map(clk,en,k3p3,k4p4,s34);
   s56_chip: add_16bit port map(clk,en,k5p5,k6p6,s56);
   s78_chip: add_16bit port map(clk,en,k7p7,k8p8,s78);
   
   s1234_chip: add_16bit port map(clk,en,s12,s34,s1234);
   s5678_chip: add_16bit port map(clk,en,s56,s78,s5678);
   
   s12345678_chip: add_16bit port map(clk,en,s1234,s5678,s12345678);
   sum_chip: add_16bit port map(clk,en,s12345678,k9p9,sum_reg);

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
               sum_cnt<=0;
               fsm<=1;
            else ack_reg<='0';
            end if;
         when 1 => if sum_cnt=50 then
                      fsm<=9;
                   else
                      sum_cnt<=sum_cnt+1;
                   end if;
         when 9 =>
            if sum_reg(15)='1' then res<=(others=>'0');
            elsif sum_reg(14 downto 8+pow2_divider)/=0 then res<=(others=>'1');
            else res<=sum_reg(7+pow2_divider downto pow2_divider);
            end if;
            ready<='1';
            fsm <= 0;
         when others => null;
         end case;
      else
         ready<='0'; ack_reg<='0';
         res<=(others=>'0');
      end if;
      end if;
   end process;
end Behavioral;
