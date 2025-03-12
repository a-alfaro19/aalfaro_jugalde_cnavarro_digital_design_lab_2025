library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sumador_tb is
end entity sumador_tb;

architecture test of sumador_tb is
    
    component sumador_4_bits
        port (
            A, B  : in  STD_LOGIC_VECTOR(3 downto 0);
            Cin   : in  STD_LOGIC;
            S     : out STD_LOGIC_VECTOR(3 downto 0);
            Cout  : out STD_LOGIC
        );
    end component;

    
    signal A_tb, B_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal Cin_tb     : STD_LOGIC;
    signal S_tb       : STD_LOGIC_VECTOR(3 downto 0);
    signal Cout_tb    : STD_LOGIC;

begin
    
    UUT: sumador_4_bits port map(
        A    => A_tb,
        B    => B_tb,
        Cin  => Cin_tb,
        S    => S_tb,
        Cout => Cout_tb
    );

 
    process
    begin
  
        A_tb  <= "0100"; 
        B_tb  <= "0010"; 
        Cin_tb <= '0';
        wait for 10 ns;

    
        A_tb  <= "0101"; 
        B_tb  <= "1011"; 
        Cin_tb <= '0';
        wait for 10 ns;

    
        A_tb  <= "1010"; 
        B_tb  <= "0110"; 
        Cin_tb <= '0';
        wait for 10 ns;

   
        A_tb  <= "1111"; 
        B_tb  <= "1111"; 
        Cin_tb <= '0';
        wait for 10 ns;

   
        wait;
    end process;
end architecture test;