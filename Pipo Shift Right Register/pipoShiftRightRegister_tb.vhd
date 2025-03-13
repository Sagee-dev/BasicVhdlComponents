-- pipo Shift Left register test bench
-- Geeth De Silva
-- github : sagee-dev
-- v1.0
-- left shift register test bench
-- observe the left shift behaviour

library ieee;
use ieee.std_logic_1164.all;

entity pipoShiftLeftRegister_tb is
end entity;

architecture sim of pipoShiftLeftRegister_tb is

	constant clkFrequency : integer := 1e6;
	constant clkPeriod    : time    := 1000 ms/clkFrequency;
	
	constant shiftLeftRegisterWidth : integer := 8;
	
	signal clk  : std_logic := '0';
	signal rst  : std_logic := '1';
	signal data : std_logic_vector(shiftLeftRegisterWidth-1 downto 0);
	signal q    : std_logic_vector(shiftLeftRegisterWidth-1 downto 0);
	signal shiftLim : integer := 0;

begin

	clk <= not clk after clkPeriod/2; -- 0.5 ns clock signal 

	dut: entity work.pipoShiftLeftRegister(rtl)
	generic map(shiftLeftRegisterWidth => shiftLeftRegisterWidth)
	port map(
		clk => clk,
		rst => rst,
		data=> data,  
		shiftLim=>shiftLim,
		rOut=> q
	);
	

	
	test: process is
	begin
		-- set input 10101010 in hex AA
		-- left shif output should be
		-- 1 0 1 0 1 0 0 0 
	
		wait for 5*clkPeriod;
		data   <= x"AA";
		shiftLim<= 2;
		wait for 3*clkPeriod;
		assert(q = x"AA")report("input set failed");
		wait for 4*clkPeriod;
		assert(q = x"A8")report("Case 1: Module error");
		
		data <= x"00";
		shiftLim <=0;
		
		wait for 5*clkPeriod;
		data   <= x"FA";
		shiftLim<= 2;
		wait for 3*clkPeriod;
		assert(q = x"FA")report("input set failed");
		wait for 4*clkPeriod;
		assert(q = x"E8")report("Case 2: Module error");
		

		
		wait;
		
	end process;

end architecture;
