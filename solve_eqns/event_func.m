%% 
% This function defines the event function.
% In the three link biped, the event occurs when the swing foot hits the
% ground.
%%
function [value,isterminal,direction] = event_func(t, y)

q(1:3)  = y(1:3);
dq(1:3) = y(4:6);

% we may want to use kin_swf to set the 'value'  
%[x_swf, z_swf, dx_swf, dz_swf] = kin_swf(q, dq);
%value = z_swf + 0.01*cos(q(2)) + 0.001;
%value = z_swf + 0.001;
n = 6;
[~,  z_swf, ~, ~] = kin_swf(q, dq);
value = (z_swf + 1e-2) ;
isterminal = 1; %
direction = -1; % dz_swf only if neg
end
