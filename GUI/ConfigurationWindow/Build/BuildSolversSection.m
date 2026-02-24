%% Function: Build the solvers section.
function State = BuildSolversSection(State)
    %% 1. Create the panel and layout.
    State.ConfigurationWindow.SolversSection.Panel = uipanel('Parent', State.ConfigurationWindow.Grid, 'Title', 'Solvers', 'FontWeight', 'bold', ...
        'FontName', 'Segoe UI', 'FontSize', 13, 'BackgroundColor', [1 1 1], 'ForegroundColor', [0.86 0.50 0.20], 'BorderType', 'line', 'BorderWidth', 3);
    State.ConfigurationWindow.SolversSection.Layout = uigridlayout(State.ConfigurationWindow.SolversSection.Panel, [1 1], 'Padding', [16 14 16 14], 'BackgroundColor', [1 1 1]);
    %% 2. Extract the requirement names from State.Variables.Solvers.
    RequirementNames = fieldnames(State.Variables.Solvers);
    %% 3. Count the rows.
    NumRows = sum(cellfun(@(Name) numel(fieldnames(State.Variables.Solvers.(Name))), RequirementNames));
    %% 4. Create the table.
    State.ConfigurationWindow.SolversSection.Table = uitable(State.ConfigurationWindow.SolversSection.Layout, 'Data', cell(NumRows, 3), ...
        'ColumnName', {'Name', 'Requirement', 'Value'}, 'RowName', [], 'ColumnEditable', [false false true], 'ColumnWidth', {'auto', 'auto', 'auto'}, ...
        'FontName', 'Segoe UI', 'FontSize', 12, 'BackgroundColor', [1 1 1], 'RowStriping', 'off');
    %% 5. Style the table.
    SolversTableStyle = uistyle('HorizontalAlignment', 'left'); addStyle(State.ConfigurationWindow.SolversSection.Table, SolversTableStyle);
    SolversRowStyle = uistyle('BackgroundColor', [0.97 0.90 0.84]); addStyle(State.ConfigurationWindow.SolversSection.Table, SolversRowStyle, 'row', 2 : 2 : NumRows);
end