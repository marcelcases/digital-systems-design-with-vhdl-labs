----------------------------------------------------------------------------------
-- Component: Shift Register
-- @marcelcases
-- 24.10.2018
-------------------------------------------------------------------------------


library ieee; 
use ieee.std_logic_1164.all;


entity shift_register is
    generic ( n : integer := 32);
    port(   clk: in std_logic; 
            reset: in std_logic; 
            enable: in std_logic; --enables shifting 
            parallel_in: in std_logic_vector(n-1 downto 0);
            parallel_out: out std_logic_vector(n-1 downto 0)
            );
end shift_register;

architecture behavioral of shift_register is
    signal parallel_out_buff : std_logic_vector (n-1 downto 0);
begin

process (clk) begin
    if clk'event and clk = '1' then
        if reset = '1' then
            parallel_out_buff <= parallel_in;
        elsif enable = '1' then
            parallel_out_buff(3 downto 0) <= parallel_out_buff(31 downto 28);
            parallel_out_buff(31 downto 4) <= parallel_out_buff(27 downto 0);
        end if;
    end if;
end process;

parallel_out <= parallel_out_buff;

end behavioral;