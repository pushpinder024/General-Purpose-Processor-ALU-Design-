# General-Purpose-Processor-ALU-Design-
📌 Project Overview
This repository contains the hardware design, simulation waveforms, hand calculations, and hardware verification for a custom General-Purpose Processor Arithmetic Logic Unit (ALU) coordinated by a Mealy-type Finite State Machine (FSM). The complete digital system was implemented and verified on an Altera DE2 FPGA board using Quartus II.

🛠️ System Architecture & Components

The datapath integrates multiple combinational and sequential digital logic components:   
. Latches (1 & 2): Positive-edge triggered 8-bit synchronous registers used to capture and hold input datasets A and B.  
. Finite State Machine (FSM): A Mealy-type FSM that drives the sequence of operations based on clock cycles and manual toggle switch inputs, outputting a 4-bit state code and a 4-bit student ID.   
. 4x16 Decoder: Translates the 4-bit state input from the FSM into a one-hot 16-bit OP code to instruct the ALU.   
. ALU Variants: ALU_1: Executes 9 standard arithmetic and Boolean logic operations (such as addition, subtraction, AND, OR, XOR, and complements).   
                ALU_2: Executes modified advanced bitwise operations, logical/arithmetic shifts, rotations (ROR/SHR), and bit-significance reversals.   
                ALU_3: Integrates a modified seven-segment display logic to evaluate whether the FSM student ID is odd or even, dynamically displaying characters 'y' or 'n'.
