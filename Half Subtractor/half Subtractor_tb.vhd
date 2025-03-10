-- half Subtractor test bench
-- Geeth De Silva
-- github : sagee_dev
-- obser the output behaviour
-- changing inputs of the half Subtractor

library ieee;
use ieee.std_logic_1164.all;

entity halfSubstractor_tb is
end entity;

architecture sim of halfSubstractor_tb is
--input output signals
	--define clock period
	constant clkFrequency : integer := 1e6;
	constant clkPeriod    : time    := 1000 ms/clkFrequency;
	signal clk: std_logic := '0';
	signal rst: std_logic := '1';
	signal b1 : std_logic;
	signal b0 : std_logic;
	signal r  : std_logic;
	signal b  : std_logic;
begin

	dut: entity work.halfSubstractor(rtl)
	port map(
		clk => clk,
		rst => rst,
		b1  => b1,
		b0  => b0,
		r   => r,
		b   => b
	);
	
	clk <= not clk after clkPeriod/2; -- 0.5 ns clock signal 

	test: process is
	begin
	--test cases
		wait for clkPeriod;
		b1 <= '0';
		b0 <= '0';
		wait for clkPeriod;
		assert( r = '0' and b = '0')report("Case 1: Module error");
		
		wait for clkPeriod;
		b1 <= '0';
		b0 <= '1';
		wait for clkPeriod;
		assert( r = '1' and b = '1')report("Case 2: Module error");
		
		wait for clkPeriod;
		b1 <= '1';
		b0 <= '0';
		wait for clkPeriod;
		assert( r = '1' and b = '0')report("Case 3: Module error");
		
		wait for clkPeriod;
		b1 <= '1';
		b0 <= '1';
		wait for clkPeriod;
		assert( r = '0' and b = '0')report("Case 4: Module error");
		
		wait;
		
	end process;
end architecture;
