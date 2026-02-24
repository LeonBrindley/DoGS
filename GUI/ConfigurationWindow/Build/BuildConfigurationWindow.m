%% Function: Build the configuration window.
function State = BuildConfigurationWindow(State)
    %% 1. Create the figure and grid layout.
    State.ConfigurationWindow.Figure = uifigure('Name', 'Configuration Window', 'Color', [0.90 0.94 0.98], 'WindowState', 'maximized', 'Icon', fullfile(State.Constants.RootDirectory, 'Logo.png'));
    State.ConfigurationWindow.Grid = uigridlayout(State.ConfigurationWindow.Figure, [5 1], 'Padding', [24 24 24 24], 'RowSpacing', 18, 'BackgroundColor', [0.90 0.94 0.98]);
    State.ConfigurationWindow.Grid.RowHeight = {'1x', '1x', '1x', '1x', 60};
    %% 2. Build the options section.
    State = BuildOptionsSection(State);
    %% 3. Build the grid section.
    State = BuildGridSection(State);
    %% 4. Build the fitting definitions section.
    State = BuildFittingDefinitionsSection(State);
    %% 5. Build the solvers section.
    State = BuildSolversSection(State);
    %% 6. Build the buttons section.
    State = BuildButtonsSection(State);
    %% 7. Read State.Variables into the configuration window data.
    State = VariablesToConfigurationWindow(State);
    %% 8. Store the state in the figure user data.
    State.ConfigurationWindow.Figure.UserData = State;
end