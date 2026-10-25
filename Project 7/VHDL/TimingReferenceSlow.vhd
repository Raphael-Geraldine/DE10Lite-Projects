library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity TimingReferenceSlow is
	port ( 
		clk: in std_logic; 
		clk_slowD: out std_logic;
		clk_slow: out std_logic
	);
end TimingReferenceSlow;
  
architecture freq_div of TimingReferenceSlow is
  
signal count, countD: integer:=1;
signal change: integer:=0;
signal tmp, tmpD : std_logic := '0';
  
begin
  
process(clk)
	begin
	if(clk'event and clk='1') then
		count <= count+1;
		
		if ( count >=  5625000 ) then 
			tmp <= NOT tmp;
			count <= 1;
			change <= 1;
		end if;
		
		if (change >= 1) then
			countD <= countD+1;
		end if;
		
		if ( countD >=  5 ) then 
			tmpD <= NOT tmpD;
			countD <= 1;
			change <= 0;
		end if;
	end if;
	clk_slowD <= tmpD;
	clk_slow <= tmp;
end process;
 
end freq_div;