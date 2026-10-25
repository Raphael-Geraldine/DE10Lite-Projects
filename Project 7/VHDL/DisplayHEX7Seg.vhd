Library IEEE;
use ieee.std_logic_1164.all;

entity DisplayHEX7Seg is
	port(
		X0, X1, X2, X3: in std_logic;
		sa, sb, sc, sd, se, sf, sg: out std_logic
		);
end DisplayHEX7Seg;

architecture Display of DisplayHEX7Seg is
	begin
		sa <= ((X0)and(not X1)and(not X2)and(not X3)) or 
				((X2)and(not X1)and(not X3)and(not X0)) or
				((X0)and(X3)and(X2)and(not X1)) or
				((X0)and(X3)and(X1)and(not X2));
				
		sb <= ((X0)and(not X1)and(X2)and(not X3)) or 
				((X3)and(X1)and(X0)) or
				((X3)and(X2)and(not X0)) or
				((X2)and(X1)and(not X0));
				
		sc <= ((X1)and(not X0)and(not X2)and(not X3)) or 
				((X2)and(X3)and(not X0)) or
				((X3)and(X1)and(X2));
				
		sd <= ((X2)and(not X1)and(not X0)and(not X3)) or 
				((X0)and(not X1)and(not X3)and(not X2)) or
				((X1)and(X3)and(not X2)and(not X0)) or
				((X0)and(X2)and(X1));
				
		se <= ((X2)and(not X1)and(not X3)) or 
				((not X2)and(not X1)and(X0)) or
				((X0)and(not X3));
				
		sf <= ((X0)and(not X1)and(X2)and(X3)) or 
				((X0)and(not X2)and(not X3)) or
				((X0)and(X1)and(not X3)) or
				((X1)and(not X3)and(not X2));
				
		sg <= ((X3)and(X2)and(not X0)and(not X1)) or 
				((X2)and(X1)and(not X3)and(X0)) or
				((not X3)and(not X1)and(not X2));
				
	end Display;
		
		