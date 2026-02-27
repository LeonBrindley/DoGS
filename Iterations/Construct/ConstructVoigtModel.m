%% Function: Construct the Voigt model.
function State = ConstructVoigtModel(State)
    %% 1. Construct the common model.
    State = ConstructCommonModel(State);
    %% 2. Parse all of the Voigt fitting parameters.
    State.Iterations.idxFittingParameter = State.Iterations.idxFittingParameter + 1; State.Iterations.Gamma = State.Iterations.FittingParameters(State.Iterations.idxFittingParameter);
    State.Iterations.idxFittingParameter = State.Iterations.idxFittingParameter + 1; State.Iterations.Sigma = State.Iterations.FittingParameters(State.Iterations.idxFittingParameter);
    %% 3. Construct the normalised Lorentzian function.
    State.Iterations.LorentzianVector = (State.Iterations.Gamma ./ pi) ./ ((State.Variables.DeltaEpsilon .^ 2) + (State.Iterations.Gamma .^ 2));
    %% 4. Construct the normalised Gaussian function.
    State.Iterations.GaussianVector = (1 ./ (State.Iterations.Sigma .* sqrt(2 .* pi))) .* exp(-0.5 .* ((State.Variables.DeltaEpsilon ./ State.Iterations.Sigma) .^ 2));
    %% 5. Construct the Voigt profile by convoluting the normalised Lorentzian and normalised Gaussian functions.
    State.Iterations.VoigtVector = conv(State.Iterations.LorentzianVector, State.Iterations.GaussianVector, 'same') .* State.Variables.Grid.Increment{1};
    %% 6. Construct the normalised Voigt profile. This is defined with respect to its value at Δε = 0 eV.
    State.Iterations.VoigtVector = State.Iterations.VoigtVector ./ State.Iterations.VoigtVector(State.Variables.idxZeroDeltaEpsilon);
    %% 7. Construct D_C(Δε) from the aforementioned normalised Voigt profile.
    State.Iterations.CoulombGapDensityOfStates = max(State.Iterations.Amplitude .* State.Iterations.VoigtVector, eps);
    %% 8. Evaluate the density of states D(Δε), as well as its derivative dD(Δε)/dΔε.
    State = EvaluateDensityOfStates(State);
end