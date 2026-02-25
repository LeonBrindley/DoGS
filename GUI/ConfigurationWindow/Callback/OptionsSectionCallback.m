%% Function: Run the options section callback.
function OptionsSectionCallback(Source, ~)
    %% 1. Extract the configuration window figure.
    Figure = ancestor(Source, 'figure');
    %% 2. Store the previous options.
    PreviousOptions = Figure.UserData.Variables.Options;
    %% 3. Read the check boxes into State.Variables.Options.
    State = OptionsSectionToVariables(Figure.UserData);
    %% 4. Preserve the previous options in each category with none selected.
    for idxCategory = 1 : State.Constants.PossibleOptions.NumCategories
        CategoryName = State.Constants.PossibleOptions.Categories{idxCategory};
        if(isempty(State.Variables.Options.(CategoryName)))
            State.Variables.Options.(CategoryName) = PreviousOptions.(CategoryName);
        end
    end
    %% 5. Update the visible fitting definitions.
    State = UpdateVisibleFittingDefinitions(State);
    %% 6. Update the visible solvers.
    State = UpdateVisibleSolvers(State);
    %% 7. Update the configuration window figure user data.
    Figure.UserData = State;
end