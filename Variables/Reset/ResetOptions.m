%% Function: Reset the sub-struct State.Variables.Options.
function State = ResetOptions(State)
    %% 1. Reset the chosen input files.
    State.Variables.Options.InputFiles = State.Constants.PossibleOptions.InputFiles(1);
    %% 2. Reset the chosen models.
    State.Variables.Options.Models = State.Constants.PossibleOptions.Models(1);
    %% 3. Reset the chosen gap types.
    State.Variables.Options.GapTypes = State.Constants.PossibleOptions.GapTypes(1);
    %% 4. Reset the chosen cases.
    State.Variables.Options.Cases = State.Constants.PossibleOptions.Cases(1);
    %% 5. Reset the chosen solvers.
    State.Variables.Options.Solvers = State.Constants.PossibleOptions.Solvers(1);
end