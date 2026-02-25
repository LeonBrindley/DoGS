%% Function: Validate a scalar.
function Value = ValidateScalar(Value, Criteria, Name, PreviousValue)
    %% 1. Validate that the input is a finite scalar.
    if(~isscalar(Value) || ~isnumeric(Value) || ~isfinite(Value))
        if(nargin < 4 || isempty(PreviousValue))
            error('%s is not a finite scalar. No previous value is defined.', Name);
        else
            warning('%s is not a finite scalar. Switched to previous value.', Name);
            Value = PreviousValue;
        end   
    end
end