-------------------------------------------------------------------------------
-- Testbench: Counter
-- @marcelcases
-- 13.10.2018
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity counter_tb is
end counter_tb;


architecture bench of counter_tb is
    component counter is
        Port (  clk : in std_logic ; -- Internal clock (100MHz)
                reset : in std_logic ; -- Upper button on Nexys 4
                btnc : in std_logic ; -- Centre Button on Nexys 4
                sum : out std_logic_vector (15 downto 0) -- LEDs binary output
                );
    end component ;
    
    signal clk_tb : std_logic := '0'; -- make sure you initialise!
    signal reset_tb : std_logic := '1'; -- Upper button on Nexys 4
    signal btnc_tb : std_logic ; -- Centre Button on Nexys 4
    signal sum_tb : std_logic_vector (15 downto 0); -- LEDs binary output
    
begin

clk_tb <= not clk_tb after 5ns; --half_period
reset_tb <= '0' after 10ns;

uut : counter
    port map (  clk => clk_tb,
                reset => reset_tb, 
                btnc => btnc_tb,
                sum => sum_tb
                );
                
stimulus: process begin    

    btnc_tb <= '1' ;    wait for 5 ns;
    btnc_tb <= '0' ;    wait for 5 ns;

    btnc_tb <= '1' ;    wait for 5 ns;
    btnc_tb <= '0' ;    wait for 5 ns;

    btnc_tb <= '1' ;    wait for 5 ns;
    btnc_tb <= '0' ;    wait for 5 ns;

    btnc_tb <= '1' ;    wait for 100 ns;
    btnc_tb <= '0' ;    wait for 100 ns;
    
end process;

end bench;
