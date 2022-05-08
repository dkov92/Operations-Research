clear all
close all
clc

% The code below uses the original constraints. Please adjust the code to
% carry out sensitivity studies. The code has been commented to help
% understand the constraint/function each line signifies.

fun = @(x) 3.5*x(1) + x(1)^(1/2) + 2*x(2) + 8*x(3) %objective function definition Z = 3.5x + √x + 2y + 8z, where x(1) represents x (carbon fibre), x(2) represents y (titanium), x(3) represents z (heat treatment agent)

%inequality constraints as described in mathematical formulation
A = [1.55 4.5 3;... % c1: 1.55x + 4.5y \leq 100
    -1.55 -4.5 -3;... % c2: 1.55x + 4.5y \geq 80
    -1 -1 -1;... % c3: x + y \geq 32
    0 -0.20 1;...% c4: z ≤ 0.2y 
    0 0.15 -1;...% c5: z ≥ 0.15y
    0 -1 0]; % c6: y ≥ 12

b = [100 -80 -32 0 0 -12]; % RHS for above constraints

lb = [0 0 0]; % non negativity constraints (lower bound definition for x - carbon fibre, y - titanium, z - heat treatment agent)

ub = [Inf Inf Inf]; % upper bound definition for x - carbon fibre, y - titanium, z - heat treatment agent

x0 = [0.5,0,0]; % initial condition

[val_s3, fval_s3] = fmincon(fun, x0, A, b, [], [], lb, ub) % solution optimal point, optimal solution