%% Function: Read the fitting definitions section into State.Variables.
function State = FittingDefinitionsSectionToVariables(State, PreviousFittingDefinitions)
    %% 1. Read the table data.
    Data = State.ConfigurationWindow.FittingDefinitionsSection.Table.Data;
    %% 2. Write the table data into State.Variables.FittingDefinitions.
    for RowIndex = 1 : size(Data, 1)
        %% 2A. Read the name and requirement.
        RowName = Data{RowIndex, 1};
        RowRequirement = Data{RowIndex, 2};
        %% 2B. Read the scale, initial value, lower bound and upper bound.
        RowValues = Data(RowIndex, 3 : 6);
        %% 2C. Read the unit.
        RowUnit = Data{RowIndex, 7};
        %% 2D. Parse the previous row.
        PreviousRow = [RowValues, {RowUnit}];
        if(isfield(PreviousFittingDefinitions, RowRequirement) && isfield(PreviousFittingDefinitions.(RowRequirement), RowName))
            PreviousRow = PreviousFittingDefinitions.(RowRequirement).(RowName);
        end
        %% 2E. Validate the new row.
        NewRow = ValidateFittingDefinition([RowValues, {RowUnit}], PreviousRow, RowRequirement, RowName);
        %% 2F. Write the new row.
        State.Variables.FittingDefinitions.(RowRequirement).(RowName) = NewRow;
        %% 2G. Compose the table data.
        Data(RowIndex, 3 : 6) = NewRow(1 : 4);
        for idxColumn = 3 : 6
            if(isnumeric(Data{RowIndex, idxColumn}) && ~isscalar(Data{RowIndex, idxColumn}))
                Data{RowIndex, idxColumn} = mat2str(Data{RowIndex, idxColumn});
            end
        end
        Data{RowIndex, 7} = NewRow{5};
    end
    %% 3. Update the table data.
    State.ConfigurationWindow.FittingDefinitionsSection.Table.Data = Data;
end