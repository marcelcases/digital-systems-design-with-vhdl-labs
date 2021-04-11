-------------------------------------------------------------------------------
-- Testbench: Creeping Line
-- @marcelcases
-- 17.10.2018
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity creeping_line_tb is
end creeping_line_tb;


architecture bench of creeping_line_tb is
    component creeping_line is
        Port (  clk : in std_logic ;
                reset : in std_logic ; 
                sw : in std_logic_vector (15 downto 0);
                cat : out std_logic_vector (7 downto 0);
                an : out std_logic_vector (7 downto 0)
                );
    end component ;
    
    signal clk_tb : std_logic := '0';
    signal reset_tb : std_logic := '1'; 
    signal sw_tb : std_logic_vector (15 downto 0);
    signal cat_tb : std_logic_vector (7 downto 0);
    signal an_tb : std_logic_vector (7 downto 0);
    
begin

clk_tb <= not clk_tb after 5ns; --half_period
reset_tb <= '0' after 10ns;

uut : creeping_line
    port map (  clk => clk_tb,
                reset => reset_tb, 
                sw => sw_tb,
                cat => cat_tb,
                an => an_tb
                );
                
stimulus: process begin    

    sw_tb <= X"0000" ;    wait for 10000 us;
    sw_tb <= X"1234" ;    wait for 10000 us;
    sw_tb <= X"ABCD" ;    wait for 10000 us;
    sw_tb <= X"137F" ;    wait for 10000 us;

    --wait;
    
end process;

end bench;
