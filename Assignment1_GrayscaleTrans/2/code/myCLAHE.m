function [A_mod] = myAHE(A, width, clip)
    % A = imresize(A, 0.5);  % In order to decrease run-time
    A = double(A);
    [X_lengthA, Y_lengthA] = size(A); % Dimensions of image matrix
    conc = ((width-rem(width,2))/2)-abs(rem(width,2)-1);   % Number of zeros to be concatenated to matrix; odd as well as even widths are taken care of

    % Padding for corner pixels and pixels at edges
    C1 = repmat(A(1,:), conc, 1);   % repeating 1st row
    C2 = repmat(A(:,1), 1, conc); % repeating 1st coulumn
    C3 = repmat(A(X_lengthA,:), conc, 1); % repeating last row
    C4 = repmat(A(:,Y_lengthA),1, conc); % repeating last column
    Cul = A(1,1)*ones(conc, conc); % Upper left corner
    Cur = A(1,Y_lengthA)*ones(conc, conc); % Upper right corner
    Cll = A(X_lengthA,1)*ones(conc,conc); % Lower left corner
    Clr = A(X_lengthA, Y_lengthA)*ones(conc,conc); % Lower right corner
    B_temp1 = [Cul,C1,Cur];
    B_temp2 = [Cll,C3,Clr];
    B_temp3 = [C2,A,C4];
    B = [B_temp1;B_temp3;B_temp2];

    i = 1; j = 1;      % i and j denote the corner pixel co-ordinate of window
    [X_lengthB, Y_lengthB] = size(B);

    % Pre-allocating
    Win_B = zeros(width, width);
    A_mod = zeros(X_lengthB, Y_lengthB);

    for i = 1:(X_lengthB-width+1)
        for j = 1:(Y_lengthB-width+1)
            Win_B = uint8(B(i:(i+width-1), j:(j+width-1)));   % Image B after windowing

            [count, bin] = imhist(Win_B);  % Histogram
            count = count/(width*width);   % Normalizing
            extra = sum(count((count > clip))-clip);   % number of pixels with their count>clip
            I = find(count>clip);
            for k = 1:length(I)
                count(I(k)) = count(I(k)) - clip;      % clipping
            end
            extra_each = extra/length(bin);
            count = count +extra_each;

            A_mod(i+conc, j+conc) = sum(count(1:(Win_B(conc+1, conc+1)+1)));   % Histogram Equalization

        end
        % i % debugging purpose
    end
    A_mod = A_mod((conc+1:X_lengthB-conc),(conc+1:Y_lengthB-conc));  %removing padded zeros
end