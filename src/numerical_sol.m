function numerical_sol()
    load("data/oscillation/oscillation_data.mat");
    initial_acceleration = linear_accel_y(1);
    initial_accel_dot = 0;
    
    ic = [initial_acceleration, initial_accel_dot];

    [t, derivs] = ode45(@mass_spring_damper_sys, [time(1), time(end)], ic);
    
    figure();
    plot(t, derivs(:, 1), Color=[1, 0.8, 0.8], DisplayName="First Derivative"); hold on
    plot(t, derivs(:, 2), Color=[1, 0, 0], DisplayName="Second Derivative");
    legend();
    xlabel("Time (s)"); ylabel("Acceleration (m/s^3)");
    title("Numerical Solution");

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