%% Function: Run the options section callback.
function OptionsSectionCallback(Source, ~)
    %% 1. Extract the configuration window figure.
    Figure = ancestor(Source, 'figure');
    %% 2. Read the check boxes into State.Variables.Options.
    State = OptionsSectionToVariables(Figure.UserData, Figure.UserData.Variables.Options);
    %% 3. Update the visible fitting definitions.
    State = UpdateVisibleFittingDefinitions(State);
    %% 4. Update the visible solvers.
    State = UpdateVisibleSolvers(State);
    %% 5. Update the configuration window figure user data.
    Figure.UserData = State;
end