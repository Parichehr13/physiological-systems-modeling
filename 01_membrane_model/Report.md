# Module 01

## Title
First-Order Electrophysiological Membrane Model: Analytical and Numerical Simulation

## Executive Summary
This report presents the simulation of a first-order membrane voltage model using both an analytical solution and a forward Euler numerical method, followed by a sinusoidal current-input experiment. The numerical and theoretical step-response curves are in strong agreement, validating the Euler implementation at the selected time step. Under sinusoidal stimulation, the membrane voltage exhibits attenuated and phase-lagged oscillations, consistent with low-pass behavior of a first-order system.

## Model and Parameters
The membrane dynamics are modeled as:

`dV/dt = (-V + E0 + r*i(t)) / tau`

with the following parameters (from the provided script and module assets):

- Resting potential: `E0 = -65 mV`
- Membrane resistance: `r = 10 MOhm`
- Time constant: `tau = 30 ms`
- Initial voltage: `V0 = -50 mV`
- Numerical time step: `dt = 0.1 ms`

For the constant-current case, `i = 4 nA`, giving:

`V_inf = E0 + r*i = -65 + 10*4 = -25 mV`

and analytical response:

`V(t) = (V0 - V_inf)*exp(-t/tau) + V_inf`

## Methodology
1. Simulated the step-input case over 0-200 ms using both the analytical expression and Euler integration.
2. Compared the trajectories to assess numerical accuracy.
3. Simulated sinusoidal forcing with:
   - `i(t) = 4*cos(2*pi*f*t)` nA
   - `f = 10 Hz`
   - duration: 0-2000 ms
4. Interpreted amplitude and transient behavior from the generated plots.

## Results

### 1. Step Input: Theoretical vs Numerical
![Step response comparison](figures/1.jpg)

The analytical (solid) and Euler (dashed) curves are nearly indistinguishable throughout the simulation window, indicating high numerical accuracy with `dt = 0.1 ms`. The voltage rises monotonically from `-50 mV` toward the predicted steady-state `-25 mV`, with expected first-order kinetics governed by `tau = 30 ms`.

### 2. Sinusoidal Input Response
![Sinusoidal input response](figures/2.jpg)

Under 10 Hz sinusoidal current stimulation, the membrane voltage oscillates around the resting level with clear attenuation relative to the input-driven equilibrium term `E0 + r*i(t)`. After a short transient, the response becomes periodic and stable, consistent with a linear first-order low-pass system.

Observed behavior from the plot is consistent with theory:

- Mean level near `-65 mV`
- Peak-to-trough oscillation approximately from `-84 mV` to `-46 mV`
- Initial transient that decays over several time constants

## Discussion
The first result shows that the numerical solver is implemented correctly for this problem setup. Because the Euler curve overlaps the analytical solution almost perfectly, we can trust the simulation outcomes at `dt = 0.1 ms` for this first-order model.

The sinusoidal case is also physically meaningful. The membrane voltage follows the input rhythm, but with smaller amplitude and a visible delay, which is exactly what we expect from a first-order membrane with finite time constant. In practical terms, the membrane behaves like a smoothing filter: rapid input variations are not transferred fully to voltage, while slower components are tracked more effectively.

## Conclusion
The provided simulations successfully characterize a first-order membrane model in two regimes:

1. Accurate convergence of numerical Euler integration to the analytical step response.
2. Low-pass, attenuated, and phase-delayed voltage oscillations under sinusoidal forcing.

Overall, the results are internally consistent and aligned with expected first-order electrophysiological dynamics.



