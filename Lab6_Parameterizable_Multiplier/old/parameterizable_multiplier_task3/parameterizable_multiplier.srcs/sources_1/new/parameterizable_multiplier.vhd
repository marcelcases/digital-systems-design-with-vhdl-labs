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
            -- Output (4 7SEG-display, base 16) + carryout (LED)
            clk : in std_logic ; -- Internal clock (100MHz)
            reset : in std_logic ; -- Upper button on Nexys 4 board
            sw : in std_logic_vector (15 downto 0);
            cat : out std_logic_vector (7 downto 0);
            an : out std_logic_vector (7 downto 0);
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
        generic (   eoc: integer := 99999 -- 1kHz
                    );
        port (  clk : in STD_LOGIC;
                reset : in STD_LOGIC;
                clk_div : out STD_LOGIC
                );
    end component;
    
    type ripple_carry_adder_bus_type is array (natural range <>) of std_logic_vector(data_width downto 1);
        signal ripple_carry_adder_input : ripple_carry_adder_bus_type(data_width-1 downto 0); -- Inputs 'A' for each signal ripple_carry_adder component
        signal ripple_carry_adder_s : ripple_carry_adder_bus_type(data_width-1 downto 0);  -- Output sum from component ripple_carry_adder
        signal ripple_carry_adder_carryout : ripple_carry_adder_bus_type(data_width-1 downto 0);  -- Output carry from component ripple_carry_adder
--    type ripple_carry_adder_bit_type is array (natural range <>) of std_logic;
--        signal ripple_carry_adder_carryout : ripple_carry_adder_bit_type;  -- Output carry from component ripple_carry_adder
    signal result : std_logic_vector (15 downto 0) := X"0000";
    signal result_mux : std_logic_vector (3 downto 0); -- Result signal previous to decoder
    signal current_display : integer range 0 to 7;
    signal clk_div : std_logic ; --1kHz

begin

gen_rca_component : for i in 1 to data_width-1 generate -- "1 to data_width - 1" because for 'n' inputs it uses 'n-1' RCAs
    rca_component_number_1 : if i = 1 generate
        inst_ripple_carry_adder : ripple_carry_adder
            generic map (   data_width => data_width
                            )
            port map (  a => ripple_carry_adder_input(2),
                        b(data_width-1) => '0',
                        b(data_width-2 downto 0) => ripple_carry_adder_input(1)(3 downto 1),
                        cin => '0',
                        s  => ripple_carry_adder_s(1),
                        cout  => ripple_carry_adder_carryout(1)(0)
                        );
    end generate;
    rca_component_number_greater_than_1 : if i > 1 generate
        inst_ripple_carry_adder : ripple_carry_adder
            generic map (   data_width => data_width
                            )
            port map (  a => ripple_carry_adder_input(i+1),
                        b(data_width-1) => ripple_carry_adder_carryout(i-1)(0),
                        b(data_width-2 downto 0) => ripple_carry_adder_s(i-1)(3 downto 1),
                        cin => '0',
                        s  => ripple_carry_adder_s(i),
                        cout  => ripple_carry_adder_carryout(i)(0)
                        );
    end generate;
end generate;

gen_rca_input : for i in 1 to data_width generate
    ripple_carry_adder_input(i) <= sw(2*data_width-1 downto data_width) when sw(i-1) = '1' else (others => '0');
end generate;

-- Result assignation (non-generic, only for data_width = 4)
result(0) <= ripple_carry_adder_input(1)(0);
result(1) <= ripple_carry_adder_s(1)(0);
result(2) <= ripple_carry_adder_s(2)(0);
result(6 downto 3) <= ripple_carry_adder_s(3);
result(7) <= ripple_carry_adder_carryout(3)(0);

-- RESULT TO DISPLAYS
-- Values to show on dispays (mux)
with current_display select
    result_mux <=
        result(3 downto 0)      when 0,
        result(7 downto 4)      when 1,
        result(11 downto 8)     when 2,
        result(15 downto 12)    when 3,
        "0000"                  when others;

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
gen_an: for i in 0 to 7 generate
    an(i) <= '0' when current_display = i and i < 4 else '1';
end generate gen_an;

end Behavioral;