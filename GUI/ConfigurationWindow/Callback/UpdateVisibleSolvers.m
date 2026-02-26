%% Function: Update the visible solvers.
function State = UpdateVisibleSolvers(State)
    %% 1. Fetch the current table.
    Table = State.ConfigurationWindow.SolversSection.Table;
    %% 2. Identify the new visible requirements.
    VisibleRequirements = [{'Any'}, State.Variables.Options.Solvers(:)'];
    %% 3. Update the visible rows accordingly.
    UpdateVisibleRows(Table, VisibleRequirements);
end