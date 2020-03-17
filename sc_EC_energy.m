omega = 2;
P = 2*pi/omega;
dt = P/20;
T = 40*P;
N_t = floor(round(T/dt)); % round toward negative infinity
t = linspace(0, N_t*dt, N_t+1); % generate linearly spaced vector

u = zeros(N_t+1, 1); % create array with zeros
v = zeros(N_t+1, 1);
X_0 = 2; % initial conditions
u(1) = X_0;
v(1) = 0;
for n = 1:N_t
    v(n+1) = v(n) - dt*omega^2*u(n);
    u(n+1) = u(n) + dt*v(n+1);
end

[U, K] = osc_energy(u, v, omega);

plot(t, U+K, 'b-');
xlabel('t');
ylabel('U+K');