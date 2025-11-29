%% silenceEraser
    % This script shows how to use the silenceEraser function.

clear; clc; clf, close all;

%% Step 1) Load an audio file (replace with your own file)
[x, Fs] = audioread('MyQoutes_Mono.wav');

    % If the file is stereo, turn it into mono by averaging left+right
 if size(x,2) > 1
     x = mean(x,2);
 end

%% Step 2) Set the parameters
frameDur = 0.050;   % frame duration = 50 ms
ampThresh   = -40;     % silence threshold in dB

%% Step 3) Run the silence eraser
y = silenceEraser(x, Fs, frameDur, ampThresh);  

%% Compute zeroCrossing rate for analysis
z = zeroCross(y);

%% Step 4) Plot the original and processed signals (first 12 seconds)
    % Calculate the number of samples for the time axis
N1 = min(length(x), 12*Fs);   % number of samples in 15 seconds (or less if file is short)
t1 = (0:N1-1)/Fs;            % time axis for original
N2 = min(length(y), 12*Fs);   % same idea for processed
t2 = (0:N2-1)/Fs;

subplot(2,1,1);
plot(t1, x(1:N1));
grid on;
title('Original');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(2,1,2);
 if ~isempty(y)
     plot(t2, y(1:N2));
 else
     plot(0,0); xlim([0, 12]); ylim([-1, 1]);
 end
grid on;
title('Silence removed');
xlabel('Time (s)'); ylabel('Amplitude');

%% Step 5) Listen to the processed audio
 if ~isempty(y)
     sound(y, Fs);
 else
     disp('Processed output is empty (all frames were below threshold).');
 end

%% Step 6) Save the processed audio to a file with a timestamp
outfn = "Powell_Henry_silenceErased.wav";
audiowrite(outfn, y, Fs);
fprintf('Exported file: %s\n', outfn);

%% Functions used in the script 

function frames = framesig(x, frameLen, skip)
% Ensure frameLen is positive and skip is non-negative
 
    if frameLen <= 0 || skip < 1
        error('frameLen must be >= 1 and skip must be >= 1.');
    end

% Splits signal x into frames.
% Each column of frames = one frame of length frameLen.

    % Make sure x is column
    if isrow(x)
        x = x.'; 
    end
    x = x(:);

    % How many frames fit
    nPossible = numel(x) - frameLen;

    if nPossible < 0
        frames = zeros(frameLen, 0, 'like', x);
        return
    end
    numFrames = floor(nPossible/skip) + 1;

    % Preallocate
    frames = zeros(frameLen, numFrames, 'like', x);

    % Fill with frames
    for n = 1:numFrames
        startIndex = (n-1)*skip + 1;
        endIndex   = startIndex + frameLen - 1;
        frames(:,n) = x(startIndex:endIndex);
    end
end

function y = silenceEraser(x, Fs, frameDurSec, ampThresh)
% silenceEraser
% Removes silent parts of an audio signal based on an RMS dB threshold.

    % 1) Ensure column vector
    if isrow(x)
        x = x.'; 
    end
    x = x(:);

    % 2) Frame sizing
    frameLen = round(frameDurSec * Fs);
    skip      = frameLen;                 % no overlap

    % 3) Slice into frames (each column is one frame)
    frames     = framesig(x, frameLen, skip);
    numFrames  = size(frames, 2);

    % Preallocate full-length output (guarantees trailing zeros)
    y = zeros(size(x), 'like', x);
    outIdx = 1;  % next write position in y

    if numFrames == 0
        y = x([]);                 % nothing to keep if shorter than one frame
        return
    end

    % 4) Frame loudness (RMS -> dB)
    rmsVals = sqrt(mean(frames.^2, 1) + eps);
    rmsdB   = 20*log10(rmsVals);          % dBFS (relative to full-scale of input)

    % 5) Keep only frames above threshold
    keepFrame = (rmsdB >= ampThresh);
    keepIdx   = find(keepFrame);

    % 6) Write kept frames into y in-place (using startIdx/endIdx)
    for k = 1:numel(keepIdx)
        f        = keepIdx(k);
        startIdx = (f-1)*skip + 1;
        endIdx   = min(startIdx + frameLen - 1, numel(x));  % guard end
        frame    = x(startIdx:endIdx);
        newCopy    = numel(frame);

        y(outIdx:outIdx + newCopy - 1) = frame;
        outIdx = outIdx + newCopy;
    end

    % 7) Trim the trailing zeros so the returned y has no silent tail
    y = y(1:max(outIdx - 1, 0));
end

function z = zeroCross(x)
    % Counts how many times the signal crosses zero
    
% Ensure x is a column vector
    if isrow(x)
        x = x'; % Convert to column vector
    end

    % Find out how many samples are in x
    N = length(x);

    % Initialize the zero crossing counter variable
    z = 0; 

    % make a for loop that can compare neighboring samples
    for sampIdx = 1 : N - 1

        % Check the sign of the current and next sample
        if sign(x(sampIdx)) ~= sign(x(sampIdx))
            % Increment the counter if they don't match
            z = z + 1; 
        end
    end  

end