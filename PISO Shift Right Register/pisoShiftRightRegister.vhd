-- piso shift right register
-- Geeth De Silva
-- github : sagee-dev
-- v1.0
-- shift register basically nothig but an
-- array of D flipflops
-- piso is parallel in serial out 
-- data will be input pararelly to all flipflops
-- in a single clock cycle 
-- output will be sequential
-- data will be sift to the right side

library ieee;
use ieee.std_logic_1164.all;

entity pisoShiftRightRegister is
generic(shiftRightRegisterWidth : integer);
 port(
	signal clk    : in  std_logic;
	signal rst    : in  std_logic;
	signal data   : in  std_logic_vector(shiftRightRegisterWidth-1 downto 0);
	signal isShift: in  std_logic := '0';
	signal rOut   : out std_logic
 );
end entity;

architecture rtl of pisoShiftRightRegister is
	--intermediate signals to pass to flipflops 
	signal d_d : std_logic_vector(shiftRightRegisterWidth-1 downto 0);
	signal q_d : std_logic_vector(shiftRightRegisterWidth-1 downto 0);
	signal andMask : std_logic_vector(shiftRightRegisterWidth-1 downto 0) := (others => '1');
	

begin


	genFlipflop: for i in shiftRightRegisterWidth-1 downto 0 generate
				dflipflop: entity work.dflipflop(rtl)-- generate array of flipflops
					port map(
						clk => clk,
						d => d_d(i),
						q => q_d(i)
						);
				end generate;
	
	shift: process(clk) is

	begin
	
		if(rst = '0') then
		else
			if rising_edge(clk) then
				if(isShift = '1') then
					--right shift operation
					rOut   <= q_d(0);
					d_d(shiftRightRegisterWidth-1)	<= '0';
					d_d(shiftRightRegisterWidth-2 downto 0) <= q_d(shiftRightRegisterWidth-1 downto 1);
				else
					--set data to flipflops
					d_d <= data;
					andMask( shiftRightRegisterWidth - 1) <='0';

				end if;
			end if;
		end if;
	end process;

end architecture;
