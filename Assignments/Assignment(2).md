# Assignment (2)

## 📊 Comparison of Single-Step Methods (Euler, Heun, Midpoint)

| Method             | Order of Accuracy | Key Formula | Stability   | Error Reduction   |
|--------------------|------------------|-------------|------------|------------------|
| **Euler’s Method** | First-order (`O(h)`) | \( y_{i+1} = y_i + h f(x_i, y_i) \) | Less stable | High error |
| **Heun’s Method**  | Second-order (`O(h²)`) | Predictor-Corrector: <br> \( y_{i+1} = y_i + \frac{h}{2} [f(x_i, y_i) + f(x_{i+1}, y_i + h f(x_i, y_i))] \) | More stable | Improved accuracy |
| **Midpoint Method** | Second-order (`O(h²)`) | \( y_{i+1} = y_i + h f \left( x_i + \frac{h}{2}, y_i + \frac{h}{2} f(x_i, y_i) \right) \) | Balanced | Similar to Heun’s |

### **1. Euler’s Method**

```octave
function [x, y] = eulers_method(f, xinit, xend, yinit, h)
    N = (xend - xinit) / h;
    x = [xinit zeros(1, N)];
    y = [yinit zeros(1, N)];
    for i = 1:N
        x(i+1) = x(i) + h;
        y(i+1) = y(i) + h * feval(f, x(i), y(i));
    end
end
```

### **2. Heun’s Method (Predictor-Corrector)**

```octave
function [x, y] = heuns_method(f, xinit, xend, yinit, h)
    N = (xend - xinit) / h;
    x = [xinit zeros(1, N)];
    y = [yinit zeros(1, N)];
    for i = 1:N
        x(i+1) = x(i) + h;
        ynew = y(i) + h * feval(f, x(i), y(i)); % Predictor
        y(i+1) = y(i) + (h/2) * (feval(f, x(i), y(i)) + feval(f, x(i+1), ynew)); % Corrector
    end
end
```

### **3. Midpoint Method**

```octave
function [x, y] = midpoint_method(f, xinit, xend, yinit, h)
    N = (xend - xinit) / h;
    x = [xinit zeros(1, N)];
    y = [yinit zeros(1, N)];
    for i = 1:N
        x(i+1) = x(i) + h;
        k1 = feval(f, x(i), y(i));
        y_mid = y(i) + (h/2) * k1;
        y(i+1) = y(i) + h * feval(f, x(i) + h/2, y_mid);
    end
end
```

---

## 🚀 Example Comparison for \( \frac{dy}{dx} = x + y \), \( y(0) = 1 \), \( h = 0.2 \)

| \( x \) | Euler’s (\( y \)) | Heun’s (\( y \)) | Midpoint (\( y \)) | Exact Solution |
|--------|------------------|-----------------|-------------------|----------------|
| 0.0    | 1.0000           | 1.0000          | 1.0000            | 1.0000         |
| 0.2    | 1.2000           | 1.2440          | 1.2400            | 1.2428         |
| 0.4    | 1.4800           | 1.6098          | 1.6008            | 1.6125         |
| 0.6    | 1.8560           | 2.1109          | 2.0929            | 2.1172         |

**Observations**:

- **Euler’s** has the highest error.
- **Heun’s** and **Midpoint** are comparable (both 2nd-order), but Heun’s uses an extra function evaluation.
- **Midpoint** is computationally cheaper than Heun’s (2 vs. 3 function calls per step).

---

## 📌 Higher-Order Methods

### **4. Runge-Kutta (RK4)**

\[
y_{n+1} = y_n + \frac{h}{6} (k_1 + 2k_2 + 2k_3 + k_4)
\]

```octave
function [t, y] = runge_kutta_4(f, t0, tf, y0, N)
    h = (tf - t0) / N;
    t = linspace(t0, tf, N+1);
    y = zeros(1, N+1);
    y(1) = y0;
    for i = 1:N
        k1 = h * f(t(i), y(i));
        k2 = h * f(t(i) + h/2, y(i) + k1/2);
        k3 = h * f(t(i) + h/2, y(i) + k2/2);
        k4 = h * f(t(i) + h, y(i) + k3);
        y(i+1) = y(i) + (k1 + 2*k2 + 2*k3 + k4)/6;
    end
end
```

### **5. Adams-Bashforth (Two-Step)**

\[
y_{n+1} = y_n + \frac{h}{2} (3f(t_n, y_n) - f(t_{n-1}, y_{n-1}))
\]

```octave
function [t, y] = adams_bashforth_2(f, t0, tf, y0, N)
    h = (tf - t0) / N;
    t = linspace(t0, tf, N+1);
    y = zeros(1, N+1);
    y(1:2) = [y0, y0 + h * f(t0, y0)]; % Initialize with Euler/RK4
    for i = 2:N
        y(i+1) = y(i) + h/2 * (3*f(t(i), y(i)) - f(t(i-1), y(i-1)));
    end
end
```

---

## 📊 Graph Outputs

![Heun's Method](ODEs/imgs/heuns_method_plot.png)  
![Midpoint Method](ODEs/imgs/midpoint_method_plot.png)  
![RK4 Method](ODEs/imgs/runge-kutta-4-method.png)  
