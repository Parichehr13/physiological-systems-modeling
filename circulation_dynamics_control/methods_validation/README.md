# Methods Validation Scenario

This folder validates the circulation simulation against analytic solutions for the same underlying model used in the hemorrhage and feedback scenarios.

## Entry Point

- `run_methods_validation.m`

## Scenario Summary

- starts from an elevated arterial-pressure initial condition
- compares Euler integration, eigen-decomposition, and matrix-exponential solutions
- uses the same flow law as the rest of the project:
  - `q = Kr * (Pra - 1.82)`
- saves standardized comparison figures in `figures/`

## Model Note

The `Pra - 1.82` term makes the state equation affine rather than homogeneous. The analytic comparison is therefore performed around the equilibrium shift of the linear system instead of assuming `x' = A x` with zero offset.
