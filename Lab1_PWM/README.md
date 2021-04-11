---
layout: post
title: 'A PWM generator in VHDL'
author: marcel
category: projects
tags: vhdl fpga
published: true
date: 2018-11-14 15:00:00 +03:00
---

## Function
The following VHDL code describes a **PWM signal generator** that works at an output frequency of approximately 1kHz and has a duty cycle that can be configured through the n-bit input port *duty*.

## VHDL code
```vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pwm is
    generic (   n : integer := 10; -- 1024 bit resolution
                eoc : integer := 99
                );
    port (  clk, reset : in std_logic;
            duty : in std_logic_vector (n-1 downto 0);
            pwm_out : out std_logic
            );
end pwm;

architecture behavioral of pwm is
    signal comptador : integer range 0 to 2**n-1;
    signal comptador_clk_div : integer range 0 to eoc;
    signal clk_div : std_logic ;

begin

proc_clk_div : process (clk) begin
    if rising_edge(clk) then
        clk_div <= '0';
        if reset = '1' then
            comptador_clk_div <= 0;
        elsif comptador_clk_div = eoc then
            comptador_clk_div <= 0;
            clk_div <= '1';
        else comptador_clk_div <= comptador_clk_div + 1;
        end if;
    end if;
end process;

proc_comptador : process (clk_div) is begin
    if rising_edge(clk_div) then
        if reset = '1' then
            comptador <= 0;
        elsif comptador = 2**n-2 then
            comptador <= 0;
        else
            comptador <= comptador + 1;
        end if;
    end if;
end process;

pwm_out <= '1' when comptador < to_integer(unsigned(duty)) else '0';

end behavioral;
```

## Testbench
```vhdl
library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pwm_tb is
    generic (   n : integer := 10;
                eoc : integer := 99
                );
end pwm_tb;

architecture bench of pwm_tb is
    component  pwm is
        generic (   n : integer;
                    eoc : integer
                    );
        port (  clk, reset : in std_logic;
                duty : in std_logic_vector (n-1 downto 0);
                pwm_out : out std_logic
                );
    end component ;

    signal clk_tb : std_logic := '0';
    signal reset_tb : std_logic := '1';
    signal duty_tb : std_logic_vector (n-1 downto 0);
    signal pwm_out_tb : std_logic;
        
begin

uut: pwm
    generic map (   n => 10,
                    eoc => 99
                    )
    port map (  clk => clk_tb,
                reset => reset_tb,
                duty => duty_tb,
                pwm_out => pwm_out_tb
                );

clk_tb <= not clk_tb after 5ns; --half_period
reset_tb <= '0' after 10ns;
--duty_tb <= b"0000000000"; -- 0% duty cycle
duty_tb <= b"0111111111"; -- 50% duty cycle
--duty_tb <= b"1111111111"; -- 100% duty cycle

end bench;
```
