# Respiratory Mechanics, Assisted Ventilation, and Gas Exchange Control in MATLAB

## Overview
This project organizes three related MATLAB respiratory studies into one coherent codebase. It starts with lumped respiratory mechanics, extends that mechanics model to assisted ventilation and flow tracking, and then adds a higher-level gas-exchange and ventilatory-regulation layer.

## Scientific Motivation
Respiratory physiology spans multiple modeling levels. Pressure-flow mechanics explain how breathing moves air, assisted-ventilation models explain how external actuation can shape that flow, and gas-exchange regulation explains how CO2/O2 dynamics influence ventilation demand. These are not one fully coupled simulator here, but they form a consistent progression from mechanics to control and regulation.

## Project Progression
### 1. Spontaneous breathing mechanics
`spontaneous_breathing/` provides a baseline resistance-compliance lung model driven by periodic respiratory muscle pressure.

### 2. Assisted ventilation
`assisted_ventilation/` reuses the same mechanical model for two scenarios:
- natural breathing with a physiologic piecewise muscle-pressure waveform
- mouth-pressure assistance with simple flow-tracking control

### 3. Gas exchange and ventilatory regulation
`gas_exchange_control/` provides a higher-level compartment model for CO2 transport and for coupled CO2/O2 regulation with peripheral and central ventilatory contributions.

## Model Components
- shared respiratory-mechanics parameters and simulation logic in `shared/`
- shared gas-exchange parameters and simulation helpers in `shared/`
- thin scenario runner functions for each study
- standardized plotting and figure export
- lightweight project-level verification via `verify_respiratory_project.m`

## Representative Outputs
- pleural, alveolar, and drive-pressure trajectories
- airflow, alveolar ventilation, and lung-volume oscillations
- comparison of natural and assisted ventilation behavior
- flow-tracking plots for mouth-pressure control
- alveolar and venous CO2/O2 pressure trajectories
- ventilation decomposition into peripheral and central contributions

## Main Takeaways
- a reduced resistance-compliance model can reproduce coherent breathing-related pressure, flow, and volume dynamics
- mouth-pressure assistance can shape flow and track a target waveform without abandoning the underlying mechanics model
- higher-level gas-exchange regulation can be studied as a related extension without claiming a fully integrated cardiopulmonary simulator

## Limitations
- the mechanics and gas-exchange layers are related conceptually but are not yet fully coupled into one end-to-end model
- parameter values are fixed and teaching-scale rather than calibrated to a specific dataset
- the control designs are simple and intended for insight rather than clinical fidelity

## Future Work
- couple mechanics and gas exchange through shared ventilation outputs
- standardize scenario parameters for easier sensitivity studies
- connect this respiratory project to circulation/perfusion assumptions in the circulation project
- add regression-style numerical checks if the project grows further
