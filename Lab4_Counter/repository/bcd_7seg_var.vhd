library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.port_array_pkge.all;

entity bcd_7seg_var is

    Generic (num_bcds : integer := 2);

    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           bcd : in array_bcd(num_bcds - 1 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (7 downto 0);
           disp_en : in STD_LOGIC);
end bcd_7seg_var;

architecture Behavioral of bcd_7seg_var is

signal clk_div : std_logic;
signal clk_cnt : integer range 0 to 100000;
signal digit_act : integer range 0 to num_bcds - 1;
signal bcd_act : std_logic_vector (3 downto 0);

begin

--divisor de rellotge a 1Khz

divisor: process (clk) begin
    if clk'event and clk = '1' then
        clk_div <= '0';
        if reset = '1' then
            clk_cnt <= 0;
        elsif clk_cnt = 100000 then
            clk_div <= '1';
            clk_cnt <= 0;
        else clk_cnt <= clk_cnt + 1;
        end if;
    end if;
end process;

--selector de display a refrescar

digit_actual: process(clk, reset) begin
if clk'event and clk = '1' then
    if reset = '1' then
        digit_act <= 0;
    elsif clk_div = '1' then
        if digit_act = num_bcds - 1 then
            digit_act <= 0;
        else digit_act <= digit_act + 1;
        end if;    
    end if;
end if;
end process;

-- selecciona un port d'entrada depenent del digit_act       
     
bcd_act <= bcd(digit_act);
            
--codificador de hexadecimal a 7 segments pels càtodes:

with bcd_act select
    cat <=  "00000011" when "0000",
            "10011111" when "0001",
            "00100101" when "0010",
            "00001101" when "0011",
            "10011001" when "0100",
            "01001001" when "0101",
            "01000001" when "0110",
            "00011111" when "0111",
            "00000001" when "1000",
            "00011001" when "1001",
            "00000101" when "1010",
            "11000001" when "1011",
            "11100101" when "1100",
            "10000101" when "1101",
            "10000101" when "1110",
            "01110001" when "1111",
            "11111111" when others;                      
            

-- assignació de valors als ànodes

--an(0) <= '0' when digit_act = 0 and disp_en = '1' else '1';
--an(1) <= '0' when digit_act = 1 and disp_en = '1' else '1';
--an(2) <= '0' when digit_act = 2 and disp_en = '1' else '1';
--an(3) <= '0' when digit_act = 3 and disp_en = '1' else '1';     

gen_an: for i in 0 to 3 generate
    an(i) <= '0' when digit_act = i and disp_en = '1' else '1';
end generate gen_an;

end Behavioral;


