%% Function: Read State.Variables into the fitting definitions section.
function State = VariablesToFittingDefinitionsSection(State)
    %% 1. Extract the requirement names from State.Variables.FittingDefinitions.
    RequirementNames = fieldnames(State.Variables.FittingDefinitions);
    %% 2. Count the rows.
    NumRows = sum(cellfun(@(Name) numel(fieldnames(State.Variables.FittingDefinitions.(Name))), RequirementNames));
    %% 3. Fill the table data from State.Variables.FittingDefinitions.
    Data = cell(NumRows, 7);
    RowIndex = 0;
    for idxRequirement = 1 : numel(RequirementNames)
        %% 3A. Write the name and requirement.
        RequirementName = RequirementNames{idxRequirement};
        ParameterNames = fieldnames(State.Variables.FittingDefinitions.(RequirementName));
        for idxParameter = 1 : numel(ParameterNames)
            %% 3B. Write the scale, initial value, lower bound and upper bound.
            RowIndex = RowIndex + 1;
            ParameterRow = State.Variables.FittingDefinitions.(RequirementName).(ParameterNames{idxParameter});
            Data(RowIndex, 1 : 2) = {ParameterNames{idxParameter}, RequirementName};
            Values = ParameterRow(1 : 4);
            NonScalarMask = cellfun(@(Value) isnumeric(Value) && ~isscalar(Value), Values);
            Values(NonScalarMask) = cellfun(@mat2str, Values(NonScalarMask), 'UniformOutput', false);
            Data(RowIndex, 3 : 6) = Values;
            %% 3C. Write the unit.
            Data{RowIndex, 7} = ParameterRow{5};
        end
    end
    %% 4. Update the table data.
    State.ConfigurationWindow.FittingDefinitionsSection.Table.Data = Data;
end