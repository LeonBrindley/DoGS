%% Function: Read the configuration window data into State.Variables.
function State = ConfigurationWindowToVariables(State)
    %% 1. Store the previous sub-struct State.Variables.
    PreviousVariables = State.Variables;
    %% 2. Clear the sub-struct State.Variables.
    State.Variables = struct;
    %% 3. Read the options section into State.Variables.
    State = OptionsSectionToVariables(State, PreviousVariables.Options);
    %% 4. Read the grid section into State.Variables.
    State = GridSectionToVariables(State, PreviousVariables.Grid);
    %% 5. Read the fitting definitions section into State.Variables.
    State = FittingDefinitionsSectionToVariables(State, PreviousVariables.FittingDefinitions);
    %% 6. Read the solvers section into State.Variables.
    State = SolversSectionToVariables(State, PreviousVariables.Solvers);
    %% 7. Read State.Variables into the configuration window data.
    State = VariablesToConfigurationWindow(State);
end