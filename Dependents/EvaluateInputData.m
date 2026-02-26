%% Evaluate: Evaluate the sub-struct State.Dependents.InputData.
function State = EvaluateInputData(State)
    %% 1. Read the selected input file.
    InputData = readcell(fullfile(State.Constants.InputDirectory, State.Dependents.InputFile), 'Delimiter', ',');
    InputLabels = fillmissing(string(InputData(:, 1)), 'constant', "");
    %% 2. Parse the device data.
    State.Dependents.Device.Temperature = str2double(string(InputData{InputLabels == "# Temperature", 2}));
    State.Dependents.Device.ChannelWidth = str2double(string(InputData{InputLabels == "# Channel Width", 2}));
    State.Dependents.Device.ChannelLength = str2double(string(InputData{InputLabels == "# Channel Length", 2}));
    State.Dependents.Device.ChannelThickness = str2double(string(InputData{InputLabels == "# Channel Thickness", 2}));
    State.Dependents.Device.DielectricCapacitance = str2double(string(InputData{InputLabels == "# Dielectric Capacitance", 2}));
    %% 3. Parse the experimental data.
    DataHeaderIndex = find(InputLabels == "# Voltage (V)", 1);
    DataHeader = string(InputData(DataHeaderIndex, :));
    DataRows = InputData(DataHeaderIndex + 1 : find(InputLabels == "# Scale", 1) - 1, :);
    VoltageColumn = find(contains(DataHeader, 'Voltage'), 1);
    ConductanceColumns = find(contains(DataHeader, 'Conductance'));
    SeebeckColumns = find(contains(DataHeader, 'Seebeck'));
    State.Dependents.Data.Voltage = cell2mat(DataRows(:, VoltageColumn)).';
    State.Dependents.Data.Conductance = cell2mat(DataRows(:, ConductanceColumns));
    State.Dependents.Data.Seebeck = cell2mat(DataRows(:, SeebeckColumns));
    %% 4. Evaluate the size of the experimental data for each {Type, Test}.
    State.Dependents.Data.Columns = {DataHeader(VoltageColumn), DataHeader(ConductanceColumns), DataHeader(SeebeckColumns)};
    State.Dependents.Data.NumVoltages = size(State.Dependents.Data.Voltage);
    %% 5. Evaluate the number of combinations of {Type, Test}.
    State.Dependents.Data.NumTypes = numel(State.Dependents.Data.Columns) - 1;
    State.Dependents.Data.NumTests = cellfun(@numel, State.Dependents.Data.Columns(2 : end));
    State.Dependents.Data.MaxNumTests = max(State.Dependents.Data.NumTests);
    State.Dependents.Data.NumPlots = sum(State.Dependents.Data.NumTests(1 : State.Dependents.Data.NumTypes));
    %% 6. Evaluate the experimental variance.
    State.Dependents.Data.ExperimentalVariance = nan(State.Dependents.Data.NumTypes, State.Dependents.Data.MaxNumTests);
    State.Dependents.Data.ExperimentalVariance(1, 1 : numel(ConductanceColumns)) = var(State.Dependents.Data.Conductance, 0, 1);
    State.Dependents.Data.ExperimentalVariance(2, 1 : numel(SeebeckColumns)) = var(State.Dependents.Data.Seebeck, 0, 1);
    %% 7. Parse the fitting definitions for the charge trapping shift.
    State.Dependents.Data.ChargeTrappingShiftColumns = find(contains(DataHeader, 'Conductance') | contains(DataHeader, 'Seebeck'));
    State.Dependents.Data.ChargeTrappingShiftSize = [State.Dependents.Data.NumTypes, State.Dependents.Data.MaxNumTests];
    State.Dependents.Data.ChargeTrappingShiftCount = prod(State.Dependents.Data.ChargeTrappingShiftSize);
    ChargeTrappingShiftRows = arrayfun(@(Label) find(InputLabels == Label, 1), ["# Scale", "# Initial Value", "# Lower Bound", "# Upper Bound", "# Unit"]);
    ChargeTrappingShiftValues = string(InputData(ChargeTrappingShiftRows, State.Dependents.Data.ChargeTrappingShiftColumns));
    ChargeTrappingShiftNumeric = str2double(ChargeTrappingShiftValues(1 : 4, :));
    ChargeTrappingShiftNumeric(:, end + 1 : State.Dependents.Data.ChargeTrappingShiftCount) = NaN;
    ChargeTrappingShiftNumeric = permute(reshape(ChargeTrappingShiftNumeric.', [fliplr(State.Dependents.Data.ChargeTrappingShiftSize), 4]), [2, 1, 3]);
    ChargeTrappingShiftUnit = ChargeTrappingShiftValues(5, :);
    ChargeTrappingShiftUnit(end + 1 : State.Dependents.Data.ChargeTrappingShiftCount) = "";
    ChargeTrappingShiftUnit = reshape(ChargeTrappingShiftUnit, fliplr(State.Dependents.Data.ChargeTrappingShiftSize))';
    %% 8. Reshape the fitting definitions for the charge trapping shift.
    State.Dependents.FittingDefinitions.ChargeTrappingShift = reshape(arrayfun(@(ScaleValue, InitialValue, LowerBound, UpperBound, Unit){ScaleValue, InitialValue, LowerBound, UpperBound, Unit}, ...
        ChargeTrappingShiftNumeric(:, :, 1), ChargeTrappingShiftNumeric(:, :, 2), ChargeTrappingShiftNumeric(:, :, 3), ChargeTrappingShiftNumeric(:, :, 4), ChargeTrappingShiftUnit, 'UniformOutput', false), [], 1);
end