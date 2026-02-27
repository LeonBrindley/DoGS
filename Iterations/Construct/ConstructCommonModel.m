%% Function: Construct the common model.
function State = ConstructCommonModel(State)
    %% 1. Parse all of the scalar common fitting parameters.
    State.Iterations.idxFittingParameter = 1; State.Iterations.BackgroundSlope = State.Iterations.FittingParameters(State.Iterations.idxFittingParameter);
    State.Iterations.idxFittingParameter = State.Iterations.idxFittingParameter + 1; State.Iterations.FieldEffectMobility = State.Iterations.FittingParameters(State.Iterations.idxFittingParameter);
    State.Iterations.idxFittingParameter = State.Iterations.idxFittingParameter + 1; State.Iterations.FieldEffectLayerThickness = State.Iterations.FittingParameters(State.Iterations.idxFittingParameter);
    State.Iterations.idxFittingParameter = State.Iterations.idxFittingParameter + 1; State.Iterations.Amplitude = State.Iterations.FittingParameters(State.Iterations.idxFittingParameter);
    %% 2. Parse all of the vector common fitting parameters.
    State.Iterations.idxFittingParameter = State.Iterations.idxFittingParameter + prod(State.Dependents.Data.ChargeTrappingShiftSize); State.Iterations.ChargeTrappingShift = reshape( ...
        State.Iterations.FittingParameters(State.Iterations.idxFittingParameter - prod(State.Dependents.Data.ChargeTrappingShiftSize) + 1 : State.Iterations.idxFittingParameter), State.Dependents.Data.ChargeTrappingShiftSize);
    %% 3A. Parse the background offset fitting parameter, if applicable.
    if(strcmpi(State.Dependents.GapType, 'Soft'))
        State.Iterations.idxFittingParameter = State.Iterations.idxFittingParameter + 1; State.Iterations.BackgroundOffset = State.Iterations.FittingParameters(State.Iterations.idxFittingParameter);
    %% 3B. Set the background offset to the amplitude, if applicable.
    else
        State.Iterations.BackgroundOffset = State.Iterations.Amplitude;
    end
end