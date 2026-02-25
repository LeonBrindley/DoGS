%% Function: Read the solvers section into State.Variables.
function State = SolversSectionToVariables(State, PreviousSolvers)
    %% 1. Read the table data.
    Data = State.ConfigurationWindow.SolversSection.Table.Data;
    %% 2. Write the table data into State.Variables.Solvers.
    for RowIndex = 1 : size(Data, 1)
        %% 2A. Read the name and requirement.
        RowName = Data{RowIndex, 1};
        RowRequirement = Data{RowIndex, 2};
        %% 2B. Convert the value from a string to a numeric value.
        Data{RowIndex, 3} = str2double(Data{RowIndex, 3});
        %% 2C. Determine the criteria associated with the row.
        switch RowName
            case {'ConductanceWeight', 'SeebeckWeight'}
                RowCriteria = 'NonNegative';
            case {'NumberOfSavedSolutions', 'MaxIterations', 'MaxStallIterations', 'NumberOfRuns', ...
                'MaxGenerations', 'MaxStallGenerations', 'PopulationSize', 'MaxFunctionEvaluations', 'NumberOfStartPoints'}
                RowCriteria = 'PositiveInteger';
            case {'FunctionTolerance', 'StepTolerance', 'OptimalityTolerance'}
                RowCriteria = 'Positive';
            otherwise
                RowCriteria = 'None';
        end
        %% 2D. Validate the row.
        if(isfield(PreviousSolvers, RowRequirement) && isfield(PreviousSolvers.(RowRequirement), RowName))
            Data(RowIndex, 3) = ValidateScalar(Data(RowIndex, 3), RowCriteria, sprintf('%s.%s', RowRequirement, RowName), PreviousSolvers.(RowRequirement).(RowName));
        else
            Data(RowIndex, 3) = ValidateScalar(Data(RowIndex, 3), RowCriteria, sprintf('%s.%s', RowRequirement, RowName));
        end
        %% 2E. Write the row.
        State.Variables.Solvers.(RowRequirement).(RowName) = Data(RowIndex, 3);
        %% 2F. Convert the value from a numeric value to a string.
        Data{RowIndex, 3} = num2str(Data{RowIndex, 3});
    end
    %% 3. Validate Any.NumberOfSavedSolutions against fmincon.NumberOfStartPoints, if applicable.
    if(ismember('fmincon', State.Variables.Options.Solvers))
        if(State.Variables.Solvers.Any.NumberOfSavedSolutions > State.Variables.Solvers.fmincon.NumberOfStartPoints)
            warning('Any.NumberOfSavedSolutions > fmincon.NumberOfStartPoints. Setting Any.NumberOfSavedSolutions = fmincon.NumberOfStartPoints.');
            State.Variables.Solvers.Any.NumberOfSavedSolutions = State.Variables.Solvers.fmincon.NumberOfStartPoints;
            Data{strcmp(Data(:, 1), 'NumberOfSavedSolutions'), 3} = num2str(State.Variables.Solvers.Any.NumberOfSavedSolutions);
        end
    end
    %% 4. Update the table data.
    State.ConfigurationWindow.SolversSection.Table.Data = Data;
end