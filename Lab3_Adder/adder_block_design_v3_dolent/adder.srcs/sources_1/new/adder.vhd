
-- Two bit adder
-- @marcelcases
-- 26.09.2018 - 03.0.2018

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity adder is
    port (  a,b : in std_logic_vector (1 downto 0);
            sum : out std_logic_vector (1 downto 0);
            carry : out std_logic 
            );
end adder;


architecture Behavioral of adder is

    component half_adder
        port (  a : in std_logic;
                b : in std_logic;
                sum : out std_logic;
                cout : out std_logic
                );
    end component;
    
    component full_adder is
        port (  a : in std_logic;
                b : in std_logic;
                cin : in std_logic ;
                sum : out std_logic;
                cout : out std_logic
                );
    end component;
    
    signal carry_internal : std_logic;

begin

ha : half_adder
    port map (  a => a(0),
                b => b(0),
                sum  => sum(0),
                cout  => carry_internal
                );
                
fa : full_adder
    port map (  a => a(1),
                b => b(1),
                cin => carry_internal,
                sum  => sum(1),
                cout  => carry
                );

end Behavioral;
