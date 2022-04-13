function out = rotCounter(a)
%% Version and general code information
%Rotating Counter Clockwise V 1.0 Updated 2022-31-3
% Inputs:
    %3D array with pattern a(:,:,1) and flow rate a(:,:2)
%Outputs:
    %3D array
        %First 2D array (i.e., out(:,:,1)) contains the pattern
        %Last element contains the flow rate (i.e. out(:,:,2)), should be a
        %constant value.
%% Determining prelminary variables
resolution = size(a,1); %Calculates resolution based off of the first dimension (# of rows) of a.

%% Predefining output variables
out = a; %Assigns the correct dimensions for the output variable
out(:,:,1) = rot90(a(:,:,1)); % Rotates the pattern array a(:,:,1)90 degrees counterclockwise
out(:,:,2) = a(1,1,2).*ones(resolution,resolution); % Defines the flow rate 2D array a(:,:,2)







