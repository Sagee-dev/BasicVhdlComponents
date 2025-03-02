-- rsFlipflip truth table
-- Geeth De Silva
-- github : sagee_dev
-- v1.0
-- input different rs combinations and 
-- observe the output behaviour of rsFlipflop module

library ieee;
use ieee.std_logic_1164.all;

entity rsFlipflop_tb is
end entity;

architecture sim of rsFlipflop_tb is

	signal     r : std_logic := '0';
	signal     s : std_logic := '0';
	signal     q : std_logic;
	signal inv_q : std_logic;
begin

	dut: entity work.rsFlipflop(rtl)
	port map(
		r     => r,
		s     => s,
		q     => q,
		inv_q => inv_q);
		
	test: process is
	begin
		wait for 1 ms;
		r <= '0';
		s <= '0';
		wait for 1 ms;
		assert(q = '0' and inv_q ='0')report("Module error");
		
		wait for 1 ms;
		r <= '1';
		s <= '0';
		wait for 1 ms;
		assert(q = '0' and inv_q ='1')report("Module error");
		
		wait for 1 ms;
		r <= '0';
		s <= '1';
		wait for 1 ms;
		assert(q = '1' and inv_q ='0')report("Module error");
		
		wait for 1 ms;
		r <= '1';
		s <= '1';
		wait for 1 ms;
		assert(q = 'U' and inv_q ='U')report("Module error");
		
		wait;
	end process;

end architecture;
