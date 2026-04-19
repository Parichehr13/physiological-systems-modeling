# Biological System Modeling

MATLAB-based simulations of physiological and dynamical systems, including membrane models, systemic circulation, respiratory mechanics, gas exchange, hemodialysis, nonlinear dynamics, and the Hodgkin–Huxley neuron model.

## Overview

This repository collects **10 independent modeling projects** focused on mathematical and computational analysis of biological systems.  
Each project is organized around a specific physiological or dynamical model and typically includes:

- a MATLAB simulation script
- a short report or project note
- exported figures for interpreting the results

The repository is best understood as a **collection of modeling studies**, not as a single software package.

## Project Map

| Project | Topic | Main Focus |
|---|---|---|
| `01_membrane_model` | First-order membrane model | Analytical and numerical simulation of membrane voltage |
| `02_circulation_no_control` | Systemic circulation without control | Hemorrhage response in a circulation model |
| `03_circulation_methods_comparison` | Numerical methods comparison | Euler, eigenvalue, and matrix-exponential solutions |
| `04_circulation_feedback_control` | Circulation with feedback control | Pressure and flow recovery during hemorrhage |
| `05_hemodialysis_dynamics` | Hemodialysis dynamics | Solute, osmolarity, and fluid-volume changes over time |
| `06_respiratory_spontaneous_breathing` | Respiratory mechanics | Spontaneous breathing dynamics |
| `07_respiratory_assisted_controlled` | Ventilation modeling | Assisted and controlled ventilation behavior |
| `08_gas_exchange_ventilation_control` | Gas exchange and ventilatory control | CO2/O2 regulation with feedback |
| `09_nonlinear_dynamics_chaos` | Nonlinear dynamics and chaos | Lorenz and Rössler attractors and sensitivity to initial conditions |
| `10_hodgkin_huxley_neuron` | Hodgkin–Huxley neuron model | Repetitive spiking and ionic conductance dynamics |

## What This Repository Covers

The projects in this repository span several connected themes:

- **Bioelectric and membrane modeling**
- **Cardiovascular system dynamics**
- **Respiratory mechanics and ventilation**
- **Gas exchange and feedback regulation**
- **Hemodialysis modeling**
- **Nonlinear dynamics and chaos**
- **Computational neuroscience**

This breadth is one of the repository’s strengths: it shows not only coding work in MATLAB, but also a solid foundation in **physiological modeling, control systems, and applied dynamical systems**.

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
3. Review the corresponding figures and notes to interpret the model behavior.

Many folders also include:

- `README.md` with a short explanation of the model
- `figures/` containing exported plots from the simulations

## Recommended Entry Points

If you are visiting this repository for the first time, these are good places to start:

- **`10_hodgkin_huxley_neuron`** for computational neuroscience
- **`09_nonlinear_dynamics_chaos`** for dynamical systems and attractors
- **`08_gas_exchange_ventilation_control`** for physiological feedback modeling
- **`03_circulation_methods_comparison`** for numerical-method comparison

## Notes

- The projects are organized as **independent studies**, so each folder can be explored on its own.
- The repository emphasizes **model understanding and simulation results** more than software packaging.
- Some projects may be more physiology-focused, while others emphasize numerical analysis or dynamical behavior.

## Suggested Future Improvements

To make the repository even stronger, consider adding:

- a short README inside **every** project folder
- a consistent folder structure across all projects
- one preview figure for each project
- a small section listing required MATLAB toolboxes, if any
- a license file
- tags/topics in the GitHub About section

## License

No license file is currently included.  
If you want others to reuse the code clearly and safely, adding a license would improve the repository.

---

If you use this repository as a portfolio project, it may also help to add a short sentence about its academic context, such as coursework, self-study, or a biomedical engineering modeling class.
