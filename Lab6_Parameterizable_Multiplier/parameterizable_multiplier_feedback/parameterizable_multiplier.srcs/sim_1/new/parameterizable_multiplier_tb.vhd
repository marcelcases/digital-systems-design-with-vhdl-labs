-------------------------------------------------------------------------------
-- Testbench: Parameterizable Multiplier
-- @marcelcases
-- 08.11.2018
-------------------------------------------------------------------------------

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity parameterizable_multiplier_tb is
    generic (   data_width : integer := 4
                );
end parameterizable_multiplier_tb;

architecture bench of parameterizable_multiplier_tb is
    component  parameterizable_multiplier is
        generic (   data_width : integer := data_width
                    );
        port (  clk : in std_logic ;
                reset : in std_logic ;
                sw : in std_logic_vector (15 downto 0) := X"0000";
                cat : out std_logic_vector (7 downto 0);
                an : out std_logic_vector (7 downto 0);
                result_to_testbench : out std_logic_vector (15 downto 0)
                );
    end component ;

    signal clk_tb : std_logic := '0';
    signal reset_tb : std_logic := '1';
    signal sw_tb : std_logic_vector (15 downto 0);
    signal cat_tb : std_logic_vector (7 downto 0);
    signal an_tb : std_logic_vector (7 downto 0);
    signal result_to_testbench_tb : std_logic_vector (15 downto 0);
        
begin

clk_tb <= not clk_tb after 5ns; --half_period
reset_tb <= '0' after 10ns;

uut: parameterizable_multiplier
    generic map(   data_width => data_width
                   )
    port map (  clk => clk_tb,
                reset => reset_tb,
                sw => sw_tb,
                cat => cat_tb,
                an => an_tb,
                result_to_testbench => result_to_testbench_tb
                );
--stimulus: process begin
--    sw_tb <= std_logic_vector(to_unsigned(to_integer(unsigned(sw_tb) + 1), 16));   wait for 100 ns;   assert(unsigned(sw_tb(2*data_width-1 downto data_width))*unsigned(sw_tb(data_width-1 downto 0)) = unsigned(result_to_testbench_tb)) report "Multiplication error" severity failure;   
--end process;

stimulus: process begin
    generic_loop : loop -- Generates multiplication and asserts multiplication for any value of data_width from 2 to 8
        sw_tb <= std_logic_vector(to_unsigned(to_integer(unsigned(sw_tb) + 1), 16));   wait for 100 ns;   assert(unsigned(sw_tb(2*data_width-1 downto data_width))*unsigned(sw_tb(data_width-1 downto 0)) = unsigned(result_to_testbench_tb)+1) report "Multiplication error" severity failure;   
        exit generic_loop when sw_tb(2*data_width-1 downto 0) = (2*data_width-1 downto 0 => '1');
    end loop generic_loop;
    wait;
end process;


end bench;
