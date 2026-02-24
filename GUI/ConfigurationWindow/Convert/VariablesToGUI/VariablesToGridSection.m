%% Function: Read State.Variables into the grid section.
function State = VariablesToGridSection(State)
    %% 1. Extract the row names from State.Variables.Grid.
    RowNames = fieldnames(State.Variables.Grid);
    %% 2. Fill the table data from State.Variables.Grid.
    Data = cell(numel(RowNames), 3);
    for RowIndex = 1 : numel(RowNames)
        GridRow = State.Variables.Grid.(RowNames{RowIndex});
        %% 2A. Write the name.
        Data{RowIndex, 1} = RowNames{RowIndex};
        %% 2B. Write the value.
        Data{RowIndex, 2} = GridRow{1};
        %% 2C. Write the unit.
        Data{RowIndex, 3} = GridRow{2};
    end
    %% 3. Update the table data.
    State.ConfigurationWindow.GridSection.Table.Data = Data;
end