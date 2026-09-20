library IEEE;
use ieee.std_logic_1164.all;

entity PISO is 
    port(
        inpt: in std_logic_vector(7 downto 0);
        outp: out std_logic;

        spy: out std_logic_vector(7 downto 0);

        clk, prs, clr: in std_logic;

        ctrl: in std_logic
    );
end PISO;

architecture RegPISO of PISO is

    signal FfOutMuxIn, MuxOutFfIn : std_logic_vector(7 downto 0);

    component Mux2
        port (
            I0, I1: in std_logic;
            S: in std_logic;
            O: out std_logic
        );
    end component;

    component MyDLatch
        port
        (
            D: in std_logic;
            Preset, Clear: in std_logic;
            Clock: in std_logic;
            Q, Qo: out std_logic
        );
    end component;

    begin 

        FF0: MyDLatch port map (
            D => MuxOutFfIn(0), 
            Preset => prs, Clear => clr, Clock => clk,
            Q => FfOutMuxIn(0),
            Qo => open
        );

        FF1: MyDLatch port map (
            D => MuxOutFfIn(1), 
            Preset => prs, Clear => clr, Clock => clk,
            Q => FfOutMuxIn(1),
            Qo => open
        );

        FF2: MyDLatch port map (
            D => MuxOutFfIn(2), 
            Preset => prs, Clear => clr, Clock => clk,
            Q => FfOutMuxIn(2),
            Qo => open
        );

        FF3: MyDLatch port map (
            D => MuxOutFfIn(3), 
            Preset => prs, Clear => clr, Clock => clk,
            Q => FfOutMuxIn(3),
            Qo => open
        );

        FF4: MyDLatch port map (
            D => MuxOutFfIn(4), 
            Preset => prs, Clear => clr, Clock => clk,
            Q => FfOutMuxIn(4),
            Qo => open
        );

        FF5: MyDLatch port map (
            D => MuxOutFfIn(5), 
            Preset => prs, Clear => clr, Clock => clk,
            Q => FfOutMuxIn(5),
            Qo => open
        );

        FF6: MyDLatch port map (
            D => MuxOutFfIn(6), 
            Preset => prs, Clear => clr, Clock => clk,
            Q => FfOutMuxIn(6),
            Qo => open
        );
 
        FF7: MyDLatch port map (
            D => MuxOutFfIn(7), 
            Preset => prs, Clear => clr, Clock => clk,
            Q => outp,
            Qo => open
        );

        Muxes0: Mux2 port map(
            I0 => inpt(0), 
            I1 => '0',
            S => ctrl,
            O => MuxOutFfIn(0)
        );
        
        Muxes1: Mux2 port map(
            I0 => inpt(1), 
            I1 => FfOutMuxIn(0),
            S => ctrl,
            O => MuxOutFfIn(1)
        );

        Muxes2: Mux2 port map(
            I0 => inpt(2), 
            I1 => FfOutMuxIn(1),
            S => ctrl,
            O => MuxOutFfIn(2)
        );

        Muxes3: Mux2 port map(
            I0 => inpt(3), 
            I1 => FfOutMuxIn(2),
            S => ctrl,
            O => MuxOutFfIn(3)
        );

        Muxes4: Mux2 port map(
            I0 => inpt(4), 
            I1 => FfOutMuxIn(3),
            S => ctrl,
            O => MuxOutFfIn(4)
        );

        Muxes5: Mux2 port map(
            I0 => inpt(5), 
            I1 => FfOutMuxIn(4),
            S => ctrl,
            O => MuxOutFfIn(5)
        );

        Muxes6: Mux2 port map(
            I0 => inpt(6), 
            I1 => FfOutMuxIn(5),
            S => ctrl,
            O => MuxOutFfIn(6)
        );

        Muxes7: Mux2 port map(
            I0 => inpt(7), 
            I1 => FfOutMuxIn(6),
            S => ctrl,
            O => MuxOutFfIn(7)
        );

        spy <= MuxOutFfIn;

    end RegPISO;