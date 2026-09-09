Library IEEE;
use ieee.std_logic_1164.all;

entity Registrador is
	port(
		A0, A1, A2, A3: in std_logic;

		Key0, Key1: in std_logic;
		
		Switch: in std_logic;
		
		Hex0: out std_logic_vector(6 downto 0);
		Hex1: out std_logic_vector(6 downto 0);
		Hex2: out std_logic_vector(6 downto 0);
		Hex3: out std_logic_vector(6 downto 0);
		Hex4: out std_logic_vector(6 downto 0);
		Hex5: out std_logic_vector(6 downto 0)
		);
end Registrador;


architecture TOP_LEVEL of Registrador is
	
	signal Out0, Out1, Out2, Out3, Co: std_logic;
	signal Sec0, Sec1, Sec2, Sec3: std_logic;
	
	signal aux_x0: std_logic;
	
	component DisplayHEX7Seg
		port(
			X0, X1, X2, X3: in std_logic;
			sa, sb, sc, sd, se, sf, sg: out std_logic
			);
	end component;

	component RegDeslocamento
		port(
			Serial: in std_logic;
			Pst, Clr: in std_logic;
			Clk: in std_logic;
			O, Oo: out std_logic_vector(4 downto 0)
		);
	end component;
	
	component Compl1
		port(
			I0, I1, I2, I3: in std_logic;
			S0, S1, S2, S3: out std_logic;
			entry: in std_logic
			);
	end component;
	
	component Soma4bits
        port(
            A0, A1, A2, A3 : in  std_logic;
            B0, B1, B2, B3 : in  std_logic;
            Cin            : in  std_logic;
            Cout           : out std_logic;
            S0, S1, S2, S3 : out std_logic
        );
    end component;

	component Mux2 
		port(
			I0, I1: in std_logic_vector(3 downto 0);
        	S: in std_logic;
        	O: out std_logic_vector(3 downto 0)
		);
	end component;

	signal dis1, dis2, dis3, dis4, dis5: std_logic_vector(3 downto 0);
	signal res0, res1: std_logic_vector(3 downto 0);
	
	begin
	
	aux_x0 <= Co xor Switch;
	
	subtract: Compl1 port map (
		I0 => dis1(0), I1 => dis1(1), I2=>dis1(2), I3 =>dis1(3),
		S0 => Sec0, S1 => Sec1, S2 => Sec2, S3 => Sec3,
		entry => Switch
	);
	
	AddOrSub: Soma4bits port map
	(
		A0 => A0, A1 => A1, A2 => A2, A3 => A3,
		B0 => Sec0, B1 => Sec1, B2 => Sec2, B3 => Sec3,
		Cin => Switch, Cout => Co,
		S0 => Out0, S1 => Out1, S2 => Out2, S3 => Out3
	);
	
	display0: DisplayHEX7Seg port map (
		X0 => A0, X1 => A1, X2 => A2, X3 => A3,
		sa => Hex0(0), sb => Hex0(1), sc => Hex0(2), sd => Hex0(3), se => Hex0(4), sf => Hex0(5), sg => Hex0(6)
	);

	display1: DisplayHEX7Seg port map (
		X0 => dis1(0), X1 => dis1(1), X2 => dis1(2), X3 => dis1(3),
		sa => Hex1(0), sb => Hex1(1), sc => Hex1(2), sd => Hex1(3), se => Hex1(4), sf => Hex1(5), sg => Hex1(6)
	);

	display2: DisplayHEX7Seg port map (
		X0 => dis2(0), X1 => dis2(1), X2 => dis2(2), X3 => dis2(3),
		sa => Hex2(0), sb => Hex2(1), sc => Hex2(2), sd => Hex2(3), se => Hex2(4), sf => Hex2(5), sg => Hex2(6)
	);

	display3: DisplayHEX7Seg port map (
		X0 => dis3(0), X1 => dis3(1), X2 => dis3(2), X3 => dis3(3),
		sa => Hex3(0), sb => Hex3(1), sc => Hex3(2), sd => Hex3(3), se => Hex3(4), sf => Hex3(5), sg => Hex3(6)
	);

	funcao0: Mux2 port map
	(
		I0(0) => dis4(0), I0(1) => dis4(1), I0(2) => dis4(2), I0(3) => dis4(3),
		I1(0) => Out0, I1(1) => Out1, I1(2) => Out2, I1(3) => Out3,
		S => Key1,
		O => res0  	
	);

	funcao1: Mux2 port map
	(
		I0(0) => dis5(0), I0(1) => dis5(1), I0(2) => dis5(2), I0(3) => dis5(3),
		I1(0) => aux_x0, I1(1) => '0', I1(2) => '0', I1(3) => '0',
		S => Key1,
		O => res1  	
	);


	display4: DisplayHEX7Seg port map (
		X0 => res0(0), X1 => res0(1), X2 => res0(2), X3 => res0(3),
		sa => Hex4(0), sb => Hex4(1), sc => Hex4(2), sd => Hex4(3), se => Hex4(4), sf => Hex4(5), sg => Hex4(6)
	);

	display5: DisplayHEX7Seg port map (
		X0 => res1(0), X1 => res1(1), X2 => res1(2), X3 => res1(3),
		sa => Hex5(0), sb => Hex5(1), sc => Hex5(2), sd => Hex5(3), se => Hex5(4), sf => Hex5(5), sg => Hex5(6)
	);

	mov0: RegDeslocamento port map(		
		Serial => A0,
		Pst => '1', Clr => '1',
		Clk => Key0,
		O(0) => dis1(0), O(1) => dis2(0), O(2) => dis3(0), O(3) => dis4(0), O(4) => dis5(0),
		Oo => open
	);

	mov1: RegDeslocamento port map(		
		Serial => A1,
		Pst => '1', Clr => '1',
		Clk => Key0,
		O(0) => dis1(1), O(1) => dis2(1), O(2) => dis3(1), O(3) => dis4(1), O(4) => dis5(1),
		Oo => open
	);

	mov2: RegDeslocamento port map(		
		Serial => A2, 
		Pst => '1', Clr => '1',
		Clk => Key0,
		O(0) => dis1(2), O(1) => dis2(2), O(2) => dis3(2), O(3) => dis4(2), O(4) => dis5(2),
		Oo => open
	);

	mov3: RegDeslocamento port map(		
		Serial => A3, 
		Pst => '1', Clr => '1',
		Clk => Key0,
		O(0) => dis1(3), O(1) => dis2(3), O(2) => dis3(3), O(3) => dis4(3), O(4) => dis5(3),
		Oo => open
	);

	end TOP_LEVEL;