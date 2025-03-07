-- ripple carry adder test bech
-- Geeth De Silva
-- github : sagee_dev
-- create 2 adders with different bit width
-- observe there output behaviour change the iputs

library ieee;
use ieee.std_logic_1164.all;

entity rippleCarryAdder_tb is 
end entity;

architecture sim of rippleCarryAdder_tb is
	--generate clock period
	constant clkFrequency : integer := 1e6;
	constant clkPeriod    : time    := 1000 ms/clkFrequency;
	-- define sizer of the adders
	constant bitWidth_a1 : integer := 8;
	constant bitWidth_a2 : integer := 4;
	-- other signals
	signal clk   : std_logic := '0';
	signal rst_a1: std_logic := '1';
	signal rst_a2: std_logic := '1';
	
	signal cin_a1 : std_logic;
	signal cin_a2 : std_logic;
	signal cout_a1: std_logic;
	signal cout_a2: std_logic;
	
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
	adder1: entity work.rippleCarryAdder(rtl) 
	generic map(bitwidth => bitWidth_a1-1 )
	port map(
		      clk => clk,  
		      rst => rst_a1,
		      cin => cin_a1,
		      cout=> cout_a1,
		      d0  => d0_a1,
		      d1  => d1_a1,
		      r   => r_a1
		    );
			
	adder2: entity work.rippleCarryAdder(rtl) 
	generic map(bitwidth => bitWidth_a2-1 )
	port map(
		      clk => clk,  
		      rst => rst_a2,
		      cin => cin_a2,
		      cout=> cout_a2,
		      d0  => d0_a2,
		      d1  => d1_a2,
		      r   => r_a2
		    );
		
		
	test: process is
	begin
		--adders test cases
		wait for 5*clkPeriod;
		d0_a1  <= x"AF";
		d1_a1  <= x"01";
		cin_a1 <= '0';
		wait for 10*clkPeriod;
		assert(r_a1 = x"B0" and cout_a1 = '0')report("Case1: Module error");
		
		wait for 5*clkPeriod;
		d0_a2  <= "1010";
		d1_a2  <= "0001";
		cin_a2 <= '0';
		wait for 10*clkPeriod;
		assert(r_a2 = "1011" and cout_a2 = '0')report("Case2: Module error");
		
		
		wait for 5*clkPeriod;
		d0_a1  <= x"FF";
		d1_a1  <= x"01";
		cin_a1 <= '0';
		wait for 10*clkPeriod;
		assert(r_a1 = x"00" and cout_a1 = '1')report("Case3: Module error");
		
		wait for 5*clkPeriod;
		d0_a2  <= "1111";
		d1_a2  <= "1001";
		cin_a2 <= '0';
		wait for 10*clkPeriod;
		assert(r_a2 = "1000" and cout_a2 = '1')report("Case4: Module error");
		
		-- test reset
		
		wait for 5*clkPeriod;
		rst_a1 <= '0';
		wait for 10*clkPeriod;
		assert(r_a1 = x"00" and cout_a1 = '0')report("Case5: Module error"); 
		
		wait for 5*clkPeriod;
	    rst_a2 <= '0';
		wait for 10*clkPeriod;
		assert(r_a2 = "0000" and cout_a2 = '0')report("Case6: Module error");
		
		wait;
	end process;
end architecture;
