-------------------------------------------------------------------------------
-- Counter
-- @marcelcases
-- 10.10.2018
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity counter is
    Port (  clk : in std_logic ; -- Internal clock (100MHz)
            reset : in std_logic ; -- Upper button on Nexys 4
            btnc : in std_logic ; -- Centre Button on Nexys 4
            sum : out std_logic_vector (15 downto 0) -- LEDs binary output
            );
end counter;


architecture Behavioral of counter is
    
    -- Component *CLOCK DIVIDER*
    component clock_divider is
        Port (  clk : in STD_LOGIC;
                reset : in STD_LOGIC;
                clk_div : out STD_LOGIC
                );
    end component;

    -- Component *DEBOUNCING*
    component debouncing
        Port ( clk : in std_logic;
               reset : in std_logic;
               enable :in std_logic ;
               in_raw : in std_logic;
               out_filtered : out std_logic
               );
    end component;    
    
    -- Component *EDGE DETECTION*
    component edge_detection
        Port ( clk : in std_logic;
               reset : in std_logic;
               in_raw : in std_logic;
               out_filtered : out std_logic
               );
    end component;

    
    signal clk_div : std_logic ;
    signal btnc_post_debouncing, btnc_post_edge : std_logic ; -- Filtered signals from counter button
    signal sum_buf : std_logic_vector (15 downto 0); -- 'sum' output signal buffer in order to read and use it as an input
    
begin

inst_clock_divider : clock_divider
    port map (  clk => clk,
                reset => reset,
                clk_div => clk_div
                );

inst_debouncing : debouncing
    port map (  clk => clk,
                reset => reset,
                enable => clk_div,
                in_raw => btnc,
                out_filtered => btnc_post_debouncing
                );
                
inst_edge_detection : edge_detection
    port map (  clk => clk,
                reset => reset,
                in_raw => btnc_post_debouncing,
                out_filtered => btnc_post_edge
                );


-- Binary Up Counter
process (clk, reset) begin
    if rising_edge(clk) then
        if reset = '1' then
            sum_buf <= (others => '0');
        elsif btnc_post_edge = '1' then
            sum_buf <= std_logic_vector(unsigned(sum_buf) + 1);
        end if;
    end if;
end process;
sum <= sum_buf;

end Behavioral;
