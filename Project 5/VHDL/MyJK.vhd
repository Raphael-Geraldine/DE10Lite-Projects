library IEEE;
use ieee.std_logic_1164.all;

entity MyJK is
    port(
    J, K: in std_logic;

    clk: in std_logic;

    Q, Qo: out std_logic
    );
end MyJK;

architecture FF of MyJK is
    signal saida : std_logic := '0';

    begin 
        process(clk, J, K)
        begin   
            if rising_edge(clk) then
                if (J = '1') then
                    if (K = '0') then
                        saida <= '1';
                    else 
                        saida <= not(saida);
                    end if;

                elsif (J = '0') then
                    if (K = '1') then
                        saida <= '0';
                    else
                        saida <= saida;
                    end if;

                end if;
            end if;
        end process;

        Q  <= saida;
        Qo <= (not saida);
end FF;