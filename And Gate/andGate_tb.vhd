--Andgate testbench
--Geeth De Silva
--Github : sagee_dev
--v1.0
--input different signal combinations
--and check behaviour of the and gate module

library ieee;
use ieee.std_logic_1164.all;

entity andGate_tb is
end entity;

architecture sim of andGate_tb is 
	signal b0 : std_logic := '0';
	signal b1 : std_logic := '0';
	signal r  : std_logic;

begin	

	dut: entity work.andGate(rtl)
	port map(b0 => b0,
			 b1 => b1,
			 r => r);

	test: process is
	begin
		report "Process begins";

		b0 <= '0'; b1 <= '0';
		wait for 1 ms;
		assert r = '0' report ("Something wrong "&std_logic'image(r));
		

		b0 <= '0'; b1 <= '1';
		wait for 1 ms;
		assert r = '0' report ("Something wrong "&std_logic'image(r));
		

		b0 <= '1'; b1 <= '0';
		wait for 1 ms;
		assert r = '0' report ("Something wrong "&std_logic'image(r));
		

		b0 <= '1'; b1 <= '1';
		wait for 1 ms;
		assert r = '1' report ("Something wrong "&std_logic'image(r));
		report "Process end";
		 
		
	end process;

end architecture;
