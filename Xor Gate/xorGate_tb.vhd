--Testbench for xor module
--Geeth De Silva
--github : sagee_dev
--v1.0
--Input different input combinations to xor module
--and eveluate the output signal

library ieee;
use ieee.std_logic_1164.all;

entity xorGate_tb is
end entity;

architecture sim of xorGate_tb is

	signal b0 : std_logic;
	signal b1 : std_logic;
	signal r  : std_logic;

begin

	dut: entity work.xorGate(rtl)
	port map(
			 b0 => b0,
			 b1 => b1,
			 r  => r);
	
	test: process is
	begin
		wait for 1 ms;
		b1 <= '0'; b0 <= '0'; 
		wait for 1 ms;
		assert(r = '0') report("Case 1: module error r = "&std_logic'image(r));
		
		wait for 1 ms;
		b1 <= '0'; b0 <= '1';
		wait for 1 ms;
		assert(r = '1') report("Case 2: module error r ="&std_logic'image(r));
		
		wait for 1 ms;
		b1 <= '1'; b0 <= '0';
		wait for 1 ms;
		assert(r = '1') report("Case 3: module error r = "&std_logic'image(r));
		
		wait for 1 ms;
		b1 <= '1'; b0 <= '1';
		wait for 1 ms;
		assert(r = '0') report ("Case 4: module error r = "&std_logic'image(r));
		
	end process;
	
end architecture;
