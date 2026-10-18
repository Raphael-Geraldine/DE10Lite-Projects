Library ieee; 
use ieee.std_logic_1164.all; 

ENTITY DetectorSequencia IS
   PORT(
      clk      : IN   STD_LOGIC;
      entrada    : IN   STD_LOGIC;
      reset    : IN   STD_LOGIC;
      a, b, c, d, e, f, g: out std_logic);
END DetectorSequencia;

ARCHITECTURE TOP_LEVEL OF DetectorSequencia IS
   TYPE STATE_TYPE IS (s0, s1, s2, s3, s4, s5, s6, s7);

   SIGNAL saida : STD_LOGIC_VECTOR(2 downto 0);

   SIGNAL estado   : STATE_TYPE;

   COMPONENT DisplayHEX7Seg
	PORT(
		X0, X1, X2, X3: in std_logic;
		sa, sb, sc, sd, se, sf, sg: out std_logic
		);
   END COMPONENT;
   
BEGIN
   PROCESS (clk, reset)
   BEGIN
      IF reset = '0' THEN
         estado <= s0;
      ELSIF (falling_edge(clk)) THEN 
         CASE estado IS
            WHEN s0=>
               IF entrada = '0' THEN
                  estado <= s0;
               ELSE
                  estado <= s1;
               END IF;
       	   WHEN s1=>
               IF entrada = '0' THEN
                  estado <= s2;
               ELSE
                  estado <= s1;
               END IF;
	         WHEN s2=>
               IF entrada = '0' THEN
                  estado <= s3;
               ELSE
                  estado <= s1;
               END IF;
	         WHEN s3=>
               IF entrada = '0' THEN
                  estado <= s4;
               ELSE
                  estado <= s1;
               END IF;
	         WHEN s4=>
               IF entrada = '0' THEN
                  estado <= s0;
               ELSE
                  estado <= s5;
               END IF;
	         WHEN s5=>
               IF entrada = '0' THEN
                  estado <= s6;
               ELSE
                  estado <= s1;
               END IF;
	         WHEN s6=>
               IF entrada = '0' THEN
                  estado <= s7;
               ELSE
                  estado <= s1;
               END IF;
 	         WHEN s7=>
               IF entrada = '0' THEN
                  estado <= s0;
               ELSE
                  estado <= s1;
               END IF;
         END CASE;
      END IF;
   END PROCESS;
   
   PROCESS (estado)
   BEGIN
      CASE estado IS
         WHEN s0 =>
            saida <= "000";
         WHEN s1 =>
            saida <= "001";
         WHEN s2 =>
            saida <= "010";
	      WHEN s3 =>
            saida <= "011";	
	      WHEN s4 =>
            saida <= "100";
         WHEN s5 =>
            saida <= "101";
         WHEN s6 =>
            saida <= "110";
	      WHEN s7 =>
            saida <= "111";
      END CASE;
   END PROCESS;
   
   
   display: DisplayHEX7Seg port map (
      X0 => saida(0), X1 => saida(1), X2 => saida(2), X3 => '0',
		sa => a, sb => b, sc => c, sd => d, se => e, sf => f, sg => g
   ); 

END TOP_LEVEL;
