%% Function: Update the results window.
function UpdateResultsWindow(State)
    %% 1. Plot D(Δε).
    %% 1A. Reset the axes and the overlay.
    cla(State.ResultsWindow.Axes(1));
    hold(State.ResultsWindow.Axes(1), 'on');
    %% 1B. Plot the figure.
    plot(State.ResultsWindow.Axes(1), State.Variables.DeltaEpsilon, State.Iterations.DensityOfStates, State.ResultsWindow.Markers{1}, ...
        'LineWidth', 1.7, 'Color', lines(1), 'LineStyle', '-', 'MarkerFaceColor', lines(1), 'MarkerSize', 2);
    hold(State.ResultsWindow.Axes(1), 'off');
    %% 1C. Format the axes.
    set(State.ResultsWindow.Axes(1), 'FontSize', 14, 'FontName', 'Helvetica', 'LineWidth', 1.5, 'Box', 'on', ...
        'TickDir', 'both', 'XMinorTick', 'on', 'YMinorTick', 'on', 'TickLabelInterpreter', 'tex');
    xlabel(State.ResultsWindow.Axes(1), '{\Delta}{\epsilon} [eV]', 'Interpreter', 'tex', 'FontSize', 18, 'FontName', 'Helvetica');
    ylabel(State.ResultsWindow.Axes(1), 'D({\Delta}{\epsilon}) [eV^{-1} m^{-3}]', 'Interpreter', 'tex', 'FontSize', 18, 'FontName', 'Helvetica');
    %% 1D. Add the grid and the legend.
    grid(State.ResultsWindow.Axes(1), 'on');
    legend(State.ResultsWindow.Axes(1), {'D({\Delta}{\epsilon})'}, 'Location', 'best', 'Interpreter', 'tex', 'FontSize', 12, 'Box', 'on');
    %% 2. Plot V_FG(Δε).
    %% 2A. Reset the axes and the overlay.
    cla(State.ResultsWindow.Axes(2));
    hold(State.ResultsWindow.Axes(2), 'on');
    %% 2B. Specify the colours, handles and labels for each {Type, Test}.
    Colours = lines(State.Dependents.Data.NumPlots);
    Handles = gobjects(1, size(Colours, 1));
    Legends = cell(1, size(Colours, 1));
    Index = 1;
    %% 2C. Iterate over each {Type, Test}.
    for Type = 1 : State.Dependents.Data.NumTypes
        for Test = 1 : State.Dependents.Data.NumTests(Type)
            Handles(Index) = plot(State.ResultsWindow.Axes(2), State.Variables.DeltaEpsilon, State.Iterations.VoltageDeltaEpsilonInterpolant{Type, Test}(State.Variables.DeltaEpsilon), ...
                State.ResultsWindow.Markers{Index}, 'LineWidth', 1.7, 'Color', Colours(Index, :), 'LineStyle', '-', 'MarkerFaceColor', Colours(Index, :), 'MarkerSize', 2);
            Legends{Index} = State.Dependents.Data.Columns{Type + 1}(Test);
            Index = Index + 1;
        end
    end
    hold(State.ResultsWindow.Axes(2), 'off');
    %% 2D. Format the axes.
    set(State.ResultsWindow.Axes(2), 'FontSize', 14, 'FontName', 'Helvetica', 'LineWidth', 1.5, 'Box', 'on', ...
        'TickDir', 'both', 'XMinorTick', 'on', 'YMinorTick', 'on', 'TickLabelInterpreter', 'tex');
    xlabel(State.ResultsWindow.Axes(2), '{\Delta}{\epsilon} [eV]', 'Interpreter', 'tex', 'FontSize', 18, 'FontName', 'Helvetica');
    ylabel(State.ResultsWindow.Axes(2), 'V_{FG} [V]', 'Interpreter', 'tex', 'FontSize', 18, 'FontName', 'Helvetica');
    %% 2E. Add the grid and the legend.
    grid(State.ResultsWindow.Axes(2), 'on');
    Handles = Handles(isgraphics(Handles));
    Legends = Legends(1 : numel(Handles));
    if(~isempty(Handles))
        legend(State.ResultsWindow.Axes(2), Handles, Legends, 'Location', 'best', 'Interpreter', 'tex', 'FontSize', 12, 'Box', 'on');
    end
end