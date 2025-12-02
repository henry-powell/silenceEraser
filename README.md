# silenceEraser — Automated Silence Removal for Speech & Audio

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%2B-orange.svg)](https://www.mathworks.com/products/matlab.html)
[![Audio DSP](https://img.shields.io/badge/Focus-Audio%20DSP-blue.svg)](#)
![Portfolio Project](https://img.shields.io/badge/Project-Type%3A%20Portfolio-0057b7.svg)
[![Silence Detection](https://img.shields.io/badge/Topic-Silence%20Detection%20%26%20Gating-9cf.svg)](#)
![Audio Toolbox](https://img.shields.io/badge/Audio%20Toolbox-Enabled-purple.svg)
![Grad Program](https://img.shields.io/badge/Grad_Program-Audio_Technology_(M.A.)-6a1b9a.svg)
![University](https://img.shields.io/badge/American_University-Washington,_DC-002855.svg)

silenceEraser is a frame-based MATLAB function that removes silence and near-silence from an audio signal using RMS amplitude thresholding. The design 
focuses on transparent audio cleanup rather than aggressive gating, preserving natural timing while eliminating non-informative regions.

---

### DSP Concepts Implemented
- Frame slicing and buffer-based audio processing.  
- RMS amplitude measurement and dB conversion.  
- Conditional frame retention based on thresholding.  
- Signal reconstruction with index-accurate frame placement.  

---

### Usage Example
```matlab
[x, fs] = audioread("yourAudio.wav");
frameDuration = 0.02;      % 20 ms
thresholdDB = -35;         % silence cutoff

y = silenceEraser(x, fs, frameDuration, thresholdDB);
sound(y, fs);
```

---

### Repository Contents
| File               | Description                        |
|-------------------|------------------------------------|
| silenceEraser.m    | Main DSP function                  |
| demo_silenceEraser.m | Example script demonstrating usage |

---

### Development Environment
- MATLAB R2025a Update 1 (64-bit, macOS)
- Audio Toolbox enabled

---

### Engineering Relevance
This project demonstrates implementation of DSP algorithms from first principles, without relying on built-in audio cleanup tools. It reflects skills 
relevant to audio software engineering, plugin development, adaptive/interactive audio systems, and machine-learning preprocessing pipelines.

  
