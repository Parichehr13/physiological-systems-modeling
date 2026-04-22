# Baseline Hemorrhage Scenario

This folder contains the open-loop reference simulation for the circulation project.

## Entry Point

- `run_baseline_hemorrhage.m`

## Scenario Summary

- uses the shared circulation model and shared Euler solver
- applies a 400 mL hemorrhage between 10 s and 60 s
- returns a reusable results struct in the MATLAB workspace
- saves standardized time-series figures in `figures/`

## Notes

This scenario is the baseline comparison for the feedback-control study.
