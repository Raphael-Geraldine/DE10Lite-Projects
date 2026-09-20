library IEEE;
use ieee.std_logic_1164.all;

entity MyDLatch is
    port(
    D: in std_logic;

    Preset, Clear: in std_logic;

    Clock: in std_logic;

    Q, Qo: out std_logic
    );
end MyDLatch;

architecture FF of MyDLatch is
    begin 
        process(Clock, Preset, Clear)
        begin
            if (Preset = '0' and Clear = '1') then
                Q  <= '1';
                Qo <= '0';
            elsif (Preset = '1' and Clear = '0') then
                Q  <= '0';
                Qo <= '1';
            elsif (Preset = '0' and Clear = '0') then
                Q  <= 'X';
                Qo <= 'X';
                
            elsif rising_edge(Clock) then
                if (Preset = '1' and Clear = '1') then
                    if (D = '1') then
                        Q  <= '1';
                        Qo <= '0';
                    else
                        Q  <= '0';
                        Qo <= '1';
                    end if;
                end if;
            end if;
        end process;
end FF;