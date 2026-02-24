%% Function: Build the grid section.
function State = BuildGridSection(State)
    %% 1. Create the panel and layout.
    State.ConfigurationWindow.GridSection.Panel = uipanel('Parent', State.ConfigurationWindow.Grid, 'Title', 'Grid', 'FontWeight', 'bold', ...
        'FontName', 'Segoe UI', 'FontSize', 13, 'BackgroundColor', [1 1 1], 'ForegroundColor', [0.18 0.62 0.37], 'BorderType', 'line', 'BorderWidth', 3);
    State.ConfigurationWindow.GridSection.Layout = uigridlayout(State.ConfigurationWindow.GridSection.Panel, [1 1], 'Padding', [16 14 16 14], 'BackgroundColor', [1 1 1]);
    %% 2. Extract the row names from State.Variables.Grid.
    RowNames = fieldnames(State.Variables.Grid);
    %% 3. Count the rows.
    NumRows = numel(RowNames);
    %% 4. Create the table.
    State.ConfigurationWindow.GridSection.Table = uitable(State.ConfigurationWindow.GridSection.Layout, 'Data', cell(NumRows, 3), 'ColumnName', {'Name', 'Value', 'Unit'}, 'RowName', [], ...
        'ColumnEditable', [false true false], 'ColumnWidth', {'auto', 'auto', 'auto'}, 'FontName', 'Segoe UI', 'FontSize', 12, 'BackgroundColor', [1 1 1], 'RowStriping', 'off');
    %% 5. Style the table.
    GridTableStyle = uistyle('HorizontalAlignment', 'left'); addStyle(State.ConfigurationWindow.GridSection.Table, GridTableStyle);
    GridRowStyle = uistyle('BackgroundColor', [0.84 0.92 0.87]); addStyle(State.ConfigurationWindow.GridSection.Table, GridRowStyle, 'row', 2 : 2 : NumRows);
end