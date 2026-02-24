%% Function: Configure the Possible Options.
function State = ConfigurePossibleOptions(State)
    %% 1. Declare the sub-struct State.Constants.PossibleOptions.
    State.Constants.PossibleOptions = struct;
    %% 2. Configure the possible input files.
    State.Constants.PossibleOptions.InputFiles = sort({dir(fullfile(State.Constants.InputDirectory, '*.csv')).name});
    %% 3. Configure the possible models.
    State.Constants.PossibleOptions.Models = {'Lorentzian', 'Gaussian', 'Voigt', 'PowerLaw', 'PChip'};
    %% 4. Configure the possible gap types.
    State.Constants.PossibleOptions.GapTypes = {'Soft', 'Hard'};
    %% 5. Configure the possible cases.
    State.Constants.PossibleOptions.Cases = {'NonDegenerate', 'Degenerate'};
    %% 6. Configure the possible solvers.
    State.Constants.PossibleOptions.Solvers = {'particleswarm', 'ga', 'fmincon'};
    %% 7. Derive the aforementioned categories.
    State.Constants.PossibleOptions.Categories = fieldnames(State.Constants.PossibleOptions);
    %% 8. Concatenate the aforementioned categories.
    State.Constants.PossibleOptions.All = cellfun(@(Name) State.Constants.PossibleOptions.(Name), State.Constants.PossibleOptions.Categories, 'UniformOutput', false);
    %% 9. Calculate the number of aforementioned categories.
    State.Constants.PossibleOptions.NumCategories = numel(State.Constants.PossibleOptions.Categories);
end