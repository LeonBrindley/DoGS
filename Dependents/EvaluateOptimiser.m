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
    %% 3. Evaluate the aforementioned fitting definitions.
    %% 3A. Initialise containers for parsed fitting definition fields.
    ParsedFields = {'Names', 'Scales', 'InitialValues', 'LowerBounds', 'UpperBounds', 'Units'};
    Parsed = struct('Names', {{}}, 'Scales', {{}}, 'InitialValues', {{}}, 'LowerBounds', {{}}, 'UpperBounds', {{}}, 'Units', {{}});
    %% 3B. Iterate over each requirement selected for the current combination.
    for idxRequirement = 1 : numel(Requirements)
        %% 3C. Enumerate the parameter names defined for the current requirement.
        ParameterNames = fieldnames(State.Variables.FittingDefinitions.(Requirements{idxRequirement}));
        %% 3D. Iterate over each parameter name for the current requirement.
        for idxName = 1 : numel(ParameterNames)
            %% 3E. Read the parameter values in the order: scale, initial value, lower bound, upper bound, unit.
            Values = State.Variables.FittingDefinitions.(Requirements{idxRequirement}).(ParameterNames{idxName});
            %% 3F. Expand parameter names into indexed entries for vector-valued parameters.
            Parsed.Names{end + 1, 1} = arrayfun(@(idxElement) sprintf('%s(%d)', ParameterNames{idxName}, idxElement), (1 : numel(Values{1}))', 'UniformOutput', false);
            if(isscalar(Values{1}))
                %% 3G. Keep scalar-valued parameters as a single non-indexed name.
                Parsed.Names{end, 1} = ParameterNames(idxName);
            end
            %% 3H. Append scales, initial values and bounds as column vectors.
            Parsed.Scales{end + 1, 1} = Values{1}(:);
            Parsed.InitialValues{end + 1, 1} = Values{2}(:);
            Parsed.LowerBounds{end + 1, 1} = Values{3}(:);
            Parsed.UpperBounds{end + 1, 1} = Values{4}(:);
            %% 3I. Replicate the parameter unit once per parsed element.
            Parsed.Units{end + 1, 1} = repmat({Values{5}}, numel(Values{1}), 1);
        end
        if(idxRequirement == 1)
            %% 3J. Append charge trapping shift names based on the inferred shift count.
            Parsed.Names{end + 1, 1} = arrayfun(@(idxShift) sprintf('ChargeTrappingShift(%d)', idxShift), (1 : State.Dependents.Data.ChargeTrappingShiftCount)', 'UniformOutput', false);
            %% 3K. Append charge trapping shift scales, initial values, bounds and units.
            Parsed.Scales{end + 1, 1} = cellfun(@(Parameter) Parameter{1}, State.Dependents.FittingDefinitions.ChargeTrappingShift);
            Parsed.InitialValues{end + 1, 1} = cellfun(@(Parameter) Parameter{2}, State.Dependents.FittingDefinitions.ChargeTrappingShift);
            Parsed.LowerBounds{end + 1, 1} = cellfun(@(Parameter) Parameter{3}, State.Dependents.FittingDefinitions.ChargeTrappingShift);
            Parsed.UpperBounds{end + 1, 1} = cellfun(@(Parameter) Parameter{4}, State.Dependents.FittingDefinitions.ChargeTrappingShift);
            Parsed.Units{end + 1, 1} = cellfun(@(Parameter) Parameter{5}, State.Dependents.FittingDefinitions.ChargeTrappingShift, 'UniformOutput', false);
        end
    end
    %% 3L. Flatten parsed fitting definitions into State.Dependents.FittingDefinitions.
    for idxField = 1 : numel(ParsedFields)
        State.Dependents.FittingDefinitions.(ParsedFields{idxField}) = vertcat(Parsed.(ParsedFields{idxField}){:});
    end
    %% 4. Configure the optimiser options for the relevant solver.
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