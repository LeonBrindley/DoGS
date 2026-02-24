%% Function: Read State.Variables into the options section.
function State = VariablesToOptionsSection(State)
    %% 1. Read State.Variables.Options into the check boxes.
    for idxCategory = 1 : State.Constants.PossibleOptions.NumCategories
        %% 1A. Parse the check boxes for each category.
        CategoryName = State.Constants.PossibleOptions.Categories{idxCategory};
        Options = State.Constants.PossibleOptions.All{idxCategory};
        %% 1B. Identify the selected options.
        SelectedOptions = State.Variables.Options.(CategoryName);
        Mask = ismember(Options, SelectedOptions);
        CheckBoxes = State.ConfigurationWindow.OptionsSection.CheckBoxes{idxCategory};
        %% 1C. Apply the selected options to the check boxes.
        for idxCheckBox = 1 : numel(CheckBoxes)
            CheckBoxes(idxCheckBox).Value = Mask(idxCheckBox);
        end
    end
end