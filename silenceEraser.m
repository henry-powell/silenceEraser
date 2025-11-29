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