-- D Flip Flop test bench
-- Geeth De Silva
-- github : sagee_dev
-- change input d and 
-- observe output behaviour q

library ieee;
use ieee.std_logic_1164.all;

entity dFlipFlop_tb is
end entity;

architecture sim of dFlipFlop_tb is

	constant clkFrequency : integer := 1e6; --1MHz
	constant clkPeriod    : time    := 1000 ms/clkFrequency; --1us
	
	signal clk : std_logic := '0';
	signal d   : std_logic;
	signal q   : std_logic;

begin

	dut: entity work.dFlipFlop(rtl)
	port map(
		clk => clk,
		d   => d,
		q   => q	
	);
	
	clk <= not clk after clkPeriod/2; --create a clk signal 
                                      --with 1us period 

	test: process is
	begin
	
	    wait for 1 us;
		d <= '0';
		wait for 1 us;
		assert(q = '0')report("Report 1: module error"&std_logic'image(q));
		
		wait for 1 us;
		d <= '1';
		wait for 1 us;
		assert(q = '1')report("Report 1: module error"&std_logic'image(q));
		
		wait for 1 us;
		d <= '1';
		wait for 1 us;
		assert(q = '1')report("Report 1: module error"&std_logic'image(q));
		
		wait for 1 us;
		d <= '0';
		wait for 1 us;
		assert(q = '0')report("Report 1: module error"&std_logic'image(q));
		
		wait;
	
	end process;

end architecture;
