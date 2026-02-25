%% Function: Run the reset button callback.
function ResetButtonCallback(Figure)
    %% 1. Reset the sub-struct State.Variables.
    State = ResetVariables(Figure.UserData);
    %% 2. Read State.Variables into the configuration window data.
    State = VariablesToConfigurationWindow(State);
    %% 3. Update the configuration window figure user data.
    Figure.UserData = State;
end