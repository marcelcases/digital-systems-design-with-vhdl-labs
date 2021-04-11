----------------------------------------------------------------------------------
-- Component: Full Adder (from half adders)
-- @marcelcases
-- 26.09.2018
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity full_adder is
    port (  a_fa : in std_logic;
            b_fa : in std_logic;
            cin_fa : in std_logic ;
            sum_fa : out std_logic;
            cout_fa : out std_logic
            );
end full_adder;

architecture Behavioral of full_adder is

    component half_adder
        port (  a : in std_logic;
                b : in std_logic;
                sum : out std_logic;
                cout : out std_logic
                );
    end component;

    signal sum1, cout1, cout2 : std_logic;

begin

ha1 : half_adder
    port map (  a => a_fa,
                b => b_fa,
                sum => sum1,
                cout => cout1
                );

ha2 : half_adder
    port map (  a => sum1,
                b => cin_fa,
                sum => sum_fa,
                cout => cout2
                );

ha3 : half_adder
    port map (  a => cout1,
                b => cout2,
                sum => cout_fa
                );



--cout <= cout1 or cout2;

end Behavioral;