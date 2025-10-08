function spring_length_collection()
    % Spring weight data from an Excel file.
    spring_length_data = readtable("data/spring_length/spring_length.xlsx");

    % Spring length data, split by column.
    spring_1_length = spring_length_data.spring_1;
    spring_2_length = spring_length_data.spring_2;
    
    % Saved to a .mat file.
    save("data/spring_length/spring_length.mat", ...
            "spring_1_length", ...
            "spring_2_length" ...
        )
end