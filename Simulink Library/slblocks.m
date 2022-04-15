function blkStruct = slblocks
% This function specifies that the library 'mylib'
% should appear in the Library Browser with the 
% name 'My Library'

    Browser.Library = 'myLib_CustomBoolean';
    % Defines the name of the library

    Browser.Name = 'Boolean_Custom_Library';
    % The library that appears in the library browser in Simulink

    blkStruct.Browser = Browser;
