-------------------------------------------------------------------------------
-- Creeping Line
-- @marcelcases
-- Created: 17.10.2018
-- Modified: 29.10.2018
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity creeping_line is
    Port (  clk : in std_logic ; -- Internal clock (100MHz)
            reset : in std_logic ; -- Centre button on Nexys 4 board
            cat : out std_logic_vector (7 downto 0);
            an : out std_logic_vector (7 downto 0)
            );
end creeping_line;


architecture Behavioral of creeping_line is

    -- Component *DECODER*
    component decoder is
        port (  input : in std_logic_vector (3 downto 0);
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
    
    -- Component *SHIFT REGISTER*
    component shift_register is
        generic (   n : integer := 32;
                    code : std_logic_vector (31 downto 0)
                    );
        port(   clk: in std_logic; 
                reset: in std_logic; 
                enable: in std_logic; --enables shifting 
                parallel_in: in std_logic_vector(n-1 downto 0);
                parallel_out: out std_logic_vector(n-1 downto 0)
                );
    end component;
    
    signal current_display : integer range 0 to 7;
    signal clk_div_displays : std_logic ; --1kHz is OK for human eye
    signal clk_div_shift_register : std_logic ; -- 2Hz for proper reading
    signal shift_register_buff : std_logic ; -- Shift Register buffer
    signal sr_mux : std_logic_vector (3 downto 0); -- Shift Register mux
    signal code, code_shifted : std_logic_vector (31 downto 0); -- Code to show on displays

begin


inst_decoder_display_i : decoder
    port map (  input => sr_mux,
                cat => cat
                );

-- Clock divider to 1kHz (Display mux shift frequency)
inst_clock_divider_displays : clock_divider
    generic map (eoc => 99999)
    port map (  clk => clk,
                reset => reset,
                clk_div => clk_div_displays
                );

inst_clock_divider_shift_register : clock_divider
    generic map (eoc => 49999999) -- 2Hz
    port map (  clk => clk,
                reset => reset,
                clk_div => clk_div_shift_register
                );
-- Switch mux
with current_display select
    sr_mux <=
        code_shifted(3 downto 0)      when 0,
        code_shifted(7 downto 4)      when 1,
        code_shifted(11 downto 8)     when 2,
        code_shifted(15 downto 12)    when 3,
        code_shifted(19 downto 16)    when 4,
        code_shifted(23 downto 20)    when 5,
        code_shifted(27 downto 24)    when 6,
        code_shifted(31 downto 28)    when 7,
        "0000"                        when others;

inst_shift_register : shift_register
    generic map(    n => 32,
                    code => X"ABCD1234" -- *CODE TO SHOW ON DISPLAYS*
                    )
    port map (  clk => clk, 
                reset => reset,
                enable => clk_div_shift_register,
                parallel_in => code,
                parallel_out => code_shifted
                );

-- Display mux
process (clk, reset) begin
    if rising_edge(clk) then
        if reset = '1' then
            current_display <= 0;
        elsif clk_div_displays = '1' then
            current_display <= current_display + 1;
        end if;
    end if;
end process;

-- Anode mux
gen_an: for i in 0 to 7 generate
    an(i) <= '0' when current_display = i else '1';
end generate gen_an;

end Behavioral;
