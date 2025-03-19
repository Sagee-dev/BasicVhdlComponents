-- one bit comparator
-- Geeth De Silva
-- github : sagee-dev
-- 2 inputs bit 1 (b1) bit 2 (b2)
-- 3 output lesser(1) equal(e) greater(g)
-- compares the two bit and output the 
-- respective output
-- truth table as follow
-- |b1 | b0 | l | e | g |
-------------------------
-- | 0 |  0 | 0 | 1 | 0 |
-- | 0 |  1 | 1 | 0 | 0 |
-- | 1 |  0 | 0 | 0 | 1 |
-- | 1 |  1 | 0 | 1 | 0 |
-- l = not(b1) and b0
-- e = not(b1 xor b0)
-- g = b1 and not(b0)


library ieee;
use ieee.std_logic_1164.all;

entity comparator1Bit is
port(
	b1 : in std_logic;
	b0 : in std_logic;
	l  : out std_logic;
	e  : out std_logic;
	g  : out std_logic
);
end comparator1Bit;

architecture rtl of comparator1Bit is
begin
	behaviour: process (b1,b0) is
	begin
		l <= ((not(b1)) and b0);
		e <= (not(b1 xor b0));
		g <= (b1 and (not(b0)));
	end process;
end rtl;

