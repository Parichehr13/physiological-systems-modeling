# Gas Exchange and Ventilatory Regulation Scenarios

This folder contains the gas-exchange extension of the respiratory project.

## Entry Points
- `run_gas_exchange_open_loop.m`
- `run_gas_exchange_controlled.m`

## Summary
- uses shared gas-exchange parameter and simulation helpers
- includes an open-loop CO2 scenario and a controlled CO2/O2 regulation scenario
- saves standardized `open_loop_*.jpg` and `controlled_*.jpg` figures in `figures/`
- should be interpreted as a higher-level extension of the respiratory project, not as a fully coupled mechanics-plus-gas simulator
