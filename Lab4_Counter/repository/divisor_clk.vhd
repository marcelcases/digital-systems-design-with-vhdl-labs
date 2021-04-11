----------------------------------------------------------------------------------------------
--
--  Component: divisor_clk
--  Funcio: filtra un pols de clock cada cert temps
--
--  Autor: @marcelcases
--  Creat:  2017.11.10
--  Editat: 2017.11.10
--
----------------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity divisor_clk is
    generic (eoc: integer := 100000);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_div : out STD_LOGIC
          );
end divisor_clk;

architecture Behavioral of divisor_clk is
   signal clk_reg: integer range 0 to eoc;
begin

process (clk, reset)
begin
    if clk'event and clk = '1' then
        clk_div <= '0';
        if reset = '1' then
            clk_reg <= 0;
        elsif clk_reg = eoc then
            clk_reg <= 0;
            clk_div <= '1';
        else clk_reg <= clk_reg + 1;
        end if;
    end if;
end process;

end Behavioral;
