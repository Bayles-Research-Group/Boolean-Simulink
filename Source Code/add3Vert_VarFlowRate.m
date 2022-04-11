function out = add3Vert_VarFlowRate(a,b,c)
%% Version and general code information
%Add Vertical V 1.0 Updated 2022-04-07
% Inputs 
    % Three 3D arrays
% Outputs
    %One 3D arrays
    %First 2D array (out(:,:,1)) contains the pattern.
    %last element contains the flow rate (out(:,:,2)), should be a
    %constant.

%% Determining preliminary variables
resolution = size(a,1); %Calculates resolution based off of the first dimension (# of rows) of a.
numMatrices = nargin; %Determines the number of matrices based off of the number of input arguments, three.
allMat = nan(resolution,resolution, 2*numMatrices); % Determines the total 3D array size based off the provided resolution and number of matrices. For this case the dimensions are (resolution, resolution, 6).
allMat(:,:, 1:2) = a; %Assigns all the rows and columns of the 1st and 2nd third dimension of the supplied a array to allMat. The 1st and 2nd will contain the pattern and flow rate arrays of a respectively.
allMat(:,:, 3:4) = b; %Assigns all the rows and columns of the 1st and 2nd third dimension of the supplied b array to allMat. The 3rd and 4th will contain the pattern and flow rate arrays of b respectively.
allMat(:,:, 5:6) = c; %Assigns all the rows and columns of the 1st and 2nd third dimension of the supplied c array to allMat. The 5th and 6th will contain the pattern and flow rate arrays of c respectively.

%% Flow rate calculation
flowRate = nan(numMatrices,1); %Create an empty vector that has numMatrices in rows (3) and 1 column.

for i = 1:numMatrices % Loop from 1 to the final number of matrices 3.
    flowRate(i) = allMat(1,1,2*i); % Obtains the flow rate of each entering stream. Upon each loop iteration "grab" the 1st row, 1st column, and 2*i position in the array and assign it to the i'th spot in the flow rate vector.
end
totalFlowRate = sum(flowRate); % Calculates the total flowrate by adding all entries in the flow rate vector.

%% Constructing the pattern matrix 
reduceA = imresize(a(:,:,1),[resolution*flowRate(1)/totalFlowRate, resolution],'nearest');  % Take the pattern a(:,:,1) and resize into the specified dimensions based of the fraction of total flow rate (rows) and resolution (columns). Weights each of the matrices based on their respective flow rates (flowrate(1)).  
reduceB = imresize(b(:,:,1),[resolution*flowRate(2)/totalFlowRate, resolution],'nearest');  % Take the pattern b(:,:,1) and resize into the specified dimensions based of the fraction of total flow rate (rows) and resolution (columns). Weights each of the matrices based on their respective flow rates (flowrate(2)).  
reduceC = imresize(c(:,:,1),[resolution*flowRate(3)/totalFlowRate, resolution],'nearest');  % Take the pattern c(:,:,1) and resize into the specified dimensions based of the fraction of total flow rate (rows) and resolution (columns). Weights each of the matrices based on their respective flow rates (flowrate(3)).  
addMatrix = [reduceA; reduceB; reduceC]; % Vertically concatenates the matrices together. 
addMatrix = imresize(addMatrix,[resolution, resolution],'nearest'); %Resize the image to the desired resolution dimensions. 

%% Predefining output variables
out = a;  %Assigns the correct dimensions for the output variable.
out(:,:,1) = addMatrix; %Assigns the added pattern array to the output variable.
out(:,:,2) = totalFlowRate.*ones(resolution,resolution);  %Defines the flow rate 2D array out(:,:,2). Calculates the new flow rate array using the total flow rate multiplied by a ones matrix of size based on the supplied resolution.





