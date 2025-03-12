library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sumador_4_bits is
    port (
        A, B    : in  STD_LOGIC_VECTOR(3 downto 0);  
        Cin     : in  STD_LOGIC;                     
        S       : out STD_LOGIC_VECTOR(3 downto 0);  
        Cout    : out STD_LOGIC                      
    );
end entity sumador_4_bits;

architecture sint of sumador_4_bits is
    component sumador
        port (
            a, b, cin : in STD_LOGIC;
            s, cout   : out STD_LOGIC
        );
    end component;

    signal carry : STD_LOGIC_VECTOR(3 downto 0);  

begin
   
    U0: sumador port map(A(0), B(0), Cin, S(0), carry(0));
    U1: sumador port map(A(1), B(1), carry(0), S(1), carry(1));
    U2: sumador port map(A(2), B(2), carry(1), S(2), carry(2));
    U3: sumador port map(A(3), B(3), carry(2), S(3), Cout);

end architecture sint;