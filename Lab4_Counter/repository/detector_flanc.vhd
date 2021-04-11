----------------------------------------------------------------------------------------------
--
--  Component: detector_flanc
--  Funcio: detecta el flanc de pujada quan es prem un polsador
--
--  Autor: @marcelcases
--  Creat:  2017.11.17
--  Editat: 2017.11.17
--
----------------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity detector_flanc is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           entrada_bruta : in std_logic;
           sortida_neta : out std_logic
          );
end detector_flanc;

architecture Behavioral of detector_flanc is
    signal q1, q0 : std_logic;

begin

process (clk) begin
    if clk'event and clk = '1' then
        if reset = '1' then
            q0 <= '0';
            q1 <= '0';
        else
            q0 <= entrada_bruta;
            q1 <= q0;
        end if;
    end if;
end process;
sortida_neta <= q0 and not q1;

end Behavioral;
