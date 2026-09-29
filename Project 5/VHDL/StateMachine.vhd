library IEEE;
use ieee.std_logic_1164.all;

entity StateMachine is
    port(
        InNum: in std_logic_vector (3 downto 0); 
        OutNum: out std_logic_vector (3 downto 0);
        clk: in std_logic
    );
end StateMachine;

architecture Mach of StateMachine is

    signal J, K : std_logic_vector (3 downto 0);

    component MyJK
        port(
            J, K: in std_logic;

            clk: in std_logic;

            Q, Qo: out std_logic
        );
    end component;

    component LogicGates
        port(
            InNum: in std_logic_vector (3 downto 0); 
            OutJ, OutK : out std_logic_vector (3 downto 0)
        );
    end component;

    begin

        BinaryMagic: LogicGates port map(
            InNum => InNum, OutJ => J, OutK => K
        );

        FF0: MyJK port map(
            J => J(0), K => K(0), clk => clk,
            Q => OutNum(0), Qo => open
        );
    
        FF1: MyJK port map(
            J => J(1), K => K(1), clk => clk,
            Q => OutNum(1), Qo => open
        );

        FF2: MyJK port map(
            J => J(2), K => K(2), clk => clk,
            Q => OutNum(2), Qo => open
        );

        FF3: MyJK port map(
            J => J(3), K => K(3), clk => clk,
            Q => OutNum(3), Qo => open
        );

    end Mach;