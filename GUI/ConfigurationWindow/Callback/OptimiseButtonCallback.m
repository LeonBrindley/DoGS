%% Function: Run the optimise button callback.
function OptimiseButtonCallback(Figure)
    %% 1. Evaluate the sub-struct State.Variables.
    State = EvaluateVariables(Figure.UserData);
    %% 2. Optimise each of the models.
    for idxCombination = 0 : State.Variables.NumCombinations - 1
        %% 2A. Evaluate the sub-struct State.Dependents.
        State.Combination = idxCombination; State = ParseDependents(State);
        %% 2B. Optimise the chosen model.
    end
    %% 3. Update the configuration window figure user data.
    Figure.UserData = State;
    %% 4. Update the results window figure user data.
    State.ResultsWindow.Figure.UserData = State;
    %% 5. Update the results window figure.
    UpdateResultsWindow(State);
end