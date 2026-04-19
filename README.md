# Biological System Modeling

MATLAB-based simulations of physiological and dynamical systems, covering membrane models, circulation, respiratory mechanics, gas exchange, hemodialysis, nonlinear dynamics, and the Hodgkin–Huxley neuron model.

## Overview

This repository is a collection of **10 MATLAB modeling projects** in biomedical engineering and computational physiology.  
Each folder focuses on a different biological or dynamical system and usually includes:

- a MATLAB script for simulation
- a short report or notes about the model
- **at least one figure showing the main result of that project**

Rather than being a single software package, this repository is better understood as a **set of independent modeling studies**.

## Project Map

| Folder | Topic | Main Focus | Figure Included |
|---|---|---|---|
| `01_membrane_model` | First-order membrane model | Analytical and numerical simulation of membrane voltage | Membrane response plot |
| `02_circulation_no_control` | Circulation without control | Hemorrhage response in systemic circulation | Pressure/flow response figure |
| `03_circulation_methods_comparison` | Numerical methods comparison | Euler, eigenvalue, and matrix-exponential solutions | Method comparison plot |
| `04_circulation_feedback_control` | Circulation with feedback control | Pressure and flow recovery during hemorrhage | Feedback-control response figure |
| `05_hemodialysis_dynamics` | Hemodialysis dynamics | Solute, volume, and osmolarity changes over time | Dialysis dynamics plot |
| `06_respiratory_spontaneous_breathing` | Respiratory mechanics | Spontaneous breathing dynamics | Breathing waveform figure |
| `07_respiratory_assisted_controlled` | Ventilation modeling | Assisted and controlled ventilation behavior | Ventilation response plot |
| `08_gas_exchange_ventilation_control` | Gas exchange and ventilatory control | CO2/O2 regulation with feedback | Gas exchange figure |
| `09_nonlinear_dynamics_chaos` | Nonlinear dynamics and chaos | Lorenz and Rössler attractors and sensitivity to initial conditions | Attractor / phase-space plot |
| `10_hodgkin_huxley_neuron` | Hodgkin–Huxley neuron model | Repetitive spiking and ionic conductance dynamics | Membrane potential / conductance figure |

## What This Repository Covers

The projects in this repository span several connected themes:

- **Bioelectric and membrane modeling**
- **Cardiovascular system dynamics**
- **Respiratory mechanics and ventilation**
- **Gas exchange and feedback regulation**
- **Hemodialysis modeling**
- **Nonlinear dynamics and chaos**
- **Computational neuroscience**

Together, these projects show a broad foundation in **physiological modeling, numerical simulation, control systems, and dynamical systems** using MATLAB.

## Figures Across the Repository

A figure is included in each project folder to illustrate the central behavior of the model being studied.  
These figures are not just decorations — they are part of the project outputs and help the reader quickly understand what each simulation demonstrates.

Examples include:

- membrane voltage responses
- circulation pressure and flow changes
- numerical-method comparisons
- ventilation and breathing curves
- gas exchange dynamics
- chaotic attractors
- neuron membrane potential and conductance behavior

Because each folder already contains its own relevant figure, this README uses the project map above to show **which kind of figure belongs to each project**, instead of only displaying three selected images from the whole repository.

## Why This Repository Is Useful

This repository can be useful for:

- students learning biomedical system modeling
- coursework in biomedical engineering or physiological control systems
- MATLAB-based numerical simulation practice
- quick reference examples for dynamical-system implementation
- building intuition about how mathematical models describe biological processes

## Repository Structure

```text
biological-system-modeling/
├── 01_membrane_model/
├── 02_circulation_no_control/
├── 03_circulation_methods_comparison/
├── 04_circulation_feedback_control/
├── 05_hemodialysis_dynamics/
├── 06_respiratory_spontaneous_breathing/
├── 07_respiratory_assisted_controlled/
├── 08_gas_exchange_ventilation_control/
├── 09_nonlinear_dynamics_chaos/
├── 10_hodgkin_huxley_neuron/
└── README.md
```

## How to Use

1. Open any project folder in MATLAB.
2. Run the main `.m` script.
3. Read the local notes or report if included.
4. Review the figure in that folder to interpret the main result.

## Recommended Entry Points

If you are visiting this repository for the first time, these are good places to start:

- **`10_hodgkin_huxley_neuron`** for computational neuroscience
- **`09_nonlinear_dynamics_chaos`** for dynamical systems and attractors
- **`08_gas_exchange_ventilation_control`** for physiological feedback modeling
- **`03_circulation_methods_comparison`** for numerical-method comparison

## Notes

- Each folder is designed to be explored **independently**.
- The repository emphasizes **model understanding and simulation results** more than software packaging.
- The included figures are an important part of the documentation for each project.

---

If you use this repository as a portfolio project, it may also help to add a short sentence about its academic context, such as coursework, self-study, or a biomedical engineering modeling class.
