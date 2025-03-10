-- ripple carry adder test bech
-- Geeth De Silva
-- github : sagee_dev
-- v1.0
-- create 2 subtractors with different bit width
-- observe there output behaviour change the iputs

library ieee;
use ieee.std_logic_1164.all;

entity rippleBorrowSubtractor_tb is 
end entity;

architecture sim of rippleBorrowSubtractor_tb is
	--generate clock period
	constant clkFrequency : integer := 1e6;
	constant clkPeriod    : time    := 1000 ms/clkFrequency;
	-- define sizer of the subtractors
	constant bitWidth_a1 : integer := 8;
	constant bitWidth_a2 : integer := 4;
	-- other signals
	signal clk   : std_logic := '0';
	signal rst_a1: std_logic := '1';
	signal rst_a2: std_logic := '1';
	
	signal bin_a1 : std_logic;
	signal bin_a2 : std_logic;
	signal bout_a1: std_logic;
	signal bout_a2: std_logic;
	
	signal d0_a1: std_logic_vector(bitWidth_a1-1 downto 0);
	signal d0_a2: std_logic_vector(bitWidth_a2-1 downto 0);
	signal d1_a1: std_logic_vector(bitWidth_a1-1 downto 0);
	signal d1_a2: std_logic_vector(bitWidth_a2-1 downto 0);
	signal r_a1 : std_logic_vector(bitWidth_a1-1 downto 0);
	signal r_a2 : std_logic_vector(bitWidth_a2-1 downto 0);
	
begin
    --clk with 1 ns
	clk <= not clk after clkPeriod/2;
	
	--create 2 rca instances 
	adder1: entity work.rippleBorrowSubtractor(rtl) 
	generic map(bitwidth => bitWidth_a1-1 )
	port map(
		      clk => clk,  
		      rst => rst_a1,
		      bin => bin_a1,
		      bout=> bout_a1,
		      d0  => d0_a1,
		      d1  => d1_a1,
		      r   => r_a1
		    );
			
	adder2: entity work.rippleBorrowSubtractor(rtl) 
	generic map(bitwidth => bitWidth_a2-1 )
	port map(
		      clk => clk,  
		      rst => rst_a2,
		      bin => bin_a2,
		      bout=> bout_a2,
		      d0  => d0_a2,
		      d1  => d1_a2,
		      r   => r_a2
		    );
		
		
	test: process is
	begin
		--adders test cases
		wait for 5*clkPeriod;
		d1_a1  <= x"AF";
		d0_a1  <= x"01";
		bin_a1 <= '0';
		wait for 10*clkPeriod;
		assert(r_a1 = x"AE" and bout_a1 = '0')report("Case1: Module error");
		
		wait for 5*clkPeriod;
		d1_a2  <= "1010";
		d0_a2  <= "0001";
		bin_a2 <= '0';
		wait for 10*clkPeriod;
		assert(r_a2 = "1001" and bout_a2 = '0')report("Case2: Module error");
		
		
		wait for 5*clkPeriod;
		d1_a1  <= x"A0";
		d0_a1  <= x"B0";
		bin_a1 <= '0';
		wait for 10*clkPeriod;
		assert(r_a1 = x"F0" and bout_a1 = '1')report("Case3: Module error");
		
		wait for 5*clkPeriod;
		d1_a2  <= "0000";
		d0_a2  <= "0001";
		bin_a2 <= '0';
		wait for 10*clkPeriod;
		assert(r_a2 = "1111" and bout_a2 = '1')report("Case4: Module error");
		
		-- test reset
		
		wait for 5*clkPeriod;
		rst_a1 <= '0';
		wait for 10*clkPeriod;
		assert(r_a1 = x"00" and bout_a1 = '0')report("Case5: Module error"); 
		
		wait for 5*clkPeriod;
	    rst_a2 <= '0';
		wait for 10*clkPeriod; 
		assert(r_a2 = "0000" and bout_a2 = '0')report("Case6: Module error");
		
		wait;
	end process;
end architecture;
