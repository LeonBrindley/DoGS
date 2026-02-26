%% Function: Update the visible solvers.
function State = UpdateVisibleSolvers(State)
    %% 1. Fetch the current table.
    Table = State.ConfigurationWindow.SolversSection.Table;
    %% 2. Identify the visible requirements.
    VisibleRequirements = [{'Any'}, State.Variables.Options.Solvers(:)'];
    %% 3. If 'fmincon' is used as a hybrid function, update the visible requirements accordingly.
    if(any(ismember(State.Variables.Options.Solvers, {'ga', 'particleswarm'})))
        VisibleRequirements = [VisibleRequirements, {'fmincon'}];
    end
    %% 4. Update the visible rows accordingly.
    UpdateVisibleRows(Table, VisibleRequirements);
    %% 5. If 'fmincon' is not used as a primary function, hide NumberOfStartPoints accordingly.
    if(~any(strcmp(State.Variables.Options.Solvers, 'fmincon')))
        RowMask = strcmp(Table.Data(:, 2), 'fmincon') & strcmp(Table.Data(:, 1), 'NumberOfStartPoints');
        Table.Data(RowMask, :) = [];
        Table.UserData.VisibleRows(RowMask) = [];
    end
end