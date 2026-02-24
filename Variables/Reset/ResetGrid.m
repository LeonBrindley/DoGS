%% Function: Reset the sub-struct State.Variables.Grid.
function State = ResetGrid(State)
    %% 1. Reset the Δε minimum and its unit.
    State.Variables.Grid.Minimum = {-2.5E-1, 'eV'};
    %% 2. Reset the Δε increment and its unit.
    State.Variables.Grid.Increment = {1.0E-3, 'eV'};
    %% 3. Reset the Δε maximum and its unit.
    State.Variables.Grid.Maximum = {2.5E-1, 'eV'};
end