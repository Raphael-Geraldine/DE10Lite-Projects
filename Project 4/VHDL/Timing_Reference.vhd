library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity Timing_Reference is
	port ( 
		switch: in std_logic;
		clk: in std_logic; 
		clk_1kHz: out std_logic
	);
end Timing_Reference;
  
architecture freq_div of Timing_Reference is
  
signal count: integer:=1;
signal tmp : std_logic := '0';
  
begin
  
process(clk, switch)
	begin
	if(clk'event and clk='1') then
		count <=count+1;
		if ( (switch ='0' and count >= 50000000/2000) or (switch='1' and count >= 50000000/160000)) then
			tmp <= NOT tmp;
			count <= 1;
		end if;
	end if;
	clk_1kHz <= tmp;
end process;
 
end freq_div;