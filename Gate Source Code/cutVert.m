function [outA, outB] = cutVert(a)
%% Version and general code information
%Cut Vertical V 1.0 Updated 2022-04-07
% Inputs 
    % One 3D array
% Outputs
    %Two 3D arrays
    %First 2D array (out(:,:,1)) contains the pattern.
    %last element contains the flow rate (out(:,:,2)), should be a
    %constant.

%% Determining preliminary variables
resolution = size(a,1); %Calculates resolution based off of the first dimension (# of rows) of a.
numMatrices = nargin; %Calculates the number of matrices based off  the supplied input arguments, one. 
numOutMatrices = nargout; %Determines the number of output matrices based off the number of output arguments,two.

%% Flow rate calculation
inputFlowRate = a(1,1,2); %Determines the inlet flow rate based off of the first element in the second 2D array of the inlet stream. 
flowRate = nan(numOutMatrices,1); % Form a vector of NaN values (2,1).

for i = 1:numOutMatrices % Loop from 1 to the final number of matrices 2.
    flowRate(i) = inputFlowRate/numOutMatrices; % Determine the new flow rate of the outlet streams based off the total inlet flow rate and number of outlet matrices (two). Store the flow rate after each iteration. Assigns equal flow rate to each stream.
end


cutA = imresize(a(1:resolution/numOutMatrices,:,1), [resolution, resolution],'nearest'); % Take the pattern matrix a(:,:,1) and extract the first row to the row specified by resolution/numOutMatrices and all the columns. Resize this to the desired resolution based off the provided input variables.
cutB = imresize(a(resolution/numOutMatrices+1:end,:,1), [resolution, resolution],'nearest'); % Take the pattern matrix a(:,:,1) and extract the from the row specified by resoltion/numOutMatries+1 to the last row in the matrix and all the columns. Resize this to the desired resolution based off the provided input variables.

%% Predefining output variables
outA = a; %Assigns the correct dimensions for the output variable.
outB = a; %Assigns the correct dimensions for the output variable.

outA(:,:,1) = cutA; %The new pattern of array A (outA(:,:,1)) after the vertical splitting. 
outA(:,:,2) = flowRate(1).*ones(resolution,resolution); %The new flow rate of array A (outA(:,:,2)) after the horizontal splitting. Calculates the new flow rate array using the individual flow rates (flowrate(1), first element in the flow rate vector) multiplied by a ones matrix of size based on the supplied resolution.
outB(:,:,1) = cutB; %The new pattern of array B (outB(:,:,1)) after the vertical splitting.
outB(:,:,2) = flowRate(2).*ones(resolution,resolution); %The new flow rate of array B (outB(:,:,2)) after the horizontal splitting. Calculates the new flow rate array using the individual flow rates (flowrate(2), second element in the flow rate vector) multiplied by a ones matrix of size based on the supplied resolution.







