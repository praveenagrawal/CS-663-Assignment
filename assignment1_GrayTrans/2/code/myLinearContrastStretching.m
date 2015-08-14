function [ output ] = myLinearContrastStretching(img)
    img = double(img);
    min_intensity = min(min(img)); % Value of minimum intensity pixel   
    max_intensity = max(max(img)); % Value of mamimum intensity pixel

    % Contrast Stretching using a linear equation 
    % Equation of a line joining (min_intensity, 0) and (max_intensity, 255)
    % All the intermediate grayscale pixel values are mapped according to this
    % straight line equation

    output = double(img - min_intensity)*(255/double(max_intensity-min_intensity)); 
    output = uint8(output);
end

