-------------------------------------------------------------------------------
-- Creeping Line
-- @marcelcases
-- 17.10.2018
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity creeping_line is
    Port (  clk : in std_logic ; -- Internal clock (100MHz)
            reset : in std_logic ; -- Centre button on Nexys 4 board
            sw : in std_logic_vector (15 downto 0);
            cat : out std_logic_vector (7 downto 0);
            an : out std_logic_vector (7 downto 0)
            );
end creeping_line;


architecture Behavioral of creeping_line is

    -- Component *DECODER*
    component decoder is
        port (  sw : in std_logic_vector (3 downto 0);
                cat : out std_logic_vector (7 downto 0)
                );
    end component;
    
    -- Component *CLOCK DIVIDER*
    component clock_divider is
        generic (eoc: integer := 99999); -- 1kHz
        Port (  clk : in STD_LOGIC;
                reset : in STD_LOGIC;
                clk_div : out STD_LOGIC
                );
    end component;

    signal sw_mux : std_logic_vector (3 downto 0);
    signal current_display : integer range 0 to 3;
    signal clk_div : std_logic ; --1kHz

begin

inst_decoder_display_i : decoder
    port map (  sw => sw_mux,
                cat => cat
                );

-- Clock divider to 1kHz (Display mux shift frequency)
inst_clock_divider : clock_divider
    port map (  clk => clk,
                reset => reset,
                clk_div => clk_div
                );

-- Switch mux
with current_display select
    sw_mux <=
        sw(3 downto 0)      when 0,
        sw(7 downto 4)      when 1,
        sw(11 downto 8)     when 2,
        sw(15 downto 12)    when 3,
        "0000"              when others;

-- Display mux
process (clk, reset) begin
    if rising_edge(clk) then
        if reset = '1' then
            current_display <= 0;
        elsif clk_div = '1' then
            current_display <= current_display + 1;
        end if;
    end if;
end process;

-- Anode mux
gen_an: for i in 0 to 7 generate
    an(i) <= '0' when current_display = i else '1';
end generate gen_an;

end Behavioral;
