Library IEEE;
use ieee.std_logic_1164.all;

entity ContadorHexa is
	port(
		A0, A1, A2, A3: in std_logic;
		Cin: in std_logic;
		Cout: out std_logic;
		S0, S1, S2, S3: out std_logic
	);
end ContadorHexa;

architecture structHexa of ContadorHexa is

signal C0I1, C1I2, C2I3, Co :std_logic;
signal out0, out1, out2, out3: std_logic;

component Soma1bit
	port(
		A, B, Cin: in std_logic;
		Cout, S: out std_logic
	);
end component;

begin
	Co <= (not A3) and A2 and (not A1) and A0; -- marcou 5 (0101)

    Cout <= Co and Cin;

    somador0: Soma1bit port map (A => A0, B => Cin, Cin => '0',  Cout => C0I1, S => out0);
    somador1: Soma1bit port map (A => A1, B => '0', Cin => C0I1, Cout => C1I2, S => out1);
    somador2: Soma1bit port map (A => A2, B => '0', Cin => C1I2, Cout => C2I3, S => out2);
    somador3: Soma1bit port map (A => A3, B => '0', Cin => C2I3, Cout => open, S => out3);
   
    S0 <= out0 and (not (Co and Cin));
    S1 <= out1 and (not (Co and Cin));
    S2 <= out2 and (not (Co and Cin));
    S3 <= out3 and (not (Co and Cin));
	
end structHexa;