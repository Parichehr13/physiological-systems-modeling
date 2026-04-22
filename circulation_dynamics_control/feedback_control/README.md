# Feedback Control Scenario

This folder compares uncontrolled and feedback-controlled systemic circulation during hemorrhage.

## Entry Point

- `run_feedback_control.m`

## Scenario Summary

- reuses the same shared open-loop model as the baseline scenario
- adds dynamic adaptation of systemic arterial resistance and cardiac gain
- compares controlled and open-loop trajectories using standardized plots
- saves standardized comparison figures plus a combined `feedback_adaptation.jpg` summary in `figures/`

## Notes

The controller redistributes pressure and flow but does not replace lost volume, so filling-volume changes still follow the hemorrhage input.
