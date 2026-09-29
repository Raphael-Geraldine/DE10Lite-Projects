library IEEE;
use ieee.std_logic_1164.all;

entity LogicGates is
    port(
        InNum: in std_logic_vector (3 downto 0); 
        OutJ, OutK : out std_logic_vector (3 downto 0)
    );
end LogicGates;

architecture Gates of LogicGates is
    begin

        OutJ(0) <= ((not InNum(3)) and (not InNum(2))) or (InNum(3) and InNum(2) and InNum(1));
        OutJ(1) <= InNum(2) or ((not InNum(3)) and InNum(0));
        OutJ(2) <= (InNum(3) and InNum(0)) or (InNum(1) and (not InNum(0)));
        OutJ(3) <= (InNum(2) and InNum(1)) or (InNum(0) and InNum(2)) or (InNum(1) and InNum(0));

        OutK(0) <= (InNum(2) and InNum(1)) or (InNum(3) and (not InNum(2)) and (not InNum(1)));
        OutK(1) <= ((not InNum(3)) and InNum(0)) or (InNum(3) and (not InNum(0))) or (InNum(3) and (not InNum(2)));
        OutK(2) <= ((not InNum(3)) and InNum(0)) or ((not InNum(3)) and InNum(1)) or (InNum(1) and InNum(0));
        OutK(3) <= ((not InNum(2)) and (not InNum(1))) or (InNum(2) and InNum(1));

    end Gates;