--test bench for full adder
--Geeth De Silva
--Github: sagee_dev
--v1.0

library ieee;
use ieee.std_logic_1164.all;

entity fullAdder_tb is
end entity;

architecture sim of fullAdder_tb is
	
	constant clockFrequecy: integer := 10e6;
	constant clockPeriod  : time    := (1000 ms)/clockFrequecy;
	
	signal clk : std_logic := '0';
	signal rst : std_logic := '1';
	signal b0  : std_logic;
	signal b1  : std_logic;
	signal ci  : std_logic;
	signal s   : std_logic;
	signal co  : std_logic;

begin

	dut: entity work.fullAdder(rtl)
	port map(
		clk => clk,
		rst => rst,
		b0  => b0,
		b1  => b1,
		ci  => ci,
		s   => s,
		co  => co);
	
	clk <= not clk after clockPeriod;
	
	test: process is 
	begin
		
		wait for 10 ms;
		b0 <= '0';
		b1 <= '0';
		ci <= '0';
		wait for 10 ms;
		assert(s='0' and co='0')report ("Report 1: b0 "&std_logic'image(b0)&"b1 "&std_logic'image(b1)&"cin "&std_logic'image(ci)&"s "&std_logic'image(s)&"cout "&std_logic'image(co));
		
		wait for 10 ms;
		b0 <= '0';
		b1 <= '0';
		ci <= '1';
		wait for 10 ms;
		assert(s='1' and co='0')report ("Report 2: b0 "&std_logic'image(b0)&"b1 "&std_logic'image(b1)&"cin "&std_logic'image(ci)&"s "&std_logic'image(s)&"cout "&std_logic'image(co));
		
		wait for 10 ms;
		b0 <= '0';
		b1 <= '1';
		ci <= '0';
		wait for 10 ms;
		assert(s='1' and co='0')report ("Report 3: b0 "&std_logic'image(b0)&"b1 "&std_logic'image(b1)&"cin "&std_logic'image(ci)&"s "&std_logic'image(s)&"cout "&std_logic'image(co));
		
		wait for 10 ms;
		b0 <= '0';
		b1 <= '1';
		ci <= '1';
		wait for 10 ms;
		assert(s='0' and co='1')report ("Report 4: b0 "&std_logic'image(b0)&"b1 "&std_logic'image(b1)&"cin "&std_logic'image(ci)&"s "&std_logic'image(s)&"cout "&std_logic'image(co));
		
		wait for 10 ms;
		b0 <= '1';
		b1 <= '0';
		ci <= '0';
		wait for 10 ms;
		assert(s='1' and co='0')report ("Report 5: b0 "&std_logic'image(b0)&"b1 "&std_logic'image(b1)&"cin "&std_logic'image(ci)&"s "&std_logic'image(s)&"cout "&std_logic'image(co));
		
		wait for 10 ms;
		b0 <= '1';
		b1 <= '0';
		ci <= '1';
		wait for 10 ms;
		assert(s='0' and co='1')report ("Report 6: b0 "&std_logic'image(b0)&"b1 "&std_logic'image(b1)&"cin "&std_logic'image(ci)&"s "&std_logic'image(s)&"cout "&std_logic'image(co));
		
		wait for 10 ms;
		b0 <= '1';
		b1 <= '1';
		ci <= '0';
		wait for 10 ms;
		assert(s='0' and co='1')report ("Report 7: b0 "&std_logic'image(b0)&"b1 "&std_logic'image(b1)&"cin "&std_logic'image(ci)&"s "&std_logic'image(s)&"cout "&std_logic'image(co));
		
		wait for 10 ms;
		b0 <= '1';
		b1 <= '1';
		ci <= '1';
		wait for 10 ms;
		assert(s='1' and co='1')report ("Report 8: b0 "&std_logic'image(b0)&"b1 "&std_logic'image(b1)&"cin "&std_logic'image(ci)&"s "&std_logic'image(s)&"cout "&std_logic'image(co));
	end process;
end architecture;
