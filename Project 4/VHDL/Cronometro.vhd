Library IEEE;
use ieee.std_logic_1164.all;

entity Cronometro is 
    port(
        CLOCK_50: in std_logic;
		dot0, dot1: out std_logic;
        PB0, PB1, switch: in std_logic;
        hex0, hex1, hex2, hex3, hex4, hex5: out std_logic_vector(6 downto 0)
    );
end Cronometro;    

architecture top_level of Cronometro is
    signal clk, OutMiliInSec, OutSecInMin, ra, goBck: std_logic;
    signal enable_user, enable, rst : std_logic := '0';
    signal numToDis0, numToDis1, numToDis2, numToDis3, numToDis4, numToDis5: std_logic_vector(3 downto 0);

    component DisplayHEX7Seg
        port(
            X0, X1, X2, X3: in std_logic;
            sa, sb, sc, sd, se, sf, sg: out std_logic
            );
    end component;

    component Milisegundos
        port(
            rst: in std_logic;
            clk, enable: in std_logic;
            numToDis0, numToDis1, numToDis2: out std_logic_vector(3 downto 0);
            cout: out std_logic
        );
    end component;  
    
    component Segundos
        port(
            rst: in std_logic;
            clk, enable: in std_logic;
            numToDis3, numToDis4: out std_logic_vector(3 downto 0);
            cout: out std_logic
        );
    end component; 
    
    component Minutos 
        port(
            rst: in std_logic;
            clk, enable: in std_logic;
            numToDis5: out std_logic_vector(3 downto 0)
        );
    end component;  

    component Timing_Reference
        port ( 
            switch: in std_logic;
            clk: in std_logic; 
            clk_1kHz: out std_logic
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

    component raPause is
        port(
            numToDis0, numToDis1, numToDis2, numToDis3, numToDis4, numToDis5: in std_logic_vector(3 downto 0);
            S: out std_logic
        );
    end component;

    begin
        Temporizador: Timing_Reference port map (
            switch => switch,
            clk => CLOCK_50, clk_1kHz => clk
        );

        Milis: Milisegundos port map (
            rst => rst,
            clk => clk, enable => enable,
            numToDis0 => numToDis0,
            numToDis1 => numToDis1,
            numToDis2 => numToDis2,
            cout => OutMiliInSec
        );

        Seco: Segundos port map (
            rst => rst,
            clk => clk, enable => OutMiliInSec,
            numToDis3 => numToDis3,
            numToDis4 => numToDis4,
            cout => OutSecInMin
        );

        Minu: Minutos port map (
            rst => rst,
            clk => clk, enable => OutSecInMin,
            numToDis5 => numToDis5
        );



        raVerify: raPause port map(
            numToDis0 => numToDis0, numToDis1 => numToDis1, numToDis2 => numToDis2, 
            numToDis3 => numToDis3, numToDis4 => numToDis4, numToDis5 => numToDis5,
            S => ra
        );
        
        Pause: MyDLatch port map(
            D => ((not enable_user) or goBck), Preset => '1', Clear  => '1', 
            clk => (PB0 and (not ra)), Q => enable_user, Qo => open
        );
		  
		  GoBack: MyDLatch port map(
            D => ra, Preset => '1', Clear  => ra, 
            clk => PB0, Q => goBck, Qo => open
        );

        enable <= (enable_user and (not ra)) or goBck;

        rst <= PB1;


        
        Display0: DisplayHEX7Seg port map(
            X0 => numToDis0(0), X1 => numToDis0(1), X2 => numToDis0(2), X3 => numToDis0(3),
            sa => hex0(0), sb => hex0(1), sc => hex0(2), sd => hex0(3), se => hex0(4), sf => hex0(5), sg => hex0(6)
        );

        Display1: DisplayHEX7Seg port map(
            X0 => numToDis1(0), X1 => numToDis1(1), X2 => numToDis1(2), X3 => numToDis1(3),
            sa => hex1(0), sb => hex1(1), sc => hex1(2), sd => hex1(3), se => hex1(4), sf => hex1(5), sg => hex1(6)
        );

        Display2: DisplayHEX7Seg port map(
            X0 => numToDis2(0), X1 => numToDis2(1), X2 => numToDis2(2), X3 => numToDis2(3),
            sa => hex2(0), sb => hex2(1), sc => hex2(2), sd => hex2(3), se => hex2(4), sf => hex2(5), sg => hex2(6)
        );

        Display3: DisplayHEX7Seg port map(
            X0 => numToDis3(0), X1 => numToDis3(1), X2 => numToDis3(2), X3 => numToDis3(3),
            sa => hex3(0), sb => hex3(1), sc => hex3(2), sd => hex3(3), se => hex3(4), sf => hex3(5), sg => hex3(6)
        );

        Display4: DisplayHEX7Seg port map(
            X0 => numToDis4(0), X1 => numToDis4(1), X2 => numToDis4(2), X3 => numToDis4(3),
            sa => hex4(0), sb => hex4(1), sc => hex4(2), sd => hex4(3), se => hex4(4), sf => hex4(5), sg => hex4(6)
        );
		  
		Display5: DisplayHEX7Seg port map(
            X0 => numToDis5(0), X1 => numToDis5(1), X2 => numToDis5(2), X3 => numToDis5(3),
            sa => hex5(0), sb => hex5(1), sc => hex5(2), sd => hex5(3), se => hex5(4), sf => hex5(5), sg => hex5(6)
        );
        
        dot0 <= '0';
        dot1 <= '0';

end top_level;