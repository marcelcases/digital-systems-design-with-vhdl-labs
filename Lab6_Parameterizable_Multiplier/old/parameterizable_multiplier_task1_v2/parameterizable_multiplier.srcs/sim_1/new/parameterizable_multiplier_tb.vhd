-------------------------------------------------------------------------------
-- Testbench: Parameterizable Multiplier
-- @marcelcases
-- 08.11.2018
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


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
                sw : in std_logic_vector (15 downto 0);
                cat : out std_logic_vector (7 downto 0);
                an : out std_logic_vector (3 downto 0);
                carryin : in std_logic;
                carryout : out std_logic
                );
    end component ;

    signal clk_tb : std_logic := '0';
    signal reset_tb : std_logic := '1';
    signal carryin_tb, carryout_tb : std_logic ;
    signal sw_tb : std_logic_vector (15 downto 0);
    signal cat_tb : std_logic_vector (7 downto 0);
    signal an_tb : std_logic_vector (3 downto 0);
        
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
                carryin => carryin_tb,
                carryout => carryout_tb
                );

stimulus: process begin
    if data_width = 2 then
        sw_tb <= b"000000000000_00_01" ;    carryin_tb <= '0' ;    wait for 100 ns;
        sw_tb <= b"000000000000_10_10" ;    carryin_tb <= '0' ;    wait for 100 ns;
        sw_tb <= b"000000000000_00_11" ;    carryin_tb <= '1' ;    wait for 100 ns;
        sw_tb <= b"000000000000_10_00" ;    carryin_tb <= '0' ;    wait for 100 ns;
        sw_tb <= b"000000000000_00_10" ;    carryin_tb <= '0' ;    wait for 100 ns;
        sw_tb <= b"000000000000_11_01" ;    carryin_tb <= '0' ;    wait for 100 ns;
        sw_tb <= b"000000000000_10_01" ;    carryin_tb <= '1' ;    wait for 100 ns;
        sw_tb <= b"000000000000_00_00" ;    carryin_tb <= '0' ;    wait for 100 ns;
        wait;
    
    elsif data_width = 4 then
        sw_tb <= b"00000000_0000_1111" ;    carryin_tb <= '0' ;    wait for 100 ns;
        sw_tb <= b"00000000_0011_1111" ;    carryin_tb <= '0' ;    wait for 100 ns;
        sw_tb <= b"00000000_0000_1111" ;    carryin_tb <= '1' ;    wait for 100 ns;
        sw_tb <= b"00000000_1000_1111" ;    carryin_tb <= '0' ;    wait for 100 ns;
        sw_tb <= b"00000000_0010_0010" ;    carryin_tb <= '0' ;    wait for 100 ns;
        sw_tb <= b"00000000_1111_1111" ;    carryin_tb <= '0' ;    wait for 100 ns;
        sw_tb <= b"00000000_1111_1111" ;    carryin_tb <= '1' ;    wait for 100 ns;
        sw_tb <= b"00000000_0000_0000" ;    carryin_tb <= '0' ;    wait for 100 ns;
        wait;
        
    elsif data_width = 7 then
        sw_tb <= b"00_0000111_0011111" ;    carryin_tb <= '0' ;    wait for 100 ns;
        sw_tb <= b"00_1001110_0111000" ;    carryin_tb <= '0' ;    wait for 100 ns;
        sw_tb <= b"00_1001110_0111000" ;    carryin_tb <= '1' ;    wait for 100 ns;
        wait;
        
    
    end if;
    
end process;


end bench;
