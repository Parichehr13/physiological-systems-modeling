# Biological System Modeling

MATLAB-based projects in biomedical system modeling, computational physiology, and nonlinear dynamics.

## Overview

This repository presents a collection of compact modeling projects developed in MATLAB across core topics in biomedical engineering. The work covers membrane dynamics, cardiovascular and respiratory systems, gas exchange, hemodialysis, nonlinear dynamics, and neuronal modeling.

Most project folders include:
- MATLAB implementation files (`.m`)
- a project README or concise technical report
- a `figures/` directory with saved plots

## Repository Layout

| Folder | Topic | Description |
|---|---|---|
| `01_membrane_model` | Membrane model | First-order membrane modeling and simulation of membrane voltage behavior |
| `02_circulation_no_control` | Circulatory system | Modeling systemic circulation under hemorrhage conditions without control mechanisms |
| `03_circulation_methods_comparison` | Numerical methods | Comparison of numerical and analytical solution methods for circulation models |
| `04_circulation_feedback_control` | Feedback control | Circulatory modeling with physiological feedback mechanisms |
| `05_hemodialysis_dynamics` | Hemodialysis | Dynamic modeling of solute, osmolarity, and fluid-volume changes during hemodialysis |
| `respiratory_mechanics_gas_exchange` | Respiratory systems | Merged project covering spontaneous breathing, assisted ventilation, and gas-exchange control |
| `09_nonlinear_dynamics_chaos` | Nonlinear systems | Exploration of chaos and sensitivity to initial conditions in classical dynamical systems |
| `10_hodgkin_huxley_neuron` | Neuron model | Hodgkin-Huxley modeling of neuronal membrane potential and ionic conductances |

## Featured Merged Project

### `respiratory_mechanics_gas_exchange`
This project combines three related respiratory modules into one coherent study:
- `spontaneous_breathing/`: baseline respiratory mechanics with muscle-driven ventilation
- `assisted_ventilation/`: natural and controlled ventilation using the same mechanics model
- `gas_exchange_control/`: CO2/O2 gas exchange and ventilatory regulation

The hemodialysis project in `05_hemodialysis_dynamics` remains separate because it belongs to a different physiological story centered on solute transport, ultrafiltration, and osmotic balance rather than respiratory mechanics and gas exchange.

## Academic Focus

This repository highlights experience in:
- MATLAB-based simulation and numerical analysis
- differential-equation-based modeling
- physiological and biomedical system modeling
- feedback and control in biological systems
- computational analysis of neural and physiological dynamics

## Quick Start

1. Open MATLAB.
2. Navigate to a project folder, for example `respiratory_mechanics_gas_exchange/assisted_ventilation`.
3. Run one of the main scripts in that folder, for example `respiratory_controlled_breathing`.
4. Review the generated plots and the local `README.md`.

## Notes

- No external toolbox is required for the provided scripts.
- The circulation modules are still separate at the repository root and can be consolidated in a later cleanup step.
- Parameter values are intentionally easy to modify for sensitivity testing.
