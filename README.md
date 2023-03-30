# Bipedal Robotic Walker

The bipedal walker simulation code contains various functions that simulate the dynamics of a simple 3-link bipedal walker. The walker is modelled as a rigid body with three segments: a torso and two legs. The simulation is performed using the Euler-Lagrange equations of motion, and the gait is generated using a hybrid zero dynamics-based + impedance controller. The simulation also includes a ground contact model and an optimization-based collision handling method.

![bipedal_animation](images/biped_animate.gif)

The main features of the code are:

- The main script, `solve_eqns.m`, is used to simulate the dynamics of the bipedal walker. It takes as input the initial conditions of the system and the simulation parameters such as the duration of the simulation, the time step, and the number of steps to be taken. It returns the solution of the dynamics in the form of the state and control trajectories.

- The control function, `control()` implements the hybrid zero dynamics-based + impedance controller, which generates the desired torques for the two actuators that control the hip and inter-leg angles. <br>
_**NOTE** that in this case, the impedance controller happens to coincide with a PD controller (altered definition of error term)._

- The `set_parameters()` function is used to define the physical parameters of the robot, such as the masses and lengths of the links, and the acceleration due to gravity.

The remaining code is used to plot various metrics such as the angles and velocities of the joints over time, the speed of the hip joint, the distance travelled by the bipedal walker in each step, the step frequency, and the torque applied to the actuators over time. It also calculates the cost of transport, which is a measure of the energy efficiency of the gait.
<br>
For example, below we see 

Overall, the code provides a basic implementation of a 3-link bipedal walker and a simple hybrid zero dynamics + impedance controller. <br>
The simulation results & metrics can be used to evaluate the performance of the controller and the efficiency of the gait.

Other notable scripts include:

- The `kin_swf` function calculates the kinematics of the swing foot during the stance phase of the gait. It takes as input the current state of the system and returns the position and velocity of the swing foot.

- The `eqns` function defines the equations of motion for the system, which are solved in `solve_eqns` (using the `ODE45`). It is used with an event function to detect collisions with the ground. The function returns the time vector T, the solution Y, the event time TE, and the solution at the event time YE.

The eqns function defines the equations of motion for the system, which are solved using the solve_eqns function. The solve_eqns function solves the equations of motion using the ODE45 solver, with an event function used to detect collisions with the ground. The function returns the time vector T, the solution Y, the event time TE, and the solution at the event time YE.
