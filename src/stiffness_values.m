function [k_1, l0_1, k_2, l0_2] = stiffness_values(show_plot)
    load("data/spring_length/spring_length.mat")
    load("data/spring_weight/spring_weight.mat")

    GRAVITY = 9.8;
    CM_TO_M = 1 / 100;
    G_TO_KG =  1 / 1000;

    force = (spring_1_weight) * G_TO_KG * GRAVITY; % Weight, in Newtons

    spring_1_length = spring_1_length * CM_TO_M;
    spring_2_length = spring_2_length * CM_TO_M;

    
    % Linear Regression to find Natural Length and K
    lin_reg_1 = polyfit(spring_1_length, force, 1);
    lin_reg_2 = polyfit(spring_2_length, force, 1);

    k_1 = lin_reg_1(1);
    l0_1 = -lin_reg_1(2) / lin_reg_1(1);
    k_2 = lin_reg_2(1);
    l0_2 = -lin_reg_2(2) / lin_reg_1(1);

    if (show_plot)
        subplot(1, 2, 1);
        plot(spring_1_length, force, ".", Color=[0.8, 0.8, 0], MarkerSize=15, DisplayName="Measured Spring Length"); hold on
            plot(spring_1_length, polyval(lin_reg_1, spring_1_length), "--", Color=[0.3, 0.3, 1], DisplayName="Line of Best Fit");
            legend();
            xlabel("Spring Length (m)"); ylabel("Weight (N)");
            title("Spring 1 Best Fit Line");
        hold off
        
        subplot(1, 2, 2);
        plot(spring_2_length, force, ".", Color=[0.8, 0.8, 0], MarkerSize=15, DisplayName="Measured Spring Length"); hold on
            plot(spring_2_length, polyval(lin_reg_2, spring_2_length), "--", Color=[0.3, 0.3, 1], DisplayName="Line of Best Fit");
            legend();
            xlabel("Spring Length (m)"); ylabel("Weight (N)");
            title("Spring 2 Best Fit Line");
        hold off

    end


end