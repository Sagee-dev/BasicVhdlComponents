-- nbit comparator test bench
-- Geeth De Silva
-- github : sagee-dev
-- Testbench for the nbitComparator to observe the output behavior
-- by changing the input signals and checking the comparison outputs

library ieee;
use ieee.std_logic_1164.all;

-- Testbench entity declaration (no ports, as this is a simulation)
entity nbitComparator_tb is
end entity;

-- Architecture declaration for the testbench simulation
architecture sim of nbitComparator_tb is

    -- Constant to define the width of the comparator (8 bits in this case)
    constant comparatorwidth : integer := 8;

    -- Signal declarations for the clock, reset, input data, and output signals
    signal clk : std_logic := '0';                -- Clock signal initialized to '0'
    signal rst : std_logic;                        -- Reset signal (will be asserted in test)
    signal data1 : std_logic_vector(comparatorwidth-1 downto 0);  -- First data input
    signal data0 : std_logic_vector(comparatorwidth-1 downto 0);  -- Second data input
    signal lesser: std_logic;                      -- Lesser output signal
    signal equal : std_logic;                      -- Equal output signal
    signal grater: std_logic;                     -- Greater output signal

    -- Constants for clock frequency and period (1 MHz clock)
    constant clkFrequency : integer := 1e6;        -- Clock frequency 1 MHz
    constant clkPeriod    : time    := 1000 ms/clkFrequency; -- Clock period (1 ms for 1 MHz frequency)

begin

    -- Instantiation of the Unit Under Test (UUT), the nbitComparator
    -- Pass in the 8-bit comparator width via the generic map
    dut: entity work.nbitComparator(rtl)
    generic map(comparatorwidth => 8)    -- Set the comparator width to 8
    port map(
        clk => clk,                       -- Connect the clock signal to UUT
        rst => rst,                       -- Connect the reset signal to UUT
        data1 => data1,                   -- Connect input data1 to UUT
        data0 => data0,                   -- Connect input data0 to UUT
        lesser => lesser,                 -- Connect lesser output to testbench signal
        equal => equal,                   -- Connect equal output to testbench signal
        grater => grater                  -- Connect greater output to testbench signal
    );
    
    -- Generate the clock signal with the specified period
    clk <= not clk after clkPeriod / 2;  -- Invert clock every half-period (to create a square wave)
    
    -- Test process to apply test cases and check outputs
    test: process is
    begin
        -- Initializing reset signal
        rst <= '1';   -- Assert reset signal at the beginning
        
        -- Wait for two clock periods before changing the inputs
        wait for 2*clkPeriod;

        -- Test Case 1: data1 = 0xAF, data0 = 0xAA
        data1 <= x"AF";  -- Set data1 to hexadecimal value 0xAF
        data0 <= x"AA";  -- Set data0 to hexadecimal value 0xAA
        wait for 50*clkPeriod;  -- Wait for 50 clock periods to let comparison happen
        -- Check if the output signals are correct (greater)
        assert (lesser = '0' and equal = '0' and grater = '1') 
            report "Case 1: Module error";  -- If output is incorrect, report an error
        
        -- Test Case 2: data1 = 0xBB, data0 = 0xBB
        wait for 2*clkPeriod;  -- Wait for 2 clock periods before changing inputs
        data1 <= x"BB";  -- Set data1 to hexadecimal value 0xBB
        data0 <= x"BB";  -- Set data0 to hexadecimal value 0xBB
        wait for 50*clkPeriod;  -- Wait for 50 clock periods
        -- Check if the output signals are correct (equal)
        assert (lesser = '0' and equal = '1' and grater = '0') 
            report "Case 2: Module error";  -- If output is incorrect, report an error
        
        -- Test Case 3: data1 = 0xCE, data0 = 0xDF
        wait for 2*clkPeriod;  -- Wait for 2 clock periods
        data1 <= x"CE";  -- Set data1 to hexadecimal value 0xCE
        data0 <= x"DF";  -- Set data0 to hexadecimal value 0xDF
        wait for 50*clkPeriod;  -- Wait for 50 clock periods
        -- Check if the output signals are correct (lesser)
        assert (lesser = '1' and equal = '0' and grater = '0') 
            report "Case 3: Module error";  -- If output is incorrect, report an error
        
        -- End of test
        wait;  -- Wait indefinitely (end of process)
    
    end process;

end architecture;