- Carry Select Adder
-- Geeth De Silva
-- github : sagee_dev
-- model a carry select adder using multiple carry slect adder blocks

-- package declaration
-- custom integer array to recive withs of blocks
package mytypes_pkg is

     type int_array_t is array (integer range<>) of integer;
	 
end package mytypes_pkg;


library ieee;
use ieee.std_logic_1164.all;
use work.mytypes_pkg.all;

entity carrySelectAdder is
generic(totalBlocks : integer; --number of blocks and size of the each block
		blockWidths : int_array_t );
port(
	signal clk : in  std_logic; --input output signals
	signal rst : in  std_logic;
	signal cin : in  std_logic;
	signal cout: out std_logic;
	
	signal num_1 : in  std_logic_vector;
	signal num_2 : in  std_logic_vector;
	signal num_r : out std_logic_vector
);

end entity;

architecture rtl of carrySelectAdder is


	--custom function to calculate the position of the results and inputs from each array
	function getElementSum(upperIndex : integer ) return integer is
			 variable totalBitSum : integer := 0;
	begin
		for i in upperIndex downto 0 loop
			totalBitSum := totalBitSum + blockwidths(i);
		end loop;
		return totalBitSum;
	end function;
 
	-- intermidiate signals to communicate between blocks
	signal cin_adder : std_logic;
	signal cout_adder: std_logic;
	signal blockinput_1 : std_logic_vector(getElementSum(totalBlocks-1)-1 downto 0);
	signal blockinput_2 : std_logic_vector(getElementSum(totalBlocks-1)-1 downto 0);
	signal blockCarries : std_logic_vector((totalBlocks-1) downto 0);
	signal output : std_logic_vector(getElementSum(totalBlocks-1)-1 downto 0);

	 
begin

	
	blocksgen: for i in totalBlocks-1 downto 0 generate
	--generate carry select adderblock
		gen1: if i  = 0 generate
			blocks: entity work.carrySelectAdderBlock(rtl)
			generic map(blockWidth => blockwidths(i)-1)
			port map(
				   clk=>clk,
				   rst=> '1',
				   cin => cin,
				   cout=> blockCarries(i), -- save carry signals in a dedicated array
				   dataBus_1 =>blockinput_1(getElementSum(i)-1 downto (getElementSum(i)-blockwidths(i))),
				   dataBus_2 =>blockinput_2(getElementSum(i)-1 downto (getElementSum(i)-blockwidths(i))),
				   sum       =>output(getElementSum(i)-1 downto (getElementSum(i)-blockwidths(i))));
		end generate;
		gen2: if i>0 and   i<totalBlocks-1 generate
			blocks: entity work.carrySelectAdderBlock(rtl)
			generic map(blockWidth => blockwidths(i)-1)
			port map(
				   clk=>clk,
				   rst=> '1',
				   cin => blockCarries(i-1),
				   cout=> blockCarries(i),
				   dataBus_1 =>blockinput_1(getElementSum(i)-1 downto (getElementSum(i)-blockwidths(i))),
				   dataBus_2 =>blockinput_2(getElementSum(i)-1 downto (getElementSum(i)-blockwidths(i))),
				   sum       =>output(getElementSum(i)-1 downto (getElementSum(i)-blockwidths(i))));
		end generate;
		gen3: if i  = totalBlocks-1 generate
			blocks: entity work.carrySelectAdderBlock(rtl)
			generic map(blockWidth => blockwidths(i)-1)
			port map(
				   clk=>clk,
				   rst=>'1',
				   cin => blockCarries(i-1),
				   cout=> blockCarries(i),
				   dataBus_1 =>blockinput_1(getElementSum(i)-1 downto (getElementSum(i)-blockwidths(i))),
				   dataBus_2 =>blockinput_2(getElementSum(i)-1 downto (getElementSum(i)-blockwidths(i))),
				   sum       =>output(getElementSum(i)-1 downto (getElementSum(i)-blockwidths(i))));
		end generate;
	end generate;

	behaviour: process(clk) is
	begin
	
			if(rst = '0') then
			--reset functionality
				        cin_adder <= '0';
						blockinput_1 <= (others => '0');
						blockinput_2 <= (others => '0');
						cout_adder   <= '0';
			else
			
				if rising_edge(clk) then
				-- set intermidiate signals at rising clock edge
						cin_adder <= cin;
						blockinput_1 <= num_1;
						blockinput_2 <= num_2;
						
						num_r <= output;
						cout <= blockCarries(totalBlocks-1);
				end if;
			
			end if;
	
	end process;
	
end architecture;
