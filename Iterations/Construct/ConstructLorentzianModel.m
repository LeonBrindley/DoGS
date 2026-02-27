%% Function: Construct the Lorentzian model.
function State = ConstructLorentzianModel(State)
    %% 1. Construct the common model.
    State = ConstructCommonModel(State);
    %% 2. Parse all of the Lorentzian fitting parameters.
    State.Iterations.idxFittingParameter = State.Iterations.idxFittingParameter + 1; State.Iterations.Gamma = State.Iterations.FittingParameters(State.Iterations.idxFittingParameter);
    %% 3. Construct D_C(Δε) from a Lorentzian function.
    State.Iterations.CoulombGapDensityOfStates = max(State.Iterations.Amplitude .* (1 ./ (1 + ((State.Variables.DeltaEpsilon ./ State.Iterations.Gamma) .^ 2))), eps);
    %% 4. Evaluate the density of states D(Δε), as well as its derivative dD(Δε)/dΔε.
    State = EvaluateDensityOfStates(State);
end