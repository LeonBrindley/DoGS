%% Function: Evaluate the sub-struct State.Dependents.Optimiser.
function State = EvaluateOptimiser(State)
    %% 1. Clear the sub-struct State.Dependents.Optimiser.
    State.Dependents.Optimiser = struct;
    %% 2. Parse the fitting definition requirements for the current combination.
    Requirements = {'Any'};
    if(strcmp(State.Dependents.GapType, 'Soft'))
        Requirements = [Requirements, {'Soft'}];
    end
    Requirements = [Requirements, {State.Dependents.Model}];
    %% 3. Initialise storage for the parsed fitting definitions.
    Names = {};
    Scales = {};
    InitialValues = {};
    LowerBounds = {};
    UpperBounds = {};
    Units = {};
    %% 4. Parse the fitting definitions selected by the current requirements.
    for idxRequirement = 1 : numel(Requirements)
        CurrentDefinitions = State.Variables.FittingDefinitions.(Requirements{idxRequirement});
        CurrentNames = fieldnames(CurrentDefinitions);
        for idxName = 1 : numel(CurrentNames)
            ParameterName = CurrentNames{idxName};
            ParameterRow = CurrentDefinitions.(ParameterName);
            if(isnumeric(ParameterRow{1}) && ~isscalar(ParameterRow{1}))
                Names{end + 1, 1} = arrayfun(@(idxElement) sprintf('%s(%d)', ParameterName, idxElement), (1 : numel(ParameterRow{1}))', 'UniformOutput', false);
                Scales{end + 1, 1} = ParameterRow{1}(:);
                InitialValues{end + 1, 1} = ParameterRow{2}(:);
                LowerBounds{end + 1, 1} = ParameterRow{3}(:);
                UpperBounds{end + 1, 1} = ParameterRow{4}(:);
                Units{end + 1, 1} = repmat({ParameterRow{5}}, numel(ParameterRow{1}), 1);
            else
                Names{end + 1, 1} = {ParameterName};
                Scales{end + 1, 1} = ParameterRow{1};
                InitialValues{end + 1, 1} = ParameterRow{2};
                LowerBounds{end + 1, 1} = ParameterRow{3};
                UpperBounds{end + 1, 1} = ParameterRow{4};
                Units{end + 1, 1} = {ParameterRow{5}};
            end
        end
    end
    %% 5. Append the charge trapping shift fitting definitions.
    Names{end + 1, 1} = arrayfun(@(idxShift) sprintf('ChargeTrappingShift(%d)', idxShift), (1 : State.Dependents.Data.ChargeTrappingShiftCount)', 'UniformOutput', false);
    Scales{end + 1, 1} = cellfun(@(Parameter) Parameter{1}, State.Dependents.FittingDefinitions.ChargeTrappingShift);
    InitialValues{end + 1, 1} = cellfun(@(Parameter) Parameter{2}, State.Dependents.FittingDefinitions.ChargeTrappingShift);
    LowerBounds{end + 1, 1} = cellfun(@(Parameter) Parameter{3}, State.Dependents.FittingDefinitions.ChargeTrappingShift);
    UpperBounds{end + 1, 1} = cellfun(@(Parameter) Parameter{4}, State.Dependents.FittingDefinitions.ChargeTrappingShift);
    Units{end + 1, 1} = cellfun(@(Parameter) Parameter{5}, State.Dependents.FittingDefinitions.ChargeTrappingShift, 'UniformOutput', false);
    %% 6. Write the parsed fitting definitions.
    State.Dependents.FittingDefinitions.Names = vertcat(Names{:});
    State.Dependents.FittingDefinitions.Scales = vertcat(Scales{:});
    State.Dependents.FittingDefinitions.InitialValues = vertcat(InitialValues{:});
    State.Dependents.FittingDefinitions.LowerBounds = vertcat(LowerBounds{:});
    State.Dependents.FittingDefinitions.UpperBounds = vertcat(UpperBounds{:});
    State.Dependents.FittingDefinitions.Units = vertcat(Units{:});
    %% 7. Setup the optimiser options for the current solver.
    State.Dependents.Optimiser.Solver = State.Dependents.Solver;
    switch(State.Dependents.Solver)
        case 'particleswarm'
            State.Dependents.Optimiser.Options.particleswarm = optimoptions('particleswarm', 'Display', 'iter', 'UseParallel', true, ...
                'MaxIterations', State.Variables.Solvers.particleswarm.MaxIterations, ...
                'MaxStallIterations', State.Variables.Solvers.particleswarm.MaxStallIterations, ...
                'FunctionTolerance', State.Variables.Solvers.particleswarm.FunctionTolerance, ...
                'HybridFcn', 'fmincon');
            State.Dependents.Optimiser.Options.fmincon = optimoptions('fmincon', 'Display', 'iter', 'UseParallel', true, ...
                'MaxIterations', State.Variables.Solvers.fmincon.MaxIterations, ...
                'MaxFunctionEvaluations', State.Variables.Solvers.fmincon.MaxFunctionEvaluations, ...
                'StepTolerance', State.Variables.Solvers.fmincon.StepTolerance, ...
                'OptimalityTolerance', State.Variables.Solvers.fmincon.OptimalityTolerance, ...
                'Algorithm', 'sqp');
        case 'ga'
            State.Dependents.Optimiser.Options.ga = optimoptions('ga', 'Display', 'iter', 'UseParallel', true, ...
                'MaxGenerations', State.Variables.Solvers.ga.MaxGenerations, ...
                'MaxStallGenerations', State.Variables.Solvers.ga.MaxStallGenerations, ...
                'PopulationSize', State.Variables.Solvers.ga.PopulationSize, ...
                'FunctionTolerance', State.Variables.Solvers.ga.FunctionTolerance, ...
                'HybridFcn', 'fmincon');
            State.Dependents.Optimiser.Options.fmincon = optimoptions('fmincon', 'Display', 'iter', 'UseParallel', true, ...
                'MaxIterations', State.Variables.Solvers.fmincon.MaxIterations, ...
                'MaxFunctionEvaluations', State.Variables.Solvers.fmincon.MaxFunctionEvaluations, ...
                'StepTolerance', State.Variables.Solvers.fmincon.StepTolerance, ...
                'OptimalityTolerance', State.Variables.Solvers.fmincon.OptimalityTolerance, ...
                'Algorithm', 'sqp');
        case 'fmincon'
            State.Dependents.Optimiser.Options.fmincon = optimoptions('fmincon', 'Display', 'iter', 'UseParallel', true, ...
                'MaxIterations', State.Variables.Solvers.fmincon.MaxIterations, ...
                'MaxFunctionEvaluations', State.Variables.Solvers.fmincon.MaxFunctionEvaluations, ...
                'StepTolerance', State.Variables.Solvers.fmincon.StepTolerance, ...
                'OptimalityTolerance', State.Variables.Solvers.fmincon.OptimalityTolerance, ...
                'Algorithm', 'sqp');
    end
end