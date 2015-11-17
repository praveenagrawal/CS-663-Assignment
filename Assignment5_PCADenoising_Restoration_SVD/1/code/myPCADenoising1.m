function [ imgOutput ] = myPCADenoising1( imgInput, sigma)
    [rows, columns] = size(imgInput);
    patchSize = 7.0;  %   7 x 7 patch size.
    P = zeros((patchSize*patchSize), (rows - (patchSize-1))*(columns - (patchSize-1)));%No. of patches will be (r-6)*(c-6)
    patchNumber = 0.0;
    imgOutput = double(zeros(rows, columns));
    averagingCounter = double(zeros(rows, columns));
    
    %Creating the matrix P
    for i=1:1:(rows-(patchSize-1))
        for j=1:1:(columns-(patchSize-1))
            patch = imgInput(i:i+(patchSize-1), j:j+(patchSize-1));
            patchNumber = patchNumber + 1;
            P(:,patchNumber) = patch(:);
        end
    end
    
    % Compute eigenvectors and eigencoefficients of the matrix PP'
    [eigenVectors, eigenValues] = eig(P*P.');
    eigenCoefficients = eigenVectors.'*P;
    
    % Estimate of the average squared eigen-coefficients of the original patches
    coeffsEstimate = max(0, (((sum((eigenCoefficients.').^2))/patchNumber).')-(sigma*sigma));
    
    % Manipulate the noisy coefficients
    denoisedCoeffs = eigenCoefficients;
    for j = 1:1:length(coeffsEstimate)
        denoisedCoeffs(j,:) = eigenCoefficients(j,:)./(1+(sigma^2)/coeffsEstimate(j));
    end
    
    % reconstruct the denoised patches and re-assemble them to produce the final denoised image
    denoisedP = eigenVectors*denoisedCoeffs;
    patchNumber = 0.0;
    for i=1:1:(rows-(patchSize-1))
        for j=1:1:(columns-(patchSize-1))
            patchNumber = patchNumber + 1;
            imgOutput(i:i+(patchSize-1), j:j+(patchSize-1)) = imgOutput(i:i+(patchSize-1), j:j+(patchSize-1)) + reshape(denoisedP(:,patchNumber), patchSize, patchSize);
            averagingCounter(i:i+(patchSize-1), j:j+(patchSize-1)) = averagingCounter(i:i+(patchSize-1), j:j+(patchSize-1)) + 1;
        end
    end    
    imgOutput = imgOutput./averagingCounter;    
end

