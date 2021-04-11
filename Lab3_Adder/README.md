---
layout: post
title: 'A two bit adder in VHDL'
author: marcel
category: projects
tags: vhdl fpga
published: true
date: 2018-10-03 15:00:00 +03:00
---

## Introduction
This project consists in the design and implementation of a digital **two bit adder**. To do this, two methods are used. The first is using **VHDL code** only and a full adder and a **half adder as components**. The other is using a Xininx's Vivado feature named **Block Design**.

## Workflow
The hardware description of the two bit adder has been developed using two methods. The first is using only VHDL code and two components, a half-adder and a full-adder, that are instantiated in the top level. The other method is using a Xilinx's Vivado feature named Block Design as the top level file.

## Contents
```
1 Introduction . . . . . . . . . . . . . . . . . 1
1.1 Aim  . . . . . . . . . . . . . . . . . . . . 1
1.2 Background . . . . . . . . . . . . . . . . . 1
2 Workflow . . . . . . . . . . . . . . . . . . . 3
2.1 VHDL-based top level . . . . . . . . . . . . 3
2.1.1 Libraries . . . . . . . . . . . . . . . . .3
2.1.2 Entity . . . . . . . . . . . . . . . . . . 3
2.1.3 Architecture . . . . . . . . . . . . . . . 3
2.1.4 Components . . . . . . . . . . . . . . . . 4
2.2 Block Design-based top level . . . . . . . . 6
2.3 Testbench . . . . . . . . . . . . . . . . . .7
3 Results and discussion . . . . . . . . . . . . 8
3.1 Simulation . . . . . . . . . . . . . . . . . 8
3.2 RTL analysis . . . . . . . . . . . . . . . . 8
3.3 Synthesis analysis . . . . . . . . . . . . . 9
4 Conclusion . . . . . . . . . . . . . . . . . .11
References . . . . . . . . . . . . . . . . . . .12
```

Check out the [report](report.pdf)
