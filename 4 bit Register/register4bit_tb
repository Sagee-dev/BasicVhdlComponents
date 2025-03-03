-- testbench for 4 bit register
-- Geeth De Silva
-- githud : sagee_dev
-- v1.0
-- input different data cobination and observe
-- output behaviour

library ieee;
use ieee.std_logic_1164.all;

entity register4bit_tb is
end entity;

architecture sim of register4bit_tb is
	
	constant clkFrequency : integer := 1e6; -- 1 MHz
	constant clkPeriod    : time    := 1000 ms/clkFrequency; -- 1 ns perids
	
	signal clk : std_logic := '0';
	signal rst : std_logic := '1';
	signal d3,d2,d1,d0 : std_logic;
	signal q3,q2,q1,q0 : std_logic;
	
begin
	
	dut: entity work.register4bit(rtl)
	port map(
		clk => clk,
		rst => rst,
		d3 => d3, d2 => d2, d1 => d1, d0 => d0,
		q3 => q3, q2 => q2, q1 => q1, q0 => q0
		);
	
		clk <= not clk after clkPeriod/2; -- change clo signal every 0.5 ns 
		
		test : process is
		begin
		--state changes take 2 clock cycles to update 
		--need to goto register and to flipflop
			wait for 1 us;
			d3 <= '0'; d2 <= '0'; d1 <='0'; d0 <= '0';
			wait for 3 us;
			assert( q3 = '0' and q2 ='0' and q1 = '0' and q0 = '0')Report ("Case 1 Module error");
		
			wait for 5 us;
			
			wait for 1 us;
			d3 <= '0'; d2 <= '0'; d1 <='1'; d0 <= '1';
			wait for 3 us;
			assert( q3 = '0' and q2 ='0' and q1 = '1' and q0 = '1')Report ("Case 2 Module error");
	
			wait for 5 us;
			
			wait for 1 us;
			d3 <= '0'; d2 <= '1'; d1 <='0'; d0 <= '1';
			wait for 3 us;
			assert( q3 = '0' and q2 ='1' and q1 = '0' and q0 = '1')Report ("Case 3 Module error");
		
			wait for 5 us;
			
			wait for 1 us;
			rst <= '0'; -- reset the register
			wait for 3 us;
			assert( q3 = '0' and q2 ='0' and q1 = '0' and q0 = '0')Report ("Case 4 Module error");
			wait for 1 us;
			rst <= '1';
		
			wait for 5 us;
			
			wait for 1 us;
			d3 <= '1'; d2 <= '0'; d1 <='1'; d0 <= '0';
			wait for 3 us;
			assert( q3 = '1' and q2 ='0' and q1 = '1' and q0 = '0')Report ("Case 5 Module error");
		
			wait for 5 us;
			
			wait for 1 us;
			d3 <= '1'; d2 <= '1'; d1 <='1'; d0 <= '1';
			wait for 3 us;
			assert( q3 = '1' and q2 ='1' and q1 = '1' and q0 = '1')Report ("Case 6 Module error");
		
			wait;
		
		end process;

end architecture;
