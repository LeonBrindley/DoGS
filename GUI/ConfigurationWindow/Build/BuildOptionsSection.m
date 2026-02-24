%% Function: Build the options section.
function State = BuildOptionsSection(State)
    %% 1. Create the panel and layout.
    State.ConfigurationWindow.OptionsSection.Panel = uipanel('Parent', State.ConfigurationWindow.Grid, 'Title', 'Options', 'FontWeight', 'bold', ...
        'FontName', 'Segoe UI', 'FontSize', 13, 'BackgroundColor', [1 1 1], 'ForegroundColor', [0.18 0.45 0.85], 'BorderType', 'line', 'BorderWidth', 3);
    State.ConfigurationWindow.OptionsSection.Layout = uigridlayout(State.ConfigurationWindow.OptionsSection.Panel, [1 5], 'Padding', [16 14 16 14], 'ColumnWidth', {'1x', '1x', '1x', '1x', '1x'}, 'BackgroundColor', [1 1 1]);
    %% 2. Build the check boxes for each category.
    for idxCategory = 1 : State.Constants.PossibleOptions.NumCategories
        %% 2A. Calculate the number of check boxes in the category.
        NumCheckBoxes = numel(State.Constants.PossibleOptions.All{idxCategory});
        %% 2B. Create the grid layout for the category.
        Category = uigridlayout(State.ConfigurationWindow.OptionsSection.Layout, [NumCheckBoxes 1], 'Padding', [0 0 0 0], 'RowSpacing', 6, 'BackgroundColor', [1 1 1]);
        Category.Layout.Row = 1; Category.Layout.Column = idxCategory; Category.RowHeight = repmat({'fit'}, 1, NumCheckBoxes);
        %% 2C. Create one check box for each option in the category.
        State.ConfigurationWindow.OptionsSection.CheckBoxes{idxCategory} = arrayfun(@(idxCheckBox) uicheckbox(Category, ...
            'Text', State.Constants.PossibleOptions.All{idxCategory}{idxCheckBox}, 'FontName', 'Segoe UI', 'FontSize', 12, ...
            'ValueChangedFcn', @OptionsSectionCallback), 1 : NumCheckBoxes);
    end
end