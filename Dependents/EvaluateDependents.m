%% Function: Evalate the sub-struct State.Dependents.
function State = EvaluateDependents(State)
    %% 1. Clear the sub-struct State.Dependents.
    State.Dependents = struct;
    %% 2. Mutate the integer State.Combination.
    State.MutatedCombination = State.Combination;
    %% 3. Decode the corresponding indices for each category.
    SolverIndex = mod(State.MutatedCombination, numel(State.Variables.Options.Solvers)) + 1;
    State.MutatedCombination = floor(State.MutatedCombination / numel(State.Variables.Options.Solvers));
    CaseIndex = mod(State.MutatedCombination, numel(State.Variables.Options.Cases)) + 1;
    State.MutatedCombination = floor(State.MutatedCombination / numel(State.Variables.Options.Cases));
    GapTypeIndex = mod(State.MutatedCombination, numel(State.Variables.Options.GapTypes)) + 1;
    State.MutatedCombination = floor(State.MutatedCombination / numel(State.Variables.Options.GapTypes));
    ModelIndex = mod(State.MutatedCombination, numel(State.Variables.Options.Models)) + 1;
    State.MutatedCombination = floor(State.MutatedCombination / numel(State.Variables.Options.Models));
    InputFileIndex = mod(State.MutatedCombination, numel(State.Variables.Options.InputFiles)) + 1;
    %% 4. Select the corresponding options in each category.
    State.Dependents.InputFile = State.Variables.Options.InputFiles{InputFileIndex};
    State.Dependents.Model = State.Variables.Options.Models{ModelIndex};
    State.Dependents.GapType = State.Variables.Options.GapTypes{GapTypeIndex};
    State.Dependents.Case = State.Variables.Options.Cases{CaseIndex};
    State.Dependents.Solver = State.Variables.Options.Solvers{SolverIndex};
    %% 5. Evaluate the sub-struct State.Dependents.InputData.
    State = EvaluateInputData(State);
    %% 6. Evaluate the sub-struct State.Dependents.Optimiser.
    State = EvaluateOptimiser(State);
    %% 7. Calculate the W/L ratio of the channel (dimensionless).
    State.Dependents.Device.WidthOverLengthRatio = State.Dependents.Device.ChannelWidth / State.Dependents.Device.ChannelLength;
    %% 8. Calculate the product of the Boltzmann constant and temperature (eV).
    State.Dependents.k_B_Times_Temperature = State.Constants.k_B{1} * State.Dependents.Device.Temperature;
    %% 9. Calculate the Fermi-Dirac distribution f_B(Δε), as well as its derivative -df_B(Δε)/dΔε, in the bulk.
    State.Dependents.BulkFermiDiracExponent = State.Variables.DeltaEpsilon ./ State.Dependents.k_B_Times_Temperature;
    State.Dependents.BulkFermiDirac = 0.5 .* (1 - tanh(State.Dependents.BulkFermiDiracExponent ./ 2));
    State.Dependents.BulkFermiDiracDerivative = (1 ./ State.Dependents.k_B_Times_Temperature) .* (State.Dependents.BulkFermiDirac .* (1 - State.Dependents.BulkFermiDirac));
end