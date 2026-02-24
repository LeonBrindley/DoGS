%% Function: Reset the sub-struct State.Variables.FittingDefinitions. Order = {Scale, Initial Value, Lower Bound, Upper Bound, Unit}.
function State = ResetFittingDefinitions(State)
    %% 1. Reset the fitting definitions for any model.
    State.Variables.FittingDefinitions.Any.BackgroundSlope = {1.0E28, 0.0E0, -1.0E30, 1.0E30, 'eV^(-2) m^(-3)'};
    State.Variables.FittingDefinitions.Any.FieldEffectMobility = {1.0E-7, 1.0E-7, 1.0E-8, 1.0E-6, 'm^2 V^(-1) s^(-1)'};
    State.Variables.FittingDefinitions.Any.FieldEffectLayerThickness = {1.0E-9, 1.0E-9, 5.0E-10, 2.0E-9, 'm'};
    State.Variables.FittingDefinitions.Any.Amplitude = {1.0E28, 1.0E28, 1.0E26, 1.0E30, 'eV^(-1) m^(-3)'};
    %% 2. Reset the fitting definitions for the soft gap type.
    State.Variables.FittingDefinitions.Soft.BackgroundOffset = {1.0E28, 1.0E28, 1.0E26, 1.0E30, 'eV^(-1) m^(-3)'};
    %% 3. Reset the fitting definitions for the Lorentzian model.
    State.Variables.FittingDefinitions.Lorentzian.Gamma = {1.0E-2, 1.0E-2, 1.0E-3, 2.0E-1, 'eV'};
    %% 4. Reset the fitting definitions for the Gaussian model.
    State.Variables.FittingDefinitions.Gaussian.Sigma = {1.0E-2, 1.0E-2, 1.0E-3, 2.0E-1, 'eV'};
    %% 5. Reset the fitting definitions for the Voigt model.
    State.Variables.FittingDefinitions.Voigt.Gamma = {1.0E-2, 1.0E-2, 1.0E-3, 2.0E-1, 'eV'};
    State.Variables.FittingDefinitions.Voigt.Sigma = {1.0E-2, 1.0E-2, 1.0E-3, 2.0E-1, 'eV'};
    %% 6. Reset the fitting definitions for the power law model.
    State.Variables.FittingDefinitions.PowerLaw.Width = {1.0E-1, 1.0E-1, 2.0E-2, 2.0E-1, 'eV'};
    State.Variables.FittingDefinitions.PowerLaw.Exponent = {3.0, 3.0, 2.0, 4.0, '-'};
    %% 7. Reset the fitting definitions for the pchip model.
    State.Variables.FittingDefinitions.PChip.Width = {1.0E-1, 1.0E-1, 2.0E-2, 2.0E-1, 'eV'};
    State.Variables.FittingDefinitions.PChip.Knots = {[0.25, 0.25, 0.25, 0.25], [0.10, 0.20, 0.30, 0.40], [0.02, 0.02, 0.02, 0.02], [0.80, 0.80, 0.80, 0.80], '-'};
end