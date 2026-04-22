# Assisted Ventilation Scenarios

This folder contains the mechanical-ventilation extension of the respiratory mechanics model.

## Entry Points
- `run_natural_breathing.m`
- `run_controlled_breathing.m`

## Summary
- reuses the shared respiratory mechanics solver
- compares natural breathing with mouth-pressure-assisted flow tracking
- saves standardized `natural_*.jpg` and `controlled_*.jpg` figures in `figures/`
- keeps the mechanics model explicit rather than hiding it behind plotting scripts
