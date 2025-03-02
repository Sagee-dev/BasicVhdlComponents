-- RS Flipflop
-- Geeth De Silva
-- github : sagee_dev
-- v1.0
-- RS Flipflop until it changes
-- has two inputs set (s) reset (r)
-- has two output (q) and inverse of q (inv_q)
-- truth tables as follow
--  s   r   q   invq  
--  0   0   q   invq  hold
--  0   1   0    1
--  1   0   1    0
--  1   1   u    u    invalid

library ieee;
use ieee.std_logic_1164.all;

entity rsFlipflop is
port(
	signal     s : in  std_logic;
	signal     r : in  std_logic;
	signal     q : inout std_logic;
	signal inv_q : inout std_logic
);
end entity;

architecture rtl of rsFlipflop is
	
	function to_bool( a : std_logic := '0') return boolean is
	--this function is to convert std_logic to boolean
	--because if statements required booleans
	begin
		if (a = '1') then
		 return true;
		else
		 return false;
		end if;
	end function;
	

begin

	rs: process(s,r) is
		variable bool_s : boolean;
		variable bool_r : boolean;

	begin
	
	bool_s := to_bool(s);
	bool_r := to_bool(r);
	
		
		if(bool_s xor bool_r) then
		    --if s /= r set or reset data accordingly
			q     <= s;
			inv_q <= r;
		elsif(not(bool_s or bool_r)) then
			-- if s = r = 0; hold data
			q     <= q;  
			inv_q <= inv_q;
		else
			-- results will be invalid otherwise
			q     <= 'U';
			inv_q <= 'U';
		end if;
			
		
	end process;

end architecture;
