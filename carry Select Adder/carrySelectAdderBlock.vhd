-- Carry Select Adder
-- Geeth De Silva
-- github : sagee_dev
-- consists of 2*n adders
-- n set of addser add bits assuming cin is 1
-- n set of adders add bits assuming cin is 0
-- final result will be upon the actual cin 

library ieee;
use ieee.std_logic_1164.all;

entity carrySelectAdderBlock is
generic(blockWidth : integer ); --generic interger to get width of the block
port(
	signal clk : in  std_logic;--input output signals
	signal rst : in  std_logic;
	signal cin : in  std_logic;
	signal cout: out std_logic;
	signal dataBus_1 : in  std_logic_vector(blockWidth downto 0);
	signal dataBus_2 : in  std_logic_vector(blockWidth downto 0);
	signal sum       : out std_logic_vector(blockWidth downto 0));
end entity;

architecture rtl of carrySelectAdderBlock is
--intermediate signals to pass to the ripple carry adders
	signal ci_mux   : std_logic;
	signal cout0   : std_logic;
	signal cout1   : std_logic;
	signal input_1  : std_logic_vector(blockWidth downto 0);
	signal input_2  : std_logic_vector(blockWidth downto 0);
	signal sum_c0   : std_logic_vector(blockWidth downto 0);
	signal sum_c1   : std_logic_vector(blockWidth downto 0);
	signal sum_mux  : std_logic_vector(blockWidth downto 0);
begin
-- generate rca with carry input o
	rca_c0 : entity work.rippleCarryAdder(rtl)
	generic map(bitWidth => blockWidth)
	port map(
		clk => clk,
		rst => rst,
		cin => '0',
		cout=> cout0,
		d0  => input_1,
		d1  => input_2,
		r   => sum_c0
	);
-- generate rca with carry input 1
	rca_c1 : entity work.rippleCarryAdder(rtl)
	generic map(bitWidth => blockWidth)
	port map(
		clk => clk,
		rst => rst,
		cin => '1',
		cout=> cout1,
		d0  => input_1,
		d1  => input_2,
		r   => sum_c1
	);
--generate multiplexer to multi[lex between two addition
--depending on the actual carryin
	mux : entity work.nbit2to1mux(rtl)
	generic map(buswidth => blockWidth)
	port map(
		dBus1 => sum_c0,
		dBus2 => sum_c1,
		sel => cin,
		muxedBus => sum_mux
	);
	
	addition: process(clk) is
	begin
		if rising_edge(clk) then
		--set inputoutputs on each clock edge
			input_1 <= dataBus_1;
			input_2 <= dataBus_2;
			sum     <= sum_mux;
			ci_mux  <= cin;
			if(cin = '0') then
				cout <= cout0;
			else
				cout <= cout1;
			end if;
	
		end if;
	end process;

end architecture;
