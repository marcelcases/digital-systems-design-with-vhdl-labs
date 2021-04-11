-------------------------------------------------------------------------------
-- Parameterizable Multiplier
-- @marcelcases
-- 31.10.2018
-------------------------------------------------------------------------------


library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity parameterizable_multiplier is
    generic (   data_width : integer := 4
                );
    port (  -- Input (16 switches, base 2) and
            -- Output (4 7SEG-display, base 16)
            clk : in std_logic ; -- Internal clock (100MHz)
            reset : in std_logic ; -- Upper button on Nexys 4 board
            sw : in std_logic_vector (15 downto 0);
            cat : out std_logic_vector (7 downto 0);
            an : out std_logic_vector (3 downto 0);
            carryin : in std_logic; -- Centre button on Nexys 4 board
            carryout : out std_logic
            );
end parameterizable_multiplier;


architecture Behavioral of parameterizable_multiplier is

    -- Component *RIPPLE CARRY ADDER*
    component ripple_carry_adder is
        generic (   data_width : integer
                    );
        port (  a, b: in std_logic_vector (data_width-1 downto 0);
                cin: in std_logic;
                s: out std_logic_vector (data_width-1 downto 0);
                cout: out std_logic
                );
    end component;
    
    -- Component *7SEG HEXA DECODER*
    component decoder is
        port (  value : in std_logic_vector (3 downto 0);
                cat : out std_logic_vector (7 downto 0)
                );
    end component;
    
    -- Component *CLOCK DIVIDER*
    component clock_divider is
        generic (   eoc: integer := 99999
                    ); -- 1kHz
        Port (  clk : in STD_LOGIC;
                reset : in STD_LOGIC;
                clk_div : out STD_LOGIC
                );
    end component;
    
    signal ripple_carry_adder_s : std_logic_vector (15 downto 0) := X"0000"; -- Output from component ripple_carry_adder
--    signal ripple_carry_adder_cout : std_logic := '0' ; -- Output from component ripple_carry_adder
    signal result_mux : std_logic_vector (3 downto 0); -- Result signal previous to decoder
    signal current_display : integer range 0 to 3;
    signal clk_div : std_logic ; --1kHz

begin

inst_ripple_carry_adder : ripple_carry_adder
    generic map (   data_width => data_width
                )
    port map (  a => sw(data_width-1 downto 0),
                b => sw(2*data_width-1 downto data_width),
                cin => carryin,
                s  => ripple_carry_adder_s(data_width-1 downto 0),
                cout  => carryout
                );
--carryout <= ripple_carry_adder_cout;

-- Values to show on dispays (mux)
with current_display select
    result_mux <=
        ripple_carry_adder_s(3 downto 0)      when 0,
        ripple_carry_adder_s(7 downto 4)      when 1,
        ripple_carry_adder_s(11 downto 8)     when 2,
        ripple_carry_adder_s(15 downto 12)    when 3,
        "0000"              when others;

inst_decoder_display_i : decoder
    port map (  value => result_mux,
                cat => cat
                );

-- Clock divider to 1kHz (Display mux shift frequency)
inst_clock_divider : clock_divider
    port map (  clk => clk,
                reset => reset,
                clk_div => clk_div
                );

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
gen_an: for i in 0 to 3 generate
    an(i) <= '0' when current_display = i else '1';
end generate gen_an;

end Behavioral;