function [peaks, filtH] = hough_peaks(H, varargin)
    % Find peaks in a Hough accumulator array.
    %
    % Threshold (optional): Threshold at which values of H are considered to be peaks
    % NHoodSize (optional): Size of the suppression neighborhood, [M N]
    %
    % Please see the Matlab documentation for houghpeaks():
    % http://www.mathworks.com/help/images/ref/houghpeaks.html
    % Your code should imitate the matlab implementation.

    %% Parse input arguments
    p = inputParser;
    addOptional(p, 'numpeaks', 1, @isnumeric);
    addParameter(p, 'Threshold', 0.5 * max(H(:)));
    addParameter(p, 'NHoodSize', floor(size(H) / 100.0) * 2 + 1);  % odd values >= size(H)/50
    parse(p, varargin{:});

    numpeaks = p.Results.numpeaks
    threshold = p.Results.Threshold
    nHoodSize = p.Results.NHoodSize

    %Smooth the image
    filter = fspecial('gaussian');
    filtH = imfilter(H,filter);
    
    
    %For each pixel, see if the intensity is maximum in neighborhood. If
    %yes keep it, else set it to zero
    Hpad1 = [zeros(nHoodSize(1,1)-1,size(filtH,2));filtH;zeros(nHoodSize(1,1)-1,size(filtH,2))];
    Hpad2 = [zeros(size(Hpad1,1),nHoodSize(1,2)-1), Hpad1, zeros(size(Hpad1,1),nHoodSize(1,2)-1)];
    
    for col= nHoodSize(1,2):1:size(Hpad2,2)-nHoodSize(1,2)+1
        for row= nHoodSize(1,1):1:size(Hpad2,1)-nHoodSize(1,1)+1
            row;
            col;
            row - (nHoodSize(1,1)-1)/2;
            row + (nHoodSize(1,1)-1)/2;
            col-(nHoodSize(1,2)-1)/2;
            col+(nHoodSize(1,2)-1)/2;
            if ( Hpad2(row,col) ~= max(max(  Hpad2(  row-(nHoodSize(1,1)-1)/2 : row+(nHoodSize(1,1)-1)/2 , col-(nHoodSize(1,2)-1)/2 : col+(nHoodSize(1,2)-1)/2))))
                Hpad2(row,col) = 0;
            end
        end
    end
    %Collect Max 10
    filtH = Hpad2(nHoodSize(1,1):size(Hpad2,1)-nHoodSize(1,1)+1,nHoodSize(1,2):size(Hpad2,2)-nHoodSize(1,2)+1);
    size(filtH)
    [sortedFiltH,sortingIndices] = sort(filtH(:),'descend');
    [rows,cols] = ind2sub(size(filtH),sortingIndices(1:numpeaks));
    peaks = [rows cols];
end
