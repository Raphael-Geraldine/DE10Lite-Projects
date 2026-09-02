Library IEEE;
use ieee.std_logic_1164.all;

entity Somador is
	port(
		A0, A1, A2, A3: in std_logic;
		B0, B1, B2, B3: in std_logic;
		
		Switch: in std_logic;
		
		DAa, DAb, DAc, DAd, DAe, DAf, DAg: out std_logic;
		DBa, DBb, DBc, DBd, DBe, DBf, DBg: out std_logic;
		
		DSa, DSb, DSc, DSd, DSe, DSf, DSg: out std_logic;
		
		DCa, DCb, DCc, DCd, DCe, DCf, DCg: out std_logic
		);
end Somador;


architecture TOP_LEVEL of Somador is
	
	signal Out0, Out1, Out2, Out3, Co: std_logic;
	signal Sec0, Sec1, Sec2, Sec3: std_logic;
	
	signal aux_x0 : std_logic;
	
	component DisplayHEX7Seg
		port(
			X0, X1, X2, X3: in std_logic;
			sa, sb, sc, sd, se, sf, sg: out std_logic
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
	
	begin
	
	aux_x0 <= Co xor Switch;

	displayValorA: DisplayHEX7Seg port map (
		X0 => A0, X1 => A1, X2 => A2, X3 => A3,
		sa => DAa, sb => DAb, sc => DAc, sd => DAd, se => DAe, sf => DAf, sg => DAg
	);
	
	displayValorB: DisplayHEX7Seg port map (
		X0 => B0, X1 => B1, X2 => B2, X3 => B3,
		sa => DBa, sb => DBb, sc => DBc, sd => DBd, se => DBe, sf => DBf, sg => DBg
	);
	
	subtract: Compl1 port map (
		I0 => B0, I1 => B1, I2=>B2, I3 =>B3,
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
	
	displayValorS: DisplayHEX7Seg port map (
		X0 => Out0, X1 => Out1, X2 => Out2, X3 => Out3,
		sa => DSa, sb => DSb, sc => DSc, sd => DSd, se => DSe, sf => DSf, sg => DSg
	);
	
	displayValorC: DisplayHEX7Seg port map (
		X0 => aux_x0, X1 => '0', X2 => '0', X3 => '0',
		sa => DCa, sb => DCb, sc => DCc, sd => DCd, se => DCe, sf => DCf, sg => DCg
	);
	
	end TOP_LEVEL;