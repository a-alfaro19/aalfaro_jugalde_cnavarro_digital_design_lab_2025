library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sumador_top is
    port (
        SW  : in  STD_LOGIC_VECTOR(8 downto 0); 
        LEDR : out STD_LOGIC_VECTOR(4 downto 0) 
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
begin
  
  
     SUMA: sumador_4_bits port map(
        A    => SW(3 downto 0),
        B    => SW(7 downto 4),
        Cin  => SW(8),
        S    => LEDR(3 downto 0),
        Cout => LEDR(4)
    );
	 
end architecture sint;