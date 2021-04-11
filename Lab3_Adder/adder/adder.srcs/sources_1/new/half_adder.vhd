
-- Half Adder
-- @marcelcases
-- 26.09.2018

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity half_adder is
    port (  a : in std_logic;
            b : in std_logic;
            sum : out std_logic;
            cout : out std_logic
            );
end half_adder;

architecture Behavioral of half_adder is

begin

sum  <=  a xor b ;	
cout  <=  a and b ; 

end Behavioral;