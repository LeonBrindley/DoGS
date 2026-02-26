%% Function: Build the results window.
function State = BuildResultsWindow(State)
    %% 1. Create the figure and grid layout.
    State.ResultsWindow.Figure = uifigure('Name', 'Results Window', 'Color', [0.90 0.94 0.98], 'WindowState', 'maximized', 'Icon', fullfile(State.Constants.RootDirectory, 'Logo.png'));
    State.ResultsWindow.Grid = uigridlayout(State.ResultsWindow.Figure, [2 3], 'Padding', [24 24 24 24], 'RowSpacing', 18, 'ColumnSpacing', 18, 'BackgroundColor', [0.90 0.94 0.98]);
    State.ResultsWindow.Grid.RowHeight = {'1x', '1x'};
    State.ResultsWindow.Grid.ColumnWidth = {'1x', '1x', '1x'};
    %% 2. Create the axes.
    State.ResultsWindow.Axes = gobjects(6, 1);
    State.ResultsWindow.Axes(1) = uiaxes(State.ResultsWindow.Grid);
    State.ResultsWindow.Axes(1).Layout.Row = 1;
    State.ResultsWindow.Axes(1).Layout.Column = 1;
    State.ResultsWindow.Axes(2) = uiaxes(State.ResultsWindow.Grid);
    State.ResultsWindow.Axes(2).Layout.Row = 2;
    State.ResultsWindow.Axes(2).Layout.Column = 1;
    State.ResultsWindow.Axes(3) = uiaxes(State.ResultsWindow.Grid);
    State.ResultsWindow.Axes(3).Layout.Row = 1;
    State.ResultsWindow.Axes(3).Layout.Column = 2;
    State.ResultsWindow.Axes(4) = uiaxes(State.ResultsWindow.Grid);
    State.ResultsWindow.Axes(4).Layout.Row = 2;
    State.ResultsWindow.Axes(4).Layout.Column = 2;
    State.ResultsWindow.Axes(5) = uiaxes(State.ResultsWindow.Grid);
    State.ResultsWindow.Axes(5).Layout.Row = 1;
    State.ResultsWindow.Axes(5).Layout.Column = 3;
    State.ResultsWindow.Axes(6) = uiaxes(State.ResultsWindow.Grid);
    State.ResultsWindow.Axes(6).Layout.Row = 2;
    State.ResultsWindow.Axes(6).Layout.Column = 3;
    %% 3. Define the markers.
    State.ResultsWindow.Markers = {'o', 's', '^', 'v', 'd', 'x', '+', '.', '*'};
    %% 4. Store State in the results window figure user data.
    State.ResultsWindow.Figure.UserData = State;
    %% 5. Store State in the configuration window figure user data.
    State.ConfigurationWindow.Figure.UserData = State;
end