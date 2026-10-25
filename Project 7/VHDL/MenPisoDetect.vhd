library IEEE;
use ieee.std_logic_1164.all;

entity MenPisoDetect is
    port(
        display0, display1, display2, display3 : out std_logic_vector (6 downto 0);
        PB : in std_logic;
        Led : out std_logic;
        clkRef : in std_logic
    );
end MenPisoDetect;

architecture TOP_LEVEL of MenPisoDetect is

    signal numToDisplay0, numToDisplay1: std_logic_vector (7 downto 0);
    signal timer, timerSlow, timerSlowD, timerFast : std_logic;
    signal toDetect, seque, nstate, nseque, ntimerSlow, actPiso, prs : std_logic;
    signal state, add : std_logic := '1';

	signal a,b,c : std_logic;
	 
    component TimingReferenceFast
	port ( 
		clk: in std_logic; 
		clk_slow: in std_logic; 
		clk_fast: out std_logic
	);
    end component;

    component TimingReferenceSlow
	port ( 
		clk: in std_logic;
	   clk_slowD: out std_logic;	
		clk_slow: out std_logic
	);
    end component;

    component DisplayHEX7Seg
	port(
		X0, X1, X2, X3: in std_logic;
		sa, sb, sc, sd, se, sf, sg: out std_logic
		);
    end component;

    component PISO 
    port(
        inpt: in std_logic_vector(7 downto 0);
        outp: out std_logic;
        spy: out std_logic_vector(7 downto 0);
        clk, prs, clr: in std_logic;
        ctrl: in std_logic
    );
    end component;
    
    COMPONENT DetectorSequencia
    PORT(
        clk      : IN   STD_LOGIC;
        entrada    : IN   STD_LOGIC;
        reset    : IN   STD_LOGIC;
		  saida : OUT STD_LOGIC_VECTOR(2 downto 0);
        found : OUT std_logic
    );
    END COMPONENT;

    component MemSelector
    port(
        rst: in std_logic;
        Clock, ClockD, Cin: in std_logic;
        MemUse : out std_logic;
        AddrSpy: out std_logic_vector(7 downto 0); 
        NumOut: out std_logic_vector(7 downto 0)
    ); 
    end component;

    component MyDLatch is
    port(
        D: in std_logic;
        Preset, Clear: in std_logic;
        clk: in std_logic;
        Q, Qo: out std_logic
    );
    end component;
    
    
    begin

    timer <= (clkRef and add);

    Memory: MemSelector port map(
        rst => '1',
        Clock => timerSlow, ClockD => timerSlowD, Cin => '1',
        MemUse => Led, AddrSpy => numToDisplay0, NumOut => numToDisplay1
    );

    Slow: TimingReferenceSlow port map(
        clk => timer, clk_slowD => timerSlowD, clk_slow => timerSlow
    );

    Fast: TimingReferenceFast port map(
        clk => timer, clk_slow => timerSlow, clk_fast => timerFast
    );

	actPiso <= not(timerSlow and not(timerSlowD));
    ParalelSerial: PISO port map(
        inpt => numToDisplay1, outp => toDetect, 
        spy => open,
        clk => timerFast, prs => '1', clr => '1',
        ctrl => actPiso
    );

    ntimerSlow <= not(timerSlow);
	Sequence: DetectorSequencia port map(
        clk => timerFast, entrada => toDetect, 
        reset => timerSlow, 
		saida => open,
		found => seque
    );

    nstate <= not(state);
	nseque <= not(seque);
	prs <= not(seque and (not PB));
	 
	Pause: MyDLatch port map(
        D => nstate,
        Preset => prs, Clear => '1',  
        clk => seque,
        Q => state, Qo => open 
    );

    add <= state;



    display00: DisplayHEX7Seg port map (
        X0 => numToDisplay0(0), X1 => numToDisplay0(1), X2 => numToDisplay0(2), X3 => numToDisplay0(3),
		sa => display0(0), sb => display0(1), sc => display0(2), sd => display0(3), se => display0(4), sf => display0(5), sg => display0(6)
    );
    display01: DisplayHEX7Seg port map (
        X0 => numToDisplay0(4), X1 => numToDisplay0(5), X2 => numToDisplay0(6), X3 => numToDisplay0(7),
		sa => display1(0), sb => display1(1), sc => display1(2), sd => display1(3), se => display1(4), sf => display1(5), sg => display1(6)
    );

    display10: DisplayHEX7Seg port map (
        X0 => numToDisplay1(0), X1 => numToDisplay1(1), X2 => numToDisplay1(2), X3 => numToDisplay1(3),
		sa => display2(0), sb => display2(1), sc => display2(2), sd => display2(3), se => display2(4), sf => display2(5), sg => display2(6)
    );
    display11: DisplayHEX7Seg port map (
        X0 => numToDisplay1(4), X1 => numToDisplay1(5), X2 => numToDisplay1(6), X3 => numToDisplay1(7),
		sa => display3(0), sb => display3(1), sc => display3(2), sd => display3(3), se => display3(4), sf => display3(5), sg => display3(6)
    );

end TOP_LEVEL;