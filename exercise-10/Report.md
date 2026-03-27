# Exercise 10

## Title
Hodgkin-Huxley Membrane Dynamics Under Constant Current Stimulation

## Executive Summary
This exercise simulates the Hodgkin-Huxley neuronal membrane model under constant injected current (`I = 15`). The model produces a periodic train of action potentials over 100 ms, with realistic coupling between membrane voltage, gating variables (`m`, `n`, `h`), and voltage-dependent sodium/potassium conductances.

The results are consistent with classical excitability behavior: fast sodium activation drives the spike upstroke, sodium inactivation and delayed potassium activation drive repolarization, and the cycle repeats at a regular firing rate.

## Model Formulation
The membrane equation implemented in `Exercise10.m` is:

`dV/dt = ( -gKmax*n^4*(V-EK) - gNamax*m^3*h*(V-ENa) - gEq*(V-EEq) + I ) / C`

Gating dynamics:

- `dm/dt = alpha_m*(1-m) - beta_m*m`
- `dn/dt = alpha_n*(1-n) - beta_n*n`
- `dh/dt = alpha_h*(1-h) - beta_h*h`

where `alpha` and `beta` rates are voltage-dependent and updated at each step.

Effective conductances shown in the plots:

- Sodium: `gNa = gNamax*m^3*h`
- Potassium: `gK = gKmax*n^4`

## Parameters and Simulation Setup
From the script:

- `gNamax = 120`
- `gKmax = 36`
- `gEq = 0.3`
- `ENa = 55 mV`
- `EK = -77 mV`
- `EEq = -54.4 mV`
- `V0 = -65 mV`
- `I = 15` (constant current input)
- `C = 4`
- `dt = 0.01 ms`
- Time horizon: `0-100 ms`

## Results

### 1. Membrane Potential
![Membrane potential](figures/membrane_potential.jpg)

The voltage trace shows repetitive spiking with peaks near `+20 mV` and troughs around `-73 mV`. Approximately 6 spikes appear over 100 ms, indicating a sustained periodic firing regime under the selected current.

### 2. Gating Variables (`m`, `n`, `h`)
![Gating variables](figures/gating_variables_m_n_h.jpg)

- `m` (red) rises sharply during each upstroke and falls quickly after the peak.
- `n` (blue) activates more slowly and remains elevated during repolarization.
- `h` (green) decreases during depolarization (inactivation) and recovers between spikes.

This timing relationship is the expected Hodgkin-Huxley mechanism for spike generation and recovery.

### 3. Ionic Conductances
![Ionic conductances](figures/ionic_conductances.jpg)

The sodium conductance (red) shows narrow high peaks preceding potassium peaks. Potassium conductance (green) rises later and decays more slowly, consistent with delayed-rectifier behavior.

The sequence of events per spike is clear:

1. Rapid `gNa` increase initiates depolarization.
2. `gNa` collapses due to inactivation.
3. Elevated `gK` repolarizes and hyperpolarizes the membrane.
4. Recovery of gating variables enables the next spike.

## Discussion
The simulation reproduces the hallmark Hodgkin-Huxley firing cycle under tonic stimulation. Spike shape and gating trajectories are internally consistent and physiologically plausible.

The repeated spike train indicates that `I = 15` is above the threshold for sustained firing in this parameter setup. The conductance traces confirm the expected sodium-leading/potassium-lagging interaction that stabilizes periodic oscillations in membrane voltage.

Overall, Exercise 10 provides a strong numerical demonstration of excitability and repetitive firing in a conductance-based neuron model.

## Conclusion
Exercise 10 successfully demonstrates periodic action potential generation in the Hodgkin-Huxley model.

Main outcomes:

1. Constant input current drives stable repetitive spiking.
2. Gating variables exhibit correct relative timing (`m` fast, `n` delayed, `h` inactivating).
3. Sodium and potassium conductance dynamics explain depolarization-repolarization cycles.

These results form a solid baseline for further tests such as current-threshold sweeps, altered channel maxima, or pharmacological conductance block simulations.
