%% Function: Run the apply button callback.
function ApplyButtonCallback(Figure)
    %% 1. Evaluate the sub-struct State.Variables.
    State = EvaluateVariables(Figure.UserData);
    %% 2. Evaluate the sub-struct State.Dependents.
    State.Combination = 0; State = EvaluateDependents(State);
    %% 3. Evaluate the sub-struct State.Iterations.
    State.Iterations.FittingParameters = State.Dependents.FittingDefinitions.InitialValues;
    State.Query = 'Full'; State = EvaluateIterations(State);
    %% 4. Update the configuration window figure user data.
    Figure.UserData = State;
    %% 5. Update the results window figure user data.
    State.ResultsWindow.Figure.UserData = State;
    %% 6. Update the results window figure.
    UpdateResultsWindow(State);
end