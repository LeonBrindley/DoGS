%% Function: Build the buttons section.
function State = BuildButtonsSection(State)
    %% 1. Create the layout.
    ButtonLayout = uigridlayout(State.ConfigurationWindow.Grid, [1 3], 'Padding', [0 0 0 0], 'ColumnSpacing', 16, 'BackgroundColor', [0.90 0.94 0.98]);
    ButtonLayout.Layout.Row = 5; ButtonLayout.Layout.Column = 1;
    %% 2. Create the apply button.
    ApplyButton = uibutton(ButtonLayout, 'Text', 'Apply', 'FontName', 'Segoe UI', 'FontWeight', 'bold', 'FontSize', 15, 'BackgroundColor', [0.14 0.45 0.80], ...
        'FontColor', [1 1 1], 'ButtonPushedFcn', @(~, ~) ApplyButtonCallback(State.ConfigurationWindow.Figure));
    ApplyButton.Layout.Row = 1; ApplyButton.Layout.Column = 1;
    %% 3. Create the optimise button.
    OptimiseButton = uibutton(ButtonLayout, 'Text', 'Optimise', 'FontName', 'Segoe UI', 'FontWeight', 'bold', 'FontSize', 15, 'BackgroundColor', [0.12 0.56 0.70], ...
        'FontColor', [1 1 1], 'ButtonPushedFcn', @(~, ~) OptimiseButtonCallback(State.ConfigurationWindow.Figure));
    OptimiseButton.Layout.Row = 1; OptimiseButton.Layout.Column = 2;
    %% 4. Create the reset button.
    ResetButton = uibutton(ButtonLayout, 'Text', 'Reset', 'FontName', 'Segoe UI', 'FontWeight', 'bold', 'FontSize', 15, 'BackgroundColor', [0.92 0.94 0.97], ...
        'FontColor', [0.20 0.25 0.35], 'ButtonPushedFcn', @(~, ~) ResetButtonCallback(State.ConfigurationWindow.Figure));
    ResetButton.Layout.Row = 1; ResetButton.Layout.Column = 3;
end