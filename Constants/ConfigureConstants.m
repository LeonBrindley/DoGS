%% Function: Configure the sub-struct State.Constants.
function State = ConfigureConstants(State)
    %% 1. Clear the sub-struct State.Constants.
    State.Constants = struct;
    %% 2. Configure the input and output properties.
    State = ConfigureInputAndOutput(State);
    %% 3. Configure the hardware properties.
    State = ConfigureHardware(State);
    %% 4. Configure any fundamental physics.
    State = ConfigurePhysics(State);
    %% 5. Configure the possible options.
    State = ConfigurePossibleOptions(State);
end