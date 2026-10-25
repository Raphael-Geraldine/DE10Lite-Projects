Library ieee; 
use ieee.std_logic_1164.all; 

ENTITY DetectorSequencia IS
   PORT(
      clk      : IN   STD_LOGIC;
      entrada    : IN   STD_LOGIC;
      reset    : IN   STD_LOGIC;
		saida : OUT STD_LOGIC_VECTOR(2 downto 0);
      found : OUT std_logic
   );
END DetectorSequencia;

ARCHITECTURE TOP_LEVEL OF DetectorSequencia IS
   TYPE STATE_TYPE IS (s0, s1, s2, s3, s4, s5, s6, s7);
   SIGNAL estado   : STATE_TYPE;

   SIGNAL momentum, rst, clr : STD_LOGIC := '1';
	SIGNAL nrst : STD_LOGIC;
	
	component MyDLatch
   port(
		D: in std_logic;
		Preset, Clear: in std_logic;
		clk: in std_logic;
		Q, Qo: out std_logic
    );
	end component;
   
BEGIN

	nrst <= not(rst);
	FF: MyDLatch port map(
		D => nrst,
		Preset => '1', Clear => clr,
		clk => reset,
		Q => rst, Qo => open
	);

   PROCESS (clk)
   BEGIN
      IF (rst = '1') THEN
         estado <= s0;
         momentum <= '0';
			clr <= '0';
      ELSIF (falling_edge(clk)) THEN 
			clr <= '1';
         CASE estado IS
            WHEN s0=>
               IF entrada = '0' THEN
						momentum <= '0';
                  estado <= s0;
               ELSE
					   momentum <= '0';
                  estado <= s1;
               END IF;
       	   WHEN s1=>
               IF entrada = '0' THEN
						momentum <= '0';
                  estado <= s2;
               ELSE
						momentum <= '0';
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
						momentum <= '1';
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
   
   found <= momentum;

END TOP_LEVEL;