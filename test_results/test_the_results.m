% run the following code
clear all
load('sln_test.mat') 
q0 = [-pi/9; +pi/9; 0];
dq0 = [0;0;0];
num_steps = 100;
sln = solve_eqns(q0, dq0, num_steps);
% load("U.mat")
% figure;
% plot(U(1,:));hold on;
% plot(U(2,:));hold on;
% plot(U(3,:)*180/pi);hold on;
% plot(U(4,:)*180/pi); legend("u1","u2","q1","q2");
% U = [];
% save('U.mat','U');
animate(sln)
metrics

