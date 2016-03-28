function [H, thetaRange, rhoRange] = hough_lines_acc(BW, varargin)
    % Compute Hough accumulator array for finding lines.
    %
    % BW: Binary (black and white) image containing edge pixels
    % RhoResolution (optional): Difference between successive rho values, in pixels
    % Theta (optional): Vector of theta values to use, in degrees
    %
    % Please see the Matlab documentation for hough():
    % http://www.mathworks.com/help/images/ref/hough.html
    % Your code should imitate the Matlab implementation.
    %
    % Pay close attention to the coordinate system specified in the assignment.
    % Note: Rows of H should correspond to values of rho, columns those of theta.

    %% Parse input arguments
%     p = inputParser();
%     addParameter(p, 'RhoResolution', 1);
%     addParameter(p, 'Theta', linspace(-90, 89, 180));
%     parse(p, varargin{:});
% 
%     rhoStep = p.Results.RhoResolution;
%     rhoRange = p.Results.Theta;

    %% TODO: Your code here
    D=400;
    theta=90;
    deltaTheta=15;
    deltaD=20;
    H(1:2*D+1,1:2*theta+1) = 0;
    size(H)
    
    for r=1:size(BW,1)
        for c=1:size(BW,2)
            if (BW(r,c) > 0)
                for angle=-theta:deltaTheta:theta
                    x = c;
                    y= r;
                    angle;
                    dist = x*cos(angle)+y*sin(angle);
                    dist = ceil(dist);
                    if (angle == -90 || angle == 90)
                        angle;
                        dist;
                    end
                    if (dist < D && dist>-D)
                        H(dist+D,angle+theta+1) = H(dist+D,angle+theta+1) + 1;
                    end

                end
            end
        end
    end
    thetaRange = -theta:1:theta;
    rhoRange = -D:1:D;
end
