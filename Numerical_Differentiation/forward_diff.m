function [f_dash] = forward_diff(f, h, x0)
    x1 = x0 + h;
    f_dash = (f(x1) - f(x0))/h;
endfunction