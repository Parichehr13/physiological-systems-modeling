# Physiological Systems Modeling Portfolio

Curated MATLAB portfolio focused on reduced-order physiological modeling, feedback control, and nonlinear biological dynamics.

## Overview

This repository is organized as a small modeling portfolio rather than a flat archive of coursework exercises. The two main projects are the circulation and respiratory codebases, each refactored into reusable MATLAB project structures with shared functions, scenario-specific runners, saved figures, and lightweight verification scripts.

Alongside those core projects, a smaller set of supplementary modules captures additional work in membrane dynamics, hemodialysis transport, nonlinear chaos, and neuronal spiking.

## Scientific Focus

The repository emphasizes:

- compartmental and reduced-order physiological modeling
- ordinary differential equation simulation in MATLAB
- feedback and control in biomedical systems
- numerical verification and project-style code organization
- interpretation of nonlinear and excitable biological dynamics

## Repository Structure

```text
core_projects/
|-- circulation_dynamics_control/
`-- respiratory_mechanics_gas_exchange/

supplementary_modules/
|-- membrane_dynamics/
|-- hemodialysis_dynamics/
|-- nonlinear_dynamics_chaos/
`-- hodgkin_huxley_neuron/
```

## Core Projects

### 1. [Systemic Circulation Modeling and Feedback Control](core_projects/circulation_dynamics_control/README.md)

Refactored MATLAB project for systemic hemodynamics under hemorrhage. It progresses from an uncontrolled baseline to numerical-method validation and then to pressure-based feedback control.

Key elements:
- open-loop hemorrhage simulation
- Euler, eigen-decomposition, and matrix-exponential validation
- controlled versus uncontrolled hemodynamic response
- shared simulation, plotting, and verification utilities

Main entry points:
- `core_projects/circulation_dynamics_control/baseline_hemorrhage/run_baseline_hemorrhage.m`
- `core_projects/circulation_dynamics_control/methods_validation/run_methods_validation.m`
- `core_projects/circulation_dynamics_control/feedback_control/run_feedback_control.m`
- `core_projects/circulation_dynamics_control/verify_circulation_project.m`

### 2. [Respiratory Mechanics, Assisted Ventilation, and Gas Exchange Control](core_projects/respiratory_mechanics_gas_exchange/README.md)

Refactored MATLAB project for respiratory-system modeling, moving from spontaneous breathing mechanics to assisted ventilation and then to higher-level gas-exchange regulation.

Key elements:
- resistance-compliance respiratory mechanics
- assisted ventilation and flow-tracking control
- CO2 and CO2/O2 gas-exchange regulation studies
- shared simulation, plotting, and verification utilities

Main entry points:
- `core_projects/respiratory_mechanics_gas_exchange/spontaneous_breathing/run_spontaneous_breathing.m`
- `core_projects/respiratory_mechanics_gas_exchange/assisted_ventilation/run_natural_breathing.m`
- `core_projects/respiratory_mechanics_gas_exchange/assisted_ventilation/run_controlled_breathing.m`
- `core_projects/respiratory_mechanics_gas_exchange/gas_exchange_control/run_gas_exchange_open_loop.m`
- `core_projects/respiratory_mechanics_gas_exchange/gas_exchange_control/run_gas_exchange_controlled.m`
- `core_projects/respiratory_mechanics_gas_exchange/verify_respiratory_project.m`

## Supplementary Modules

These modules remain standalone because they represent distinct physiological or dynamical topics rather than direct extensions of the two core project stories.
They add breadth to the portfolio, but the primary work is represented by the two core projects above.

- [Membrane Dynamics](supplementary_modules/membrane_dynamics/README.md): first-order electrophysiological membrane dynamics under step and sinusoidal forcing
- [Hemodialysis Dynamics](supplementary_modules/hemodialysis_dynamics/README.md): two-compartment solute, osmolarity, and fluid-volume dynamics during single and repeated dialysis sessions
- [Nonlinear Dynamics and Chaos](supplementary_modules/nonlinear_dynamics_chaos/README.md): Lorenz and Rossler attractors, sensitivity to initial conditions, and qualitative parameter variation
- [Hodgkin-Huxley Neuron](supplementary_modules/hodgkin_huxley_neuron/README.md): conductance-based spiking dynamics under constant current stimulation

`hemodialysis_dynamics` stays supplementary rather than joining the respiratory project because it is fundamentally a solute-transport and ultrafiltration model, not a respiratory mechanics or gas-exchange model.

## Skills Demonstrated

- MATLAB simulation workflow design
- refactoring scripts into reusable functions
- parameter centralization and scenario organization
- figure standardization and lightweight verification
- modeling of circulation, ventilation, gas exchange, transport, and excitable dynamics

## Recommended Reading Order

1. Start with `core_projects/circulation_dynamics_control/` for a compact example of physiological modeling, numerical validation, and feedback control.
2. Continue with `core_projects/respiratory_mechanics_gas_exchange/` for a broader progression from mechanics to assistance and gas-regulation dynamics.
3. Then browse `supplementary_modules/` based on interest: membrane dynamics, dialysis transport, nonlinear chaos, or neuronal spiking.

## Academic Context

These projects were developed in an academic modeling context and then curated into a cleaner portfolio structure. The emphasis here is on clear formulation, reproducible MATLAB workflows, and honest presentation of reduced-order models rather than claims of clinical or experimental validation.

## Notes

- No external MATLAB toolbox is required for the provided scripts.
- The two core projects include lightweight verification scripts for quick sanity checks after refactoring.
- The supplementary modules are intentionally kept simpler and more self-contained for now.
