----------------------------------------------------------------------------------
-- Component: Clock Divider
-- @marcelcases
-- 10.10.2018
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity clock_divider is
    generic (eoc: integer := 999999);
    Port (  clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            clk_div : out STD_LOGIC
            );
end clock_divider;


architecture Behavioral of clock_divider is
    signal counter: integer range 0 to eoc;
--    signal counter: integer range 0 to 99; --1MHz
--    signal counter: integer range 0 to 999999; --100Hz
begin

process (clk) begin
    if rising_edge(clk) then
        clk_div <= '0';
        if reset = '1' then
            counter <= 0;
        elsif counter = eoc then
            counter <= 0;
            clk_div <= '1';
        else counter <= counter + 1;
        end if;
    end if;
end process;

end Behavioral;
