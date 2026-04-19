# Project 03

## Title
Systemic Circulation Model: Numerical and Analytical Solution Consistency

## Executive Summary
This report analyzes a systemic circulation simulation without external perturbation, starting from a non-equilibrium initial arterial pressure. Three solution methods are compared: Euler integration, eigenvector-based closed-form reconstruction, and matrix exponential propagation. The three approaches match closely in all pressure trajectories, confirming numerical correctness and model consistency.

## Model Formulation
The model uses the following state variables:

- `Psa`: systemic arterial pressure (mmHg)
- `Psv`: systemic venous pressure (mmHg)
- `Pra`: right atrial pressure (mmHg)

Flow and dynamics are:

- `q = Kr*Pra`
- `dPsa/dt = (q - (Psa - Psv)/Rsa)/Csa`
- `dPsv/dt = ((Psa - Psv)/Rsa - (Psv - Pra)/Rsv + Ii)/Csv`
- `dPra/dt = ((Psv - Pra)/Rsv - q)/Cra`
- `V = Csa*Psa + Csv*Psv + Cra*Pra`

For this project, `Ii = 0` over the full simulation.

## Parameters and Initial Conditions
From `circulation_methods_comparison.m`:

- `q0 = 5 L/min = 83.33 mL/s`
- `Psa0 = 100 mmHg`
- `Psv0 = 5 mmHg`
- `Pra0 = 4 mmHg`
- `Kr = q0/Pra0 = 20.83 mL/(s*mmHg)`
- `Rsa = (Psa0 - Psv0)/q0 = 1.14 mmHg*s/mL`
- `Rsv = (Psv0 - Pra0)/q0 = 0.012 mmHg*s/mL`
- `Csa = 4 mL/mmHg`
- `Csv = 111 mL/mmHg`
- `Cra = 31 mL/mmHg`
- `DT = 0.1 s`
- `t = 0 to 50 s`

Initial state used in simulation:

- `Psa(0) = 1.5*Psa0 = 150 mmHg`
- `Psv(0) = 5 mmHg`
- `Pra(0) = 4 mmHg`

## Solution Approaches
The script compares three solution methods for the same linear system:

1. **Euler integration** in time domain.
2. **Eigenvector decomposition** using `A = V*Lambda*V^-1` and `x(t)` built from modal terms.
3. **Matrix exponential** using `x(t) = expm(A*t)*x0`.

The matrix `A` is formed from `Rsa`, `Rsv`, `Csa`, `Csv`, `Cra`, and `Kr`.

## Results

### 1. Systemic Arterial Pressure
![Systemic arterial pressure](figures/systemic%20arterial%20pressure.jpg)

Arterial pressure decays from 150 mmHg toward a steady value near 118.5 mmHg. The three curves (Euler, Eigenvectors, Exponential) are nearly superimposed, with only tiny visual differences during the early transient.

### 2. Systemic Venous Pressure
![Systemic venous pressure](figures/Systemic%20Venous%20pressure.jpg)

Venous pressure rises from 5.0 mmHg to approximately 5.93 mmHg and stabilizes. Agreement among the three methods remains excellent over the full simulation.

### 3. Right Atrial Pressure
![Right atrial pressure](figures/right%20atrial%20pressure.jpg)

Right atrial pressure increases from 4.0 mmHg to approximately 4.74 mmHg, with smooth first-order-like convergence. Euler, eigenvector, and matrix exponential solutions overlap closely.

### 4. Cardiac Output
![Cardiac output](figures/cardiac%20output.jpg)

Since `q = Kr*Pra`, cardiac output increases from about 83.3 mL/s to approximately 98.7 mL/s as `Pra` rises to its steady value.

### 5. Filling Volume
![Filling volume](figures/fuilling%20volume.jpg)

Total filling volume remains essentially constant at about 1279 mL, as expected when no external inflow/outflow perturbation is applied (`Ii = 0`). Minor fluctuations are numerical-scale and negligible.

## Discussion
This project is mainly a consistency and validation test. The system starts away from equilibrium because arterial pressure is set to 150 mmHg, and then relaxes to a new steady state dictated by model parameters and mass-balance relations.

The key result is the close overlap among Euler, eigenvector, and matrix exponential solutions. That agreement indicates that the state-space formulation is correct and that the Euler implementation with `DT = 0.1 s` is sufficiently accurate for this linear model.

Another important observation is volume conservation. With zero perturbation input, the total filling volume stays constant while pressures and flow redistribute dynamically. This is physically coherent and reinforces confidence in the model equations.

## Conclusion
project 03 confirms both the dynamic behavior and the numerical integrity of the systemic circulation model.

Main outcomes:

1. Pressures and flow converge smoothly from the imposed non-equilibrium initial condition.
2. Euler, eigenvector, and matrix exponential methods produce nearly identical trajectories.
3. Total filling volume is conserved in the no-perturbation case.

These results provide a solid foundation for subsequent modules involving control inputs or physiological feedback mechanisms.




