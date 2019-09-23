# Image Compression Data Mining

This system has been created to perform improved compression using Data Mining Algorithms.

### Running Instructions:
1. `Jepeg_Haufmann.m` - > This performs the jpeg compression
2. `testf2.m` -> This performs the pattern mining and huffman encoding
3. `decode.m` -> This performs the decoding
4. `combine.m` -> This combines all the files
5. `measures.m` -> This provides the metrics

###    Algorithms used:
1. JPEG Compression
2. ARM - Apriori Algorithm
3. FP Huffmann Encoding and Decoding

#### Software: MATLAB 2014a

### Steps:
1. Image converted to matrix
2. Algorithms run over dataset
3. Output image regained from matrix

Efficiency = 85.6 % with reference to exisiting system
Ideal image size: 
1. 8X8
2. 16X16
3. 32X32
4. 64X64
5. 128X128
6. 256X256
7. 512X512

Not ideal for Large sized images

Citation:

If you use this code in your work then please cite the paper - [Lossy Image Compression using Frequent Pattern Mining based Huffman Encoding](https://ieeexplore.ieee.org/abstract/document/8487850) with the following:
```
@INPROCEEDINGS{8487850, 
author={S. {Biswas} and N. {Chennu} and H. {Valveti} and C. {Oswald} and B. {Sivaselvan}}, 
booktitle={2017 14th IEEE India Council International Conference (INDICON)}, 
title={Lossy Image Compression using Frequent Pattern Mining based Huffman Encoding}, 
year={2017}, 
volume={}, 
number={}, 
pages={1-6}, 
keywords={data compression;data mining;discrete cosine transforms;Huffman codes;image coding;runlength codes;frequent pattern mining;lossy compression techniques;lossless compression techniques;lossy algorithms;lossless algorithms;modified DCT algorithm;decoding;modified run-length encoding;compression ratio;image quality;lossy image compression;Huffman encoding;Image coding;Transform coding;Matrix converters;Discrete cosine transforms;Quantization (signal);Data mining;Itemsets;Lossy algorithm;Modified DCT algorithm;Compression ratio;Frequent Pattern Mining;Huffman Encoding;PSNR}, 
doi={10.1109/INDICON.2017.8487850}, 
ISSN={2325-9418}, 
month={Dec},}
```
