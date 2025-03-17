-- n by One bit Multiplyer test bench
-- Geeth De Silva
-- github : sagee-dev
-- observe output behaviour changing
-- multiplier and multiplicand
-- inputs are multiplicand and multiplier
-- output is product and will be the size of N

library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration for testbench (no ports since it's just simulation)
entity nByOneBitMultiplier_tb is
end entity;

-- Architecture definition for simulation
architecture sim of nByOneBitMultiplier_tb is
    -- Constant for defining the width of the multiplicand
    constant multiplicandWidth : integer := 8;
    
    -- Clock parameters
    constant clkFrequecy : integer := 1e6;  -- Clock frequency set to 1 MHz
    constant clkPeriod   : time := 1000 ms/clkFrequecy;  -- Calculate clock period based on frequency

    -- Signals declaration for the testbench
    signal clk : std_logic := '1';  -- Clock signal, initialized to '1'
    signal rst : std_logic := '1';  -- Reset signal, initialized to '1'
    signal multiplicand : std_logic_vector(multiplicandWidth - 1 downto 0);  -- 8-bit multiplicand signal
    signal multiplier   : std_logic;  -- 1-bit multiplier signal
    signal product      : std_logic_vector(multiplicandWidth - 1 downto 0);  -- 8-bit product output

begin
    -- Clock generation: toggles the clock every half period
    clk <= not clk after clkPeriod/2;
    
    -- Instantiate the N-by-One Bit Multiplier entity for simulation
    multip: entity work.nByOneBitMultiplyer(rtl)
    generic map (multiplicandWidth => multiplicandWidth)  -- Map the constant multiplicand width to the multiplier
    port map(
        clk => clk,               -- Connect clock signal
        rst => rst,               -- Connect reset signal
        multiplicand => multiplicand,  -- Connect multiplicand signal
        multiplier   => multiplier,    -- Connect multiplier signal
        product      => product       -- Connect product signal
    );
    
    -- Test process to stimulate input signals and check outputs
    test: process is
    begin
        -- Test case 1: Set multiplicand to FF (255), multiplier to 1
        multiplicand <= x"FF";  -- Set multiplicand to 255 (all bits 1)
        multiplier   <= '1';    -- Set multiplier to 1
        wait for 20 * clkPeriod;  -- Wait for 20 clock periods
        
        -- Assert: Product should be 255 (x"FF")
        assert(product = x"FF") report("Case 1: module error");
        wait for 2 * clkPeriod;  -- Wait for 2 clock periods

        -- Test case 2: Set multiplicand to FF, multiplier to 0
        multiplicand <= x"FF";  -- Set multiplicand to 255 (all bits 1)
        multiplier   <= '0';    -- Set multiplier to 0
        wait for 20 * clkPeriod;  -- Wait for 20 clock periods
        
        -- Assert: Product should be 0 (x"00")
        assert(product = x"00") report("Case 2: module error");
        wait for 2 * clkPeriod;  -- Wait for 2 clock periods

        -- Test case 3: Repeat Test case 2 (same inputs, should have same output)
        multiplicand <= x"FF";  -- Set multiplicand to 255 (all bits 1)
        multiplier   <= '0';    -- Set multiplier to 0
        wait for 20 * clkPeriod;  -- Wait for 20 clock periods
        
        -- Assert: Product should be 0 (x"00")
        assert(product = x"00") report("Case 3: module error");
        wait for 2 * clkPeriod;  -- Wait for 2 clock periods
        
        -- End simulation
        wait;  -- Wait forever (end of simulation)
    end process;

end architecture;
