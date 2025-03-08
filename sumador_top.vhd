library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sumador_top is
    port (
        SW  : in  STD_LOGIC_VECTOR(2 downto 0); 
        LEDR : out STD_LOGIC_VECTOR(1 downto 0) 
    );
end entity sumador_top;

architecture sint of sumador_top is
    component sumador
        port (
            a, b, cin : in STD_LOGIC;
            s, cout   : out STD_LOGIC
        );
    end component;
begin
  
  
    FA_inst: sumador port map(
        a    => SW(0),
        b    => SW(1),
        cin  => SW(2),
        s    => LEDR(0),
        cout => LEDR(1)
    );
	 
end architecture sint;