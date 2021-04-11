--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
--Date        : Wed Oct  3 16:50:00 2018
--Host        : ICT-50130K running 64-bit major release  (build 9200)
--Command     : generate_target full_adder.bd
--Design      : full_adder
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity full_adder is
  port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    cin : in STD_LOGIC;
    cout : out STD_LOGIC;
    sum : out STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of full_adder : entity is "full_adder,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=full_adder,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=3,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of full_adder : entity is "full_adder.hwdef";
end full_adder;

architecture STRUCTURE of full_adder is
  component full_adder_half_adder_0_0 is
  port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    sum : out STD_LOGIC;
    cout : out STD_LOGIC
  );
  end component full_adder_half_adder_0_0;
  component full_adder_half_adder_0_1 is
  port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    sum : out STD_LOGIC;
    cout : out STD_LOGIC
  );
  end component full_adder_half_adder_0_1;
  component full_adder_half_adder_0_2 is
  port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    sum : out STD_LOGIC;
    cout : out STD_LOGIC
  );
  end component full_adder_half_adder_0_2;
  signal a_0_1 : STD_LOGIC;
  signal b_0_1 : STD_LOGIC;
  signal b_0_2 : STD_LOGIC;
  signal half_adder_0_sum : STD_LOGIC;
  signal half_adder_1_cout : STD_LOGIC;
  signal half_adder_1_sum : STD_LOGIC;
  signal half_adder_2_cout : STD_LOGIC;
  signal half_adder_2_sum : STD_LOGIC;
  signal NLW_half_adder_0_cout_UNCONNECTED : STD_LOGIC;
begin
  a_0_1 <= a;
  b_0_1 <= b;
  b_0_2 <= cin;
  cout <= half_adder_0_sum;
  sum <= half_adder_1_sum;
half_adder_0: component full_adder_half_adder_0_0
     port map (
      a => half_adder_2_cout,
      b => half_adder_1_cout,
      cout => NLW_half_adder_0_cout_UNCONNECTED,
      sum => half_adder_0_sum
    );
half_adder_1: component full_adder_half_adder_0_1
     port map (
      a => half_adder_2_sum,
      b => b_0_2,
      cout => half_adder_1_cout,
      sum => half_adder_1_sum
    );
half_adder_2: component full_adder_half_adder_0_2
     port map (
      a => a_0_1,
      b => b_0_1,
      cout => half_adder_2_cout,
      sum => half_adder_2_sum
    );
end STRUCTURE;
