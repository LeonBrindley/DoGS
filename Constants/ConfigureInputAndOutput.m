%% Function: Configure the input and output properties.
function State = ConfigureInputAndOutput(State)
    %% 1. Configure the root directory.
    State.Constants.RootDirectory = fileparts(evalin('caller', 'mfilename(''fullpath'')'));
    %% 2. Configure the input directory.
    State.Constants.InputDirectory = fullfile(State.Constants.RootDirectory, 'Input');
    if(~isfolder(State.Constants.InputDirectory))
        mkdir(State.Constants.InputDirectory);
    end
    %% 3. Configure the output directory.
    State.Constants.OutputDirectory = fullfile(State.Constants.RootDirectory, 'Output');
    if(~isfolder(State.Constants.OutputDirectory))
        mkdir(State.Constants.OutputDirectory);
    end
    %% 4. Configure the timestamp for when the program was started.
    State.Constants.TimestampFormat = 'yy-MM-dd-HH-mm';
    State.Constants.Timestamp = string(datetime('now', 'Format', State.Constants.TimestampFormat));
end