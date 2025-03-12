-- 2bit multiplier test bench
-- Geeth De Silva
-- github : sagee-dev
-- observe the oupbut giving diffrent 
-- input combinations to 2bitMultiplier

library ieee;
use ieee.std_logic_1164.all;

entity multiplyer2Bit_tb is 
end entity;

architecture sim of multiplyer2Bit_tb is
    --define clock period
	constant clkFrequency : integer := 1e6;
	constant clkPeriod    : time    := 1000 ms/clkFrequency;
    --signals for input and output
	signal b1 : std_logic;
	signal b0 : std_logic;
	signal r  : std_logic;
	-- clock signal
    signal clk: std_logic := '0';
	
	
begin

	dut: entity work.multiplyer2Bit(rtl)
	port map(
		clk => clk,
		b1 => b1,
		b0 => b0,
		r  => r 
	);
	
	clk <= not clk after clkPeriod/2; --change clock value eve  ns
	
	test: process is
	begin
		--test cases
		wait for clkPeriod;
		b1 <= '0';
		b0 <= '0';
		wait for clkPeriod;
		assert( r = '0')report("Case 1: Module error");
		
		wait for clkPeriod;
		b1 <= '0';
		b0 <= '1';
		wait for clkPeriod;
		assert( r = '0')report("Case 2: Module error");
		
		wait for clkPeriod;
		b1 <= '1';
		b0 <= '0';
		wait for clkPeriod;
		assert( r = '0')report("Case 3: Module error");
		
		wait for clkPeriod;
		b1 <= '1';
		b0 <= '1';
		wait for clkPeriod;
		assert( r = '1')report("Case 4: Module error");
		-- hold
		wait;
	end process;


end architecture;
