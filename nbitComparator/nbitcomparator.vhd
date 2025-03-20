-- nbitComparator 
-- Geeth De Silva
-- github : sagee-dev
-- nbit comparator accepts 2 N-bit binary numbers 
-- and outputs whether the first number is equal, lesser, or greater than the second number

library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration for the n-bit comparator
entity nbitComparator is
    -- Generic parameter to define the width of the comparator (number of bits)
    generic(comparatorwidth : integer );
    
    -- Port declaration
    port(
        clk : in std_logic;               -- Clock signal
        rst : in std_logic;               -- Reset signal
        data1 : in std_logic_vector(comparatorwidth-1 downto 0); -- First binary input
        data0 : in std_logic_vector(comparatorwidth-1 downto 0); -- Second binary input
        lesser: out std_logic;           -- Output signal indicating if data1 is lesser than data0
        equal : out std_logic;           -- Output signal indicating if data1 is equal to data0
        grater: out std_logic            -- Output signal indicating if data1 is greater than data0
    );
end nbitComparator;

-- Architecture definition for the nbitComparator
architecture rtl of nbitComparator is
    -- Define the state machine states
    type states is (IDLE, SET_INPUT, COMPARE, SET_OUTPUT);
    
    -- Internal signals
    signal data1_c : std_logic_vector(comparatorwidth-1 downto 0);  -- Internal signal for data1
    signal data0_c : std_logic_vector(comparatorwidth-1 downto 0);  -- Internal signal for data0
    signal data1_0 : std_logic_vector(comparatorwidth-1 downto 0); -- Storing data1 for comparison
    signal data0_0 : std_logic_vector(comparatorwidth-1 downto 0); -- Storing data0 for comparison
    signal l_c    : std_logic_vector(comparatorwidth-1 downto 0); -- Lesser comparison result
    signal e_c    : std_logic_vector(comparatorwidth-1 downto 0); -- Equal comparison result
    signal g_c    : std_logic_vector(comparatorwidth-1 downto 0); -- Greater comparison result
    signal lesser_c: std_logic;  -- Internal signal for lesser output
    signal equal_c : std_logic;  -- Internal signal for equal output
    signal grater_c: std_logic;  -- Internal signal for greater output
    signal state : states := IDLE; -- Initial state is IDLE
    signal en : std_logic;  -- Enable signal for the sequential comparators
    
begin
    
    -- Generate blocks to instantiate multiple 1-bit sequential comparators
    seqComGen: for i in comparatorwidth-1 downto 0 generate
        -- 1st bit comparator at the MSB
        gen1: if i = comparatorwidth-1 generate
            seqComl: entity work.sequentialComparator1Bit(rtl)
            port map(
                    clk => clk,
                    en  => en,
                    b1  => data1_c(i),
                    b0  => data0_c(i),
                    l   => l_c(i),
                    e   => e_c(i),
                    g   => g_c(i)
                    );
        end generate;
        
        -- Subsequent bit comparators
        gen0: if i /= comparatorwidth-1 generate
            seqComo: entity work.sequentialComparator1Bit(rtl)
            port map(
                    clk => clk,
                    en  => e_c(i+1),
                    b1  => data1_c(i),
                    b0  => data0_c(i),
                    l   => l_c(i),
                    e   => e_c(i),
                    g   => g_c(i)
                    );
        end generate;
    end generate;
    
    -- Main process to control the state machine and comparator behavior
    behaviour: process(clk) is 
        variable bitcount: integer;  -- To track the bit index during comparison
    begin
        
        -- Reset condition
        if (rst = '0') then
            -- Reset behavior can be defined here if necessary
        else
            -- Rising edge detection for clock
            if rising_edge(clk) then
            
                -- State machine logic
                case state is
                
                    -- IDLE state: Waiting for new inputs
                    when IDLE =>
                        if(data1_0 = data1 and data0_0 = data0) then
                            -- No change in input, stay in IDLE
                        else
                            -- New inputs detected, move to SET_INPUT
                            state <= SET_INPUT;
                        end if;
                        
                    -- SET_INPUT state: Store the inputs and prepare for comparison
                    when SET_INPUT =>
                        -- Load inputs into internal signals
                        data1_c <= data1;
                        data0_c <= data0;
                        data1_0 <= data1;
                        data0_0 <= data0;
                        -- Enable comparison
                        en <= '1';
                        -- Initialize bit count to comparator width
                        bitCount := comparatorwidth;
                        -- Move to comparison state
                        state <= COMPARE;
                        
                    -- COMPARE state: Compare the bits one by one
                    when COMPARE =>
                        -- Decrease bit count with each comparison
                        bitCount := bitCount -1;
                        -- If all bits have been compared, go to SET_OUTPUT
                        if(bitcount = 0) then
                            state <= SET_OUTPUT;
                        else
                            -- If any bit is unequal, exit to SET_OUTPUT
                            if(e_c(bitCount) = '0') then
                                state <= SET_OUTPUT;
                            end if;
                        end if;
                        
                    -- SET_OUTPUT state: Output the results of the comparison
                    when SET_OUTPUT =>
                        -- Set the output signals based on comparison results
                        lesser <= l_c(bitCount);
                        equal  <= e_c(bitCount);
                        grater <= g_c(bitCount);
                        -- Return to IDLE state
                        state <= IDLE;
						en <= '0';
                        
                    -- Default state (should never occur)
                    when others =>
                        state <= IDLE;
                
                end case;
            
            end if;
        end if;
    end process;
end rtl;
