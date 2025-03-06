-- n bit register test bench
-- Geeth De Silva
-- github : sagee_dev
-- v1.0
-- initiate 2 registers with defferent bitwidth
-- give different input and 
-- observer output behaviour

library ieee;
use ieee.std_logic_1164.all;

entity nbitRegister_tb is 
end entity;

architecture sim of nbitRegister_tb is
	--define clock period
	constant clkfrequency : integer := 1e6;
	constant clkperiod    : time    := 1000 ms/clkfrequency;
	
	constant r1_width : integer := 8; --8 bit register 1
	constant r2_width : integer := 4; --4 bit register 2
	
	signal clk: std_logic:= '0';
	
	signal dr1 : std_logic_vector(r1_width-1 downto 0);--input of register 1
	signal dr2 : std_logic_vector(r2_width-1 downto 0);-- 0 to 7 8 bits
	signal qr1 : std_logic_vector(r1_width-1 downto 0);--output of register 2
	signal qr2 : std_logic_vector(r2_width-1 downto 0);-- 0 to 3 4 bits
	
	signal rst1 : std_logic :='1'; -- reset with default 1
	signal rst2 : std_logic :='1';
	

begin
	
	clk <= not clk after clkperiod/2; --1 ns clock signal
	
	reg1: entity work.nbitRegister(rtl) -- register 1
	generic map(registerWidth => r1_width-1)
	port map(clk => clk,
			 rst => rst1,
			 d   => dr1,
			 q   => qr1);
			
	reg2: entity work.nbitRegister(rtl) -- register 2
	generic map(registerWidth => r2_width-1)
	port map(clk => clk,
			 rst => rst2,
			 d   => dr2,
			 q   => qr2);
	
	
	

	test: process is
	begin

 		wait for (clkperiod);
		dr1 <= x"FA";
		dr2 <= x"A";
		wait for (3*clkperiod);
		assert (qr1 = x"FA" and qr2 = x"A") report ("Module error "); 
		wait;
	end process;
end architecture;
