--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
--Date        : Wed Oct  3 17:33:50 2018
--Host        : ICT-50130K running 64-bit major release  (build 9200)
--Command     : generate_target adder.bd
--Design      : adder
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity adder is
  port (
    a0 : in STD_LOGIC;
    a1 : in STD_LOGIC;
    b0 : in STD_LOGIC;
    b1 : in STD_LOGIC;
    carry : out STD_LOGIC;
    sum0 : out STD_LOGIC;
    sum1 : out STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of adder : entity is "adder,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=adder,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=4,numReposBlks=4,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=4,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of adder : entity is "adder.hwdef";
end adder;

architecture STRUCTURE of adder is
  component adder_half_adder_0_0 is
  port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    sum : out STD_LOGIC;
    cout : out STD_LOGIC
  );
  end component adder_half_adder_0_0;
  component adder_half_adder_1_0 is
  port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    sum : out STD_LOGIC;
    cout : out STD_LOGIC
  );
  end component adder_half_adder_1_0;
  component adder_half_adder_2_0 is
  port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    sum : out STD_LOGIC;
    cout : out STD_LOGIC
  );
  end component adder_half_adder_2_0;
  component adder_half_adder_3_0 is
  port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    sum : out STD_LOGIC;
    cout : out STD_LOGIC
  );
  end component adder_half_adder_3_0;
  signal a_0_1 : STD_LOGIC;
  signal a_0_2 : STD_LOGIC;
  signal b_0_1 : STD_LOGIC;
  signal b_0_2 : STD_LOGIC;
  signal half_adder_0_sum : STD_LOGIC;
  signal half_adder_1_cout : STD_LOGIC;
  signal half_adder_1_sum : STD_LOGIC;
  signal half_adder_2_cout : STD_LOGIC;
  signal half_adder_2_sum : STD_LOGIC;
  signal half_adder_3_sum : STD_LOGIC;
  signal NLW_half_adder_0_cout_UNCONNECTED : STD_LOGIC;
  signal NLW_half_adder_3_cout_UNCONNECTED : STD_LOGIC;
begin
  a_0_1 <= a0;
  a_0_2 <= a1;
  b_0_1 <= b0;
  b_0_2 <= b1;
  carry <= half_adder_0_sum;
  sum0 <= half_adder_3_sum;
  sum1 <= half_adder_1_sum;
half_adder_0: component adder_half_adder_0_0
     port map (
      a => half_adder_2_cout,
      b => half_adder_1_cout,
      cout => NLW_half_adder_0_cout_UNCONNECTED,
      sum => half_adder_0_sum
    );
half_adder_1: component adder_half_adder_1_0
     port map (
      a => half_adder_2_sum,
      b => '0',
      cout => half_adder_1_cout,
      sum => half_adder_1_sum
    );
half_adder_2: component adder_half_adder_2_0
     port map (
      a => a_0_2,
      b => b_0_2,
      cout => half_adder_2_cout,
      sum => half_adder_2_sum
    );
half_adder_3: component adder_half_adder_3_0
     port map (
      a => a_0_1,
      b => b_0_1,
      cout => NLW_half_adder_3_cout_UNCONNECTED,
      sum => half_adder_3_sum
    );
end STRUCTURE;
