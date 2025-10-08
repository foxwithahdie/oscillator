function spring_weight_collection()
    % Spring weight data, collected from an Excel file.
    spring_weight_data = readtable("data/spring_weight/spring_weight.xlsx");

    % Weights from the data separated by spring.
    spring_1_weight = spring_weight_data.spring_1;
    spring_2_weight = spring_weight_data.spring_2;

    % Saved in a .mat file.
    save("data/spring_weight/spring_weight.mat", ...
            "spring_1_weight", ...
            "spring_2_weight" ...
        )
end