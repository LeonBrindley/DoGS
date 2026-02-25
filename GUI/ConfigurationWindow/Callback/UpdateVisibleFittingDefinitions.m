%% Function: Update the visible fitting definitions.
function State = UpdateVisibleFittingDefinitions(State)
    %% 1. Fetch the current table.
    Table = State.ConfigurationWindow.FittingDefinitionsSection.Table;
    %% 2. Save any edits from the old visible rows.
    Table.UserData.AllRows(Table.UserData.VisibleRowIndices, :) = Table.Data;
    %% 3. Identify the new visible requirements.
    VisibleRequirements = [{'Any'}, State.Variables.Options.Models(:)', intersect(State.Variables.Options.GapTypes, {'Soft'})];
    %% 4. Identify the new visible rows.
    Table.UserData.VisibleRowIndices = find(ismember(Table.UserData.AllRows(:, 2), VisibleRequirements));
    %% 5. Update the visible rows.
    Table.Data = Table.UserData.AllRows(Table.UserData.VisibleRowIndices, :);
end