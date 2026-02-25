%% Function: Validate a fitting definition.
function FittingDefinition = ValidateFittingDefinition(FittingDefinition, PreviousFittingDefinition)
    %% 1. Determine whether a previous fitting definition has been specified.
    HasPreviousFittingDefinition = (nargin >= 2 && ~isempty(PreviousFittingDefinition));
    FailureMessage = '';
    %% 2. Construct the text required for any subsequent failure message.
    DefinitionLocation = sprintf('%s.%s', FittingDefinition{2}, FittingDefinition{1});
    NumericNames = {'scale', 'initial value', 'lower bound', 'upper bound'};
    NumericIndices = 3 : 6;
    %% 3. Validate that the scale, initial value, lower bound and upper bound are finite.
    for ValueIndex = 1 : numel(NumericIndices)
        DefinitionValue = FittingDefinition{NumericIndices(ValueIndex)};
        if(~isnumeric(DefinitionValue) || any(~isfinite(DefinitionValue), 'all'))
            FailureMessage = sprintf('%s is a non-finite scalar or vector.', NumericNames{ValueIndex});
            break;
        end
    end
    %% 4. Validate that the scale, initial value, lower bound and upper bound have identical sizes.
    if(isempty(FailureMessage))
        Sizes = cellfun(@size, FittingDefinition(NumericIndices), 'UniformOutput', false);
        for ValueIndex = 2 : numel(Sizes)
            if(~isequal(Sizes{1}, Sizes{ValueIndex}))
                FailureMessage = sprintf('%s and %s do not have identical sizes.', NumericNames{1}, NumericNames{ValueIndex});
                break;
            end
        end
    end
    %% 5. Validate that lower bound <= initial value <= upper bound.
    if(isempty(FailureMessage))
        if(any(FittingDefinition{5} > FittingDefinition{4}, 'all'))
            FailureMessage = 'lower bound exceeds its initial value.';
        elseif(any(FittingDefinition{4} > FittingDefinition{6}, 'all'))
            FailureMessage = 'initial value exceeds its upper bound.';
        end
    end
    %% 6. If the fitting definition is invalid, revert to the previous fitting definition or throw an error.
    if(~isempty(FailureMessage))
        if(~HasPreviousFittingDefinition)
            error('%s %s No previous fitting definition has been specified.', DefinitionLocation, FailureMessage);
        else
            warning('%s %s Switched to previous fitting definition.', DefinitionLocation, FailureMessage);
            FittingDefinition(3 : 7) = PreviousFittingDefinition;
        end
    end
end