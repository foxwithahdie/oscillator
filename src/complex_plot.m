function complex_plot()
    diff_eq_params = table_params();

    lambda_1 = -1 * diff_eq_params.sigma + 1i * diff_eq_params.w_d;
    lambda_2 = -1 * diff_eq_params.sigma - 1i * diff_eq_params.w_d;
    
    figure();
    xline(0, Color=[0, 0, 0], DisplayName="X Axis"); hold on
    yline(0, Color=[0, 0, 0], DisplayName="Y Axis");
    quiver(0, 0, real(lambda_1), imag(lambda_1), DisplayName="Positive");
    quiver(0, 0, real(lambda_2), imag(lambda_2), DisplayName="Negative");
    title("Complex Exponential Coefficients");
    xlabel("Real"); ylabel("Imaginary");
    grid on;
    xlim([-3, 3])
    legend();
    hold off
end