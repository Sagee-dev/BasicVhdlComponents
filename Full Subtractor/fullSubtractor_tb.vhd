-- full Subtractor test bench
-- Geeth De Silva
-- github : sagee_dev
-- v1.0
-- obser the output behaviour
-- changing inputs of the half Subtractor

library ieee;
use ieee.std_logic_1164.all;

entity fullSubstractor_tb is
end entity;

architecture sim of fullSubstractor_tb is
--input output signals
	--define clock period
	constant clkFrequency : integer := 1e6;
	constant clkPeriod    : time    := 1000 ms/clkFrequency;
	signal clk : std_logic := '0';
	signal rst : std_logic := '1';
	signal b1  : std_logic;
	signal b0  : std_logic;
	signal bin : std_logic;
	signal r   : std_logic;
	signal bout: std_logic;
begin

	dut: entity work.fullSubtractor(rtl)
	port map(
		clk => clk,
		rst => rst,
		b1  => b1,
		b0  => b0,
		bin => bin,
		r   => r,
		bout=> bout
	);
	
	clk <= not clk after clkPeriod/2; -- 0.5 ns clock signal 

	test: process is
	begin
	--test cases
		wait for clkPeriod;
		b1  <= '0';
		b0  <= '0';
		bin <= '0';
		wait for clkPeriod;
		assert( r = '0' and bout = '0')report("Case 1: Module error");
		
		wait for clkPeriod;
		b1  <= '0';
		b0  <= '0';
		bin <= '1';
		wait for clkPeriod;
		assert( r = '1' and bout = '1')report("Case 2: Module error");
		
		wait for clkPeriod;
		b1  <= '0';
		b0  <= '1';
		bin <= '0';
		wait for clkPeriod;
		assert( r = '1' and bout = '1')report("Case 3: Module error");
		
		wait for clkPeriod;
		b1  <= '0';
		b0  <= '1';
		bin <= '1';
		wait for clkPeriod;
		assert( r = '0' and bout = '1')report("Case 4: Module error");
		
		wait for clkPeriod;
		b1  <= '1';
		b0  <= '0';
		bin <= '0';
		wait for clkPeriod;
		assert( r = '1' and bout = '0')report("Case 5: Module error");
		
		wait for clkPeriod;
		b1  <= '1';
		b0  <= '0';
		bin <= '1';
		wait for clkPeriod;
		assert( r = '0' and bout = '0')report("Case 6: Module error");
		
		wait for clkPeriod;
		b1  <= '1';
		b0  <= '1';
		bin <= '0';
		wait for clkPeriod;
		assert( r = '0' and bout = '0')report("Case 7: Module error");
		
		wait for clkPeriod;
		b1  <= '1';
		b0  <= '1';
		bin <= '1';
		wait for clkPeriod;
		assert( r = '1' and bout = '1')report("Case 8: Module error");
		
		wait;
		
	end process;
end architecture;
