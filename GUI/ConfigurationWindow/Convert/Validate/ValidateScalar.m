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
    %% 2. Enforce any further constraints.
    switch Criteria
        case 'Positive'
            if(Value <= 0)
                if(nargin < 4 || isempty(PreviousValue))
                    error('%s must be a positive scalar. No previous value is defined.', Name);
                else
                    warning('%s must be a positive scalar. Switched to previous value.', Name);
                    Value = PreviousValue;
                end
            end
        case 'Negative'
            if(Value >= 0)
                if(nargin < 4 || isempty(PreviousValue))
                    error('%s must be a negative scalar. No previous value is defined.', Name);
                else
                    warning('%s must be a negative scalar. Switched to previous value.', Name);
                    Value = PreviousValue;
                end
            end
        case 'PositiveInteger'
            if(Value <= 0 || mod(Value, 1) ~= 0)
                if(nargin < 4 || isempty(PreviousValue))
                    error('%s must be a positive integer. No previous value is defined.', Name);
                else
                    warning('%s must be a positive integer. Switched to previous value.', Name);
                    Value = PreviousValue;
                end
            end
        case 'NegativeInteger'
            if(Value >= 0 || mod(Value, 1) ~= 0)
                if(nargin < 4 || isempty(PreviousValue))
                    error('%s must be a negative integer. No previous value is defined.', Name);
                else
                    warning('%s must be a negative integer. Switched to previous value.', Name);
                    Value = PreviousValue;
                end
            end
        case 'NonPositive'
            if(Value > 0)
                if(nargin < 4 || isempty(PreviousValue))
                    error('%s must be a non-positive scalar. No previous value is defined.', Name);
                else
                    warning('%s must be a non-positive scalar. Switched to previous value.', Name);
                    Value = PreviousValue;
                end
            end
        case 'NonNegative'
            if(Value < 0)
                if(nargin < 4 || isempty(PreviousValue))
                    error('%s must be a non-negative scalar. No previous value is defined.', Name);
                else
                    warning('%s must be a non-negative scalar. Switched to previous value.', Name);
                    Value = PreviousValue;
                end
            end
    end
end