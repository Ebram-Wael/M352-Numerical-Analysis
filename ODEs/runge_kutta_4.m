function [t, y] = runge_kutta_4(f,t0,y0,h,n)
    t = t0:h:(t0 + n*h);
    y = zeros(size(t));
    y(1) = y0;

    for i = 1 : n
        k1 = f(t(i), y(i));
        k2 = f(t(i) + h/2, y(i) + h/2 * k1);
        k3 = f(t(i) + h/2, y(i) + h/2 * k2);
        k4 = f(t(i) + h, y(i) + h * k3);
    
        y(i + 1) = y(i) + (h/6) * (k1 + 2 *k2 + 3*k3 + k4);
    end
endfunction