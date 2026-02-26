%% Function: Update the visible rows in a table.
function UpdateVisibleRows(Table, VisibleRequirements)
    %% 1. Initialise the relevant table's user data, if applicable.
    if(isempty(Table.UserData))
        Table.UserData.AllRows = Table.Data;
        Table.UserData.VisibleRows = transpose(1 : size(Table.Data, 1));
    end
    %% 2. Save any edits from the old visible rows.
    Table.UserData.AllRows(Table.UserData.VisibleRows, :) = Table.Data;
    %% 3. Identify the new visible rows.
    Table.UserData.VisibleRows = find(ismember(Table.UserData.AllRows(:, 2), VisibleRequirements));
    %% 4. Update the visible rows accordingly.
    Table.Data = Table.UserData.AllRows(Table.UserData.VisibleRows, :);
end