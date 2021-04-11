
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity bits_to_bus is
    Port (  bit_in1, bit_in0 : in std_logic;
            bus_out : out std_logic_vector (1 downto 0)
            );
end bits_to_bus;


architecture Behavioral of bits_to_bus is begin

bus_out(1) <= bit_in1;
bus_out(0) <= bit_in0;

end Behavioral;