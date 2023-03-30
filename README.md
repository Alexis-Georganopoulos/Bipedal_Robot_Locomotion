# Bipedal Robotic Walker

The bipedal walker simulation code contains various functions that simulate the dynamics of a simple 3-link bipedal walker. The walker is modelled as a rigid body with three segments: a torso and two legs. The simulation is performed using the Euler-Lagrange equations of motion, and the gait is generated using a hybrid zero dynamics-based + impedance controller. The simulation also includes a ground contact model and an optimization-based collision handling method.

![bipedal_animation](images/biped_animate.gif)

The main function, `solve_eqns`, is used to simulate the dynamics of the bipedal walker. It takes as input the initial conditions of the system and the simulation parameters such as the duration of the simulation, the time step, and the number of steps to be taken. It returns the solution of the dynamics in the form of the state and control trajectories.

The control function implements the hybrid zero dynamics-based controller, which generates the desired torques for the two actuators that control the hip and knee joints of the bipedal walker. The controller uses the current state of the system and the desired periodic gait pattern to generate the control signals.

The kin_swf function calculates the kinematics of the swing foot during the stance phase of the gait. It takes as input the current state of the system and returns the position and velocity of the swing foot.

The eqns function defines the equations of motion for the system, which are solved using the solve_eqns function. The solve_eqns function solves the equations of motion using the ODE45 solver, with an event function used to detect collisions with the ground. The function returns the time vector T, the solution Y, the event time TE, and the solution at the event time YE.

The remaining code is used to plot various metrics such as the angles and velocities of the joints over time, the speed of the hip joint, the distance travelled by the bipedal walker in each step, the step frequency, and the torque applied to the actuators over time. It also calculates the cost of transport, which is a measure of the energy efficiency of the gait.

Overall, the code provides a basic implementation of a 3-link bipedal walker and a simple hybrid zero dynamics-based controller. The simulation results and metrics can be used to evaluate the performance of the controller and the efficiency of the gait.





Summary
The code simulates a 3-link bipedal walker using the Euler-Lagrange equations of motion, with a hybrid zero dynamics-based controller generating the gait pattern. The main features of the code are:

The bipedal walker is modelled as a rigid body with a torso and two legs
The gait pattern is generated using a hybrid zero dynamics-based controller
The simulation includes a ground contact model and an optimization-based collision handling method
The simulation results are evaluated with various metrics, such as joint angles, velocities, speed, distance travelled, step frequency, and cost of transport
Functions
The main functions of the code are:

simulate: Simulates the dynamics of the bipedal walker, taking the initial conditions and simulation parameters as input and returning the state and control trajectories
control: Implements the hybrid zero dynamics-based controller to generate the desired torques for the hip and knee joints based on the current state and desired gait pattern
kin_swf: Calculates the kinematics of the swing foot during the stance phase of the gait based on the current state
Plotting functions: Plot various metrics of the simulation results
Key Features
The key features of the code are:

Implements a 3-link bipedal walker model
Uses Euler-Lagrange equations of motion to simulate the dynamics
Includes a hybrid zero dynamics-based controller to generate the gait pattern
Implements a ground contact model and optimization-based collision handling method
Provides metrics to evaluate the performance of the controller and the efficiency of the gait
Overall, the code provides a simple implementation of a 3-link bipedal walker with a hybrid zero dynamics-based controller that can be used to evaluate the performance of the gait and the controller.




The eqns function defines the equations of motion for the system, which are solved using the solve_eqns function. The solve_eqns function solves the equations of motion using the ODE45 solver, with an event function used to detect collisions with the ground. The function returns the time vector T, the solution Y, the event time TE, and the solution at the event time YE.




The solve_eqns() function is used to solve the equations of motion for the robot. This function takes the robot's initial joint positions and velocities, as well as the number of steps the robot is supposed to take. The function uses the ode45() function to integrate the equations of motion over time. The impact() function is called after each step to handle any impacts the robot experiences.



The set_parameters() function is used to define the physical parameters of the robot, such as the masses and lengths of the links, and the acceleration due to gravity.