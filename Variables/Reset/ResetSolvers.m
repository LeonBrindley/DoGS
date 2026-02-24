%% Function: Reset the sub-struct State.Variables.Solvers.
function State = ResetSolvers(State)
    %% 1. Reset the variables for any solver.
    State.Variables.Solvers.Any.ConductanceWeight = 1.0;
    State.Variables.Solvers.Any.SeebeckWeight = 1.0;
    State.Variables.Solvers.Any.NumberOfSavedSolutions = 4;
    %% 2. Reset the variables for the particleswarm solver.
    State.Variables.Solvers.particleswarm.MaxIterations = 5.0E2;
    State.Variables.Solvers.particleswarm.MaxStallIterations = 5.0E1;
    State.Variables.Solvers.particleswarm.FunctionTolerance = 1.0E-10;
    State.Variables.Solvers.particleswarm.NumberOfRuns = 5.0E0;
    %% 3. Reset the variables for the ga solver.
    State.Variables.Solvers.ga.MaxGenerations = 5.0E2;
    State.Variables.Solvers.ga.MaxStallGenerations = 5.0E1;
    State.Variables.Solvers.ga.PopulationSize = 5.0E2;
    State.Variables.Solvers.ga.FunctionTolerance = 1.0E-10;
    State.Variables.Solvers.ga.NumberOfRuns = 5.0E0;
    %% 4. Reset the variables for the fmincon solver.
    State.Variables.Solvers.fmincon.MaxIterations = 2.0E2;
    State.Variables.Solvers.fmincon.MaxFunctionEvaluations = 2.0E4;
    State.Variables.Solvers.fmincon.StepTolerance = 1.0E-10;
    State.Variables.Solvers.fmincon.OptimalityTolerance = 1.0E-10;
    State.Variables.Solvers.fmincon.NumberOfStartPoints = 2.0E2;
end