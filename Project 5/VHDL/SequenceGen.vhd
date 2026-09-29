library IEEE;
use ieee.std_logic_1164.all;

entity SequenceGen is
    port (
        Clock: in std_logic;
        Display: out std_logic_vector(6 downto 0)
    );
end SequenceGen;


architecture top_level of SequenceGen is
    signal actualNum : std_logic_vector (3 downto 0) := (others => '0');
    signal ClockInt : std_logic; 

    component DisplayHEX7Seg
        port(
            X0, X1, X2, X3: in std_logic;
            sa, sb, sc, sd, se, sf, sg: out std_logic
            );
    end component;

    component Timing_Reference
        port ( 
            clk: in std_logic; 
            clk_0_2Hz: out std_logic
        );
    end component;

    component StateMachine
        port(
            InNum: in std_logic_vector (3 downto 0); 
            OutNum: out std_logic_vector (3 downto 0);
            clk: in std_logic
        );
    end component;

    begin
        Spy: DisplayHEX7Seg port map(
            X0 => actualNum(0), X1 => actualNum(1), X2 => actualNum(2), X3 => actualNum(3),
            sa => Display(0), sb => Display(1), sc => Display(2), sd => Display(3), se => Display(4), sf => Display(5), sg => Display(6)
        );

        Timer: Timing_Reference port map(
            clk => Clock, clk_0_2Hz => ClockInt
        );

        Main: StateMachine port map(
            InNum => actualNum, OutNum => actualNum,
            clk => ClockInt
        );

    end top_level;