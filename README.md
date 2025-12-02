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

## How to Use
1. Set the target audio file inside the script:
   ```matlab
   fileName = "yourAudio.wav";
   ```
2.	Modify the frame length and hop size if needed:
    ```
    N = 1024;
    hop = 512;
3.	Run the script. The silenceEraser function will:
      - split the audio into frames,
      - compute frame-level energy values,
      - identify silence based on a threshold,
      - remove silent frames automatically.
4.	Optional tuning:
      - lower the silence threshold for soft speech / whisper content
      - increase the threshold for noisy room recordings
5.	Listen to the output or export to disk depending on your implementation (e.g., audiowrite() or sound()).

---


### Development Environment
- MATLAB R2025a Update 1 (64-bit, macOS)
- Audio Toolbox enabled

---

### Engineering Relevance
This project demonstrates implementation of DSP algorithms from first principles, without relying on built-in audio cleanup tools. It reflects skills 
relevant to audio software engineering, plugin development, adaptive/interactive audio systems, and machine-learning preprocessing pipelines.

---

## Requirements

- MATLAB R2023b or later
- Audio Toolbox recommended
- Tested using:
  - N = 1024
  - hop = 512
  - Mono .wav input (44.1 kHz)
  - Amplitude threshold: –35 dB (suggested starting point)
- Threshold values between –25 dB and –45 dB work well for most voice recordings.
 
---

## Real-World Applications
- **Podcast & voiceover production** — removes long pauses automatically and speeds up editing time.
- **Audiobook mastering** — tightens pacing while preserving natural conversational flow.
- **Film & TV post-production** — clears dead room tone between dialogue lines before EQ and compression.
- **Broadcast / livestream workflows** — prevents “dead air” during interviews or commentary segments.
- **Speech analytics / call-center audio** — trims silent segments before running speech-to-text analysis.
- **Machine learning / AI training datasets** — cleans and normalizes speech samples before model training.
- **Accessibility tools** — improves clarity of synthesized speech segments used in assistive technologies.

---
© Henry Powell — Audio DSP Development

  
