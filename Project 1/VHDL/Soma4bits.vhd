Library IEEE;
use ieee.std_logic_1164.all;

entity Soma4bits is
	port(
		A0, A1, A2, A3: in std_logic;
		B0, B1, B2, B3: in std_logic;
		Cin: in std_logic;
		Cout: out std_logic;
		S0, S1, S2, S3: out std_logic
	);
end Soma4bits;

architecture struct of Soma4bits is

signal C0I1, C1I2, C2I3 :std_logic;

component Soma1bit
port(
		A, B, Cin: in std_logic;
		Cout, S: out std_logic
	);
end component;

begin
	somador0: Soma1bit port map (A=>A0, B=>B0, Cin =>Cin, Cout=>C0I1, S=>S0);
	somador1: Soma1bit port map (A=>A1, B=>B1, Cin =>C0I1, Cout=>C1I2, S=>S1);
	somador2: Soma1bit port map (A=>A2, B=>B2, Cin =>C1I2, Cout=>C2I3, S=>S2);
	somador3: Soma1bit port map (A=>A3, B=>B3, Cin =>C2I3, Cout=>Cout, S=>S3);
	
end struct;