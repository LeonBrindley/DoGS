%% Function: Validate a Fitting Definition.
function FittingDefinition = ValidateFittingDefinition(FittingDefinition, PreviousFittingDefinition)
    %% 1. Determine whether a previous fitting definition has been specified.
    HasPreviousFittingDefinition = (nargin >= 2 && ~isempty(PreviousFittingDefinition));
    FailureMessage = '';
    %% 2. Validate that the scale, initial value, lower bound and upper bound are finite.
    if(any(~cellfun(@(Value) isnumeric(Value) && all(isfinite(Value), 'all'), FittingDefinition(3 : 6))))
        FailureMessage = ' is not a finite scalar or vector.';
    end
end