%% Function: Validate a scalar.
function Value = ValidateScalar(Value, Criteria, Name, PreviousValue)
    %% 1. Determine whether a previous value has been specified.
    HasPreviousValue = (nargin >= 4 && ~isempty(PreviousValue));
    FailureMessage = '';
    %% 2. Validate that the input is a finite scalar.
    if(~isscalar(Value) || ~isnumeric(Value) || ~isfinite(Value))
        FailureMessage = 'is not a finite scalar.';
    end
    %% 3. Enforce any further constraints.
    if(isempty(FailureMessage))
        switch Criteria
            case 'Positive'
                if(Value <= 0)
                    FailureMessage = 'is not a positive scalar.';
                end
            case 'Negative'
                if(Value >= 0)
                    FailureMessage = 'is not a negative scalar.';
                end
            case 'PositiveInteger'
                if(Value <= 0 || mod(Value, 1) ~= 0)
                    FailureMessage = 'is not a positive integer.';
                end
            case 'NegativeInteger'
                if(Value >= 0 || mod(Value, 1) ~= 0)
                    FailureMessage = 'is not a negative integer.';
                end
            case 'NonPositive'
                if(Value > 0)
                    FailureMessage = 'is not a non-positive scalar.';
                end
            case 'NonNegative'
                if(Value < 0)
                    FailureMessage = 'is not a non-negative scalar.';
                end
        end
    end
    %% 4. If the scalar is invalid, revert to the previous value or throw an error.
    if(~isempty(FailureMessage))
        if(~HasPreviousValue)
            error('%s %s No previous value is defined.', Name, FailureMessage);
        else
            warning('%s %s Switched to previous value.', Name, FailureMessage);
            Value = PreviousValue;
        end
    end
end