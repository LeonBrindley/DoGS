%% Function: Read State.Variables into the solvers section.
function State = VariablesToSolversSection(State)
    %% 1. Extract the requirement names from State.Variables.Solvers.
    RequirementNames = fieldnames(State.Variables.Solvers);
    %% 2. Count the rows.
    NumRows = sum(cellfun(@(Name) numel(fieldnames(State.Variables.Solvers.(Name))), RequirementNames));
    %% 3. Fill the table data from State.Variables.Solvers.
    Data = cell(NumRows, 3);
    RowIndex = 0;
    for idxRequirement = 1 : numel(RequirementNames)
        %% 3A. Write the name and requirement.
        RequirementName = RequirementNames{idxRequirement};
        ParameterNames = fieldnames(State.Variables.Solvers.(RequirementName));
        for idxParameter = 1 : numel(ParameterNames)
            %% 3B. Write the value.
            RowIndex = RowIndex + 1;
            Value = State.Variables.Solvers.(RequirementName).(ParameterNames{idxParameter});
            Data(RowIndex, 1 : 3) = {ParameterNames{idxParameter}, RequirementName, Value};
        end
    end
    %% 4. Update the table data.
    State.ConfigurationWindow.SolversSection.Table.Data = Data;
end