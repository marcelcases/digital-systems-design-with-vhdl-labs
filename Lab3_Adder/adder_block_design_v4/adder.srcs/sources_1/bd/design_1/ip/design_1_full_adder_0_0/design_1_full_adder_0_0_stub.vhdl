-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Wed Oct  3 18:14:45 2018
-- Host        : ICT-50130K running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               p:/Lab3_Adder/Lab3_Adder/adder_block_design_v2/adder.srcs/sources_1/bd/design_1/ip/design_1_full_adder_0_0/design_1_full_adder_0_0_stub.vhdl
-- Design      : design_1_full_adder_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_full_adder_0_0 is
  Port ( 
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    cin : in STD_LOGIC;
    sum : out STD_LOGIC;
    cout : out STD_LOGIC
  );

end design_1_full_adder_0_0;

architecture stub of design_1_full_adder_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a,b,cin,sum,cout";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "full_adder,Vivado 2018.2";
begin
end;
