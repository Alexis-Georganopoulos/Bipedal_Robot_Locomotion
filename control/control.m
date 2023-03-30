function u = control(q, dq,t)%(t, q, dq, q0, dq0, step_number)

% control system for the bipedal walker. In principle it uses
%impedance control (and passively uses zero dynamics), but the 
%resulting equations are a modified PD controller. 
%In this case, impedance/PD control are one and the same

[~, ~, ~, l1, ~, ~, ~] = set_parameters();

J_hat = [l1*cos(q(1)), 0, 0; ...
            0        , 0, 1; ...
            -1       , 1, 0];
        
C = [1, 0, -1; 0, 1, -1];

%"adjusted" jacobian since our system is MIMO, and we dont use a state-space controller
J_t = (J_hat*pinv(C))'; 

%% These constants are the main hyper-parameters for the control method

%Desired tracking angles
theta_ref = pi/12;                  %SLOW pi/12 REF pi/6 = FAST
torso_ref = pi/36;                  %SLOW pi/36 REF pi/20 = FAST

%Impedance parameters
stiffness_interleg = 25;           %SLOW 25   REF 40 = FAST
dampening_interleg = 4;            %SLOW 4    REF 2.5 = FAST

stiffness_torso = 75;               %SLOW 75    REF 80 = FAST
dampening_torso = 4;                %SLOW 4     REF 1 = FAST

%These terms help with stabilisation
dx_hip_tracking = -5;               %SLOW -5    REF 1 FAST 2.2
k_hip = 4;                         %SLOW 4    REF 1 FAST 0.5



dx_hip = l1*cos(q(1))*dq(1);
F_rabit = k_hip*(dx_hip - dx_hip_tracking);

F_torso = stiffness_torso*(torso_ref - q(3)) + ...
          dampening_torso*(-dq(3));
      
F_swing = -stiffness_interleg*(q(2)-q(1)+theta_ref) - ...
          dampening_interleg*(dq(2) - dq(1));

F = [F_rabit;F_torso;F_swing];

u = J_t*F; %ie, the jacobian of the system * force vector = control torques

if(abs(u(1)) > 30)
    u(1) = 30*sign(u(1));
end

if(abs(u(2)) > 30)
    u(2) = 30*sign(u(2));
end
if(t>12 && t < 12.003) %FAST 10.003 SLOW 13.00521
   u(1) = u(1) + 17;%*((15.0052197098-t)/0.00522); % FAST 25 SLOW 148
   u(2) = u(2) + 17;%*((15.0052197098-t)/0.00522); % FAST 24 SLOW 148
   %fprintf("In the impulse \n");
   %t
   %(15.0052197098-t)/0.00522
end

%u

end