%% Function: Construct the power law model.
function State = ConstructPowerLawModel(State)
    %% 1. Construct the common model.
    State = ConstructCommonModel(State);
    %% 2. Parse all of the power law fitting parameters.
    State.Iterations.idxFittingParameter = State.Iterations.idxFittingParameter + 1; State.Iterations.Width = State.Iterations.FittingParameters(State.Iterations.idxFittingParameter);
    State.Iterations.idxFittingParameter = State.Iterations.idxFittingParameter + 1; State.Iterations.Exponent = State.Iterations.FittingParameters(State.Iterations.idxFittingParameter);
    %% 3. Construct D_C(Δε) from a power law.
    State.Iterations.CoulombGapDensityOfStates = max(State.Iterations.Amplitude .* (1 - ((abs(State.Variables.DeltaEpsilon) ./ State.Iterations.Width) .^ State.Iterations.Exponent)), eps);
    %% 4. Evaluate the density of states D(Δε), as well as its derivative dD(Δε)/dΔε.
    State = EvaluateDensityOfStates(State);
end