%% Function: Reset the sub-struct State.Variables.
function State = ResetVariables(State)
    %% 1. Clear the sub-struct State.Variables.
    State.Variables = struct;
    %% 2. Reset the sub-struct State.Variables.Options.
    State = ResetOptions(State);
    %% 3. Reset the sub-struct State.Variables.Grid.
    State = ResetGrid(State);
    %% 4. Reset the sub-struct State.Variables.FittingDefinitions.
    State = ResetFittingDefinitions(State);
    %% 5. Reset the sub-struct State.Variables.Solvers.
    State = ResetSolvers(State);
end