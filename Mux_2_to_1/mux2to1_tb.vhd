-- 2 to 1 Mux test bench
-- Geeth De Silva
-- github : sagee_dev
-- v 1.0
-- input different combinations for select signal 
-- and examine the behaviour of mux module
library ieee;
use ieee.std_logic_1164.all;

entity mux2to1_tb is
end entity;

architecture sim of mux2to1_tb is

	signal d0 : std_logic := '0';
	signal d1 : std_logic := '1';
	signal s  : std_logic;
	signal o  : std_logic;

begin

	dut: entity work.mux2to1(rtl)
	port map(
		d0 => d0,
		d1 => d1,
		s  => s,
		o  => o
	);
	
	evaluate: process is
	begin
		wait for 10 ms;
		s <= '0';
		wait for 10 ms;
		assert(o = '0')report("Report 1: Module error");
		
		wait for 10 ms;
		s <= '1';
		wait for 10 ms;
		assert( o = '1')report("Report 2: Module error");
	end process;

end architecture;
