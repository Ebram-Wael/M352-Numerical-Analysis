function [t, y] = adam_bashforth(f,t0,y0,h,n)
    [t_rk,y_rk] = runge_kutta_4(f,t0,y0,h,1);

    t = t0:h:(t0 + n*h);
    y = zeros(size(t));
    y(1:2) = y_rk(1:2);

    for i = 2:n
        y(i+1) = y(i) + (h/2) * (3 * f(t(i),y(i)) - f(t(i-1), y(i-1)));
    end
endfunction