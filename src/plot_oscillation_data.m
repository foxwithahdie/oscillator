function plot_oscillation_data()
    %load in data
    load("data/oscillation/oscillation_data.mat");
    load("data/general_data/general_data.mat");

    % Grab acceleration and time from data
    acceleration = linear_accel_y;
    t_list = time;
    
    figure();
    plot(time, linear_accel_y, Color=[0, 0.8, 0], LineWidth=1);
    xlabel("Time (s)"); ylabel("Vertical Acceleration (m/s^2)");
    title("Cart Oscillation");

end