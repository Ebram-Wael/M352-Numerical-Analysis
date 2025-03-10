function [f_dash] = backward_diff(f,h,x1)
    x0 = x1 - h;
    f_dash = (f(x1) - f(x0))/h;
endfunction