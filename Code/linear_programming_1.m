clear all
close all
clc

% The code below uses the original constraints. Please adjust the code to
% carry out sensitivity studies. The code has been commented to help
% understand the constraint/function that each line signifies.

f = [4 2]; % objective function definition in the order x (carbon fibre) and y (titanium)

% inequality constraints
A = [1.55 4.5;... % 1.55x + 4.5y <= 100
    -1.55 -4.5;... % 1.55x + 4.5y >= 80
    -1 -1;... % x + y >= 32
    0 -1]; % y >= 12

b = [100 -80 -32 -12]; % corresponding RHS for the above inequality constraints

lb = [0 0] % non-negativity constraints (lower bound definition for x, y)
ub = [Inf Inf] % upper bound definition for x, y

[val, fval] = linprog(f, A, b, [], [], lb, ub) % solution optimal point, optimal solution

figure(1) % feasible region and constraint lines

lb_plt = [0 0]; % define lower bounds (just for plot axis)
ub_plt = [70 35]; % define upper bound (just for plot axis)

plotregion(-A, -b, lb, ub, 'g', 0.5) % from Matlab File Exchange 

xlabel('x: Carbon fibre volume (cubic cm)'), ylabel('y: Titanium volume (cubic cm)')

% axis limits definition 
axis([lb_plt(1) ub_plt(1) lb_plt(2) ub_plt(2)]), grid
hold on

% compute constraints lines:
x1 = lb_plt(1):ub_plt(1); % x axis lb to ub
x2 = lb_plt(2):ub_plt(2); % y axis lb to ub
x2_1 = (100 - 1.55.*x1)/4.5; % constraint Y<=(100-1.55X)/4.5
x2_2 = (-1.55.*x1 + 80)/4.5; % constraint Y>=(80-1.55X)/4.5
x2_3 = (32 - x1); % constraint Y>=32-X

% compute objective function line:
x2_cf = (fval-4.*x1) / 2; 

% plotting the lines
obj = plot(zeros(size(x2)), x2, x1, 12*ones(size(x1)), x1, zeros(size(x1)),...
 x1, x2_1, x1, x2_2, x1, x2_3, x1, x2_cf,'LineWidth',1.5);
set(gca,'FontSize',20);

% defining linestyle and colours
obj(2).LineStyle = '--';
obj(4).LineStyle = '--';
obj(5).LineStyle = '--';
obj(6).LineStyle = '--';
obj(7).LineStyle = '--';
obj(7).Color = 'k'

% highlighting optimal solution
plot(val(1), val(2),'r*', 'LineWidth', 4)
hold off % releases graph

% set axes and figure legend:
legend(obj, {'x \geq 0', 'y \geq 12', 'y \geq 0', ...
    'c1: 1.55x + 4.5y \leq 100', ...
    'c2: 1.55x + 4.5y \geq 80', ...
    'c3: x + y \geq 32', ...
    'Optimal cost line: 4x + 2y = Z'}, ...
    'Location', 'Best', 'FontSize', 20)



f_s = [4 2];
A_s = [1.55 4.5; -1.55 -4.5; -1 -1];
b_s = [100 -80 -31];

lb_s = [0 12]
ub_s = [Inf Inf]

[val_s, fval_s] = linprog(f_s, A_s, b_s, [], [], lb_s, ub_s)

figure(2) %sensitivity of changing volume

lb_s = [0 12]; % define lower bounds
ub_s = [70 35]; % define upper bound (just for plot axis)
plotregion(-A_s,-b_s,lb_s,ub_s,'g',0.5) % from Matlab File Exchange 
xlabel('x: Carbon fibre volume (cubic cm)'), ylabel('y: Titanium volume (cubic cm)')
axis([lb_s(1) ub_s(1) 0 ub_s(2)]), grid
hold on
% compute constraints lines:
x2_3 = (32 - x1); % constraint Y>=32-X
x2_4 = (31 - x1); % constraint Y>=31-X

% compute optimal cost function line:
x2_cf = (fval_s-4.*x1) / 2;

