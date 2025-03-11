-- piso shift right register
-- Geeth De Silva
-- github : sagee-dev
-- v1.0
-- shift reguster basically nothig but an
-- array of D flipflops
-- piso is parallel in serial out 
-- data will be input pararelly to all flipflops
-- in a single clock cycle 
-- output will be sequential

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
					rOut   <= q_d(shiftRightRegisterWidth-1);
					d_d(0) <= '0';
					--set q to d of next flipflop
					d_d(shiftRightRegisterWidth-1 downto 1) <= q_d(shiftRightRegisterWidth-2 downto 0);
				else
					--set data to flipflops
					d_d <= data;

				end if;
			end if;
		end if;
	end process;

end architecture;
