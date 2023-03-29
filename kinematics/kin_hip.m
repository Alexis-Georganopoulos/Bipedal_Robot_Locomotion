function [x_h, z_h, dx_h, dz_h] = kin_hip(q, dq)

if nargin == 1
    dq = zeros(3, 1);
end

q1 = q(1);
dq1 = dq(1);

[~, ~, ~, l1, ~, ~, ~] = set_parameters();

x_h = l1*sin(q1);
z_h = l1*cos(q1);
dx_h = dq1*l1*cos(q1);
dz_h = -dq1*l1*sin(q1);

end