--orGate
--Geeth De Silva
--Github : sagee_dev
--v1.0
--or gate has two inputs bit 0 (b0) bit 1 (b1)
--has a one output result (r)
--Truth table
-- | b0 | b1 | r |
------------------
-- | 0  | 0  | 0 |
-- | 0  | 1  | 1 |
-- | 1  | 0  | 1 |
-- | 1  | 1  | 1 |

library ieee;
use ieee.std_logic_1164.all;

entity orGate is

port(signal b0: in std_logic;
	 signal b1: in std_logic;
	 signal r : out std_logic);

end entity;

architecture rtl of orGate is
begin

	oring: process(b0,b1) is
	begin
	
		if b0 = '1'  then
			r <= '1';
		elsif b1 = '1' then
			r <= '1';
		else
		    r <= '0';
		end if;
		
	end process;
	

end architecture;
