--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
--Date        : Wed Oct  3 17:33:50 2018
--Host        : ICT-50130K running 64-bit major release  (build 9200)
--Command     : generate_target adder_wrapper.bd
--Design      : adder_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity adder_wrapper is
  port (
    a0 : in STD_LOGIC;
    a1 : in STD_LOGIC;
    b0 : in STD_LOGIC;
    b1 : in STD_LOGIC;
    carry : out STD_LOGIC;
    sum0 : out STD_LOGIC;
    sum1 : out STD_LOGIC
  );
end adder_wrapper;

architecture STRUCTURE of adder_wrapper is
  component adder is
  port (
    a0 : in STD_LOGIC;
    b0 : in STD_LOGIC;
    a1 : in STD_LOGIC;
    b1 : in STD_LOGIC;
    sum0 : out STD_LOGIC;
    carry : out STD_LOGIC;
    sum1 : out STD_LOGIC
  );
  end component adder;
begin
adder_i: component adder
     port map (
      a0 => a0,
      a1 => a1,
      b0 => b0,
      b1 => b1,
      carry => carry,
      sum0 => sum0,
      sum1 => sum1
    );
end STRUCTURE;
