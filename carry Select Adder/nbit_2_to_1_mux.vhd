-- nbit 2 to 1 mux
-- Geeth De Silva
-- github : sagee_dev
-- v1.1
   -- carry out behaviour updated
-- 2 data buses conected to multiplexter
-- output decided over selector bit
-- both data buses are equal in size
-- data bus size is generic

library ieee;
use ieee.std_logic_1164.all;

entity nbit2to1Mux is
generic(buswidth : integer);
port(
	signal dBus1 : in  std_logic_vector(buswidth downto 0);
	signal dBus2 : in  std_logic_vector(buswidth downto 0);
	signal sel   : in  std_logic;
	signal muxedBus  : out std_logic_vector(buswidth downto 0)
);
end entity;

architecture rtl of nbit2to1Mux is
begin

	nbitMux: process(sel,dBus1,dBus2) is
	begin
	
		if (sel = '0') then
			muxedBus <= dBus1;
		else
			muxedBus <= dBus2;
		end if;

	end process;

end architecture;