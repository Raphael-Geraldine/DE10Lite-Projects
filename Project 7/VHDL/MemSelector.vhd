Library IEEE;
use ieee.std_logic_1164.all;

entity MemSelector is
    port(
        rst: in std_logic;
        Clock, ClockD, Cin: in std_logic;
        MemUse : out std_logic;
        AddrSpy: out std_logic_vector(7 downto 0); 
        NumOut: out std_logic_vector(7 downto 0)
    ); 
end MemSelector;

architecture CTRL of MemSelector is
    signal MemInUse : std_logic := '0';
    signal CoutLig,nMemInUse , clk, sec : std_logic;
    signal addr, outp1, outp2 : std_logic_vector (7 downto 0);

    component GerenciadorContagem  
    port(
        rst: in std_logic;
        Clock, Cin: in std_logic;
        Cout: out std_logic;
        Spy: out std_logic_vector (7 downto 0)
    );
    end component;

    COMPONENT MenCtrl1
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
    END COMPONENT;

    COMPONENT MenCtrl2
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
    END COMPONENT;

    component MyDLatch
    port(
        D: in std_logic;
        Preset, Clear: in std_logic;
        clk: in std_logic;
        Q, Qo: out std_logic
        );
    end component;

    component Mux2_Vector
    port(
        I0, I1: in std_logic_vector (7 downto 0);
        S: in std_logic;
        O: out std_logic_vector (7 downto 0)
    );
    end component;
	 
	 component AddrBuffer
    port(
        AddrIn: in std_logic_vector(7 downto 0);
		MemIn, Clk: in std_logic;
        AddrOut: out std_logic_vector(7 downto 0);
		MemOut: out std_logic
    ); 
	 end component;

    begin 

        clk <= Clock;
		  
		sec <= (CoutLig and ClockD);
		  
		nMemInUse <= not(MemInUse);

        selector: MyDLatch port map (
            D => nMemInUse,
            Preset => '1', Clear => '1',
            clk => sec,
            Q => MemInUse, Qo => open
        );
        
        contagem: GerenciadorContagem port map (
            rst => rst,
            Clock => clk, Cin => Cin,
            Cout => CoutLig,
            Spy => addr 
        );

        RealAddr: AddrBuffer port map (
			AddrIn => addr, MemIn => MemInUse,
			Clk => clk,
			AddrOut => AddrSpy, MemOut => MemUse
		);

        men0: MenCtrl1 port map(
		    address	=> addr,
		    clock => clk,
		    q => outp1
        );

        men1: MenCtrl2 port map(
		    address	=> addr,
		    clock => clk,
		    q => outp2
        );

        mux: Mux2_Vector port map(
            I0 => outp1, I1 => outp2,
            S => MemInUse,
            O => NumOut
        );
        
end CTRL;