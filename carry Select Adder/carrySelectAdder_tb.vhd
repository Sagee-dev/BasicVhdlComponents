-- carry select adder test bench
-- Geeth De Silva
-- github : sagee_dev
-- obserse output behaviour of the carry select adder
-- by changing the inputs

library ieee;
use ieee.std_logic_1164.all;
use work.mytypes_pkg.all;

entity carrySelectAdder_tb is
end entity;

architecture sim of carrySelectAdder_tb is

--input and output signals to/from carry select adder
    --define clock period of 1 ns
	constant clkFrequency : integer := 1e6;
	constant clkPeriod    : time    := 1000 ms/clkFrequency;
	
	constant bitWidth    : integer := 8;
	constant totalBlocks : integer := 3;
	constant blockWidths : int_array_t(totalBlocks-1 downto 0) := (2,2,4);
	
	signal clk : std_logic := '0';
	signal rst : std_logic := '1';
	signal cin  : std_logic;
	signal cout : std_logic;
	signal inputNum1 : std_logic_vector(bitWidth-1 downto 0);
	signal inputNum2 : std_logic_vector(bitWidth-1 downto 0);
	signal resultNum : std_logic_vector(bitWidth-1 downto 0);
	
begin
--generate Carry select adder with defined size
	dut: entity work.carrySelectAdder(rtl)
	generic map(totalBlocks => totalBlocks,
				blockWidths => blockWidths)
	port map(
		clk => clk,
		rst => rst,
		cin => cin,
		cout=> cout,
	    num_1 => inputNum1,
		num_2 => inputNum2,
		num_r => resultNum
	);
	
	clk <= not clk after clkPeriod/2; --change clock state every 0.5 ns
	
	result: process is 
	begin
	--test cases
		wait for 10*clkPeriod;
		cin <= '0';
		inputNum1 <= x"AA";
		inputNum2 <= x"05";
		wait for 10*clkPeriod;
		assert( resultNum = x"AF" and cout = '0')report("Case 1: Module Error");
		
		wait for 10*clkPeriod;
		cin <= '0';
		inputNum1 <= x"AA";
		inputNum2 <= x"AF";
		wait for 10*clkPeriod;
		assert( resultNum = x"59" and cout = '1')report("Case 2: Module Error");
		
		wait;
	
	end process;
				
