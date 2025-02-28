--And gate
--Geeth De Silva
--Github : sagee_dev
--v1.0
--has two inputs bit0 (b0) bit1 (b1)
--one output result (r)
--truth table as follow
-- | b0 | b1 | r |
------------------ 
-- | 0  | 0  | 0 |
-- | 0  | 1  | 0 |
-- | 1  | 0  | 0 |
-- | 1  | 1  | 1 |
library ieee;
use ieee.std_logic_1164.all;

entity andGate is
port(signal b0 : in std_logic;
     signal b1 : in std_logic;
     signal r  : out std_logic);
	 
end entity;

architecture rtl of andGate is
begin
	anding: process(b0,b1) is
	begin
		if b0 = '1' then
		-- in an And gate both inputs need to be 1 to output to be 1
		-- it doesnt matter which one become 1 first
			if b1 = '1' then
				r <= '1';
			else
				r <= '0';
			end if;
		else
		--if any input is zero then output is zero
			r <= '0';
		end if;
	end process;
end architecture; 
