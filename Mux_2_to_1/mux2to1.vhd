--2 to 1 Mux
--Geeth De Silva
--github : sagee_dev
--v1.0
--multiplex select output signal from 
--multiple imput
--three input signals data1 (d1) data2 (d2) select(s)
--one output signal (0)

library ieee;
use ieee.std_logic_1164.all;

entity mux2to1 is
port(
     signal d0: in  std_logic;
     signal d1: in  std_logic;
	 signal s : in  std_logic;
	 signal o : out std_logic
	 );
end entity;

architecture rtl of mux2to1 is
begin

	mux: process(s) is
	begin
		if s = '0' then
			-- if select is 0 set output to d1 
			o <= d0;
		elsif s = '1' then
			-- if select is 1 set output to d2 
			o <= d1;
		end if;
	end process;
end architecture;
