%% Function: Read the fitting definitions section into State.Variables.
function State = FittingDefinitionsSectionToVariables(State, PreviousFittingDefinitions)
    %% 1. Read the table data.
    Data = State.ConfigurationWindow.FittingDefinitionsSection.Table.Data;
    %% 2. Write the table data into State.Variables.FittingDefinitions.
    for RowIndex = 1 : size(Data, 1)
        %% 2A. Read the name and requirement.
        RowName = Data{RowIndex, 1};
        RowRequirement = Data{RowIndex, 2};
        %% 2B. Convert the scale, initial value, lower bound and upper bound from strings to numeric values.
        Data{RowIndex, 3} = str2double(Data{RowIndex, 3});
        Data{RowIndex, 4} = str2double(Data{RowIndex, 4});
        Data{RowIndex, 5} = str2double(Data{RowIndex, 5});
        Data{RowIndex, 6} = str2double(Data{RowIndex, 6});
        %% 2C. Validate the row.
        Data{RowIndex} = ValidateFittingDefinition(Data{RowIndex}, PreviousFittingDefinitions);
        %% 2D. Write the row.
        State.Variables.FittingDefinitions.(RowRequirement).(RowName) = Data{RowIndex, 3 : 6};
        %% 2E. Convert the scale, initial value, lower bound and upper bound from numeric values to strings.
        Data{RowIndex, 3} = num2str(Data{RowIndex, 3});
        Data{RowIndex, 4} = num2str(Data{RowIndex, 4});
        Data{RowIndex, 5} = num2str(Data{RowIndex, 5});
        Data{RowIndex, 6} = num2str(Data{RowIndex, 6});
    end
    %% 3. Update the table data.
    State.ConfigurationWindow.FittingDefinitionsSection.Table.Data = Data;
end