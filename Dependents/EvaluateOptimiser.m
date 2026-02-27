%% Function: Evaluate the sub-struct State.Dependents.Optimiser.
function State = EvaluateOptimiser(State)
    %% 1. Clear the sub-struct State.Dependents.Optimiser.
    State.Dependents.Optimiser = struct;
    %% 2. Parse the fitting definitions associated with the current combination.
    Requirements = {'Any'};
    if(strcmp(State.Dependents.GapType, 'Soft'))
        Requirements{end + 1} = 'Soft';
    end
    Requirements{end + 1} = State.Dependents.Model;
    %% 3. Convert the initial values, lower bounds and upper bounds from structs into three arrays.

    %% 4. Configure the options associated with the solver in question.

    %% 5. Define the objective function to be minimised.

end