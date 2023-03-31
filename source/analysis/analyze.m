 
function sln = analyse(sln)
q0 = [pi/9; -pi/9; 0];
dq0 = [0;0;8];
num_steps = 500;
sln = solve_eqns(q0, dq0, num_steps);
animate(sln)
end