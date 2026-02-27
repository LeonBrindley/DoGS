%% Function: Construct the pchip model.
function State = ConstructPChipModel(State)
    %% 1. Construct the common model.
    State = ConstructCommonModel(State);
    %% 2. Parse all of the pchip fitting parameters.
    State.Iterations.idxFittingParameter = State.Iterations.idxFittingParameter + 1; State.Iterations.Width = State.Iterations.FittingParameters(State.Iterations.idxFittingParameter);
    State.Iterations.idxFittingParameter = State.Iterations.idxFittingParameter + State.Variables.NumRelativeKnots; State.Iterations.Knots = reshape(State.Iterations.FittingParameters( ...
        State.Iterations.idxFittingParameter - State.Variables.NumRelativeKnots + 1 : State.Iterations.idxFittingParameter), size(State.Variables.FittingDefinitions.PChip.Knots{2}));
    %% 3. Preallocate an array for the absolute knots.
    State.Iterations.DensityOfStatesAbsoluteKnots = zeros(1, State.Variables.NumAbsoluteKnots);
    %% 4. Initialise the central absolute knot to 1.
    State.Iterations.DensityOfStatesAbsoluteKnots(State.Variables.CentralKnot) = 1;
    %% 5. Convert the relative knots to absolute knots.
    CumulativeRelativeKnots = min(cumsum(State.Iterations.Knots), 1);
    State.Iterations.DensityOfStatesAbsoluteKnots(State.Variables.CentralKnot - (1 : State.Variables.NumRelativeKnots)) = 1 - CumulativeRelativeKnots(1 : State.Variables.NumRelativeKnots);
    State.Iterations.DensityOfStatesAbsoluteKnots(State.Variables.CentralKnot + (1 : State.Variables.NumRelativeKnots)) = 1 - CumulativeRelativeKnots(1 : State.Variables.NumRelativeKnots);
    %% 6. Construct D_C(Δε) from a pchip function.
    State.Iterations.CoulombGapDensityOfStates = max(pchip(State.Iterations.Width .* State.Variables.DeltaEpsilonBaseKnots, State.Iterations.Amplitude .* ...
        State.Iterations.DensityOfStatesAbsoluteKnots, State.Variables.DeltaEpsilon) .* (abs(State.Variables.DeltaEpsilon) <= State.Iterations.Width), eps);
    %% 7. Evaluate the density of states D(Δε), as well as its derivative dD(Δε)/dΔε.
    State = EvaluateDensityOfStates(State);
end