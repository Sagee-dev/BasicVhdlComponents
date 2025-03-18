-- nbymMultiplier test bench
-- Geeth De Silva
-- github: sagee-dev
-- observer output
-- giving different inputs

library ieee;
use ieee.std_logic_1164.all;

entity nbymMultiplier_tb is 
end entity;

architecture sim of nbymMultiplier_tb is
	signal clk : std_logic :='0';
	signal rst : std_logic :='1';
	signal multiplicand : std_logic_vector(2 downto 0);
	signal multiplier   : std_logic_vector(2 downto 0);
	signal product      : std_logic_vector(5 downto 0);
	
	constant clkFrequency : integer := 1e6;
	constant clkPeriod    : time    := 1000 ms/clkFrequency;
	

begin

	

	dut: entity work.nbymMultiplier(rtl)
	port map(
		clk => clk,
		rst => rst,
		multiplicand => multiplicand,
		multiplier   => multiplier,
		product      => product
	);
	
	clk <= not clk after clkPeriod/2;
	
	test: process is 
	begin
		
		
		
		wait for 1*clkPeriod;
		multiplicand <= "111";
		multiplier   <= "000";
		wait for 5000*clkPeriod;
		assert(product = "000000")Report("case 1: Module error");
		
		wait for 500*clkPeriod;
		
		wait for 1*clkPeriod;
		multiplicand <= "111";
		multiplier   <= "001";
		wait for 5000*clkPeriod;
		assert(product = "000111")Report("case 1: Module error");
		
		wait for 500*clkPeriod;
		
		wait for 1*clkPeriod;
		multiplicand <= "111";
		multiplier   <= "010";
		wait for 5000*clkPeriod;
		assert(product = "001110")Report("case 1: Module error");
		
		wait for 500*clkPeriod;
		
		wait for 1*clkPeriod;
		multiplicand <= "111";
		multiplier   <= "011";
		wait for 5000*clkPeriod;
		assert(product = "010101")Report("case 1: Module error");
		
		wait for 500*clkPeriod;
		
		wait for 1*clkPeriod;
		multiplicand <= "111";
		multiplier   <= "100";
		wait for 5000*clkPeriod;
		assert(product = "011100")Report("case 1: Module error");
		
		wait for 500*clkPeriod;
		
		wait for 1*clkPeriod;
		multiplicand <= "111";
		multiplier   <= "101";
		wait for 5000*clkPeriod;
		assert(product = "100011")Report("case 1: Module error");
		
		wait for 500*clkPeriod;
		
		wait for 1*clkPeriod;
		multiplicand <= "111";
		multiplier   <= "110";
		wait for 5000*clkPeriod;
		assert(product = "101010")Report("case 1: Module error");
		
		wait for 500*clkPeriod;
		
		wait for 1*clkPeriod;
		multiplicand <= "111";
		multiplier   <= "111";
		wait for 5000*clkPeriod;
		assert(product = "110001")Report("case 1: Module error");
		
	
		
		wait;
	end process;
end architecture;