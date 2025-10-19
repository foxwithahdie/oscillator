function return_table = values_table()
    params = table_params();

    names = ["Mass of Cart", "Average Stiffness Coefficient", "Damping Coefficient", "Exponential Decay Rate", "Damped Frequency", "Natural Frequency from Mass and Stiffness Coefficient", "Natural Frequency from Data", "Damping Ratio"];

    units = ["kg", "N * kg", "(N * s) * m^-1", "s^-1", "rad/s", "rad/s", "rad/s", ""];
    values = {};
    field_names = fieldnames(params);
    for i = 1:8
        value = getfield(params, field_names{i});
        value_str = (string(value) + " " + units(i));
        values{i} = value_str;
    end

    return_table = entries(dictionary(names, values));

end