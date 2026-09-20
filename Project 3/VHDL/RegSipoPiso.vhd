library IEEE;
use ieee.std_logic_1164.all;

entity RegSipoPiso is 
    port(
        InSwitch: in std_logic_vector(7 downto 0);
        SpyLeds: out std_logic_vector(7 downto 0);

        Key0, Key1: in std_logic;

        OutActive: in std_logic;

        Dis0, Dis1, Dis4, Dis5: out std_logic_vector(6 downto 0) 
    );
end RegSipoPiso;

architecture TopLevel of RegSipoPiso is

    signal OutPisoInSipo : std_logic;
    signal OutSipo, SpyInpt : std_logic_vector(7 downto 0);

    component PISO
        port(
            inpt: in std_logic_vector(7 downto 0);
            outp: out std_logic;
            spy: out std_logic_vector(7 downto 0);
            clk, prs, clr: in std_logic;
            ctrl: in std_logic
        );
    end component;

    component SIPO
        port(
            inpt: in std_logic;
            outp: out std_logic_vector(7 downto 0);
            spy: out std_logic_vector(7 downto 0);
            clk, prs, clr: in std_logic;
            OE: in std_logic
        );
    end component;

    component DisplayHEX7Seg
        port(
            X0, X1, X2, X3: in std_logic;
		    sa, sb, sc, sd, se, sf, sg: out std_logic
        );
    end component;

    begin

    RegPiso0: PISO port map(
        inpt => InSwitch,
        outp => OutPisoInSipo,
        spy => SpyInpt,
        clk => Key1,
        prs => '1', clr => '1',
        ctrl => Key0
    );

    RegSipo0: SIPO port map(
        inpt => OutPisoInSipo, outp => OutSipo,
        spy => SpyLeds,
        clk => Key1,
        prs => '1', clr => '1',
        OE => OutActive
    );


    Display0: DisplayHEX7Seg port map(
        X0 => SpyInpt(0), X1 => SpyInpt(1), X2 => SpyInpt(2), X3 => SpyInpt(3),
        sa => Dis0(0), sb => Dis0(1), sc => Dis0(2), sd => Dis0(3), se => Dis0(4), sf => Dis0(5), sg => Dis0(6)
    );

    Display1: DisplayHEX7Seg port map(
        X0 => SpyInpt(4), X1 => SpyInpt(5), X2 => SpyInpt(6), X3 => SpyInpt(7),
        sa => Dis1(0), sb => Dis1(1), sc => Dis1(2), sd => Dis1(3), se => Dis1(4), sf => Dis1(5), sg => Dis1(6)
    );

    Display4: DisplayHEX7Seg port map(
        X0 => OutSipo(0), X1 => OutSipo(1), X2 => OutSipo(2), X3 => OutSipo(3),
        sa => Dis4(0), sb => Dis4(1), sc => Dis4(2), sd => Dis4(3), se => Dis4(4), sf => Dis4(5), sg => Dis4(6)
    );

    Display5: DisplayHEX7Seg port map(
        X0 => OutSipo(4), X1 => OutSipo(5), X2 => OutSipo(6), X3 => OutSipo(7),
        sa => Dis5(0), sb => Dis5(1), sc => Dis5(2), sd => Dis5(3), se => Dis5(4), sf => Dis5(5), sg => Dis5(6)
    );

    end TopLevel;