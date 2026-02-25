%% Function: Validate a fitting definition.
function FittingDefinition = ValidateFittingDefinition(FittingDefinition, PreviousFittingDefinition)
    %% 1. Determine whether a previous fitting definition has been specified.
    HasPreviousFittingDefinition = (nargin >= 2 && ~isempty(PreviousFittingDefinition));
    FailureMessage = '';
    %% 2. Construct the text required for any subsequent failure message.
    DefinitionLocation = sprintf('%s.%s', FittingDefinition{2}, FittingDefinition{1});
    DefinitionNames = {'scale', 'initial value', 'lower bound', 'upper bound'};
    %% 2. Validate that the scale, initial value, lower bound and upper bound are finite.
    for ValueIndex = 1 : 4
        if(~isnumeric(FittingDefinition{ValueIndex + 2}) || any(~isfinite(FittingDefinition{ValueIndex + 2}), 'all'))
            FailureMessage = sprintf('%s contains a non-finite scalar or vector.', DefinitionNames{ValueIndex});
            break;
        end
    end
    %% 3. Validate that the scale, initial value, lower bound and upper bound have identical sizes.
    if(isempty(FailureMessage))
        Sizes = cellfun(@size, FittingDefinition(3 : 6), 'UniformOutput', false);
        if(~isequal(Sizes{1}, Sizes{2}))
            FailureMessage = 'scale and initial value do not have identical sizes.';
        elseif(~isequal(Sizes{1}, Sizes{3}))
            FailureMessage = 'scale and lower bound do not have identical sizes.';
        elseif(~isequal(Sizes{1}, Sizes{4}))
            FailureMessage = 'scale and upper bound do not have identical sizes.';
        end
    end
    %% 4. Validate that lower bound <= initial value <= upper bound.
    if(isempty(FailureMessage))
        if(any(FittingDefinition{5} > FittingDefinition{4}, 'all'))
            FailureMessage = 'lower bound exceeds initial value.';
        elseif(any(FittingDefinition{4} > FittingDefinition{6}, 'all'))
            FailureMessage = 'initial value exceeds upper bound.';
        end
    end
    %% 5. If the fitting definition is invalid, revert to the previous fitting definition or throw an error.
    if(~isempty(FailureMessage))
        if(~HasPreviousFittingDefinition)
            error('%s %s No previous fitting definition is defined.', DefinitionLocation, FailureMessage);
        else
            warning('%s %s Switched to previous fitting definition.', DefinitionLocation, FailureMessage);
            FittingDefinition(3 : 7) = PreviousFittingDefinition;
        end
    end
end