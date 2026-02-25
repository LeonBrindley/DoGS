%% Function: Validate a Fitting Definition.
function FittingDefinition = ValidateFittingDefinition(FittingDefinition, PreviousFittingDefinition)
    %% 1. Determine whether a previous fitting definition has been specified.
    HasPreviousFittingDefinition = (nargin >= 4 && ~isempty(PreviousFittingDefinition));
    FailureMessage = '';
end