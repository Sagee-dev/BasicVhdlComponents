--halfAdder testbecnch file
--Geeth De Silva
--Github: sagee_dev
--v 1.0
--inputu different input conbinations and 
--observe the output behaviour

library ieee;
use ieee.std_logic_1164.all;

entity halfAdder_tb is 
end entity;

architecture sim of halfAdder_tb is
	
	constant clkFrequency: integer := 1e6;
	constant clkPeriod   : time := 1000 ms/clkFrequency; --creat a clock period 1ns
	
	signal clk: std_logic := '0';
	signal rst: std_logic := '1';
	
	signal b0: std_logic := '0';
	signal b1: std_logic := '0';
	signal s : std_logic;
	signal c0: std_logic;
begin
	dut: entity work.halfAdder(rtl)
	port map(
		clk => clk,
		rst => rst,
		b0  => b0,
		b1  => b1,
		s   => s,
		c0  => c0);
	
	clk <= not clk after clkPeriod/2; --change clock state every 0.5 ns
	
	test:process is
	begin

		wait for 10 us;
		b0 <= '0';
		b1 <= '0';
		
		wait for 10 us;
		assert (s = '0' and c0 = '0')report "Incorrect Output";
		
		wait for 10 us;
		b0 <= '1';
		b1 <= '0';
		
		wait for 10 us;
		assert (s = '1' and c0 = '0' )report "Incorrect Output";
		
		wait for 10 us;
		b0 <= '0';
		b1 <= '1';
		
		wait for 10 us;
		assert (s = '1' and c0 = '0') report "Incorrect Output";
		
		wait for 10 us;
		b0 <= '1';
		b1 <= '1';
		
		wait for 10 us;
		assert (s = '1' and c0 = '1') report "Incorrect Output";
	end process;

end architecture;
