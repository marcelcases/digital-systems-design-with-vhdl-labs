library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

use work.port_array_pkge.all;

entity bin_bcd_var is

    Generic (bin_n : integer := 5;
            bcds_out_n : integer := 2);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           bin_in : in STD_LOGIC_VECTOR(bin_n - 1 downto 0);
           bcd_out : out array_bcd(bcds_out_n - 1 downto 0));
end bin_bcd_var;


architecture Behavioral of bin_bcd_var is

type states is (start, shift, done);
signal state, state_next: states;

signal binary, binary_next: std_logic_vector(bin_n-1 downto 0); -- valor binari a convertir
signal bcds, bcds_reg, bcds_next: std_logic_vector(bcds_out_n*4 - 1 downto 0); -- registre on es va desplaçant el valor binari i es converteix en bcd
signal bcds_out_reg, bcds_out_reg_next: std_logic_vector(bcds_out_n*4 - 1 downto 0); -- regsitre del resultat en bcd després de tots els desplaçaments
signal shift_counter, shift_counter_next: natural range 0 to bin_n; -- comptador de desplaçaments

begin

-- Procés síncron de la màquina d'estats de conversió

sinc: process(clk, reset) begin
    if reset = '1' then
        binary <= (others => '0');
        bcds <= (others => '0');
        state <= start;
        bcds_out_reg <= (others => '0');
        shift_counter <= 0;
    elsif rising_edge(clk) then
        binary <= binary_next;
        bcds <= bcds_next;
        state <= state_next;
        bcds_out_reg <= bcds_out_reg_next;
        shift_counter <= shift_counter_next;
    end if;
end process;


-- Procés combinatori de la màquina d'estats de conversió

comb: process(state, binary, bin_in, bcds, bcds_reg, shift_counter, bcds_out_reg) begin
    state_next <= state;
    bcds_next <= bcds;
    binary_next <= binary;
    shift_counter_next <= shift_counter;
    bcds_out_reg_next <= bcds_out_reg;

    case state is
        when start =>
            bcds_next <= (others => '0');
            shift_counter_next <= 0;
                state_next <= shift;
                binary_next <= bin_in;                                        
        when shift =>
            if shift_counter = bin_n then
                state_next <= done;
                bcds_out_reg_next <= bcds;
            else
                binary_next <= binary(bin_n-2 downto 0) & '0';
                bcds_next <= bcds_reg(bcds_out_n*4 - 2 downto 0) & binary(bin_n-1);
                shift_counter_next <= shift_counter + 1;
            end if;
        when done =>
            state_next <= start;
    end case;
end process;

gen_assig_out: for i in 0 to bcds_out_n - 1 generate
    -- Quan un nibble és superior a 4 li suma 3
    bcds_reg(4*(i + 1) - 1 downto 4*(i + 1) - 4) <= bcds(4*(i + 1) - 1 downto 4*(i + 1) - 4) + 3 
    when bcds(4*(i + 1) - 1 downto 4*(i + 1) - 4) > 4 
    else bcds(4*(i + 1) - 1 downto 4*(i + 1) - 4);
    -- Distribueix els bcd's del resultat en els ports disponibles
    bcd_out(i) <= bcds_out_reg(4*i + 3 downto 4*i);
end generate gen_assig_out;
        
    



end Behavioral;
