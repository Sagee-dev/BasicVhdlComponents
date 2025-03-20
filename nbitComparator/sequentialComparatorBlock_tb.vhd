-- 1bit sequential Comparator test bench
-- Geeth De Silva
-- v1.0
-- Observe output behavior by changing the input

library ieee;
use ieee.std_logic_1164.all;

-- Testbench entity for the 1-bit sequential comparator
entity sequentialComparator1Bit_tb is
end entity;

architecture sim of sequentialComparator1Bit_tb is
    -- Signal declarations for clock, enable, input bits, and output signals
    signal clk : std_logic := '0';                -- Clock signal, initialized to '0'
    signal en : std_logic;                         -- Enable signal (input)
    signal b1 : std_logic;                         -- First input bit (b1)
    signal b0 : std_logic;                         -- Second input bit (b0)
    signal isLesser : std_logic;                   -- Output for lesser (l)
    signal isEqual : std_logic;                    -- Output for equal (e)
    signal isGrater : std_logic;                   -- Output for greater (g)
    
    -- Constants for clock frequency and period
    constant clkFrequency : integer := 1e6;        -- Clock frequency (1 MHz)
    constant clkPeriod : time := 1000 ms/clkFrequency;  -- Clock period (1 ms for 1 MHz)

begin

    -- Instantiate the unit under test (UUT) - the sequential comparator
    dut: entity work.sequentialComparator1Bit(rtl)
    port map(
        clk => clk,    -- Connect the clock signal to the UUT
        en => en,      -- Connect the enable signal to the UUT
        b1 => b1,      -- Connect the first input bit to the UUT
        b0 => b0,      -- Connect the second input bit to the UUT
        l => isLesser, -- Connect the lesser output to the testbench
        e => isEqual,  -- Connect the equal output to the testbench
        g => isGrater  -- Connect the greater output to the testbench
    );
    
    -- Clock generation: toggle clock signal every half-period
    clk <= not clk after clkPeriod / 2;

    -- Test process to simulate various input combinations and check outputs
    test: process is
    begin
        
        -- Initial delay and setting inputs for first test case
        wait for 2 us;
        en <= '1';          -- Enable the comparator
        b1 <= '0';          -- Set first input bit (b1) to '0'
        b0 <= '0';          -- Set second input bit (b0) to '0'
        wait for 1 us;      -- Wait for 1 clock cycle
        -- Check if output is correct (expected: equal)
        assert(isLesser = '0' and isEqual = '1' and isGrater = '0')
        report("Case 1: Module error");

        -- Second test case: b1 = '0', b0 = '1'
        wait for 2 us;
        b1 <= '0';          -- Set first input bit (b1) to '0'
        b0 <= '1';          -- Set second input bit (b0) to '1'
        wait for 1 us;
        -- Check if output is correct (expected: lesser)
        assert(isLesser = '1' and isEqual = '0' and isGrater = '0')
        report("Case 2: Module error");

        -- Third test case: b1 = '1', b0 = '1'
        wait for 2 us;
        b1 <= '1';          -- Set first input bit (b1) to '1'
        b0 <= '1';          -- Set second input bit (b0) to '1'
        wait for 1 us;
        -- Check if output is correct (expected: equal)
        assert(isLesser = '0' and isEqual = '1' and isGrater = '0')
        report("Case 3: Module error");

        -- Fourth test case: b1 = '1', b0 = '0'
        wait for 2 us;
        b1 <= '1';          -- Set first input bit (b1) to '1'
        b0 <= '0';          -- Set second input bit (b0) to '0'
        wait for 1 us;
        -- Check if output is correct (expected: greater)
        assert(isLesser = '0' and isEqual = '0' and isGrater = '1')
        report("Case 4: Module error");

        -- Fifth test case: Disable the comparator (en = '0')
        wait for 2 us;
        en <= '0';          -- Disable the comparator by setting en = '0'
        b1 <= '0';          -- Set first input bit (b1) to '0'
        b0 <= '0';          -- Set second input bit (b0) to '0'
        wait for 1 us;
        -- Check if output is undefined when en = '0'
        assert(isLesser = '0' and isEqual = '0' and isGrater = '0')
        report("Case 5: Module error");

        -- Sixth test case: Check when en = '0', but inputs change
        wait for 2 us;
        b1 <= '0';          -- Set first input bit (b1) to '0'
        b0 <= '1';          -- Set second input bit (b0) to '1'
        wait for 1 us;
        -- Check if output remains undefined when en = '0'
        assert(isLesser = '0' and isEqual = '0' and isGrater = '0')
        report("Case 6: Module error");

        -- Seventh test case: Check when en = '0' and both bits are '1'
        wait for 2 us;
        b1 <= '1';          -- Set first input bit (b1) to '1'
        b0 <= '1';          -- Set second input bit (b0) to '1'
        wait for 1 us;
        -- Check if output remains undefined when en = '0'
        assert(isLesser = '0' and isEqual = '0' and isGrater = '0')
        report("Case 7: Module error");

        -- Eighth test case: Check when en = '0' and b1 = '1', b0 = '0'
        wait for 2 us;
        b1 <= '1';          -- Set first input bit (b1) to '1'
        b0 <= '0';          -- Set second input bit (b0) to '0'
        wait for 1 us;
        -- Check if output remains undefined when en = '0'
        assert(isLesser = '0' and isEqual = '0' and isGrater = '0')
        report("Case 8: Module error");

        -- Ninth test case: Set en to 'U' (undefined)
        wait for 2 us;
        en <= 'U';          -- Set enable to undefined
        b1 <= '0';          -- Set first input bit (b1) to '0'
        b0 <= '0';          -- Set second input bit (b0) to '0'
        wait for 1 us;
        -- Check if output is undefined when en = 'U'
        assert(isLesser = '0' and isEqual = 'U' and isGrater = '0')
        report("Case 9: Module error");

        -- Tenth test case: Set en to 'U' and b1 = '0', b0 = '1'
        wait for 2 us;
        b1 <= '0';          -- Set first input bit (b1) to '0'
        b0 <= '1';          -- Set second input bit (b0) to '1'
        wait for 1 us;
        -- Check if output is undefined when en = 'U'
        assert(isLesser = 'U' and isEqual = '0' and isGrater = '0')
        report("Case 10: Module error");

        -- Eleventh test case: Set en to 'U' and b1 = '1', b0 = '1'
        wait for 2 us;
        b1 <= '1';          -- Set first input bit (b1) to '1'
        b0 <= '1';          -- Set second input bit (b0) to '1'
        wait for 1 us;
        -- Check if output is undefined when en = 'U'
        assert(isLesser = '0' and isEqual = 'U' and isGrater = '0')
        report("Case 11: Module error");

        -- Twelfth test case: Set en to 'U' and b1 = '1', b0 = '0'
        wait for 2 us;
        b1 <= '1';          -- Set first input bit (b1) to '1'
        b0 <= '0';          -- Set second input bit (b0) to '0'
        wait for 1 us;
        -- Check if output is undefined when en = 'U'
        assert(isLesser = '0' and isEqual = '0' and isGrater = 'U')
        report("Case 12: Module error");

        -- End of test cases
        report("END OF TEST CASES");

        -- End the process
        wait;
        
    end process;

end architecture;