----------------------------------------------------------------------------------
-- Component: Edge Detection
-- @marcelcases
-- 10.10.2018
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity edge_detection is
    Port (  clk : in std_logic;
            reset : in std_logic;
            in_raw : in std_logic;
            out_filtered : out std_logic
            );
end edge_detection;


architecture Behavioral of edge_detection is    
    signal q1, q0 : std_logic; -- Flip-Flop D internal signals
begin

process (clk) begin -- Flip-Flop D process
    if rising_edge(clk) then
        if reset = '1' then
            q0 <= '0';
            q1 <= '0';
        else
            q0 <= in_raw;
            q1 <= q0;
        end if;
    end if;
end process;

out_filtered <= q0 and not q1;

end Behavioral;
