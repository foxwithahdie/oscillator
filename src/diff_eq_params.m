function [table_struct] = table_params()
    %load in data
    load("data/oscillation/oscillation_data.mat");
    load("data/general_data/general_data.mat");
    
    % initialize struct to hold values
    table_struct = struct();

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

    %find the time period
    T = mean(diff(t_at_peaks));
    
    %calculate the damped frequency
    w_d = 2 * pi /T;
    
    %fit peaks to exponential decay
    peak_decay = fit(t_at_peaks, filtered_peaks, 'exp1');
    sigma = -peak_decay.b;
    
    %find w_n and zeta
    w_n = sqrt(w_d^2 + sigma^2);
    zeta = sigma / w_n;
    
    %find damping constant
    m = cart_phone_combo;
    c = 2*m*zeta*w_n;
    [k_1, ~, k_2, ~] = stiffness_values(0);

    % Fill struct with calculated values
    table_struct.m = m;
    table_struct.k = mean([k_1, k_2]);
    table_struct.c = c;
    table_struct.sigma = sigma;
    table_struct.w_d = w_d;
    table_struct.w_n_from_m_k = sqrt(mean([k_1, k_2]) / m);
    table_struct.w_n_from_accel = w_n;
    table_struct.zeta = zeta;
end