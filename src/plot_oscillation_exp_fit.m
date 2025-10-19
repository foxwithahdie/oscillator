function plot_oscillation_exp_fit()
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
     
    %fit peaks to exponential decay
    peak_decay = fit(t_at_peaks, filtered_peaks, 'exp1');
    x_1 = peak_decay.a;
    sigma = -peak_decay.b;
    t_fit = linspace(min(t_at_peaks), max(t_at_peaks), 200);
    exponential_decay = x_1 * exp(-sigma * t_fit);
    
    figure();
    plot(t_list, acceleration, DisplayName="Acceleration"); hold on
        plot(t_fit, exponential_decay, DisplayName="Exponential Decay Fit")
        xlabel("Time (s)"); ylabel("Vertical Acceleration (m/s^2)");
        title("Cart Oscillation, Seeing the Exponential Decay Fit")
        legend();
end