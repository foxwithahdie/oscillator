function plot_oscillation_peaks()
    %load in data
    load("data/oscillation/oscillation_data.mat");
    load("data/general_data/general_data.mat");

    % Grab acceleration and time from data
    acceleration = linear_accel_y;
    t_list = time;

    %find the peaks
    [peaks, locations] = findpeaks(acceleration, Threshold=0.02);
    
    t_at_peaks = t_list(locations);
    cut = 10.5;
    filtered_peaks = peaks(t_at_peaks < cut);
    t_at_peaks = t_at_peaks(t_at_peaks < cut);
    filtered_peaks = filtered_peaks(t_at_peaks > 1);
    t_at_peaks = t_at_peaks(t_at_peaks > 1);

    figure();
    plot(t_list, acceleration, DisplayName="Acceleration"); hold on
        plot(t_at_peaks, filtered_peaks, ".", DisplayName="Peaks");
        xlabel("Time (s)"); ylabel("Vertical Acceleration (m/s^2)");
        title("Cart Oscillation, While Viewing the Peaks");
        legend();
end