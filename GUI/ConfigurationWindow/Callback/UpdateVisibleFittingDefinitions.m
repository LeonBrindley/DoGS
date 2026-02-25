%% Function: Update the visible fitting definitions.
function State = UpdateVisibleFittingDefinitions(State)
    %% 1. Extract the table data.
    Table = State.ConfigurationWindow.FittingDefinitionsSection.Table;
    if(isempty(Table.UserData))
        Table.UserData = struct('FullData', {Table.Data}, 'VisibleIndices', {(1 : size(Table.Data, 1))'});
    end
    %% 2. Update the cached data.
    Table.UserData.FullData(Table.UserData.VisibleIndices, :) = Table.Data;
    %% 3. Determine the visible requirements.
    VisibleRequirements = [{'Any'}, State.Variables.Options.Models(:)'];
    if(any(strcmp(State.Variables.Options.GapTypes, 'Soft')))
        VisibleRequirements = [VisibleRequirements, {'Soft'}];
    end
    %% 4. Update the table data.
    Table.UserData.VisibleIndices = find(ismember(Table.UserData.FullData(:, 2), VisibleRequirements));
    Table.Data = Table.UserData.FullData(Table.UserData.VisibleIndices, :);
end