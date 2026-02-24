%% Function: Evaluate the knots for the pchip model.
function State = EvaluateKnots(State)
    %% 1. Calculate the number of relative knots.
    State.Variables.NumRelativeKnots = numel(State.Variables.FittingDefinitions.PChip.Knots{2});
    %% 2. Calculate the number of absolute knots.
    State.Variables.NumAbsoluteKnots = (2 .* State.Variables.NumRelativeKnots) + 1;
    %% 3. Store the index of the central knot.
    State.Variables.CentralKnot = ceil(State.Variables.NumAbsoluteKnots / 2);
    %% 4. Construct the array of base knots.
    State.Variables.DeltaEpsilonBaseKnots = linspace(-1, 1, State.Variables.NumAbsoluteKnots);
end