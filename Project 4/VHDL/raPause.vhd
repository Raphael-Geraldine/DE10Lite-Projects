Library IEEE;
use ieee.std_logic_1164.all;

entity raPause is
    port(
        numToDis0, numToDis1, numToDis2, numToDis3, numToDis4, numToDis5: in std_logic_vector(3 downto 0);
        S: out std_logic
    );
end raPause;

architecture verify of raPause is
    begin

        -- quando der: 820089 (1000 - 0010 - 0000 - 0000 - 1000 - 1001)
        -- pois últimos 6 dígitos do meu ra: 780089

        S <= numToDis5(3) and (not numToDis5(2)) and (not numToDis5(1)) and (not numToDis5(0)) and 
        (not numToDis4(3)) and (not numToDis4(2)) and numToDis4(1) and (not numToDis4(0)) and 
        (not numToDis3(3)) and (not numToDis3(2)) and (not numToDis3(1)) and (not numToDis3(0)) and 
        (not numToDis2(3)) and (not numToDis2(2)) and (not numToDis2(1)) and (not numToDis2(0)) and 
        numToDis1(3) and (not numToDis1(2)) and (not numToDis1(1)) and (not numToDis1(0)) and 
        numToDis0(3) and (not numToDis0(2)) and (not numToDis0(1)) and numToDis0(0);

    end verify;