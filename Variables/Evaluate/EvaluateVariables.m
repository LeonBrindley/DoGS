%% Function: Evaluate the sub-struct State.Variables.
function State = EvaluateVariables(State)
    %% 1. Read the configuration window data into State.Variables.
    State = ConfigurationWindowToVariables(State);
    %% 2. Evaluate the Δε grid.
    State = EvaluateGrid(State);
    %% 3. Evaluate the knots for the pchip model.
    State = EvaluateKnots(State);
end