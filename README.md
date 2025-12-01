# silenceEraser — Automated Silence Removal for Speech & Audio

[![License MIT](https://img.shields.io/badge/License-MIT-green)](LICENSE)
![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%2B-orange?style=flat-square)
![DSP](https://img.shields.io/badge/DSP-Silence%20Detection%20%26%20Gating-blue?style=flat-square)
![Audio Editing](https://img.shields.io/badge/Audio%20Editing-Silence%20Removal-lightgrey?style=flat-square)

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

  
