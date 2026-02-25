%% Function: Update the visible fitting definitions.
function State = UpdateVisibleFittingDefinitions(State)
    %% 1. Extract the table data.
    Table = State.ConfigurationWindow.FittingDefinitionsSection.Table;
    if(isempty(Table.UserData))
        Table.UserData = struct('FullData', {Table.Data}, 'FullNames', {Table.Data(:, [2 1])});
    end
    %% 2. Update the cached data.
    for idxRow = 1 : size(Table.Data, 1)
        CachedRow = strcmp(Table.UserData.FullNames(:, 1), Table.Data{idxRow, 2}) & strcmp(Table.UserData.FullNames(:, 2), Table.Data{idxRow, 1});
        Table.UserData.FullData(CachedRow, :) = Table.Data(idxRow, :);
    end
    %% 3. Determine the visible requirements.
    VisibleRequirements = [{'Any'}, State.Variables.Options.Models(:)'];
    if(any(strcmp(State.Variables.Options.GapTypes, 'Soft')))
        VisibleRequirements = [VisibleRequirements, {'Soft'}];
    end
    %% 4. Update the table data.
    Table.Data = Table.UserData.FullData(ismember(Table.UserData.FullNames(:, 1), VisibleRequirements), :);
end