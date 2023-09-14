# RISC-V-Single-Cycle
This documentation outlines our data path configuration for a single-cycle RISC-V processor implementation. Within this document, we provide a comprehensive explanation of the instructions supported by our code, considering that our presented data path includes the essential hardware components necessary to handle various RISC-V instructions. Additionally, at the conclusion of the document, you will find a detailed description of our project's design, which was created using the VIVADO tool.

A RISC-V single-cycle processor is a computer processor designed based on the RISC-V architecture, which stands for Reduced Instruction Set Computing. The RISC-V architecture is an open standard instruction set architecture (ISA) that is becoming increasingly popular due to its simplicity and versatility.

In a single-cycle processor design, each instruction is executed in a single clock cycle. This means that the cycle time hasto be enough to complete all the instruction stages such as fetch, decode, execute, and write back, they’re all completed within a single clock cycle. 
While single-cycle processors may not be the most efficient in terms of performance, they serve as an excellent starting point for understanding computer architecture and processor design principles. The key characteristic of a RISC-V processor is the modular ISA it has. This modularity makes the hardware design much simpler as we will illustrate.

Supported Instructions:
1. R-type instructions
2. I-type instructinss
3. S-type instructions
4. SB-type instructions
5. U-type instructions
6. UJ-type instructions
