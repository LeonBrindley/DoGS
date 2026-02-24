%% Function: Read State.Variables into the configuration window data.
function State = VariablesToConfigurationWindow(State)
    %% 1. Read State.Variables into the options section.
    State = VariablesToOptionsSection(State);
    %% 2. Read State.Variables into the grid section.
    State = VariablesToGridSection(State);
    %% 3. Read State.Variables into the fitting definitions section.
    State = VariablesToFittingDefinitionsSection(State);
    %% 4. Read State.Variables into the solvers section.
    State = VariablesToSolversSection(State);
end