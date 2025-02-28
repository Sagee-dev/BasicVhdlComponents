--xor gate
--Geeth De Silva
--github : sagee_dev
--v1.0
--xor gate has a two input bit0 (b0) and bit1 (b1)
--and one output result (r)
--truth table as follow
-- |b0 | b1 | r |
-----------------
-- | 0 |  0 | 0 |
-- | 0 |  1 | 1 |
-- | 1 |  0 | 1 |
-- | 1 |  1 | 0 |

library ieee;
use ieee.std_logic_1164.all;

entity xorGate is

port(signal b0: in  std_logic;
	 signal b1: in  std_logic;
	 signal r : out std_logic);

end entity;

architecture rtl of xorGate is
begin

	xoring: process(b0,b1) is
	begin
	-- output of the xor is true only when two signals are different
		if b0 = b1 then
			r <= '0';
		else
			r <= '1';
		end if;
	end process;

end architecture;
