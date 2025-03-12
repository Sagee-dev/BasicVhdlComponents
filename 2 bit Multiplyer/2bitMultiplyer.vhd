-- 2 bit multiplyer
-- two bit multiplyer output the result
-- of multiplication of two single bit inputs
-- truth table as follow
-- | b1 | b0 | r |
------------------
-- |  0 |  0 | 0 |
-- |  0 |  1 | 0 |
-- |  1 |  0 | 0 |
-- |  1 |  1 | 1 |
-- r = b1 and b0
-- 2 bit multiplyer nothing but a simple
-- and gate but has clock input for syncronus operation

library ieee;
use ieee.std_logic_1164.all;


entity multiplyer2Bit is
port(
	--input output port for the multiplyer
	signal clk: in  std_logic;
	signal b1 : in  std_logic;
	signal b0 : in  std_logic;
	signal r  : out std_logic
);
end entity;

architecture rtl of multiplyer2Bit is
begin
	--define the behaviour
	behaviour : process(clk) is
	begin
		if rising_edge(clk) then
			-- set r = b1 and bo on rising clock edge
			r <= b1 and b0;
		end if;
	end process;
end architecture;
