--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
--Date        : Wed Oct  3 18:10:18 2018
--Host        : ICT-50130K running 64-bit major release  (build 9200)
--Command     : generate_target design_1.bd
--Design      : design_1
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1 is
  port (
    a_0 : in STD_LOGIC;
    a_1 : in STD_LOGIC;
    b_0 : in STD_LOGIC;
    b_1 : in STD_LOGIC;
    cout_0 : out STD_LOGIC;
    sum_0 : out STD_LOGIC;
    sum_1 : out STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1 : entity is "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=2,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of design_1 : entity is "design_1.hwdef";
end design_1;

architecture STRUCTURE of design_1 is
  component design_1_full_adder_0_0 is
  port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    cin : in STD_LOGIC;
    sum : out STD_LOGIC;
    cout : out STD_LOGIC
  );
  end component design_1_full_adder_0_0;
  component design_1_half_adder_0_0 is
  port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    sum : out STD_LOGIC;
    cout : out STD_LOGIC
  );
  end component design_1_half_adder_0_0;
  signal a_0_1 : STD_LOGIC;
  signal a_1_1 : STD_LOGIC;
  signal b_0_1 : STD_LOGIC;
  signal b_1_1 : STD_LOGIC;
  signal full_adder_0_cout : STD_LOGIC;
  signal full_adder_0_sum : STD_LOGIC;
  signal half_adder_0_cout : STD_LOGIC;
  signal half_adder_0_sum : STD_LOGIC;
begin
  a_0_1 <= a_0;
  a_1_1 <= a_1;
  b_0_1 <= b_0;
  b_1_1 <= b_1;
  cout_0 <= full_adder_0_cout;
  sum_0 <= half_adder_0_sum;
  sum_1 <= full_adder_0_sum;
full_adder_0: component design_1_full_adder_0_0
     port map (
      a => a_1_1,
      b => b_1_1,
      cin => half_adder_0_cout,
      cout => full_adder_0_cout,
      sum => full_adder_0_sum
    );
half_adder_0: component design_1_half_adder_0_0
     port map (
      a => a_0_1,
      b => b_0_1,
      cout => half_adder_0_cout,
      sum => half_adder_0_sum
    );
end STRUCTURE;
