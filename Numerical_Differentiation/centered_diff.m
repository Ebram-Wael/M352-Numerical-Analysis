function [f_dash] = centered_diff(f,h,x1)
    x0 = x1 - h;
    x2 = x1 + h;

    f_dash = (f(x2) - f(x0))/2*h;
endfunction