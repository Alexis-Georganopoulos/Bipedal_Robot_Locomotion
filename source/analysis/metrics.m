%Plots metrics

%PLot of q1,q2,q3
[~,~,~,l1,~,~,~,] = set_parameters();

Time_stamp =[];
for j = 1 : num_steps
    Time_stamp = [Time_stamp, sln.T{j}'];
end

%% Plot of the angle over time q1 q2


legends =["q1","q2","q3"];
q1=[];
q2=[];
q3=[];



for j = 1 : num_steps
 q1 = [q1,sln.Y{j}(:,1)'];
 q2 = [q2,sln.Y{j}(:,2)'];
 q3= [q3,sln.Y{j}(:,3)'];
end

q1p=[];
q2p=[];
q3p=[];
dq1p=[];
dq2p=[];
dq3p=[];
time_stamp_p=[];

for j = 15:17
    q1p = [q1p,sln.Y{j}(:,1)'];
    q2p = [q2p,sln.Y{j}(:,2)'];
    q3p= [q3p,sln.Y{j}(:,3)'];
    dq1p = [dq1p,sln.Y{j}(:,4)'];
    dq2p = [dq2p,sln.Y{j}(:,5)'];
    dq3p= [dq3p,sln.Y{j}(:,6)'];    
    time_stamp_p =[time_stamp_p; sln.T{j}(:)];
end

figure(9)
plot(time_stamp_p, [q1p;q2p;q3p])
legend("q1","q2","q3")
title("Angles vs time over 2 period at steady state")
xlabel("Time [s]")
ylabel("Angle [rad]")

figure(2)
plot(Time_stamp, [q1;q2;q3])
legend("q1","q2","q3")
title("Angles vs time")
xlabel("Time [s]")
ylabel("Angle [rad]")

%% Plot of the speed over time max and min velocities
size_of_vh =0 ;

max_vel = 0;
min_vel =0;


%%c
v_h = zeros(1,size(Time_stamp,2));
steps = 0;
for i = 1 : num_steps 
    for j = 1 : size(sln.Y{i},1)
        steps = steps +1;
        v_h(1,steps ) = l1*cos(sln.Y{i}(j,1)).*sln.Y{i}(j,4);
        
        if i == 1 && j ==1
            min_vel = v_h(steps);
            max_vel = v_h(steps);
        else
            if v_h(steps) > max_vel
                max_vel = v_h(steps);
            elseif v_h(steps) < min_vel
                min_vel = v_h(steps);
            end   
        end
    end
end
% figure(3)

fprintf("Max speed : %f \n", max_vel); 
fprintf("Min speed : %f \n", min_vel);

plot(Time_stamp, v_h, 'r');
title("Speed of the hip vs the time")
xlabel("Time [s]")
ylabel("Speed [m/s]")
% 
% for j =1 : num_steps
%     hold on
%     plot(sln.TE{j}, l1*cos(sln.YE{j}(1))*sln.YE{j}(4), 'o');
% end 

%% Distance made by a step
d = zeros(1,num_steps);
d(1) = abs(-l1*sin(sln.Y{1}(1))+l1*sin(q0(1)));

for i= 1:num_steps
    d(i) = abs(l1*sin(sln.Y{i}(1,1)) - l1*sin(sln.Y{i}(end,1)));
end

figure(4)
stem(1:num_steps,d)

title("Distance made by a step")
xlabel("Step [-]")
ylabel("Distance of the step [m]")

%% Step frequency vs step number
fr = zeros(1, num_steps);

for i = 1 : num_steps
    fr(i) = 1/(sln.T{i}(end)-sln.T{i}(1));
end

figure(5)
stem(1:num_steps, fr)
title("Step frequency vs step number")
xlabel("Step [-]")
ylabel("Frequency [Hz]")

%% Torque vs time plot

torque = zeros(2, size(Time_stamp,2));
n =1;
for i = 1 : num_steps 
    for j = 1 : size(sln.Y{i},1)
        torque(:,n) = control(sln.Y{i}(j,1:3),sln.Y{i}(j,4:6),1);
        n = n+1;
    end
end

figure(6)
plot(Time_stamp, torque(1,:), "r");
hold on
plot(Time_stamp, torque(2,:), "b");
title("Torques in the acuators vs time")
xlabel("Time [s]")
ylabel("Torque [N.m]")
legend("u1","u2")

%% Cost of transport 
cot= 0;
n =1;
r0=0;

for i = 1 : num_steps 
    [x_swf,z_swf,~,~]= kin_swf(sln.YE{i}(1:3), sln.YE{i}(4:6)); %% À vérifier;
    r0 = r0+ x_swf;
    for j = 1 : size(sln.Y{i},1)
        cot = cot + max(0,torque(1,n)*(sln.Y{i}(j,4)-sln.Y{i}(j,6))*0.001)... 
            + max(0,torque(2,n)*(sln.Y{i}(j,5)-sln.Y{i}(j,6))*0.001);
        n = n+1;
    end
end

cot = cot/r0;
fprintf("CoT : %f\n", cot);

%% 
dq1 =[];
dq2=[];
dq3=[];

for j = 1 : num_steps
 dq1 = [dq1,sln.Y{j}(:,4)'];
 dq2 = [dq2,sln.Y{j}(:,5)'];
 dq3= [dq3,sln.Y{j}(:,6)'];
end    
figure(7)

plot(q1,dq1)
hold on
plot(q2,dq2)
hold on
plot(q3,dq3)
legend("dq1(q1)","dq2(q2)","dq3(q3)")
title("Angular speed vs angular position")
xlabel("Angular position [rad]")
ylabel("Angular speed [rad/s]")

%% Mean speed per step

av_speed= [];
for i = 1 : num_steps 
    xh_0 =-l1*sin(sln.Y{i}(1,1));
    xh_f = -l1*sin(sln.Y{i}(end,1));
    deltaT = sln.T{i}(end)-sln.T{i}(1);
    speed = abs(xh_f-xh_0)/deltaT;
    av_speed =[av_speed;speed];
end
figure(8)
plot(1:num_steps, av_speed);

title("Average step speed per step")
xlabel("Step [-]")
ylabel("Average speed [m/s]")
steady_state_av_speed = av_speed(end);

fprintf("Steady state average speed : %f\n", steady_state_av_speed);

%% Plot energie potentielle
V=[];
T=[];
for i = 1 : size(time_stamp_p)
    [cin,pot] = eval_energy([q1p(i),q2p(i),q3p(i)],[dq1p(i),dq2p(i),dq3p(i)]);
    V=[V,pot];
    T=[T,cin];
end
V = (V-min(V))/max(V);
T =T/max(T);
figure(10)
plot(time_stamp_p,V);
hold on
plot(time_stamp_p,T)
legend("Potential energy", "Kinetic energy")
