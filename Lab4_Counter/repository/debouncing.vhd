----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:53:22 01/25/2013 
-- Design Name: 
-- Module Name:    debouncing - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
-- Circuit de "debouncing" per a pulsadors en un sistema. Inclou un retard de 40ms on els polsos de l'entrada
-- seran considerats com a glitch o soroll.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debouncing is
    Port ( sw : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  tick : out STD_LOGIC);
           --db : out  STD_LOGIC);
end debouncing;

architecture fsmd_arch of debouncing is

	constant n: integer :=21;
	type state_type is (zero, wait0, one, wait1);
	signal state_reg, state_next: state_type;
	signal q_reg, q_next: unsigned(n-1 downto 0);

begin

--FSMD state & data registers

	process (clk, reset) begin
		if reset = '1' then
			state_reg <= zero;
			q_reg <= (others =>'0');
		elsif	(clk'event and clk = '1') then
			state_reg <= state_next;
			q_reg <= q_next;
		end if;
	end process;
	
-- next-state logic & data path functional units/routing

	process (state_reg, q_reg, sw, q_next) begin
		state_next <= state_reg;
		q_next <= q_reg;
		tick <= '0';
		case state_reg is
			when zero =>
				--db <= '0';
				if (sw = '1') then
					state_next <= wait1;
					q_next <= (others => '1');
				end if;
			when wait1 =>
				--db <= '0';
				if (sw = '1') then
					q_next <= q_reg - 1;
					if (q_next = 0) then
						state_next <= one;
						tick <= '1';
					end if;
				else state_next <= zero;
				end if;
			when one =>
				--db <= '1';
				if (sw = '0') then
					state_next <= wait0;
					q_next <= (others => '1');
				end if;
			when wait0 =>
				--db <= '1';
				if (sw = '0') then
					q_next <= q_reg - 1;
					if (q_next = 0) then
						state_next <= zero;
					end if;
				else state_next <= one;
				end if;
		end case;
	end process;
				

end fsmd_arch;
