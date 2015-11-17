function [ imgOutput ] = myPCADenoising2( imgInput, sigma)
    [rows, columns] = size(imgInput);
    patchSize = 7.0;  %   7 x 7 patch size.
    winSize  = 31.0; % 31 x 31 window size.
    K = 200;         % No. of similar patches to be taken from a window
    P = zeros((patchSize*patchSize), (rows - (patchSize-1))*(columns - (patchSize-1)));%No. of patches will be (r-6)*(c-6)
    patchNumber = 0.0;
    imgOutput = double(zeros(rows, columns));
    averagingCounter = double(zeros(rows, columns));
    
    for i=1:1:(rows-(patchSize-1))
        for j=1:1:(columns-(patchSize-1))
            patch1 = imgInput(i:i+(patchSize-1), j:j+(patchSize-1));
            patch1 = reshape(patch1, patchSize^2, 1);
            
            % Window dimensions
            x1 = max(i-floor(winSize/2),1);
            x2 = min(i+floor(winSize/2)-(patchSize-1),rows-(patchSize-1));
            y1 = max(j-floor(winSize/2),1);
            y2 = min(j+floor(winSize/2)-(patchSize-1),columns-(patchSize-1));
            
            % For all the patches in the window
            Q = zeros(patchSize^2, (x2-x1+1)*(y2-y1+1));
            error = zeros(1, (x2-x1+1)*(y2-y1+1));
            
            patchNumber = 0;
            for k=x1:1:x2
                for l=y1:1:y2
                    patch2 = imgInput(k:k+(patchSize-1), l:l+(patchSize-1));
                    patchNumber = patchNumber + 1;
                    Q(:,patchNumber) = patch2(:);
                    error(patchNumber) = sum(sum((patch1-Q(:,patchNumber)).^2));
                end
            end
            
            %  Collect K = 200 most similar patches
            [sortError, index]=sort(error); % Sort in ascending order
            Q = Q(:,index);
            [Qrows, Qcolumns] = size(Q);
            K = min(K, Qcolumns); % Just in case window size is too small to have 200 patches
            Q = Q(:,1:K);  
            
            % Compute eigenvectors and eigencoefficients of the matrix QQ'
            [eigenVectors, eigenValues] = eig(Q*Q.');
            eigenCoefficients = eigenVectors.'*Q;
            
            % Estimate of the average squared eigen-coefficients of the original patches
            coeffsEstimate = max(0, (((sum((eigenCoefficients.').^2))/K).')-(sigma*sigma));

            % Manipulate the noisy coefficients
            denoisedCoeffs = eigenCoefficients;
            for m = 1:1:length(coeffsEstimate)
                denoisedCoeffs(m,:) = eigenCoefficients(m,:)./(1+(sigma^2)/coeffsEstimate(m));
            end
            
            % Denoise the eigen-coefficients corresponding to only Pi
            denoisedPi = eigenVectors*denoisedCoeffs(:,1);
            
            imgOutput(i:i+(patchSize-1), j:j+(patchSize-1)) = imgOutput(i:i+(patchSize-1), j:j+(patchSize-1)) + reshape(denoisedPi, patchSize, patchSize);
            averagingCounter(i:i+(patchSize-1), j:j+(patchSize-1)) = averagingCounter(i:i+(patchSize-1), j:j+(patchSize-1)) + 1;
        end
    end
    imgOutput = imgOutput./averagingCounter; 
end
