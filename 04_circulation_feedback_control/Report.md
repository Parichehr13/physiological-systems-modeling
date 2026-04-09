# Module 04 Report

## Title
Systemic Circulation With and Without Feedback Control During Hemorrhage

## Executive Summary
This module compares two simulations of systemic circulation under hemorrhage: one without control and one with feedback control acting on systemic arterial resistance (`Rsa`) and cardiac factor (`Kr`). During blood loss, both cases show reduced pressures and flow; however, the controlled model significantly improves arterial pressure and cardiac output recovery. As expected, total filling volume remains determined by hemorrhage input and is not restored by this pressure-flow controller.

## Model Formulation
The state variables are:

- `Psa`: systemic arterial pressure (mmHg)
- `Psv`: systemic venous pressure (mmHg)
- `Pra`: right atrial pressure (mmHg)

Core dynamics:

- `q = Kr*(Pra - 1.82)`
- `dPsa/dt = (q - (Psa - Psv)/Rsa)/Csa`
- `dPsv/dt = ((Psa - Psv)/Rsa - (Psv - Pra)/Rsv + Ii)/Csv`
- `dPra/dt = ((Psv - Pra)/Rsv - q)/Cra`
- `V = Csa*Psa + Csv*Psv + Cra*Pra`

Hemorrhage profile:

- Total blood loss: `400 mL` over `50 s`
- `Ii(t) = 0` for `0-10 s`
- `Ii(t) = -8 mL/s` for `10-60 s`
- `Ii(t) = 0` for `60-150 s`

## Parameters
From `circulation_feedback_control.m`:

- `q0 = 5 L/min = 83.33 mL/s`
- `Psa0 = 100 mmHg`
- `Psv0 = 5 mmHg`
- `Pra0 = 4 mmHg`
- `Kr0 = q0/(Pra0 - 1.82) = 38.23 mL/(s*mmHg)`
- `Rsa0 = (Psa0 - Psv0)/q0 = 1.14 mmHg*s/mL`
- `Rsv = (Psv0 - Pra0)/q0 = 0.012 mmHg*s/mL`
- `Csa = 4 mL/mmHg`
- `Csv = 111 mL/mmHg`
- `Cra = 31 mL/mmHg`
- `DT = 0.1 s`, simulation time `0-150 s`

## Feedback Controller
In the controlled simulation, `Rsa` and `Kr` adapt dynamically:

- `DKr = -(Kr - Kr0) - GK*(Psa - Psa0)`
- `DRsa = -(Rsa - Rsa0) - GR*(Psa - Psa0)`
- `Kr_next = Kr + (DT/tauK)*DKr`
- `Rsa_next = Rsa + (DT/tauR)*DRsa`

with:

- `tauK = 5 s`
- `tauR = 15 s`
- `GK = (Kr0/Psa0)*15`
- `GR = (Rsa0/Psa0)*0.6`

## Results

### 1. Systemic Arterial Pressure
![Systemic arterial pressure](figures/Systemic%20arterial%20pressure.jpg)

- Uncontrolled (blue): pressure drops from ~100 mmHg to ~52 mmHg.
- Controlled (red): pressure decreases less severely and stabilizes around ~75-76 mmHg.

The controller substantially improves perfusion pressure during and after hemorrhage.

### 2. Systemic Venous Pressure
![Systemic venous pressure](figures/Systemic%20venous%20pressure.jpg)

- Uncontrolled: stabilizes near ~3.43 mmHg.
- Controlled: settles lower, near ~2.80 mmHg.

Lower venous pressure in the controlled case is consistent with altered flow distribution and increased pumping effectiveness.

### 3. Right Atrial Pressure
![Right atrial pressure](figures/Rigth%20atrial%20pressure.jpg)

- Uncontrolled: final level near ~2.93 mmHg.
- Controlled: lower final level near ~2.13 mmHg.

With higher `Kr`, the controlled model supports stronger outflow from right atrial compartment.

### 4. Cardiac Output
![Cardiac output](figures/Cardiac%20output.jpg)

- Uncontrolled: falls to ~42 mL/s.
- Controlled: recovers and stabilizes near ~56 mL/s.

The control law improves output significantly compared with the no-control baseline.

### 5. Systemic Filling Volume
![Systemic filling volume](figures/Systemic%20filling%20volume.jpg)

Both curves overlap almost perfectly and drop from ~1080 mL to ~680 mL, matching imposed hemorrhage magnitude (400 mL). Controller action does not replace lost volume.

### 6. Systemic Arterial Resistance
![Systemic arterial resistance](figures/Systemic%20arterial%20resistance.jpg)

`Rsa` rises from baseline `Rsa0 ~ 1.14` to about `1.31 mmHg*s/mL`, while no-control reference remains constant. This resembles vasoconstrictive compensation.

### 7. Cardiac Factor (k)
![Cardiac factor](figures/Cardiac%20factor%20(k).jpg)

`Kr` increases strongly from `Kr0 ~ 38` to about `178-180 mL/(s*mmHg)`, supporting cardiac output recovery despite reduced volume.

## Discussion
This module demonstrates the value of feedback in a hemorrhage scenario. Without control, pressures and output collapse toward a low-flow state. With control, the system still reflects blood loss, but the drop in arterial pressure and cardiac output is much less severe.

The mechanism is clear in the parameter trajectories: `Rsa` increases and `Kr` increases, which together help preserve arterial pressure and flow. At the same time, total filling volume remains unchanged between cases because the controller redistributes hemodynamics but does not inject volume.

Overall, the controlled model reproduces an intuitive compensatory response: maintain pressure and flow as much as possible under reduced circulating volume.

## Conclusion
module 04 confirms that the added controller improves hemodynamic stability during hemorrhage.

Main outcomes:

1. Controlled simulation maintains higher arterial pressure and higher cardiac output than the uncontrolled case.
2. Controller acts through dynamic increase of `Rsa` and `Kr`.
3. Filling volume trajectory is unchanged by control and follows hemorrhage input exactly.

The results provide a strong controlled-vs-uncontrolled baseline for subsequent cardiovascular regulation analyses.



