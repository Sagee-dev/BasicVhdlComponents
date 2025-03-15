-- pipo Left Shift FSM register test bench
-- Geeth De Silva
-- github : sagee-dev
-- v1.0
-- Left shift register test bench
-- Observe the left shift behavior

library ieee;
use ieee.std_logic_1164.all;

-- Entity definition for the testbench
-- No ports needed for the testbench as it's self-contained
entity pipoShiftLeftFsmRegister_tb is
end entity;

-- Architecture definition: sim
-- Contains the testbench logic and stimulus for the pipoShiftLeftFsmRegister
architecture sim of pipoShiftLeftFsmRegister_tb is

    -- Constant definitions for clock frequency and period
    constant clkFrequency : integer := 1e6;  -- Clock frequency (in Hz)
    constant clkPeriod    : time    := 1000 ms / clkFrequency;  -- Clock period based on the frequency
    
    -- Constant for the shift-left register width (8 bits in this case)
    constant shiftLeftRegisterWidth : integer := 8;

    -- Signals for the testbench
    signal clk  : std_logic := '1';  -- Clock signal, initially set to '1'
    signal rst  : std_logic := '1';  -- Reset signal, initially set to '1'
    signal data : std_logic_vector(shiftLeftRegisterWidth-1 downto 0);  -- Input data (8-bit vector)
    signal q    : std_logic_vector(shiftLeftRegisterWidth-1 downto 0);  -- Output shifted data (8-bit vector)
    signal shiftLim : integer := 0;  -- Shift limit (number of shifts to apply, initially set to 0)

begin

    -- Clock generation: Toggle the clock every half clock period (creating a clock with period 'clkPeriod')
    clk <= not clk after clkPeriod/2;  -- 0.5 ns clock signal 

    -- Instantiate the device under test (DUT): pipoShiftLeftFsmRegister
    -- The DUT is configured with the specified register width
    dut: entity work.pipoShiftLeftFsmRegister(rtl)
        generic map(registerWidth => shiftLeftRegisterWidth)  -- Set the register width for the DUT
        port map(
            clk => clk,          -- Connect the clock signal to the DUT
            rst => rst,          -- Connect the reset signal to the DUT
            data => data,        -- Connect the input data signal to the DUT
            sLim => shiftLim,    -- Connect the shift limit to the DUT
            rslt => q            -- Connect the result/output signal from DUT
        );
    
    -- Testbench process to provide stimulus and check the output
    test: process is
    begin
        -- Case 1: Set input data to 10101010 in hexadecimal (AA)
        -- Shift left twice (shiftLim = 2)
        -- Expected output after shifting twice: 1 0 1 0 1 0 0 0 (A8 in hexadecimal)
        wait for 5*clkPeriod;  -- Wait for 5 clock periods before changing input
        data   <= x"AA";  -- Set the input data to 0xAA (10101010 in binary)
        shiftLim <= 2;    -- Set the number of shifts to 2
        wait for 15*clkPeriod;  -- Wait for 15 clock periods for the shifts to complete
        assert(q = x"A8") report("Case 1: Module error");  -- Check if output is 0xA8

        -- Case 2: Set input data to 11111010 in hexadecimal (FA)
        -- Shift left 4 times (shiftLim = 4)
        -- Expected output after shifting 4 times: 1 0 1 0 0 0 0 0 (A0 in hexadecimal)
        wait for 5*clkPeriod;  -- Wait for 5 clock periods before changing input
        data   <= x"FA";  -- Set the input data to 0xFA (11111010 in binary)
        shiftLim <= 4;    -- Set the number of shifts to 4
        wait for 30*clkPeriod;  -- Wait for 30 clock periods for the shifts to complete
        assert(q = x"A0") report("Case 2: Module error");  -- Check if output is 0xA0

        -- Case 3: Set input data to 11111111 in hexadecimal (FF)
        -- Shift left 8 times (shiftLim = 8)
        -- Expected output after shifting 8 times: 0 0 0 0 0 0 0 0 (00 in hexadecimal)
        wait for 5*clkPeriod;  -- Wait for 5 clock periods before changing input
        data   <= x"FF";  -- Set the input data to 0xFF (11111111 in binary)
        shiftLim <= 8;    -- Set the number of shifts to 8
        wait for 45*clkPeriod;  -- Wait for 45 clock periods for the shifts to complete
        assert(q = x"00") report("Case 3: Module error");  -- Check if output is 0x00

        -- End the simulation
        wait;
        
    end process;

end architecture;
