--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
--Date        : Sun Oct 28 19:04:34 2018
--Host        : DESKTOP-KUDOBOV running 64-bit major release  (build 9200)
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
    a_bus : in STD_LOGIC_VECTOR ( 1 downto 0 );
    b_bus : in STD_LOGIC_VECTOR ( 1 downto 0 );
    carry : out STD_LOGIC;
    sum_bus : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1 : entity is "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=5,numReposBlks=5,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=5,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
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
  component design_1_bus_to_bits_0_0 is
  port (
    bus_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
    bit_out1 : out STD_LOGIC;
    bit_out0 : out STD_LOGIC
  );
  end component design_1_bus_to_bits_0_0;
  component design_1_bus_to_bits_1_0 is
  port (
    bus_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
    bit_out1 : out STD_LOGIC;
    bit_out0 : out STD_LOGIC
  );
  end component design_1_bus_to_bits_1_0;
  component design_1_bits_to_bus_0_0 is
  port (
    bit_in1 : in STD_LOGIC;
    bit_in0 : in STD_LOGIC;
    bus_out : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  end component design_1_bits_to_bus_0_0;
  signal bits_to_bus_0_output : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal bus_to_bits_0_output0 : STD_LOGIC;
  signal bus_to_bits_0_output1 : STD_LOGIC;
  signal bus_to_bits_1_output0 : STD_LOGIC;
  signal bus_to_bits_1_output1 : STD_LOGIC;
  signal full_adder_0_cout : STD_LOGIC;
  signal full_adder_0_sum : STD_LOGIC;
  signal half_adder_0_cout : STD_LOGIC;
  signal half_adder_0_sum : STD_LOGIC;
  signal input_0_1 : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal input_0_2 : STD_LOGIC_VECTOR ( 1 downto 0 );
begin
  carry <= full_adder_0_cout;
  input_0_1(1 downto 0) <= a_bus(1 downto 0);
  input_0_2(1 downto 0) <= b_bus(1 downto 0);
  sum_bus(1 downto 0) <= bits_to_bus_0_output(1 downto 0);
bits_to_bus_0: component design_1_bits_to_bus_0_0
     port map (
      bit_in0 => full_adder_0_sum,
      bit_in1 => half_adder_0_sum,
      bus_out(1 downto 0) => bits_to_bus_0_output(1 downto 0)
    );
bus_to_bits_0: component design_1_bus_to_bits_0_0
     port map (
      bit_out0 => bus_to_bits_0_output0,
      bit_out1 => bus_to_bits_0_output1,
      bus_in(1 downto 0) => input_0_1(1 downto 0)
    );
bus_to_bits_1: component design_1_bus_to_bits_1_0
     port map (
      bit_out0 => bus_to_bits_1_output0,
      bit_out1 => bus_to_bits_1_output1,
      bus_in(1 downto 0) => input_0_2(1 downto 0)
    );
full_adder_0: component design_1_full_adder_0_0
     port map (
      a => bus_to_bits_0_output0,
      b => bus_to_bits_1_output0,
      cin => half_adder_0_cout,
      cout => full_adder_0_cout,
      sum => full_adder_0_sum
    );
half_adder_0: component design_1_half_adder_0_0
     port map (
      a => bus_to_bits_0_output1,
      b => bus_to_bits_1_output1,
      cout => half_adder_0_cout,
      sum => half_adder_0_sum
    );
end STRUCTURE;
