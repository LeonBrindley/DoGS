%% Function: Update the visible fitting definitions.
function State = UpdateVisibleFittingDefinitions(State)
    %% 1. Fetch the current table.
    Table = State.ConfigurationWindow.FittingDefinitionsSection.Table;
    %% 2. Identify the visible requirements.
    VisibleRequirements = [{'Any'}, State.Variables.Options.Models(:)', intersect(State.Variables.Options.GapTypes, {'Soft'})];
    %% 3. Update the visible rows accordingly.
    UpdateVisibleRows(Table, VisibleRequirements);
end