function falling_body_gui()
    fig = figure('Units', 'normalized', 'Position', [0.3 0.3 0.4 0.6], ...
                 'Name', 'Falling Body Solver', 'NumberTitle', 'off');

    uicontrol('Style', 'text', 'Units', 'normalized', ...
              'Position', [0.1 0.8 0.3 0.08], 'String', 'Mass (kg):');
    massField = uicontrol('Style', 'edit', 'Units', 'normalized', ...
                          'Position', [0.45 0.8 0.4 0.08]);

    uicontrol('Style', 'text', 'Units', 'normalized', ...
              'Position', [0.1 0.68 0.3 0.08], 'String', 'Resistance (k):');
    kField = uicontrol('Style', 'edit', 'Units', 'normalized', ...
                       'Position', [0.45 0.68 0.4 0.08]);

    uicontrol('Style', 'text', 'Units', 'normalized', ...
              'Position', [0.1 0.56 0.3 0.08], 'String', 'Initial Velocity (v0):');
    v0Field = uicontrol('Style', 'edit', 'Units', 'normalized', ...
                        'Position', [0.45 0.56 0.4 0.08]);

    uicontrol('Style', 'text', 'Units', 'normalized', ...
              'Position', [0.1 0.44 0.3 0.08], 'String', 'Step size (h):');
    hField = uicontrol('Style', 'edit', 'Units', 'normalized', ...
                       'Position', [0.45 0.44 0.4 0.08]);

    uicontrol('Style', 'text', 'Units', 'normalized', ...
              'Position', [0.1 0.32 0.3 0.08], 'String', 'Total Time (Tmax):');
    TmaxField = uicontrol('Style', 'edit', 'Units', 'normalized', ...
                          'Position', [0.45 0.32 0.4 0.08]);

    uicontrol('Style', 'pushbutton', 'Units', 'normalized', ...
              'Position', [0.3 0.2 0.4 0.08], 'String', 'Solve', ...
              'Callback', @(src, event) solve_button());

    t = []; v = [];

    function solve_button()
        m = str2double(get(massField, 'String'));
        k = str2double(get(kField, 'String'));
        v0 = str2double(get(v0Field, 'String'));
        h = str2double(get(hField, 'String'));
        Tmax = str2double(get(TmaxField, 'String'));

        if any(isnan([m, k, v0, h, Tmax])) || isempty([m, k, v0, h, Tmax])
            errordlg('Please fill all fields with numeric values.', 'Input Error');
            return;
        end

        g = 9.81;
        n = floor(Tmax/h);
        f = @(t, v) g - (k/m)*v;
        [t, v] = runge_kutta_4(f, 0, v0, h, n);

        figure('Name', 'Velocity vs Time', 'NumberTitle', 'off');
        plot(t, v, 'o-', 'LineWidth', 2, 'MarkerSize', 5);
        grid on;
        xlabel('Time (s)', 'FontSize', 12);
        ylabel('Velocity (m/s)', 'FontSize', 12);
        title('Falling Body with Air Resistance', 'FontSize', 14);
        xlim([0 Tmax]);
        ylim([min(v)-5, max(v)+5]);


    end

end
