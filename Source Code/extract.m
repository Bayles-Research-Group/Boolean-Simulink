function [mat,rate]=   extract(a)
%% Version and general code information
%Plot Cross Section V.10 Updated 2022-04-11
%Inputs
    %One 3D array
%Outputs
    %Two arrays
    % mat contains the pattern matrix a(:,:,1)
    %rate contains the total flow rate a(1,1,2)
%% Output variables
mat = double(a(:,:,1)); % The pattern matrix. Take all the rows and columns of the first 3rd dimension and assign them to the variable mat. 
rate = a(1,1,2); % The flow rate constant value. Take the first element of the second third dimension and assign it to the variable rate. 

