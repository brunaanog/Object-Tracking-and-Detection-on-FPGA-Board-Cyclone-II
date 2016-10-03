library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use IEEE.MATH_REAL.ALL; -- real
--use ieee.fixed_float_types.all; -- ieee_proposed for VHDL-93 version
--use ieee.fixed_pkg.all; -- ieee_proposed for compatibility version





entity rgb2gray is
	port(
	R,G,B: in std_logic_vector(9 downto 0);
	Gray: out std_logic_vector(9 downto 0)
	);
end rgb2gray;



architecture behavior of rgb2gray is 

	signal Gray_12bit : std_logic_vector(11 downto 0);
	begin
	
	process (R,G,B)
	variable floatingGray: integer;

	begin
	
	--floatingGray := ( 2 * to_integer(unsigned(R)) + 7 * to_integer(unsigned(G)) +  to_integer(unsigned(B)))/ 10; --experimentar Y = 0.2126 R + 0.7152 G + 0.0722 B
	floatingGray := (to_integer( (unsigned(R))) + to_integer(unsigned(G)) +  to_integer(unsigned(B)))/ 3;
	Gray_12bit <= std_logic_vector(to_unsigned(floatingGray, 12)) ;
	Gray <= Gray_12bit(11 downto 2);
	--Gray <= R;
	end process;
end behavior;
