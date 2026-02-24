%% Function: Evaluate the Δε grid.
function State = EvaluateGrid(State)
    %% 1. Construct the Δε grid.
    State.Variables.DeltaEpsilon = State.Variables.Grid.Minimum{1} : State.Variables.Grid.Increment{1} : State.Variables.Grid.Maximum{1};
    %% 2. Extract the number of Δε values.
    State.Variables.NumDeltaEpsilon = numel(State.Variables.DeltaEpsilon);
    %% 3. Extract the index at which the magnitude of Δε is closest to 0.
    [~, State.Variables.idxZeroDeltaEpsilon] = min(abs(State.Variables.DeltaEpsilon));
end