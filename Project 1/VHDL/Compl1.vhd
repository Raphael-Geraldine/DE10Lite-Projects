Library IEEE;
use ieee.std_logic_1164.all;

entity Compl1 is
	port(
		I0, I1, I2, I3: in std_logic;
		S0, S1, S2, S3: out std_logic;
		entry: in std_logic
		);
end Compl1;

architecture SUBTRAC of Compl1 is
	begin
		S0 <= I0 xor entry;
		S1 <= I1 xor entry;
		S2 <= I2 xor entry;
		S3 <= I3 xor entry;
	end SUBTRAC;
	