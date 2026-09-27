Library IEEE;
use ieee.std_logic_1164.all;

entity PIPO_4bits is 
    port(
        Clock, Preset, Clear: in std_logic;
        In0, In1, In2, In3: in std_logic;
        Out0, Out1, Out2, Out3: out std_logic
    );
end PIPO_4bits;

architecture PIPO of PIPO_4bits is
    component MyDLatch
        port(
        D: in std_logic;

        Preset, Clear: in std_logic;

        clk: in std_logic;

        Q, Qo: out std_logic
        );
    end component;

    begin
        FF0: MyDLatch port map(
            D => In0, Preset => Preset, Clear => Clear,
            clk => Clock, Q => Out0, Qo => open
        );

        FF1: MyDLatch port map(
            D => In1, Preset => Preset, Clear => Clear,
            clk => Clock, Q => Out1, Qo => open
        );

        FF2: MyDLatch port map(
            D => In2, Preset => Preset, Clear => Clear,
            clk => Clock, Q => Out2, Qo => open
        );

        FF3: MyDLatch port map(
            D => In3, Preset => Preset, Clear => Clear,
            clk => Clock, Q => Out3, Qo => open
        );

    end PIPO;