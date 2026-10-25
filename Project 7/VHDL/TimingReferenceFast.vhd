library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity TimingReferenceFast is
    port (  
        clk: in std_logic;      
        clk_slow: in std_logic; 
        clk_fast: out std_logic
    );
end TimingReferenceFast;
  
architecture freq_div of TimingReferenceFast is
  
signal count, changes: integer := 1;
signal tmp : std_logic := '0';
signal slow : std_logic_vector(1 downto 0) := "00"; 
signal start_fast : std_logic := '0';

begin
  
process(clk)
begin
    if rising_edge(clk) then
        slow <= slow(0) & clk_slow;
        
        if (slow = "01") then
            start_fast <= '1'; 
            tmp <= '1';        
            count <= 1;
			changes <= 1;				
        elsif (start_fast = '0') then
            tmp <= '0';
            count <= 1;
        else
            count <= count + 1;
            
            if ( (count >= 625000) and changes <= 15 ) then  
                tmp <= NOT tmp;
					 changes <= changes + 1;
                count <= 1;
				elsif (changes > 15) then 
					tmp <= '0';
            end if;
        end if;
        
    end if;
end process;

clk_fast <= tmp;
 
end freq_div;