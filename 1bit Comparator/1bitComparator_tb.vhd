--- 1bitComparator test bench
-- Geeth De Silva
-- v1.0
-- Observe output behavior by changing the input values

library ieee;
use ieee.std_logic_1164.all;

entity comparator1Bit_tb is
end entity;

architecture sim of comparator1Bit_tb is

    -- Declare signals for inputs and outputs
    signal b1 : std_logic;  -- First input bit
    signal b0 : std_logic;  -- Second input bit
    signal isLesser : std_logic; -- Output signal for b1 < b0
    signal isEqual  : std_logic; -- Output signal for b1 = b0
    signal isGrater : std_logic; -- Output signal for b1 > b0

begin

    -- Instantiate the device under test (DUT)
    dut: entity work.comparator1Bit(rtl)
    port map(
        b1 => b1,
        b0 => b0,
        l  => isLesser,
        e  => isEqual,
        g  => isGrater
    );

    -- Test process to apply input stimulus and check outputs
    test: process is
    begin
        
        -- Test Case 1: b1 = 0, b0 = 0  (Expected: Equal)
        wait for 2 us;
        b1 <= '0';
        b0 <= '0';
        wait for 1 us;
        assert(isLesser = '0' and isEqual = '1' and isGrater = '0')
        report("Case 1: Module error");
        wait for 2 us;
        
        -- Test Case 2: b1 = 0, b0 = 1  (Expected: Lesser)
        wait for 2 us;
        b1 <= '0';
        b0 <= '1';
        wait for 1 us;
        assert(isLesser = '1' and isEqual = '0' and isGrater = '0')
        report("Case 2: Module error");
        wait for 2 us;
        
        -- Test Case 3: b1 = 1, b0 = 1  (Expected: Equal)
        wait for 2 us;
        b1 <= '1';
        b0 <= '1';
        wait for 1 us;
        assert(isLesser = '0' and isEqual = '1' and isGrater = '0')
        report("Case 3: Module error");
        wait for 2 us;
        
        -- Test Case 4: b1 = 1, b0 = 0  (Expected: Greater)
        wait for 2 us;
        b1 <= '1';
        b0 <= '0';
        wait for 1 us;
        assert(isLesser = '0' and isEqual = '0' and isGrater = '1')
        report("Case 4: Module error");
        wait for 2 us;
        
        -- Stop simulation
        wait;
        
    end process;

end architecture;
