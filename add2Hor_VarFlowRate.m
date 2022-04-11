function out = add2Hor_VarFlowRate(a,b)
%% Version and general code information
% Horizontal Addition Updated 2022-04-07
% Inputs 
    % Two 3D arrays
% Outputs
    %3D array
    %First 2D array (out(:,:,1)) contains the pattern.
    %last element (out(:,:,2)) contains the flow rate, should be a
    %constant.

%% Determining preliminary variables
resolution = size(a,1);  %Calculates resolution based off the first dimension (# of rows) of a.
numMatrices = nargin; %Determines the number of matrices based off of the number of input arguments, two.

allMat = nan(resolution,resolution, 2*numMatrices); % Determines the total 3D array size based off the provided resolution and number of matrices. For this case the dimensions are (resolution, resolution, 4).
allMat(:,:, 1:2) = a; %Assigns all the rows and columns of the 1st and 2nd third dimension of the supplied a array to allMat. The 1st and 2nd will contain the pattern and flow rate arrays of a respectively.
allMat(:,:, 3:4) = b; %Assigns all the rows and columns of the 1st and 2nd third dimension of the supplied b array to allMat. The 3rd and 4th will contain the pattern and flow rate arrays of b respectively.

%% Flow rate calculation
flowRate = nan(numMatrices,1); %Create an empty vector that has numMatrices in rows (2) and 1 column.

for i = 1:numMatrices % Loop from 1 to the final number of matrices 2.
    flowRate(i) = allMat(1,1,2*i); % Obtains the flow rate of each entering stream. Upon each loop iteration "grab" the 1st row, 1st column, and 2*i position in the array and assign it to the i'th spot in the flow rate vector. 
end

totalFlowRate = sum(flowRate); % Calculates the total flowrate by adding all entries in the flow rate vector.

%% Constructing the combined pattern matrix
reduceA = imresize(a(:,:,1),[resolution,resolution*flowRate(1)/totalFlowRate],'nearest'); % Take the pattern a(:,:,1) and resize into the specified dimensions based of the fraction of total flow rate (rows) and resolution (columns).  Weights each of the matrices based on their respective flow rates (flowrate(1)).  
reduceB = imresize(b(:,:,1),[resolution,resolution*flowRate(2)/totalFlowRate],'nearest'); % Take the pattern b(:,:,1) and resize into the specified dimensions based of the fraction of total flow rate (rows) and resolution (columns).  Weights each of the matrices based on their respective flow rates (flowrate(2)). 

addMatrix = [reduceB, reduceA]; %Horizontally concatenates the matrices together. The point of view is from the perspective of the extrudate.
addMatrix = imresize(addMatrix,[resolution, resolution],'nearest'); %Resize the image to the desired resolution dimensions.

%% Predifining output variables
out = a; %Assigns the correct dimensions for the output variable.
out(:,:,1) = addMatrix; %Assigns the added pattern array to the output variable.
out(:,:,2) = totalFlowRate.*ones(resolution,resolution); %Defines the flow rate 2D array out(:,:,2). Calculates the new flow rate array using the total flow rate multiplied by a ones matrix of size based on the supplied resolution.





