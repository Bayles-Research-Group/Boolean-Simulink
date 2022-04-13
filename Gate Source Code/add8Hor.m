function out = add8Hor(a,b,c,d,e,f,g,h)
%% Version and general code information
%Horizontal Addition V 1.0 Updated 2022-04-07
% Inputs
    %Eight 3D arrays
% Outputs
    %3D array 
    % First 2D array (out(:,:,1)) contains the pattern
    %Last element (out(:,:,2)) contains the flow rates, should be a
    %constant

%% Determine preliminary variabes
resolution = size(a,1); %Calculates resolution based off of the first dimension (# of rows) of a
numMatrices = nargin; %Determines the number of matrices based off of the number of input arguments, eight.
allMat = nan(resolution,resolution, 2*numMatrices); % Determines the total 3D array size based off the provided resolution and number of matrices. For this case the dimensions are (resolution, resolution, 16).
allMat(:,:, 1:2) = a; %Assigns all the rows and columns of the 1st and 2nd third dimension of the supplied a array to allMat. The 1st and 2nd will contain the pattern and flow rate arrays of a respectively.
allMat(:,:, 3:4) = b; %Assigns all the rows and columns of the 1st and 2nd third dimension of the supplied b array to allMat. The 3rd and 4th will contain the pattern and flow rate arrays of b respectively.
allMat(:,:, 5:6) = c; %Assigns all the rows and columns of the 1st and 2nd third dimension of the supplied c array to allMat. The 5th and 6th will contain the pattern and flow rate arrays of c respectively.
allMat(:,:, 7:8) = d; %Assigns all the rows and columns of the 1st and 2nd third dimension of the supplied d array to allMat. The 7th and 8th will contain the pattern and flow rate arrays of d respectively.
allMat(:,:, 9:10) = e; %Assigns all the rows and columns of the 1st and 2nd third dimension of the supplied e array to allMat. The 9th and 10th will contain the pattern and flow rate arrays of e respectively.
allMat(:,:, 11:12) = f; %Assigns all the rows and columns of the 1st and 2nd third dimension of the supplied f array to allMat. The 11th and 12th will contain the pattern and flow rate arrays of f respectively.
allMat(:,:, 13:14) = g; %Assigns all the rows and columns of the 1st and 2nd third dimension of the supplied g array to allMat. The 13th and 14th will contain the pattern and flow rate arrays of g respectively.
allMat(:,:, 15:16) = h; %Assigns all the rows and columns of the 1st and 2nd third dimension of the supplied a array to allMat. The 15th and 16th will contain the pattern and flow rate arrays of h respectively.

%% Flow rate calculation
flowRate = nan(numMatrices,1); %Create an empty vector that has numMatrices in rows (8) and 1 column.
for i = 1:numMatrices % Loop from 1 to the final number of matrices 8.
    flowRate(i) = allMat(1,1,2*i); % Obtains the flow rate of each entering stream. Upon each loop iteration "grab" the 1st row, 1st column, and 2*i position in the array and assign it to the i'th spot in the flow rate vector. 
end
totalFlowRate = sum(flowRate); % Calculates the total flowrate by adding all entries in the flow rate vector.
%% Constructing the combined pattern matrix
reduceA = imresize(a(:,:,1),[resolution,resolution*flowRate(1)/totalFlowRate],'nearest'); % Take the pattern a(:,:,1) and resize into the specified dimensions based of the fraction of total flow rate (rows) and resolution (columns). Weights each of the matrices based on their respective flow rates (flowrate(1)).  
reduceB = imresize(b(:,:,1),[resolution,resolution*flowRate(2)/totalFlowRate],'nearest'); % Take the pattern b(:,:,1) and resize into the specified dimensions based of the fraction of total flow rate (rows) and resolution (columns). Weights each of the matrices based on their respective flow rates (flowrate(2)).  
reduceC = imresize(c(:,:,1),[resolution,resolution*flowRate(3)/totalFlowRate],'nearest'); % Take the pattern c(:,:,1) and resize into the specified dimensions based of the fraction of total flow rate (rows) and resolution (columns). Weights each of the matrices based on their respective flow rates (flowrate(3)).  
reduceD = imresize(d(:,:,1),[resolution,resolution*flowRate(4)/totalFlowRate],'nearest'); % Take the pattern d(:,:,1) and resize into the specified dimensions based of the fraction of total flow rate (rows) and resolution (columns). Weights each of the matrices based on their respective flow rates (flowrate(4)).  
reduceE = imresize(e(:,:,1),[resolution,resolution*flowRate(5)/totalFlowRate],'nearest'); % Take the pattern e(:,:,1) and resize into the specified dimensions based of the fraction of total flow rate (rows) and resolution (columns). Weights each of the matrices based on their respective flow rates (flowrate(5)).  
reduceF = imresize(f(:,:,1),[resolution,resolution*flowRate(6)/totalFlowRate],'nearest'); % Take the pattern f(:,:,1) and resize into the specified dimensions based of the fraction of total flow rate (rows) and resolution (columns).  Weights each of the matrices based on their respective flow rates (flowrate(6)).  
reduceG = imresize(g(:,:,1),[resolution,resolution*flowRate(7)/totalFlowRate],'nearest'); % Take the pattern g(:,:,1) and resize into the specified dimensions based of the fraction of total flow rate (rows) and resolution (columns). Weights each of the matrices based on their respective flow rates (flowrate(7)).  
reduceH = imresize(h(:,:,1),[resolution,resolution*flowRate(8)/totalFlowRate],'nearest'); % Take the pattern h(:,:,1) and resize into the specified dimensions based of the fraction of total flow rate (rows) and resolution (columns). Weights each of the matrices based on their respective flow rates (flowrate(8)).  


addMatrix = [reduceH,reduceG,reduceF,reduceE, reduceD,reduceC, reduceB, reduceA]; % Horizontally concatenates the matrices together. The point of view is from the perspective of the extrudate.
addMatrix = imresize(addMatrix,[resolution, 2.*resolution],'nearest'); %Resize the image to the desired resolution dimensions. 


%% Predefining output variables

out = [a,a]; %Assigns the correct dimensions for the output variable.
 
out(:,:,1) = addMatrix; %Assigns the added pattern array to the output variable.
out(:,:,2) = totalFlowRate.*ones(resolution,2.*resolution); %Defines the flow rate 2D array out(:,:,2). Calculates the new flow rate array using the total flow rate multiplied by a ones matrix of size based on the supplied resolution.





