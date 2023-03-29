function dy = eqns(t, y)
% n this is the dimension of the ODE, note that n is 2*DOF 
% y1 = q1, y2 = q2, y3 = q3, y4 = dq1, y5 = dq2, y6 = dq3

n = 6;   
q =  y(1:3); 

dq =  y(4:6);
u = control(q, dq,t); % for the moment we set the control outputs to zero
dy = zeros(n, 1);


M = eval_M(q);
G = eval_G(q);
C = eval_C(q,dq);
B = eval_B();

% ddq = M \ (- C*y(4:6) - G + B*u);
b =B*u-G-C*dq;

dy(1:3) = dq;
dy(4:6) = M\b;
end