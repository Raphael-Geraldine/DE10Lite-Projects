library IEEE;
use ieee.std_logic_1164.all;

entity SIPO is
    port(
        inpt: in std_logic;
        outp: out std_logic_vector(7 downto 0);

        spy: out std_logic_vector(7 downto 0);

        clk, prs, clr: in std_logic;

        OE: in std_logic
    );
end SIPO;

architecture RegSIPO of SIPO is
    
    signal lig : std_logic_vector(7 downto 0);

    component MyDLatch 
        port(
            D: in std_logic;
            Preset, Clear: in std_logic;
            Clock: in std_logic;
            Q, Qo: out std_logic
        );
    end component;

    begin

        FF0: MyDLatch port map(
            D => inpt, 
            Preset => prs, Clear => clr, Clock => clk,
            Q => lig(0),
            Qo => open
        );

        FF1: MyDLatch port map(
            D => lig(0), 
            Preset => prs, Clear => clr, Clock => clk,
            Q => lig(1),
            Qo => open
        );

        FF2: MyDLatch port map(
            D => lig(1), 
            Preset => prs, Clear => clr, Clock => clk,
            Q => lig(2),
            Qo => open
        );

        FF3: MyDLatch port map(
            D => lig(2), 
            Preset => prs, Clear => clr, Clock => clk,
            Q => lig(3),
            Qo => open
        );

        FF4: MyDLatch port map(
            D => lig(3), 
            Preset => prs, Clear => clr, Clock => clk,
            Q => lig(4),
            Qo => open
        );

        FF5: MyDLatch port map(
            D => lig(4), 
            Preset => prs, Clear => clr, Clock => clk,
            Q => lig(5),
            Qo => open
        );

        FF6: MyDLatch port map(
            D => lig(5), 
            Preset => prs, Clear => clr, Clock => clk,
            Q => lig(6),
            Qo => open
        );

        FF7: MyDLatch port map(
            D => lig(6), 
            Preset => prs, Clear => clr, Clock => clk,
            Q => lig(7),
            Qo => open
        );

        spy(0) <= lig(0);
        outp(0) <= lig(0) AND OE;
        
        spy(1) <= lig(1);
        outp(1) <= lig(1) AND OE;
        
        spy(2) <= lig(2);
        outp(2) <= lig(2) AND OE;
        
        spy(3) <= lig(3);
        outp(3) <= lig(3) AND OE;
        
        spy(4) <= lig(4);
        outp(4) <= lig(4) AND OE;
        
        spy(5) <= lig(5);
        outp(5) <= lig(5) AND OE;

        spy(6) <= lig(6);
        outp(6) <= lig(6) AND OE;

        spy(7) <= lig(7);
        outp(7) <= lig(7) AND OE;

    end RegSIPO;