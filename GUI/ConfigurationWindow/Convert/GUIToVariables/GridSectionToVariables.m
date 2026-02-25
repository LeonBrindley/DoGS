%% Function: Read the grid section into State.Variables.
function State = GridSectionToVariables(State, PreviousGrid)
    %% 1. Read the table data.
    Data = State.ConfigurationWindow.GridSection.Table.Data;
    %% 2. Write the table data into State.Variables.Grid.
    for RowIndex = 1 : size(Data, 1)
        %% 2A. Read the name.
        RowName = Data{RowIndex, 1};
        %% 2B. Read the value.
        RowValue = Data{RowIndex, 2};
        %% 2C. Validate the row.
        if(strcmp(RowName, 'Increment') || strcmp(RowName, 'Maximum'))
            RowValue = ValidateScalar(RowValue, PreviousGrid.(RowName){1}, RowName, 'Positive');
        elseif(strcmp(RowName, 'Minimum'))
            RowValue = ValidateScalar(RowValue, PreviousGrid.(RowName){1}, RowName, 'Negative');
        end
        %% 2D. Read the unit.
        RowUnit = Data{RowIndex, 3};
        %% 2E. Write the row.
        State.Variables.Grid.(RowName) = {RowValue, RowUnit};
    end
    %% 3. Validate the Δε maximum against the Δε minimum.
    if(State.Variables.Grid.Maximum{1} <= State.Variables.Grid.Minimum{1})
        warning('Δε maximum <= Δε minimum. Switched to previous values.');
        State.Variables.Grid.Minimum = PreviousGrid.Minimum;
        State.Variables.Grid.Maximum = PreviousGrid.Maximum;
    end
    %% 4. Validate the Δε increment against the Δε maximum and the Δε minimum.
    if(State.Variables.Grid.Increment{1} > ((State.Variables.Grid.Maximum{1} - State.Variables.Grid.Minimum{1}) / 100))
        warning('Δε increment > (Δε maximum - Δε minimum) / 100. Switched to previous value.');
        State.Variables.Grid.Increment = PreviousGrid.Increment;
    end
end