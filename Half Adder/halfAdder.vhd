--Geeth De Silva
--Git hub : sagee_dev
--v1.0
-- Half adder basic digital component
-- with has two intputs bit1 (b1) and bit2 (b2)
-- has two out put sum and carry out (co)
-- and additional clock signal is requires becouse memory elements in the adder update sequentialy 
-- according to the rising edge of the clock
-- Half adder doesnt have a carry in
--truth table as follow

--| b1|  b0|  s|  c0|
--|___|____|___|____|
--| 0 |  0 |  0|  0 |
--| 0 |  1 |  1|  0 |
--| 1 |  0 |  1|  0 |
--| 1 |  1 |  0|  1 |

library ieee;
use ieee.std_logic_1164.all;

entity halfAdder is
-- define input output signals
port(signal clk: in  std_logic;
	 signal rst: in  std_logic;
	 signal b0 : in  std_logic;
     signal b1 : in  std_logic;
	 signal s  : out std_logic;
	 signal c0 : out std_logic);

end entity;

architecture rtl of halfAdder is
begin

	calculate: process(clk) is --process sensitve to the changes of the clock signal
	begin
		if rising_edge(clk) then
			if rst = '0' then
				
				
				s  <= '0';
				c0 <= '0';
			
			else
			
				--assign output values based on input values
				s <= b1 or  b0; -- sum is 1 if b0 or b1 is 1
				c0<= b1 and b0; -- carry is 1 if b0 and b1 are 1
			
			end if;
	
		end if;
	
	end process;

end architecture;
