-- piso Shift Left register test bench
-- Geeth De Silva
-- github : sagee-dev
-- left shift register test bench
-- observe the left shift behaviour

library ieee;
use ieee.std_logic_1164.all;

entity pisoShiftLeftRegister_tb is
end entity;

architecture sim of pisoShiftLeftRegister_tb is

	constant clkFrequency : integer := 1e6;
	constant clkPeriod    : time    := 1000 ms/clkFrequency;
	
	constant shiftLeftRegisterWidth : integer := 8;
	signal clk  : std_logic := '0';
	signal rst  : std_logic := '1';
	signal data : std_logic_vector(shiftLeftRegisterWidth-1 downto 0);
	signal q    : std_logic;
	signal isShift: std_logic := '0';

begin

	clk <= not clk after clkPeriod/2; -- 0.5 ns clock signal 

	dut: entity work.pisoShiftLeftRegister(rtl)
	generic map(shiftLeftRegisterWidth => shiftLeftRegisterWidth)
	port map(
		clk => clk,
		rst => rst,
		data=> data,  
		isShift=>isShift,
		rOut=> q
	);
	

	
	test: process is
	begin
		--set input 10101010 in hex AA
		--left shif output should be
		-- 1 0 1 0 1 0 1 0 000000.....
		data   <= x"AA";
	
		wait for clkPeriod;

		isShift<= '1';
		
		wait for 2*clkPeriod;
		assert(q = '1')report("Case 1: Module error");
		
		wait for 2*clkPeriod;
		assert(q = '0')report("Case 2: Module error");
		
		wait for 2*clkPeriod;
		assert(q = '1')report("Case 3: Module error");
		
		wait for 2*clkPeriod;
		assert(q = '0')report("Case 4: Module error");
		
		wait for 2*clkPeriod;
		assert(q = '1')report("Case 5: Module error");
		
		wait for 2*clkPeriod;
		assert(q = '0')report("Case 6: Module error");
		
		wait for 2*clkPeriod;
		assert(q = '1')report("Case 7: Module error");
		
		wait for 2*clkPeriod;
		assert(q = '0')report("Case 8: Module error");
		
		wait for 2*clkPeriod;
		assert(q = '0')report("Case 9: Module error");
		
		wait for 2*clkPeriod;
		assert(q = '0')report("Case 10: Module error");
		
		wait;
		
	end process;

end architecture;
