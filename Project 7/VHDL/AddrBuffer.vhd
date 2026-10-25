Library IEEE;
use ieee.std_logic_1164.all;

entity AddrBuffer is
    port(
        AddrIn: in std_logic_vector(7 downto 0);
		MemIn, Clk: in std_logic;
        AddrOut: out std_logic_vector(7 downto 0);
		MemOut: out std_logic
    ); 
end AddrBuffer;

architecture BUFF of AddrBuffer is

	signal lig : std_logic_vector(7 downto 0);
	signal ligMem : std_logic;
	
	component PIPO_8bits 
    port(
        Clock, Preset, Clear: in std_logic;
        NumIn: in std_logic_vector (7 downto 0);
        NumOut: out std_logic_vector (7 downto 0)
    );
	end component;
	
	component MyDLatch
    port(
        D: in std_logic;
        Preset, Clear: in std_logic;
        clk: in std_logic;
        Q, Qo: out std_logic
        );
    end component;
	
	begin
	
	PIPO0: PIPO_8bits port map(
	  Clock => Clk, Preset => '1', Clear => '1',
      NumIn => AddrIn,
      NumOut => lig
	);

	PIPO1: PIPO_8bits port map(
      Clock => Clk, Preset => '1', Clear => '1',
      NumIn => lig,
      NumOut => AddrOut
	);
	
	FF0: MyDLatch port map(
	  D => MemIn,
      Preset => '1', Clear => '1',
      clk => Clk,
      Q => ligMem, Qo => open
	);
	
	FF1: MyDLatch port map(
	  D => ligMem,
      Preset => '1', Clear => '1',
      clk => Clk,
      Q => MemOut, Qo => open
	);
   
end BUFF;