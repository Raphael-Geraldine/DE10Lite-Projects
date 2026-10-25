Library IEEE;
use ieee.std_logic_1164.all;

entity ContadorByte is
	port(
		NumIn : in std_logic_vector (7 downto 0);
		Cin: in std_logic;
		Cout: out std_logic;
		NumOut: out std_logic_vector (7 downto 0)
	);
end ContadorByte;

architecture struct of ContadorByte is

signal lig : std_logic_vector (6 downto 0);

component Soma1bit
	port(
		A, B, Cin: in std_logic;
		Cout, S: out std_logic
	);
end component;

begin
    somador0: Soma1bit port map (A => NumIn(0), B => Cin, Cin => '0'   , Cout => lig(0), S => NumOut(0));
    somador1: Soma1bit port map (A => NumIn(1), B => '0', Cin => lig(0), Cout => lig(1), S => NumOut(1));
    somador2: Soma1bit port map (A => NumIn(2), B => '0', Cin => lig(1), Cout => lig(2), S => NumOut(2));
    somador3: Soma1bit port map (A => NumIn(3), B => '0', Cin => lig(2), Cout => lig(3), S => NumOut(3));

	somador4: Soma1bit port map (A => NumIn(4), B => '0', Cin => lig(3), Cout => lig(4), S => NumOut(4));
    somador5: Soma1bit port map (A => NumIn(5), B => '0', Cin => lig(4), Cout => lig(5), S => NumOut(5));
    somador6: Soma1bit port map (A => NumIn(6), B => '0', Cin => lig(5), Cout => lig(6), S => NumOut(6));
    somador7: Soma1bit port map (A => NumIn(7), B => '0', Cin => lig(6), Cout => Cout  , S => NumOut(7));

end struct;