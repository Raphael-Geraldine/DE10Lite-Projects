Library IEEE;
use ieee.std_logic_1164.all;

entity GerenciadorContagem is 
    port(
        rst: in std_logic;
        Clock, Cin: in std_logic;
        Cout: out std_logic;
        Spy: out std_logic_vector (7 downto 0)
    );
end GerenciadorContagem;

architecture gerenciador of GerenciadorContagem is
    signal var : std_logic_vector (7 downto 0) := "00000000";
    signal outCont : std_logic_vector (7 downto 0);
    
    signal num_in_aux : std_logic_vector (7 downto 0);

    component ContadorByte
	port(
		NumIn : in std_logic_vector (7 downto 0);
		Cin: in std_logic;
		Cout: out std_logic;
		NumOut: out std_logic_vector (7 downto 0)
	);
    end component;

    component PIPO_8bits 
    port(
        Clock, Preset, Clear: in std_logic;
        NumIn: in std_logic_vector (7 downto 0);
        NumOut: out std_logic_vector (7 downto 0)
    );
    end component;

    begin
        num_in_aux <= var and (7 downto 0 => rst);

        Contador: ContadorByte port map(
            NumIn => num_in_aux,
            Cout => Cout, 
            Cin => Cin,
            NumOut => outCont
        );

        OutIn: PIPO_8bits port map(
            Clock => Clock, 
            Preset => '1', 
            Clear => '1',
            NumIn => outCont,
            NumOut => var
        );

        Spy <= outCont;
end gerenciador;