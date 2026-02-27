%% Function: Construct the Gaussian model.
function State = ConstructGaussianModel(State)
    %% 1. Construct the common model.
    State = ConstructCommonModel(State);
    %% 2. Parse all of the Gaussian fitting parameters.
    State.Iterations.idxFittingParameter = State.Iterations.idxFittingParameter + 1; State.Iterations.Sigma = State.Iterations.FittingParameters(State.Iterations.idxFittingParameter);
    %% 3. Construct D_C(Δε) from a Gaussian function.
    State.Iterations.CoulombGapDensityOfStates = max(State.Iterations.Amplitude .* exp(-0.5 .* ((State.Variables.DeltaEpsilon ./ State.Iterations.Sigma) .^ 2)), eps);
    %% 4. Evaluate the density of states D(Δε), as well as its derivative dD(Δε)/dΔε.
    State = EvaluateDensityOfStates(State);
end