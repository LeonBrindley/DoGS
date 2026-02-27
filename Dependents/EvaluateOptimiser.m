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
    State.Dependents.Optimiser.InitialValues = [];
    State.Dependents.Optimiser.LowerBounds = [];
    State.Dependents.Optimiser.UpperBounds = [];
    for idxRequirement = 1 : numel(Requirements)
        ParameterNames = fieldnames(State.Variables.FittingDefinitions.(Requirements{idxRequirement}));
        for idxParameter = 1 : numel(ParameterNames)
            FittingDefinition = State.Variables.FittingDefinitions.(Requirements{idxRequirement}).(ParameterNames{idxParameter});
            State.Dependents.Optimiser.InitialValues = [State.Dependents.Optimiser.InitialValues, reshape(FittingDefinition{2} ./ FittingDefinition{1}, 1, [])];
            State.Dependents.Optimiser.LowerBounds = [State.Dependents.Optimiser.LowerBounds, reshape(FittingDefinition{3} ./ FittingDefinition{1}, 1, [])];
            State.Dependents.Optimiser.UpperBounds = [State.Dependents.Optimiser.UpperBounds, reshape(FittingDefinition{4} ./ FittingDefinition{1}, 1, [])];
        end
    end
    %% 4. Configure the options associated with the solver in question.

    %% 5. Define the objective function to be minimised.

end