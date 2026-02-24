%% Function: Configure the hardware properties.
function State = ConfigureHardware(State)
    %% 1. Specify the maximum number of workers manually.
    MaxNumWorkers = 12; 
    %% 2. etermine the number of available workers automatically.
    try
        Cluster = parcluster('local');
        NumAvailableWorkers = Cluster.NumWorkers;
    catch
        NumAvailableWorkers = feature('numcores');
    end
    %% 3. Set the number of workers to the smallest aforementioned value.
    NumWorkers = min(MaxNumWorkers, NumAvailableWorkers);
    %% 4. Create the parallel pool.
    PoolObject = gcp('nocreate');
    if(isempty(PoolObject))
        try
            parpool(NumWorkers);
        catch
            % If a parallel pool cannot be started, continue without one.
        end
    elseif(PoolObject.NumWorkers ~= NumWorkers)
        try
            parpool(NumWorkers);
        catch
            % If resizing the parallel pool isn't possible, keep the existing one.
        end
    end
    %% 5. Extract the screen size.
    State.Constants.ScreenSize = get(0, 'ScreenSize');
    %% 6. Configure the location and size of each GUI (for WindowState != 'maximized').
    State.Constants.GUIPosition = [State.Constants.ScreenSize(3) / 4, State.Constants.ScreenSize(4) / 4, ... %% [Left, Bottom].
        State.Constants.ScreenSize(3) / 2, State.Constants.ScreenSize(4) / 2]; %% [Width, Height].
end