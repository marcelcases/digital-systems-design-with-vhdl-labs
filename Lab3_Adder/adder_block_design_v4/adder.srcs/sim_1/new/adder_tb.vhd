

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity adder_tb is
end adder_tb;

architecture bench of adder_tb is
    component adder
        Port  ( a1, a0, b1, b0 : in std_logic ;
              sum1, sum0, carry : out std_logic 
              );
    end component;

    signal input_tb : std_logic_vector (3 downto 0);
    signal a1_tb, a0_tb, b1_tb, b0_tb, sum1_tb, sum0_tb, carry_tb : std_logic ; 
        
begin

-- Concurrent
a1_tb <= input_tb(3);
a0_tb <= input_tb(2);
b1_tb <= input_tb(1);
b0_tb <= input_tb(0);


-- Unit under test
uut: adder port map (   a1 => a1_tb, 
                        a0 => a0_tb, 
                        b1 => b1_tb, 
                        b0 => b0_tb,
                        sum1 => sum1_tb,
                        sum0 => sum0_tb,
                        carry => carry_tb
                        );

stimulus: process begin	
    input_tb <= "0000" ;    wait for 10 ns;
    input_tb <= "0001" ;    wait for 10 ns;
    input_tb <= "0010" ;    wait for 10 ns;
    input_tb <= "0011" ;    wait for 10 ns;
    input_tb <= "0100" ;    wait for 10 ns;
    input_tb <= "0101" ;    wait for 10 ns;
    input_tb <= "0110" ;    wait for 10 ns;
    input_tb <= "0111" ;    wait for 10 ns;
    input_tb <= "1000" ;    wait for 10 ns;
    input_tb <= "1001" ;    wait for 10 ns;
    input_tb <= "1010" ;    wait for 10 ns;
    input_tb <= "1011" ;    wait for 10 ns;
    input_tb <= "1100" ;    wait for 10 ns;
    input_tb <= "1101" ;    wait for 10 ns;
    input_tb <= "1110" ;    wait for 10 ns;
    input_tb <= "1111" ;    wait for 10 ns;
    
    wait;
    
end process;


end bench;