% defining linestyle
obj = plot(x1, x2_3, x1, x2_4, x1, x2_cf, 'LineWidth',1.5);
set(gca,'FontSize',20);
obj(1).LineStyle = '--';
obj(2).LineStyle = '--';
obj(3).LineStyle = '--';
obj(3).Color = 'k'

% plot optimal solution:
plot(val_s(1), val_s(2), 'r*')
hold off % releases graph

% set axes and figure legend:
legend(obj, {'c3: x + y \geq 32', ...
    'modified c3: x + y \geq 31', ...
    'Optimal cost line: 4x + 2y = Z'}, ...
    'Location', 'Best', 'FontSize', 20)

f_s2 = [3 2];
A_s2 = [1.55 4.5; -1.55 -4.5; -1 -1];
b_s2 = [100 -80 -32];

lb_s2 = [0 12]
ub_s2 = [Inf Inf]

[val_s2, fval_s2] = linprog(f_s2, A_s2, b_s2, [], [], lb_s2, ub_s2)

figure(3) % sensitivity of changing carbon fibre price

lb_s2 = [0 12]; % define lower bounds
ub_s2 = [70 35]; % define upper bound (just for plot axis)
plotregion(-A_s2,-b_s2,lb_s2,ub_s2,'g',0.5) % from Matlab File Exchange 
xlabel('x: Carbon fibre volume (cubic cm)'), ylabel('y: Titanium volume (cubic cm)')
axis([lb_s2(1) ub_s2(1) 0 ub_s2(2)]), grid
hold on
% compute constraints lines:
x2_4 = (fval-4.*x1) / 2; % original optimal cost line

% compute new optimal cost function line:
x2_cf = (fval_s2-3.*x1) / 2;

obj = plot(x1, x2_4, x1, x2_cf, 'LineWidth',1.5);
set(gca,'FontSize',20);
obj(1).LineStyle = '--';
obj(2).LineStyle = '--';
obj(1).Color = 'k';

% plot optimal solution:
plot(val_s2(1), val_s2(2),'r*', 'LineWidth', 2)
hold off % releases graph


% set axes and figure legend:
legend(obj, {'Original optimal cost line: 4x + 2y = Z', ...
    'Modified optimal cost line: 3x + 2y = Z'}, ...
    'Location', 'Best', 'FontSize', 20)

f_s3 = [2 2];
A_s3 = [1.55 4.5; -1.55 -4.5; -1 -1];
b_s3 = [100 -80 -32];

lb_s3 = [0 12]
ub_s3 = [Inf Inf]

[val_s3, fval_s3] = linprog(f_s3, A_s3, b_s3, [], [], lb_s3, ub_s3)

figure(4) % sensitivity of changing carbon fibre price

lb_s2 = [0 12]; % define lower bounds
ub_s2 = [70 35]; % define upper bound (just for plot axis)
plotregion(-A_s3,-b_s3,lb_s3,ub_s3,'g',0.5) % from Matlab File Exchange 
xlabel('x: Carbon fibre volume (cubic cm)'), ylabel('y: Titanium volume (cubic cm)')
axis([lb_s3(1) ub_s3(1) 0 ub_s3(2)]), grid
hold on
x2_4 = (fval-4.*x1) / 2; % constraint Y>=32-X
% compute optimal cost function line:
x2_cf = (fval_s3-2.*x1) / 2;
obj = plot(x1, x2_4, x1, x2_cf, 'LineWidth',1.5);
set(gca,'FontSize',20);
obj(1).LineStyle = '--';
obj(2).LineStyle = '--';
obj(1).Color = 'k';

% plot optimal solution:
plot(val_s3(1), val_s3(2),'r*', 'LineWidth', 2)
hold off % releases graph


% set axes and figure legend:
legend(obj, {'Original optimal cost line: 4x + 2y = Z', ...
    'Modified optimal cost line: 2x + 2y = Z'}, ...
    'Location', 'Best', 'FontSize', 20)