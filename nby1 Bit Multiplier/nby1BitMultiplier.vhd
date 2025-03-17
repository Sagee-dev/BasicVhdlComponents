-- n by One bit Multiplyer
-- Geeth De Silva
-- github : sagee-dev
-- product = multiplicand x multiplier
-- multiplier is always 1 bit (0 or 1)
-- multiplicand width is N bit
-- inputs are multiplicand and multiplier
-- output is product and will be the size of N

library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration for the N-by-One bit multiplier
entity nByOneBitMultiplyer is
    -- Generic parameter to specify the width of the multiplicand (N bits)
    generic(multiplicandWidth : integer );
    
    port(
        -- Input signals
        signal clk : in std_logic;  -- Clock signal
        signal rst : in std_logic;  -- Reset signal
        
        -- Input signals for the multiplicand (N bits) and multiplier (1 bit)
        signal multiplicand : in  std_logic_vector(multiplicandWidth - 1 downto 0);  -- N-bit multiplicand
        signal multiplier   : in  std_logic;  -- 1-bit multiplier (either 0 or 1)
        
        -- Output signal for the product, which will be the same width as the multiplicand
        signal product      : out std_logic_vector(multiplicandWidth - 1 downto 0)  -- N-bit product
    ); 
end entity;

-- Architecture definition: RTL (Register Transfer Level) of the N-by-One bit multiplier
architecture rtl of nByOneBitMultiplyer is

    -- Internal signals to store the multiplicand, multiplier, and product
    signal multiplicand_M : std_logic_vector(multiplicandWidth - 1 downto 0);  -- Internal signal for multiplicand
    signal multiplier_M   : std_logic;  -- Internal signal for the 1-bit multiplier
    signal product_M      : std_logic_vector(multiplicandWidth - 1 downto 0);  -- Internal signal for product

begin
    -- Generate block to instantiate individual 2-bit multipliers for each bit of the multiplicand
    genMultiplers : for i in (multiplicandWidth - 1) downto 0 generate
    begin
        -- Instantiate a 2-bit multiplier for each bit of the multiplicand
        mul2bit: entity work.multiplyer2Bit(rtl)
        port map(
            clk => clk,                    -- Clock signal passed to multiplier
            b1  => multiplicand_M(i),      -- Current bit of multiplicand passed to multiplier
            b0  => multiplier_M,           -- 1-bit multiplier passed to multiplier
            r   => product_M(i)            -- Resulting bit of product stored in product_M
        );
    end generate;

    -- Process block to handle the multiplication logic on each clock cycle
    multiply : process(clk) is
    begin
        -- Asynchronous reset: if reset is '0', clear the internal signals
        if(rst = '0') then
            multiplicand_M <= (others => '0');   -- Reset multiplicand_M to all zeros
            multiplier_M   <= '0';               -- Reset multiplier_M to zero
        else
            -- On rising edge of the clock, update the internal signals with input values
            if rising_edge(clk) then
                multiplicand_M <= multiplicand;  -- Assign the external multiplicand to internal signal
                multiplier_M   <= multiplier;    -- Assign the external multiplier to internal signal
                product <= product_M;            -- Update the product output with the internal product
            end if;
        end if;
        
    end process;

end architecture;
