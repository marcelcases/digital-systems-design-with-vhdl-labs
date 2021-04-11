--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
--Date        : Wed Oct  3 18:13:28 2018
--Host        : ICT-50130K running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    a0 : in STD_LOGIC;
    a1 : in STD_LOGIC;
    b0 : in STD_LOGIC;
    b1 : in STD_LOGIC;
    carry : out STD_LOGIC;
    sum0 : out STD_LOGIC;
    sum1 : out STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    a0 : in STD_LOGIC;
    b0 : in STD_LOGIC;
    sum0 : out STD_LOGIC;
    a1 : in STD_LOGIC;
    b1 : in STD_LOGIC;
    carry : out STD_LOGIC;
    sum1 : out STD_LOGIC
  );
  end component design_1;
begin
design_1_i: component design_1
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
