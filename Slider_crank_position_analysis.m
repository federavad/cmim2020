clear all
clc
% u = [phi_2; d];
a = 0.1;
b = 0.2;
omega=1;
t=0:0.01:10
phi = pi/6+omega*t;
close all
u0 = [0; b + a];
J = @(u) jacobian(u, b);
eps = 1e-9;
U=[];
for i=1:length(phi)
% create function handles
F = @(u) constraint(u, a, b, phi(i));
x=NR_method(F, J, u0, eps)
U=[U x];
end

theta=(U(1,:));
d=U(2,:);
 
figure  % Displacement over time
plot(t, d)
title('Displacement d over time');
xlabel('Time t (s)')
ylabel('Displacement d (m) ')

figure      % Theta over time
plot(t, rad2deg(theta))
title('Angle \theta over time');
xlabel('Time t (s)')
ylabel('Angle \theta (\circ) ')

  
v = gradient(theta)./gradient(t) ;   % time derivative of angle theta 
figure
plot(t,v);
title('Angular velocity $\dot{\theta}$ over time', 'Interpreter','latex');
xlabel('Time t (s)')
ylabel('Angular velocity $\dot{d}$ (rad/s)', 'Interpreter','latex')
v1 = gradient(d)./gradient(t) ;   % time derivative of displacement 
figure 
plot(t,v1);
title('Velocity $\dot{d}$ over time', 'Interpreter','latex');
xlabel('Time t (s)')
ylabel('Velocity $\dot{d}$ (m/s)', 'Interpreter','latex')


   
function P = constraint(u, a, b, phi)  % constraints
tetta = u(1);
d = u(2);

P = [a * cos(phi) + b * cos(tetta) - d;
    a * sin(phi) - b * sin(tetta)];
end

function P = jacobian(u, b)   % Jacobian matrix
theta = u(1);
P = [-b * sin(theta), -1
    -b * cos(theta), 0];
end