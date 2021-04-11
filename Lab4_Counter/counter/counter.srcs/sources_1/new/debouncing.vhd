-------------------------------------------------------------------------------
-- Component: Debouncing using a Shift Register
-- @marcelcases
-- 10.10.2018
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity debouncing is
    Port (  clk : in std_logic;
            reset : in std_logic;
            enable : in std_logic ;
            in_raw : in std_logic; -- D input
            out_filtered : out std_logic
            );
end debouncing;


architecture Behavioral of debouncing is
    signal Q : std_logic_vector (0 to 3);
    signal D : std_logic ;
begin

--  *4-BIT SHIFT REGISTER*
process (clk) begin
    if rising_edge(clk) then
        if reset = '1' then
            Q <= (others => '0');
        elsif enable = '1' then
            Q(0) <= D;
            Q(1 to 3) <= Q(0 to 2);
        end if;
    end if;
end process;

D <= in_raw;
out_filtered <= '1' when Q = "1111" else '0';

end Behavioral;
