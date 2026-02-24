%% Function: Build the fitting definitions section.
function State = BuildFittingDefinitionsSection(State)
    %% 1. Create the panel and layout.
    State.ConfigurationWindow.FittingDefinitionsSection.Panel = uipanel('Parent', State.ConfigurationWindow.Grid, 'Title', 'Fitting Definitions', 'FontWeight', 'bold', ...
        'FontName', 'Segoe UI', 'FontSize', 13, 'BackgroundColor', [1 1 1], 'ForegroundColor', [0.53 0.36 0.75], 'BorderType', 'line', 'BorderWidth', 3);
    State.ConfigurationWindow.FittingDefinitionsSection.Layout = uigridlayout(State.ConfigurationWindow.FittingDefinitionsSection.Panel, [1 1], 'Padding', [16 14 16 14], 'BackgroundColor', [1 1 1]);
    %% 2. Extract the requirement names from State.Variables.FittingDefinitions.
    RequirementNames = fieldnames(State.Variables.FittingDefinitions);
    %% 3. Count the rows.
    NumRows = sum(cellfun(@(Name) numel(fieldnames(State.Variables.FittingDefinitions.(Name))), RequirementNames));
    %% 4. Create the table.
    State.ConfigurationWindow.FittingDefinitionsSection.Table = uitable(State.ConfigurationWindow.FittingDefinitionsSection.Layout, 'Data', cell(NumRows, 7), ...
        'ColumnName', {'Name', 'Requirement', 'Scale', 'Initial Value', 'Lower Bound', 'Upper Bound', 'Unit'}, 'RowName', [], 'ColumnEditable', [false false true true true true false], ...
        'ColumnWidth', {'auto', 'auto', 'auto', 'auto', 'auto', 'auto', 'auto'}, 'FontName', 'Segoe UI', 'FontSize', 12, 'BackgroundColor', [1 1 1], 'RowStriping', 'off');
    %% 5. Style the table.
    FittingDefinitionsTableStyle = uistyle('HorizontalAlignment', 'left'); addStyle(State.ConfigurationWindow.FittingDefinitionsSection.Table, FittingDefinitionsTableStyle);
    FittingDefinitionsRowStyle = uistyle('BackgroundColor', [0.91 0.87 0.95]); addStyle(State.ConfigurationWindow.FittingDefinitionsSection.Table, FittingDefinitionsRowStyle, 'row', 2 : 2 : NumRows);
end