%% Solve equations of motion 
% Note: eqns.m defines the equations of motion to be solved by this script
% This function returns the time vector T, the solution Y, the event time
% TE, solution at the event time YE.
% q0, dq0 are the initial angles and angular velocities, num_steps are the
% number of steps the robot is supposed to take
% As an example you can use q0 = [pi/6; -pi/3; 0] and dq0 = [0;0;0]. 

function sln = solve_eqns(q0, dq0, num_steps)


h = 0.001;          % time step
tmax = 2;           % max time that we allow for a single step
tspan = 0:h:tmax;    % from 0 to tmax with time step h
y0 = [q0; dq0];
t0 = 0;
options =  odeset('RelTol',1e-5,'Events',@event_func);

% we define the solution as a structure to simplify the post-analyses and
% animation, here we intialize it to null. 
sln.T = {};
sln.Y = {};
sln.TE = {};
sln.YE = {};

for i = 1:num_steps
    % use ode45 to solve the equations of motion (eqns.m)   ode45(@eqns,tspan,y0,options)
    [T, Y, TE, YE] = ode45(@eqns,t0+tspan,y0,options);     
    sln.T{i} = T; 
    sln.Y{i} = Y;
    sln.TE{i} = TE;
    sln.YE{i} = YE;
    
    if T(end) == tmax
        break
    end
    
    % Impact map
    [y0(1:3,1), y0(4:6,1)] = impact(YE(1:3)', YE(4:6)'); 
    t0 = T(end);    
end
end


