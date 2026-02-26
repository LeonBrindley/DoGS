%% Function: Evaluate the sub-struct State.Dependents.Optimiser.
function State = EvaluateOptimiser(State)
    %% 1. Clear the sub-struct State.Dependents.Optimiser.
    State.Dependents.Optimiser = struct;
    %% 2. Parse the fitting definition requirements for the current combination.
    Requirements = {'Any'};
    if(strcmp(State.Dependents.GapType, 'Soft'))
        Requirements{end + 1} = 'Soft';
    end
    Requirements{end + 1} = State.Dependents.Model;
    %% 3. Initialise storage for the parsed fitting definitions.
    Parsed = struct('Names', {{}}, 'Scales', {{}}, 'InitialValues', {{}}, 'LowerBounds', {{}}, 'UpperBounds', {{}}, 'Units', {{}});
    %% 4. Parse the fitting definitions selected by the current requirements.
    for idxRequirement = 1 : numel(Requirements)
        Definition = State.Variables.FittingDefinitions.(Requirements{idxRequirement});
        ParameterNames = fieldnames(Definition);
        for idxName = 1 : numel(ParameterNames)
            Values = Definition.(ParameterNames{idxName});
            if(isnumeric(Values{1}) && ~isscalar(Values{1}))
                Parsed.Names{end + 1, 1} = arrayfun(@(idxElement) sprintf('%s(%d)', ParameterNames{idxName}, idxElement), (1 : numel(Values{1}))', 'UniformOutput', false);
                Parsed.Scales{end + 1, 1} = Values{1}(:);
                Parsed.InitialValues{end + 1, 1} = Values{2}(:);
                Parsed.LowerBounds{end + 1, 1} = Values{3}(:);
                Parsed.UpperBounds{end + 1, 1} = Values{4}(:);
                Parsed.Units{end + 1, 1} = repmat({Values{5}}, numel(Values{1}), 1);
            else
                Parsed.Names{end + 1, 1} = ParameterNames(idxName);
                Parsed.Scales{end + 1, 1} = Values{1};
                Parsed.InitialValues{end + 1, 1} = Values{2};
                Parsed.LowerBounds{end + 1, 1} = Values{3};
                Parsed.UpperBounds{end + 1, 1} = Values{4};
                Parsed.Units{end + 1, 1} = Values(5);
            end
        end
    end
    %% 5. Append the charge trapping shift fitting definitions.
    ChargeTrappingShift = State.Dependents.FittingDefinitions.ChargeTrappingShift;
    Parsed.Names{end + 1, 1} = arrayfun(@(idxShift) sprintf('ChargeTrappingShift(%d)', idxShift), (1 : State.Dependents.Data.ChargeTrappingShiftCount)', 'UniformOutput', false);
    Parsed.Scales{end + 1, 1} = cellfun(@(Parameter) Parameter{1}, ChargeTrappingShift);
    Parsed.InitialValues{end + 1, 1} = cellfun(@(Parameter) Parameter{2}, ChargeTrappingShift);
    Parsed.LowerBounds{end + 1, 1} = cellfun(@(Parameter) Parameter{3}, ChargeTrappingShift);
    Parsed.UpperBounds{end + 1, 1} = cellfun(@(Parameter) Parameter{4}, ChargeTrappingShift);
    Parsed.Units{end + 1, 1} = cellfun(@(Parameter) Parameter{5}, ChargeTrappingShift, 'UniformOutput', false);
    %% 6. Write the parsed fitting definitions.
    ParsedFields = fieldnames(Parsed);
    for idxField = 1 : numel(ParsedFields)
        State.Dependents.FittingDefinitions.(ParsedFields{idxField}) = vertcat(Parsed.(ParsedFields{idxField}){:});
    end
    %% 7. Setup the optimiser options for the current solver.
    State.Dependents.Optimiser.Solver = State.Dependents.Solver;
    State.Dependents.Optimiser.Options.fmincon = optimoptions('fmincon', 'Display', 'iter', 'UseParallel', true, ...
        'MaxIterations', State.Variables.Solvers.fmincon.MaxIterations, ...
        'MaxFunctionEvaluations', State.Variables.Solvers.fmincon.MaxFunctionEvaluations, ...
        'StepTolerance', State.Variables.Solvers.fmincon.StepTolerance, ...
        'OptimalityTolerance', State.Variables.Solvers.fmincon.OptimalityTolerance, ...
        'Algorithm', 'sqp');
    switch(State.Dependents.Solver)
        case 'particleswarm'
            State.Dependents.Optimiser.Options.particleswarm = optimoptions('particleswarm', 'Display', 'iter', 'UseParallel', true, ...
                'MaxIterations', State.Variables.Solvers.particleswarm.MaxIterations, ...
                'MaxStallIterations', State.Variables.Solvers.particleswarm.MaxStallIterations, ...
                'FunctionTolerance', State.Variables.Solvers.particleswarm.FunctionTolerance, ...
                'HybridFcn', 'fmincon');
        case 'ga'
            State.Dependents.Optimiser.Options.ga = optimoptions('ga', 'Display', 'iter', 'UseParallel', true, ...
                'MaxGenerations', State.Variables.Solvers.ga.MaxGenerations, ...
                'MaxStallGenerations', State.Variables.Solvers.ga.MaxStallGenerations, ...
                'PopulationSize', State.Variables.Solvers.ga.PopulationSize, ...
                'FunctionTolerance', State.Variables.Solvers.ga.FunctionTolerance, ...
                'HybridFcn', 'fmincon');
    end
end