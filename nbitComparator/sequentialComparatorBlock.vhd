-- one bit comparator
-- Geeth De Silva
-- github : sagee-dev
-- 2 inputs bit 1 (b1) bit 2 (b2) enable (en) clock (clk)
-- 3 output lesser(1) equal(e) greater(g)
-- output will be calculated only if the en is 1
-- otherwise outputs will be u
-- output will be updated every rising of clock cycle
-- compares the two bit and output the 
-- respective output
-- truth table as follow
-- |en |b1 | b0 | l | e | g |
-----------------------------
-- | 0 | 0 |  0 | 0 | 0 | 0 |
-- | 0 | 0 |  1 | 0 | 0 | 0 |
-- | 0 | 1 |  0 | 0 | 0 | 0 |
-- | 0 | 1 |  1 | 0 | 0 | 0 |
-- | 1 | 0 |  0 | 0 | 1 | 0 |
-- | 1 | 0 |  1 | 1 | 0 | 0 |
-- | 1 | 1 |  0 | 0 | 0 | 1 |
-- | 1 | 1 |  1 | 0 | 1 | 0 |
-- l = en and (not(b1) and b0)
-- e = en and not(b1 xor b0)
-- g = en and (b1 and not(b0))


library ieee;
use ieee.std_logic_1164.all;

entity sequentialComparator1Bit is
port(
	clk : in std_logic;
	en : in std_logic;
	b1 : in std_logic;
	b0 : in std_logic;
	l  : out std_logic;
	e  : out std_logic;
	g  : out std_logic
);
end sequentialComparator1Bit;

architecture rtl of sequentialComparator1Bit is
begin
	behaviour: process (clk) is
	begin
		if rising_edge(clk) then
			l <= (en and((not(b1)) and b0));
			e <= (en and(not(b1 xor b0)));
			g <= (en and(b1 and (not(b0))));

		end if;
	end process;
end rtl;

