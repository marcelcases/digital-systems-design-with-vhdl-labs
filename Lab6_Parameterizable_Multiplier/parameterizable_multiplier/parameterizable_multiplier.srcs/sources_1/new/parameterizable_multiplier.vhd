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
            -- Output (4 7SEG-display, base 16 + 1 LED for carryout)
            clk : in std_logic ; -- Internal clock (100MHz)
            reset : in std_logic ; -- Upper button on Nexys 4 board
            sw : in std_logic_vector (15 downto 0);
            cat : out std_logic_vector (7 downto 0);
            an : out std_logic_vector (7 downto 0);
            result_to_testbench : out std_logic_vector (15 downto 0)
            );
end parameterizable_multiplier;


architecture Behavioral of parameterizable_multiplier is

    -- Component *RIPPLE CARRY ADDER*
    component ripple_carry_adder is
        generic (   data_width : integer := data_width
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
    
    type ripple_carry_adder_bus_type is array (natural range <>) of std_logic_vector(data_width-1 downto 0);
        signal ripple_carry_adder_input : ripple_carry_adder_bus_type(data_width-1 downto 0); -- Inputs 'A' for each signal ripple_carry_adder component
        signal ripple_carry_adder_s : ripple_carry_adder_bus_type(data_width-1 downto 0);  -- Output sum from component ripple_carry_adder
    signal ripple_carry_adder_carryout : std_logic_vector (data_width-2 downto 0) := (others => '0') ; -- Output from component ripple_carry_adder
    signal result : std_logic_vector (15 downto 0) := X"0000";
    signal result_mux : std_logic_vector (3 downto 0); -- Result signal previous to decoder
    signal current_display : integer range 0 to 7;
    signal clk_1kHz : std_logic ; --1kHz

begin

gen_rca_component : for i in 0 to data_width-2 generate -- "0 to data_width - 2" because for 'n' inputs it uses 'n-1' RCAs of size 'n'
    rca_component_number_0 : if i = 0 generate
        inst_ripple_carry_adder : ripple_carry_adder
            generic map (   data_width => data_width
                            )
            port map (  a => ripple_carry_adder_input(1),
                        b(data_width-1) => '0',
                        b(data_width-2 downto 0) => ripple_carry_adder_input(0)(data_width-1 downto 1),
                        cin => '0',
                        s => ripple_carry_adder_s(0),
                        cout => ripple_carry_adder_carryout(0)
                        );
    end generate;
    rca_component_number_greater_than_0 : if i > 0 generate
        inst_ripple_carry_adder : ripple_carry_adder
            generic map (   data_width => data_width
                            )
            port map (  a => ripple_carry_adder_input(i+1),
                        b(data_width-1) => ripple_carry_adder_carryout(i-1),
                        b(data_width-2 downto 0) => ripple_carry_adder_s(i-1)(data_width-1 downto 1),
                        cin => '0',
                        s => ripple_carry_adder_s(i),
                        cout => ripple_carry_adder_carryout(i)
                        );
    end generate;
end generate;

gen_rca_input : for i in 0 to data_width - 1 generate
    ripple_carry_adder_input(i) <= sw(2*data_width-1 downto data_width) when sw(i) = '1' else (others => '0');
end generate;

gen_result : for i in 0 to data_width-2 generate
    gen_result_0 : if i = 0 generate
        result(0) <= ripple_carry_adder_input(0)(0);
    end generate;
    gen_result_greater_than_0 : if i > 0 generate
        result(i) <= ripple_carry_adder_s(i-1)(0);
    end generate;
    gen_result_msbits : if i = data_width-2 generate
        result(i+data_width downto i+1) <= ripple_carry_adder_s(i);
        result(i+data_width+1) <= ripple_carry_adder_carryout(data_width-2); --carryout
    end generate ;
end generate ;

result_to_testbench <= result; -- Function: sends the internal signal 'result' to a physical port in order to perform an 'assert' on Testbench

-- RESULT TO DISPLAYS
-- Values to show on dispays (mux)-- Values to show on dispays (mux)
with current_display select
    result_mux <=
        result(3 downto 0)      when 0,
        result(7 downto 4)      when 1,
        result(11 downto 8)     when 2,
        result(15 downto 12)    when 3,
        "0000"              when others;

inst_decoder_display_i : decoder
    port map (  value => result_mux,
                cat => cat
                );

-- Clock divider to 1kHz (Display mux shift frequency)
inst_clock_divider : clock_divider
    port map (  clk => clk,
                reset => reset,
                clk_div => clk_1kHz
                );

-- Display mux
process (clk, reset) begin
    if rising_edge(clk) then
        if reset = '1' then
            current_display <= 0;
        elsif clk_1kHz = '1' then
            current_display <= current_display + 1;
        end if;
    end if;
end process;

-- Anode mux
gen_an: for i in 0 to 7 generate
    an(i) <= '0' when current_display = i and i <= 3 and reset /= '1' else '1';
end generate gen_an;

end Behavioral;