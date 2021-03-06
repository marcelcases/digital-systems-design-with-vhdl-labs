-------------------------------------------------------------------------------
-- Component : 7-seg Display Decoder
-- @marcelcases
-- 24.10.2018
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity decoder is
    Port (  input : in std_logic_vector (3 downto 0);
            cat : out std_logic_vector (7 downto 0)
            );
end decoder;

architecture Behavioral of decoder is
begin

with input select
    cat <=
        "00000011" when "0000", --0
        "10011111" when "0001", --1
        "00100101" when "0010", --2
        "00001101" when "0011", --3
        "10011001" when "0100", --4
        "01001001" when "0101", --5
        "01000001" when "0110", --6
        "00011111" when "0111", --7
        "00000001" when "1000", --8
        "00011001" when "1001", --9
        "00010001" when "1010", --a
        "11000001" when "1011", --b
        "11100101" when "1100", --c
        "10000101" when "1101", --d
        "01100001" when "1110", --e
        "01110001" when "1111", --f
        "11111111" when others;

end Behavioral;
