---
layout: post
session: 5
title: 'A creeping line in VHDL'
author: marcel
category: projects
tags: vhdl fpga
published: true
date: 2018-10-17 15:00:00 +03:00
featured: true
---

# Lab 5: A creeping line in VHDL

## Introduction

This project consists in the design, simulation and implementation in VHDL of a **creeping line**. The content will be multiplexed and **shown on the 7-segment displays** of the Nexys 4 board.

## Workflow

The hardware description of the creeping line consists in components and concurrent statements that run together at the top level of the project. They are a **32-bit shift register**, a **clock divider**, an **up-counter** and a **look-up table**. A **testbench** is described in order to perform a **simulation**.

## Contents

```
1 Introduction . . . . . . . . . . . . . . . . . 1
1.1 Aim  . . . . . . . . . . . . . . . . . . . . 1
1.2 Background . . . . . . . . . . . . . . . . . 1
2 Workflow . . . . . . . . . . . . . . . . . . . 3
2.1 Top level file . . . . . . . . . . . . . . . 3
2.1.1 Libraries  . . . . . . . . . . . . . . . . 3
2.1.2 Entity . . . . . . . . . . . . . . . . . . 3
2.1.2.1 Using switches . . . . . . . . . . . . . 3
2.1.2.2 Using a shift register . . . . . . . . . 3
2.1.3 Architecture . . . . . . . . . . . . . . . 4
2.1.3.1 Using switches . . . . . . . . . . . . . 4
2.1.3.2 Using a shift register . . . . . . . . . 5
2.2 Components . . . . . . . . . . . . . . . . . 7
2.2.1 Decoder  . . . . . . . . . . . . . . . . . 7
2.2.2 Clock Divider  . . . . . . . . . . . . . . 8
2.2.3 Shift Register . . . . . . . . . . . . . . 8
2.3 Testbench  . . . . . . . . . . . . . . . . . 9
3 Results and discussion . . . . . . . . . . . .10
3.1 Simulation . . . . . . . . . . . . . . . . .10
4 Conclusion . . . . . . . . . . . . . . . . . .11
References . . . . . . . . . . . . . . . . . . .12
```

## Report

Check out the [report](report.pdf)
