# Hamming Distance Program

This program calculates the Hamming distance between two input strings using x86-64 assembly.

The Hamming distance is the number of bit positions that are different between two strings. The program compares the strings one character at a time, uses XOR to find which bits are different, and then counts those different bits.

If the two strings have different lengths, the program only compares up to the length of the shorter string.

## Files

- `Lab3_hamming_distance.s` - Assembly source code
- `README.md` - Project information

## Compile

```bash
as Lab3_hamming_distance.s -o Lab3_hamming_distance.o
ld Lab3_hamming_distance.o -o Lab3_hamming_distance