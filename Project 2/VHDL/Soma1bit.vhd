Library IEEE;
use ieee.std_logic_1164.all;

entity Soma1bit is
	port(
		A, B, Cin: in std_logic;
		Cout, S: out std_logic
	);
end Soma1bit;

architecture GATE_LEVEL of Soma1bit is 
	begin
		S <= A xor B xor Cin;
		Cout <= (B and (A or Cin)) or (A and Cin);
	end GATE_LEVEL;