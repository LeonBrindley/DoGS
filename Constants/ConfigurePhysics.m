%% Function: Configure any fundamental physics.
function State = ConfigurePhysics(State)
    %% 1. Configure the Boltzmann constant and its unit.
    State.Constants.k_B = {8.62E-5, 'eV K^(-1)'};
    %% 2. Configure the elementary charge and its unit.
    State.Constants.q = {1.60E-19, 'C'};
end