function [T, V] = eval_energy(q, dq)

q1 = q(1);
q2 = q(2);
q3 = q(3);
dq1 = dq(1);
dq2 = dq(2);
dq3 = dq(3);

[m1, m2, m3, l1, l2, l3, g] = set_parameters();


T = (dq1^2*l1^2*m1)/8 + (dq1^2*l1^2*m2)/2 + (dq1^2*l1^2*m3)/2 + (dq2^2*l2^2*m2)/8 + (dq3^2*l3^2*m3)/8 - (dq1*dq2*l1*l2*m2*cos(q1 - q2))/2 + (dq1*dq3*l1*l3*m3*cos(q1 - q3))/2;
V = g*m2*(l1*cos(q1) - (l2*cos(q2))/2) + g*m3*(l1*cos(q1) + (l3*cos(q3))/2) + (g*l1*m1*cos(q1))/2;

end