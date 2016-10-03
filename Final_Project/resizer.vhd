library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity resizer is
	port(
	R,G,B: in unsigned(9 downto 0);
	resized: out unsigned(9 downto 0)
	);
end resizer;



architecture behavior of resizer is 
	begin
	
	process (R,G,B)
	begin
	end process;
	
	
end behavior;