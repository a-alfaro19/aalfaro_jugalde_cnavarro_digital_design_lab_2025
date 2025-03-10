library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sumador_top is
    port (
        SW  : in  STD_LOGIC_VECTOR(8 downto 0); 
        SEG : out STD_LOGIC_VECTOR(6 downto 0);
		  SEG_COUT : out  STD_LOGIC_VECTOR(6 downto 0)
    );
end entity sumador_top;

architecture sint of sumador_top is

    component sumador_4_bits
	 
        port (
            A, B  : in  STD_LOGIC_VECTOR(3 downto 0);
            Cin   : in  STD_LOGIC;
            S     : out STD_LOGIC_VECTOR(3 downto 0);
            Cout  : out STD_LOGIC
        );
		  
    end component;
	 
	 component sumador_display
	 
		port (
			num : in STD_LOGIC_VECTOR(3 downto 0);
			Yout : out STD_LOGIC_VECTOR(6 downto 0)
		);
		
	 end component;
	 
	 signal S : STD_LOGIC_VECTOR(3 downto 0);
	 signal Cout : STD_LOGIC;
	 
begin
  
  
     SUMA: sumador_4_bits port map(
        A    => SW(3 downto 0),
        B    => SW(7 downto 4),
        Cin  => SW(8),
        S    => S,
        Cout => Cout
    );
	 
	 DIS0 : sumador_display port map(num => S, Yout => SEG);
	 DIS1 : sumador_display port map(num => "000" & Cout, Yout => SEG_COUT);
	 
end architecture sint;