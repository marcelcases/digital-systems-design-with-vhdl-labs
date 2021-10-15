---
layout: post
session: 6
title: 'A parameterizable multiplier in VHDL'
author: marcel
category: projects
tags: vhdl fpga
published: true
date: 2018-11-07 15:00:00 +03:00
featured: true
---

# Lab 6: A parameterizable multiplier in VHDL

## Introduction

This project consists in the design, simulation and implementation in VHDL of a parameterizable multiplier using **generate** and **for statements** and **structural design**. Given a number *data_width*, the synthesizer will reconfigure itself in order to perform a multiplication using *data_width* switches by *data_width* switches. The result will be shown on four 7-segment displays in hexadecimal.

## Workflow

The hardware description of the parameterizable multiplier consists in components and concurrent statements that run together at the top level of the project. They are a **Ripple Carry Adder** instantiated *data_width - 1* times; and a decoder, a clock divider and an up-counter to show the results on the 7-segment displays. A testbench is described in order to perform a simulation.

## Contents

```
1 Introduction . . . . . . . . . . . . . . . . . 1
1.1 Aim  . . . . . . . . . . . . . . . . . . . . 1
1.2 Background . . . . . . . . . . . . . . . . . 1
2 Workflow . . . . . . . . . . . . . . . . . . . 3
2.1 Top level file . . . . . . . . . . . . . . . 3
2.1.1 Libraries  . . . . . . . . . . . . . . . . 3
2.1.2 Entity . . . . . . . . . . . . . . . . . . 3
2.1.3 Architecture . . . . . . . . . . . . . . . 3
2.2 Components . . . . . . . . . . . . . . . . . 6
2.2.1 Ripple Carry Adder  . . . . . . . . . . . .6
2.2.2 Clock Divider and Decoder  . . . . . . . . 7
2.2.3 Full Adder from three Half Adders . . . . .7
2.3 Testbench  . . . . . . . . . . . . . . . . . 8
3 Results and discussion . . . . . . . . . . . .10
3.1 Simulation . . . . . . . . . . . . . . . . .10
4 Conclusion . . . . . . . . . . . . . . . . . .11
References . . . . . . . . . . . . . . . . . . .12
```

## Report

Check out the [report](report.pdf)
