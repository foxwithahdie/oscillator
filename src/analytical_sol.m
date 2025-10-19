function analytical_sol()
    load("data/oscillation/oscillation_data.mat");
    diff_eq_params = table_params();
    
    initial_accel = linear_accel_y(1);
    initial_accel_dot = 0;
    
    ic = [initial_accel, initial_accel_dot];

    [t, ~] = ode45(@mass_spring_damper_sys, [time(1), time(end)], ic);

    x = exp(-diff_eq_params.sigma .* t) .* ...
            (initial_accel .* cos(diff_eq_params.w_d .* t) + ...
            ((initial_accel_dot + diff_eq_params.sigma .* initial_accel) / diff_eq_params.w_d) .* ...
                sin(diff_eq_params.w_d .* t));
    figure();
    plot(t, x, Color='magenta');
    xlabel("Time (s)");
    ylabel("Displacement (m)")
    title("Analytical Solution");
end


function R_dot = mass_spring_damper_sys(t, R)
    arguments
        % Time
        t
        % A vector representing R1 and R2, which represent x and dxdt.   
        R
    end
    load("data/general_data/general_data.mat");
    diff_eq_params = table_params();
    zeta = diff_eq_params.zeta;
    natural_freq = diff_eq_params.w_n_from_accel;
    F = 0 * t;
    m = cart_phone_combo;
    
    % Variable definitions
    dxdt = R(2);
    x = R(1);

    % Create second derivative
    d2xdt2 = F / m - 2 * zeta * natural_freq * dxdt - (natural_freq^2) * x;
    
    % Return as vector
    R_dot = [dxdt; d2xdt2];
end