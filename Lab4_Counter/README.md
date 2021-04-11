---
layout: post
title: 'An up-counter in VHDL'
author: marcel
category: projects
tags: vhdl fpga
published: true
date: 2018-10-10 15:00:00 +03:00
---

## Introduction
This project consists in the design and implementation of a digital **up-counter** on a FPGA board. A signal from a physical push-button is **filtered** through a **debouncer** and an **edge detector** and is used in a counter process to increment one unit each time the button is pushed. The current value of the counter is shown on the board's LEDs in a binary form.

## Workflow
The hardware description of the counter consists in two **components** (debouncing and edge-detection) and a **process** (up-counter). They **run concurrently** one another.

## Contents
```
1 Introduction . . . . . . . . . . . . . . . . 1
1.1 Aim  . . . . . . . . . . . . . . . . . . . 1
1.2 Background . . . . . . . . . . . . . . . . 1
1.2.1 Debouncing . . . . . . . . . . . . . . . 1
1.2.2 Edge detection . . . . . . . . . . . . . 2
2 Workflow . . . . . . . . . . . . . . . . . . 3
2.1 Debouncing component . . . . . . . . . . . 3
2.1.1 Clock divider component  . . . . . . . . 4
2.2 Edge-detection component . . . . . . . . . 4
2.3 Up-counter process . . . . . . . . . . . . 5
2.4 Top level file . . . . . . . . . . . . . . 5
2.4.1 Libraries  . . . . . . . . . . . . . . . 5
2.4.2 Entity . . . . . . . . . . . . . . . . . 6
2.4.3 Architecture . . . . . . . . . . . . . . 6
3 Results and discussion . . . . . . . . . . . 8
4 Conclusion . . . . . . . . . . . . . . . . . 9
```

Check out the [report](report.pdf)
