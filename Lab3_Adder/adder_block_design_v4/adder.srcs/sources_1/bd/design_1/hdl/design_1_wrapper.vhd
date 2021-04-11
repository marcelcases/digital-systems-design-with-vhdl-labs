--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
--Date        : Sun Oct 28 19:04:34 2018
--Host        : DESKTOP-KUDOBOV running 64-bit major release  (build 9200)
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
    a_bus : in STD_LOGIC_VECTOR ( 1 downto 0 );
    b_bus : in STD_LOGIC_VECTOR ( 1 downto 0 );
    carry : out STD_LOGIC;
    sum_bus : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    carry : out STD_LOGIC;
    a_bus : in STD_LOGIC_VECTOR ( 1 downto 0 );
    b_bus : in STD_LOGIC_VECTOR ( 1 downto 0 );
    sum_bus : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      a_bus(1 downto 0) => a_bus(1 downto 0),
      b_bus(1 downto 0) => b_bus(1 downto 0),
      carry => carry,
      sum_bus(1 downto 0) => sum_bus(1 downto 0)
    );
end STRUCTURE;
