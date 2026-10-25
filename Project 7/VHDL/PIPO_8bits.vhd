Library IEEE;
use ieee.std_logic_1164.all;

entity PIPO_8bits is 
    port(
        Clock, Preset, Clear: in std_logic;
        NumIn: in std_logic_vector (7 downto 0);
        NumOut: out std_logic_vector (7 downto 0)
    );
end PIPO_8bits;

architecture PIPO of PIPO_8bits is
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
            D => NumIn(0), Preset => Preset, Clear => Clear,
            clk => Clock, Q => NumOut(0), Qo => open
        );

        FF1: MyDLatch port map(
            D => NumIn(1), Preset => Preset, Clear => Clear,
            clk => Clock, Q => NumOut(1), Qo => open
        );

        FF2: MyDLatch port map(
            D => NumIn(2), Preset => Preset, Clear => Clear,
            clk => Clock, Q => NumOut(2), Qo => open
        );

        FF3: MyDLatch port map(
            D => NumIn(3), Preset => Preset, Clear => Clear,
            clk => Clock, Q => NumOut(3), Qo => open
        );



        FF4: MyDLatch port map(
            D => NumIn(4), Preset => Preset, Clear => Clear,
            clk => Clock, Q => NumOut(4), Qo => open
        );

        FF5: MyDLatch port map(
            D => NumIn(5), Preset => Preset, Clear => Clear,
            clk => Clock, Q => NumOut(5), Qo => open
        );

        FF6: MyDLatch port map(
            D => NumIn(6), Preset => Preset, Clear => Clear,
            clk => Clock, Q => NumOut(6), Qo => open
        );

        FF7: MyDLatch port map(
            D => NumIn(7), Preset => Preset, Clear => Clear,
            clk => Clock, Q => NumOut(7), Qo => open
        );

    end PIPO;