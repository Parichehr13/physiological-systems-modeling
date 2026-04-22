# Respiratory Mechanics, Assisted Ventilation, and Gas Exchange Control in MATLAB

## Overview
This project studies respiratory dynamics using reduced-order MATLAB models that progress from spontaneous breathing mechanics to assisted ventilation and then to gas-exchange regulation. The goal is to connect mechanical ventilation behavior with higher-level control of CO2 and O2.

## Scientific Motivation
Respiratory physiology spans multiple levels: pressure-flow mechanics, ventilatory assistance, and chemical regulation through blood-gas feedback. Even simplified compartmental models can capture useful relationships among muscle pressure, pleural and alveolar pressure, airflow, lung volume, and ventilatory control signals.

## Project Progression
### 1. Spontaneous breathing mechanics
The `spontaneous_breathing/` study models the respiratory system as a lumped resistance-compliance network driven by periodic muscle pressure. It provides baseline pressure, flow, and volume dynamics during unassisted breathing.

### 2. Assisted and controlled ventilation
The `assisted_ventilation/` study reuses the same mechanical framework to examine external assistance. It compares natural breathing behavior with mouth-pressure-driven support and a simple controller that tracks a target ventilation waveform.

### 3. Gas exchange and ventilatory regulation
The `gas_exchange_control/` study shifts from mechanics to gas transport and feedback regulation. A baseline open-loop CO2 model is followed by a coupled CO2/O2 model with delayed peripheral and central ventilatory contributions, showing how gas levels and ventilation interact dynamically.

## Representative Outputs
Typical outputs include:
- pleural and alveolar pressure trajectories
- airflow, alveolar ventilation, and volume oscillations
- comparison of spontaneous and assisted breathing patterns
- target-tracking behavior under mouth-pressure control
- alveolar and venous CO2/O2 pressure trajectories
- decomposition of total ventilation into peripheral and central control contributions

## Folder Guide
- `spontaneous_breathing/`: baseline respiratory mechanics model, figures, and local `README.md`
- `assisted_ventilation/`: assisted and controlled ventilation variants, figures, and local `README.md`
- `gas_exchange_control/`: open-loop and feedback-regulated gas-exchange models, figures, and local `README.md`

## Limitations
These are reduced teaching-scale models with hard-coded parameters and simplified compartment structure. The mechanics and gas-exchange components are related conceptually but are not yet implemented as one fully integrated end-to-end simulator. Some scripts also preserve exercise-style choices such as inline parameter definitions, commented alternatives, and scenario-specific tuning.

## Future Work
Natural next steps include harmonizing notation across the respiratory scripts, refactoring shared parameters into reusable functions, integrating mechanics and gas exchange into one coupled model, and connecting this module to the circulation project through blood-gas transport and perfusion assumptions.
