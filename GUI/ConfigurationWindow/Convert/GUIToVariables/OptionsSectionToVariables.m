%% Function: Read the options section into State.Variables.
function State = OptionsSectionToVariables(State, PreviousOptions)
    %% 1. Read the check boxes into State.Variables.Options.
    for idxCategory = 1 : State.Constants.PossibleOptions.NumCategories
        %% 1A. Parse the check boxes for each category into the selected options.
        CategoryName = State.Constants.PossibleOptions.Categories{idxCategory};
        CategoryOptions = State.Constants.PossibleOptions.All{idxCategory};
        CategoryCheckBoxes = State.ConfigurationWindow.OptionsSection.CheckBoxes{idxCategory};
        %% 1B. If there is at least one selected option, update State.Variables accordingly.
        if(any([CategoryCheckBoxes.Value]))
            State.Variables.Options.(CategoryName) = CategoryOptions([CategoryCheckBoxes.Value]);
        %% 1C. If there are no selected options, attempt to restore the previous options.
        else
            %% 1D. If the previous options have not been specified, leave the check boxes blank.
            if(nargin < 2)
                State.Variables.Options.(CategoryName) = CategoryOptions([]);
            %% 1E. If the previous options have been specified, update the check boxes accordingly.
            else
                warning('No options selected for %s. Switched to previous values.', CategoryName);
                PreviousCheckBoxesMask = ismember(CategoryOptions, PreviousOptions.(CategoryName));
                for idxCheckBox = 1 : numel(CategoryCheckBoxes)
                    CategoryCheckBoxes(idxCheckBox).Value = PreviousCheckBoxesMask(idxCheckBox);
                end
                State.Variables.Options.(CategoryName) = PreviousOptions.(CategoryName);
            end
        end
        %% 1F. Record the number of selected options.
        State.Variables.Options.NumSelectedOptions(idxCategory) = numel(State.Variables.Options.(CategoryName));
    end
end