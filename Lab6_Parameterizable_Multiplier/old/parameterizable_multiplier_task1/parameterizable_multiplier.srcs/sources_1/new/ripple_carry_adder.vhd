----------------------------------------------------------------------------------
-- Component: Ripple Carry Adder
-- @marcelcases
-- 31.10.2018
-------------------------------------------------------------------------------


library ieee; 
use ieee.std_logic_1164.all;


entity ripple_carry_adder is
    generic (   data_width : integer := 4
                );
    port (  a, b: in std_logic_vector (data_width-1 downto 0);
            cin: in std_logic;
            s: out std_logic_vector (data_width-1 downto 0);
            cout: out std_logic
            );
end ripple_carry_adder;


architecture Behavioral of ripple_carry_adder is

    -- Component *FULL ADDER*
    component full_adder is
        port (  a_fa : in std_logic;
                b_fa : in std_logic;
                cin_fa : in std_logic ;
                sum_fa : out std_logic;
                cout_fa : out std_logic
                );
    end component;
    
    signal carry_int: std_logic_vector (data_width-1 downto 0);

begin

-- http://www.ece.ualberta.ca/~elliott/ee552/studentAppNotes/1999f/Useful_components/templates.html
gen_full_adder : for i in data_width-1 downto 0 generate
    least_significant_bit : if i = 0 generate 
        inst_fa : full_adder
            port map (  a_fa => a(0),
                        b_fa => b(0),
                        cin_fa => cin,
                        sum_fa  => s(0),
                        cout_fa  => carry_int(0)
                        );
    end generate ;
    other_bits : if i > 0 generate 
        inst_fa : full_adder
            port map (  a_fa => a(i),
                        b_fa => b(i),
                        cin_fa => carry_int(i-1),
                        sum_fa  => s(i),
                        cout_fa  => carry_int(i)
                        );
    end generate ;
end generate gen_full_adder;

most_significant_bit : cout <= carry_int(data_width-1);

end Behavioral;
