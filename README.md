<p align="center">
    <a href="https://github.com/luowensheng"><img src="https://i.ibb.co/K76QxJ0/logo-size.jpg"></a>
</p>

<h3 align="center">Digital Image Processing:</h3>
<h1 align="center">Image Coding and Image Permutation</h1>

<p align="center">
    <a href="https://www.mathworks.com/products/matlab.html"><img src="https://img.shields.io/badge/Made with-MATLAB-blue.svg"></a>
    <a href="https://github.com/luowensheng/-DIP-Image-Coding-and-Image-Permutation_/pulse"><img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg"></a>
    <a href="https://github.com/luowensheng"><img src="https://badges.frapsoft.com/os/v2/open-source.svg?v=103"></a>

<p align="center">
  <a href="#Introduction">Introduction</a> •
  <a href="#Tasks">Tasks</a> •
  <a href="#Implementation-and-Results">Implementation and Results</a> •
  <a href="#Conclusion">Conclusion</a> •
  <a href="#Questions">Questions</a>
</p>

___

# Introduction
[(Back to top :arrow_up_small:)](#Image-Coding-and-Image-Permutation)

This experiment is about **image compression**. Different algorithms had to be developed to perform different types of compressions on two images and calculate their entropy. Then, images that either had their rows shifted or their columns shifted were given, and some predictive coding algorithms was performed to recover the image.

# Tasks
[(Back to top :arrow_up_small:)](#Image-Coding-and-Image-Permutation)

### **Image Coding**
* Given the ```8-bits``` images, calculate the image entropy and horizontal difference image entropy.

* Given the ```8-bits``` images, compress the image with following methods:
1. Huffman Coding
2. Arithmetic Coding
3. LZW coding

    Compare the compression ratio difference in bit rate.

<img src="https://i.ibb.co/0j7Sc6p/1.jpg" alt="1" border="0"></a>


### **Image Permutation**
* The picture is an image that randomly shifted each row pixels with different bias, except for the first row which is same as the original image. Try to shift these pixels again to bring back the original image.

* Similar to the previous task, but instead randomly shifted each column, trying to recover the
image.

<img src="https://i.ibb.co/gt9WTJR/2.jpg" alt="2" width="350"></a><br /><br />

# Implementation and Results
[(Back to top :arrow_up_small:)](#Image-Coding-and-Image-Permutation)

### **Image Coding**
To perform this task, both images were turned into a ```1 x 256``` vector ranging gray level intensity from ```0 to 256```.

Each element of the vector stores the number of elements containing the associated gray values. All the elements with 0 gray values were taken away and divided the rest with the total number of elements to find the probability.

<h3 align="center"><b>HUFFMAN CODING</b></h3>
<p align="center"><b>Image 1:</p></b>
<p align="center"><img src="https://i.ibb.co/CWMVpCX/5.jpg" alt="5" border="0"></a></p>

<p align="center">A portion of the results from performing <i>Huffman coding</i> on Image 1:</p>

<p align="center"><img src="https://i.ibb.co/H77w3Pg/6.jpg" alt="6" border="0"></a></p>

<p align="center"><b>Image 2:</p></b>
<p align="center"><img src="https://i.ibb.co/C9YkFW7/3.jpg" alt="3" border="0"></a>

<p align="center">A portion of the results from performing <i>Huffman coding</i> on Image 2:</p>
<p align="center"><img src="https://i.ibb.co/nQ0GVdw/4.jpg" alt="4" border="0"></a><br /><br /></p>


<h3 align="center"><b>ARITHMETIC CODING</b></h3>
<p align="center"><b>Image 1:</p></b>

<p align="center">
    
```
arithmetic code for is the image = 8.4608e-09
>>
```
</p>

<p align="center"><b>Image 2:</p></b>
<p align="center">
    
```
arithmetic code for is the image = 1.3141e-10
>>
```
</p>

<h3 align="center"><b>LZW CODING</b></h3>
<p align="center"><b>Image 1:</p></b>

```
Column 3
    0.270588235294118
    0.270588235294118           0.266666666666667
    0.266666666666667           0.266666666666667
    0.266666666666667           0.270588235294118
    0.270588235294118           0.258823529411765
    0.258823529411765            0.27843137254902

Columns 1 through 2
    0.27843137254902            0.274509803921569

Column 3
    0.27843137254902 

Columns 1 through 2
```

<p align="center"><b>Image 2:</p></b>

```
Column 3
    0.313725490196078
    0.313725490196078           0.333333333333333
    0.333333333333333           0.349019607843137
    0.349019607843137           0.403921568627451
    0.403921568627451           0.513725490196078
    0.513725490196078           0.537254901960784
    0.537254901960784           0.545098039215686
    0.545098039215686           0.552941176470588
    0.552941176470588           0.549019607843137
    0.549019607843137            0.47843137254902
```
<br>

___
### **Image Permutation**
* Recover randomnly shifted rows of an image

![7](https://i.ibb.co/n0FDfQH/7.jpg)

* Recover randomnly shifted columns of an image

![8](https://i.ibb.co/BCSxLyc/8.jpg)


# Conclusion
[(Back to top :arrow_up_small:)](#Image-Coding-and-Image-Permutation)

The ```GUI```: 

![9](https://i.ibb.co/4NsGQfD/9.jpg)


# Reference
[(Back to top :arrow_up_small:)](#Image-Coding-and-Image-Permutation)

[1] [IEEE Manuscript Templates](http://www.ieee.org/conferences_events/conferences/publishing/templates.html).

# Questions
[(Back to top :arrow_up_small:)](#Image-Coding-and-Image-Permutation)

Submit your questions and bug reports [here](https://github.com/luowensheng/Natural-Language-Processing-Grammatical-Error-Correction-/issues).

