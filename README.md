

#Bayles Lab
#Installing and Operating the Boolean Simulink Package
Edited: April 13th, 2022


====Description=======

The advective assembly Boolean Simulink package is an importable library that allows for the prediction and design of extrudates for subsequent fabrication of millifluidic devices.

======================


==============Installation and Setup======================

1)Install MATLAB and Simulink.

2)From the GITHUB page, download the entire folder entitled "Simulink Library." Note: The source code operating behind the blocks is located in a separate folder entitled " Gate Source Code."

3)Navigate to the folder in which MATLAB was saved upon installation (this is usually the documents folder): 

	users/"username"/Documents/MATLAB 

	Save the folder in this location. An example file path:
	
	Users/matt/Documents/MATLAB

4)Open MATLAB and the .slx file entitled "myLib_CustomBoolean.slx." This will bring up a Simulink instance with blocks all symbolized as "?"'s. You will have to change the masks on each of the blocks.

5)In the top ribbon, click the "locked library" button to unlock the library to allow for changes to be made. To change the image on each icon right click the icon and proceed to Mask --> View Mask. This will bring up a window with a file path present in the "drawing commands" box. To have the image for each mask display correctly, change the file path for each respective image. The images for each of the icons can be found in the downloaded Simulink Library. Specifically Simulink Library/Pictures For Masks. 
	
	
	Here the .png files for each icon will be present. For each icon, copy the current directory path and paste it into the Simulink prompt box and click apply. Repeat this process for each of the blocks. When finished, make sure to lock the library and save any changes. An example of a final pathway should read as follows:
	
	image('Users/matt/Documents/MATLAB/AdvectiveAssembly_BooleanSimulink/Examples_202112/PicturesForMasks/CutHor.png')

6) To upload the custom library into the library browser in Simulink, navigate to the folder "Simulink Library". Open the MATLAB file entitled "slblocks.m" and run the function. More documentation on the slblocks function can be found on the mathworks site: https://www.mathworks.com/help/simulink/ug/adding-libraries-to-the-library-browser.html

7) Open a blank Simulink file, in the top ribbon, click the block labeled "Library Browser." This will bring up a separate window. Scroll down, a library labeled "Boolean_Custom_Library" should be present. Here, all the icons that were previously updated should be present and ready for use. Note: If the library does not open, restart MATLAB completely and rerun the function in Step 6.

==============Running a Simulation===========

1) First, specify the resolution in which the simulation is to be run at. We find that a useful number of 1024 tends to work best due to the matrix concatenation and interpolation. To set the resolution, in the MATLAB command window, type "res=1024" and press enter to store this as a variable for the simulation. 

2) The following blocks will always be needed for the output of a simulation: "Plot CrossSection, FlowRate, and Matrix Viewer8." The Plot CrossSection must be connected with the Matrix Viewer8 block (on the top output) and the FlowRate block (on the bottom output).

3) There are three different source blocks present in the library currently black, white, and gray. All of the source blocks have a default flow rate of 1 (dimensionless). It is possible to change the flow rate by double clicking each of the source blocks which will bring up a dialog box with the top output looking as (for a black input):
		
			cat(3,0.*ones(res,res),1.0.*ones(res,res))
	
	As an example, to change the flow rate from 1 to 2, the change in code will look as:

			cat(3,0.*ones(res,res),2.0.*ones(res,res))

	In general, the flow rate for any of the blocks is changed by simply editing the third column entry in the dialog box. 

4) After assembling the boxes in the desired order to establish the desired architecture, click run in the upper ribbon. This will run the simulation. A separate graphing window will appear. At first, it will look completely black. Let the simulation run for a few more seconds and the graph output should change to the results of the simulation. 

5) To export the output of the simulation to the MATLAB workspace, the "out.extrudateArray" block will be required. Connect this block to the stream entering the matrix viewer block. Run the simulation. This will send the results of the simulation to the MATLAB workspace as a symbolic variable labeled "out.extrudateArray."

6) Download and open the MATLAB function entitled "plotExtrudateArray." The function allows for exporting the resulting figure window in any file format. To do so, first, change the name of the file to your desire in the line declared "filename." Next, find the directory pathway to the folder you would like to save the image to, copy and paste this pathway into the line entitled "exportgraphics." An example file name and pathway is given below and saves the corresponding figure as a pdf:

		filename = 'Asymmetric_SwitchInlet_CorrectedFlowRate.pdf'
		exportgraphics(gcf,strcat('/Users/matt/Desktop/UD Research/Manuscript Files/Matt Edits/Boolean', filename), 'ContentType','vector') 

7) To run the function, call the function in the command window (i.e., plotExtrudateArray(out)) and press enter. The figure should then be saved in the folder specified. 

