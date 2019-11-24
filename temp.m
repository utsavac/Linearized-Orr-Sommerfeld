%% Solving the Blasius Equation for Boundary Layer Flow Over a Flat Plate
%Created by Mohammad A Alkhadra on November 3, 2018

%The equation we wish to solve is f''' + (1/2)*f*f'' with f(0) = 0, f'(0) = 0,
%f'(inf) = 1. We recast this problem as a system of first-order ODEs: y =
%[f; f'; f''] = [y(1); y(2); y(3)] so that dy/dEta = y' = [f'; f''; f'''] =
%[y(2); y(3); -(1/2)*y(1)*y(3)] with y(1)(0) = 0, y(2)(0) = 0, y(2)(inf) = 1.

%% Supplementary Functions
function [x,y] = shooting
% Use fsolve to ensure the boundary function is zero. The result is the
% unknown initial condition.
opt = optimset('Display','off','TolFun',1E-20);
F = fsolve(@(F) eval_boundary(F),[0,0,0.33],opt);
% Solve the ODE-IVP with the converged initial condition
[x,y] = solve_ode(F);
end

function [x,y] = solve_ode(F)
% Solve the ODE-IVP with initial condition F on [0 100] (arbitrary upper
% bound)
[x,y] = ode45(@(x,y) [y(2); y(3); -1.0*y(1)*y(3)],[0 100],F); %solve BVP                
end

function [g] = eval_boundary(F)
% Get the solution to the ODE with inital condition F
[x,y] = solve_ode(F);
% Get the function values (for BCs) at the starting/end points
f_start = y(1,1); %f(0) = 0
df_start = y(1,2); %f'(0) = 0
df_end = y(end,2); %f'(inf) - 1 = 0
% Evaluate the boundary function
g = [f_start
     df_start
     df_end - 1];
end