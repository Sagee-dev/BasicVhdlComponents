-- pipo shift left register
-- Geeth De Silva
-- github : sagee-dev
-- v1.0
-- shift register basically nothig but an
-- array of D flipflops
-- pipo is parallel in parallel out 
-- data will be input pararelly to all flipflops
-- in a single clock cycle 
-- then data will be shift to the defined number of bits
-- results will be output in sigble clock cycle
-- ****this version is not synthasisable as it contain an after statement ***
-- find piso Shift right afsm for synthasysable version

library ieee;
use ieee.std_logic_1164.all;

entity pipoShiftLeftRegister is
generic(shiftLeftRegisterWidth : integer);
 port(
	signal shiftLim: in  integer;
	signal clk     : in  std_logic;
	signal rst     : in  std_logic;
	signal data    : in  std_logic_vector(shiftLeftRegisterWidth-1 downto 0);
	signal rOut    : out std_logic_vector(shiftLeftRegisterWidth-1 downto 0)
 );
end entity;

architecture rtl of pipoShiftLeftRegister is
	--intermediate signals to pass to flipflops 
	signal isEnable : std_logic := '1'; 
	signal isShifted: std_logic := '1';
	signal shiftLen : integer := 0;
	signal shifCycles : integer := 0;
	signal d_d : std_logic_vector(shiftLeftRegisterWidth-1 downto 0):=(others => '0');
	signal q_d : std_logic_vector(shiftLeftRegisterWidth-1 downto 0):=(others => '0');

begin


	genFlipflop: for i in shiftLeftRegisterWidth-1 downto 0 generate
				dflipflop: entity work.dflipflop(rtl)-- generate array of flipflops
					port map(
						clk => clk,
						d => d_d(i),
						q => q_d(i)
						);
				end generate;
				

	
	enable: process(data,shiftLim) is 
	begin
		if(isShifted = '1') then
			isEnable <= '0','1' after 1 us;
			
		end if;
	end process;
	
	shift: process(clk) is
	begin
	
		if(rst = '0') then
		else
			if rising_edge(clk) then
				if (shifCycles = 0) then
					shiftLen <= shiftLim;
					if(isShifted = '0') then
						d_d <= data;
						shifCycles <= 2*shiftLen;
					else
						d_d <= q_d;
						isShifted <= isEnable;
					end if;
					rOut <= q_d;
					

				else
					shifCycles <= shifCycles - 1;
					--shift left by 1
					--set LSB to 0
					d_d(0) <= '0';
					--set q to d of next flipflop
					d_d(shiftLeftRegisterWidth-1 downto 1) <= q_d(shiftLeftRegisterWidth-2 downto 0);
					rOut <= q_d;
					if (shifCycles = 1) then
						isShifted <= '1';
						shiftLen <= 0;
						d_d <= q_d;
					end if;
					
				end if;
			end if;
		end if;
	end process;

end architecture;
