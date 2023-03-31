function [x_swf, z_swf, dx_swf, dz_swf] = kin_swf(q, dq)

if nargin == 1
    dq = zeros(3, 1);
end

q1 = q(1);
dq1 = dq(1);
q2 = q(2);
dq2 = dq(2);

[~, ~, ~, l1, l2, ~, ~] = set_parameters();

x_swf = l1*sin(q1) - l2*sin(q2);
z_swf = l1*cos(q1) - l2*cos(q2);
dx_swf = dq1*l1*cos(q1) - dq2*l2*cos(q2);
dz_swf = dq2*l2*sin(q2) - dq1*l1*sin(q1);

end