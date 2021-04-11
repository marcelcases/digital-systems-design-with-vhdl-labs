
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity bus_to_bits is
    Port (  bus_in : in std_logic_vector (1 downto 0);
            bit_out1, bit_out0 : out std_logic 
            );
end bus_to_bits;


architecture Behavioral of bus_to_bits is begin

bit_out1 <= bus_in(1);
bit_out0 <= bus_in(0);

end Behavioral;
