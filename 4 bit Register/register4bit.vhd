-- 4 bit register
-- Geeth De Silva
-- github : sagee_dev
-- V1.0
-- 4 bit register made of d flipflops
-- it stores data
-- it has a for inputs (d0,d1,d2,d3)
-- four intermeiate inputs for flipflops
-- four intermediate outputs for flipflops
-- and 4 outputs (q0,q1,q2,q3)
-- and a clk because d flipflop is a sequential logic device
-- so does the register is

library ieee;
use ieee.std_logic_1164.all;

entity register4bit is

port(signal clk : in std_logic;
	 signal rst : in std_logic;	
	 signal d3,d2,d1,d0 : in  std_logic;
	 signal q3,q2,q1,q0 : out std_logic);
	 
end entity;

architecture rtl of register4bit is

	signal d_3,d_2,d_1,d_0 : std_logic; --inputs for flipflop
	signal q_3,q_2,q_1,q_0 : std_logic; --outputs from flipflops
	
begin
	dut_3 : entity work.dFlipflop(rtl)
	port map(clk => clk,d => d_3,q => q_3);
	dut_2 : entity work.dFlipflop(rtl)
	port map(clk => clk,d => d_2,q => q_2);
	dut_1 : entity work.dFlipflop(rtl)
	port map(clk => clk,d => d_1,q => q_1);
	dut_0 : entity work.dFlipflop(rtl)
	port map(clk => clk,d => d_0,q => q_0);
	
	behaviour: process(clk) is
	
	begin
		
		if rising_edge(clk) then
			
			if (rst = '0') then
				d_3 <= '0';
				d_2 <= '0';
				d_1 <= '0';
				d_0 <= '0';
			else
				d_3 <= d3;
				d_2 <= d2;
				d_1 <= d1;
				d_0 <= d0;
			end if;
				q3 <= q_3;
				q2 <= q_2;
				q1 <= q_1;
				q0 <= q_0;
		end if;
		
	end process;
	
end architecture;
