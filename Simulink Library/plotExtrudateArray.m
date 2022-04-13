function plotExtrudateArray(out)
%% General code information
    % Extrudate prediction plotting V1.0 - Revised 22410
    %Use this file to export a pdf of the prediction in a square image
    %Requires you to output the array using simout block.
%% Loading the simulation output from simulink
close all; %Close all figure windows
extrudateArrayLocal = out.extrudateArray; % Load the output array from the simulink simulation
size(extrudateArrayLocal) %Determine the dimensions of the output variable from siimuliink
%% Generating the extrudate image
figure (1) % Generate a new figure window, Figure 1
colormap gray %Specifiy the sequence of colors used to generate the image. Gray utilizes a gradient of black and white
image(extrudateArrayLocal, 'CDataMapping', 'scaled') %Display the image in a separate figure window
box on %Display box outline around the figure
axis square % Set axis lines with equal spacing
axis off %Turn off the axis
%% Saving parameters and pathways
filename = 'Asymmetric_SwitchInlet_CorrectedFlowRate.pdf' %Define the file name and type
exportgraphics(gcf,strcat('/Users/matt/Desktop/UD Research/Manuscript Files/Matt Edits/Boolean', filename), 'ContentType','vector')  % Save the corresponding file to the specified directory pathway
end