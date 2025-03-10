-- Half Subtractor
-- Geeth De Silva
-- github : sagee_dev
-- v1.0
-- half Subtractor substracts two bit
-- and output two outputs result and borrow
-- borrow is when second bit is higer than the first bit
-- bit is borrowed from the next position
-- just as in ordinary substraction
-- truth table as follow
-- | b1 | b0 | r | b |
----------------------
-- | 0  | 0  | 0 | 0 |
-- | 0  | 1  | 1 | 1 |
-- | 1  | 0  | 1 | 0 |
-- | 1  | 1  | 0 | 0 |
-- r = b1 xor b0
-- b = (not b1) and b0

library ieee;
use ieee.std_logic_1164.all;

entity halfSubstractor is
port(--input output port
	signal clk: in  std_logic;
	signal rst: in  std_logic;
	signal b1 : in  std_logic;
	signal b0 : in  std_logic;
	signal r  : out std_logic;
	signal b  : out std_logic
);
end entity;

architecture rtl of halfSubstractor is
begin

	behaviour : process(clk,rst) is
	begin
		if(rst = '0') then
		--asychronus reset
			r <= '0';
			b <= '0';
		else
			if rising_edge(clk) then
			--set outputs
				r <= b1 xor b0;
				b <= (not b1) and b0;
			
			end if;
		
		end if;
	
	end process;

end architecture;
