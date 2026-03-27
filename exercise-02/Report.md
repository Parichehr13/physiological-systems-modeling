# Exercise 02

## Title
Simulation of Systemic Circulation Without Control During Hemorrhage

## Executive Summary
This report presents a lumped-parameter simulation of the cardiovascular systemic circulation in the absence of regulatory control. A hemorrhage event is applied between 10 s and 60 s, and the resulting changes in systemic arterial pressure, systemic venous pressure, right atrial pressure, cardiac output, and systemic filling volume are analyzed. The model shows a marked reduction in flow and pressures during blood loss, followed by stabilization at a lower operating point after hemorrhage ends.

## Model Formulation
The simulation uses three pressure state variables and one flow relation:

- `q = Kr*(Pra - 1.82)`
- `dPsa/dt = (q - (Psa - Psv)/Rsa)/Csa`
- `dPsv/dt = ((Psa - Psv)/Rsa - (Psv - Pra)/Rsv + Ii)/Csv`
- `dPra/dt = ((Psv - Pra)/Rsv - q)/Cra`
- `V = Csa*Psa + Csv*Psv + Cra*Pra`

where:
- `Psa`: systemic arterial pressure (mmHg)
- `Psv`: systemic venous pressure (mmHg)
- `Pra`: right atrial pressure (mmHg)
- `q`: cardiac output (ml/s)
- `V`: systemic filling volume (ml)
- `Ii`: external volume perturbation (ml/s)

## Parameters and Initial Conditions
From the provided MATLAB script:

- `q0 = 5 L/min = 83.33 ml/s`
- `Psa0 = 100 mmHg`
- `Psv0 = 5 mmHg`
- `Pra0 = 4 mmHg`
- `Kr = q0/(Pra0 - 1.82) = 38.23 ml/(s*mmHg)`
- `Rsa = (Psa0 - Psv0)/q0 = 1.14 mmHg*s/ml`
- `Rsv = (Psv0 - Pra0)/q0 = 0.012 mmHg*s/ml`
- `Csa = 4 ml/mmHg`
- `Csv = 111 ml/mmHg`
- `Cra = 31 ml/mmHg`
- Integration step: `DT = 0.1 s`
- Simulation time: `0 to 100 s`

## Hemorrhage Input
The model applies a blood-loss perturbation of total volume `400 ml` over `50 s`:

- `Emor = 400/50 = 8 ml/s`
- `Ii(t) = 0` for `0-10 s`
- `Ii(t) = -8 ml/s` for `10-60 s`
- `Ii(t) = 0` for `60-100 s`

This represents a constant hemorrhage rate during the middle interval.

## Results

### 1. Systemic Arterial Pressure
![Systemic arterial pressure](Systemic%20arterial%20pressure.jpg)

`Psa` remains near 100 mmHg before hemorrhage, then decreases almost linearly during blood loss to about 52-53 mmHg. After hemorrhage stops, it settles quickly with minimal rebound.

### 2. Systemic Venous Pressure
![Systemic venous pressure](Systemic%20venous%20pressure.jpg)

`Psv` drops from about 5.0 mmHg to about 3.37 mmHg during hemorrhage, then shows a small recovery and stabilizes near 3.43 mmHg.

### 3. Right Atrial Pressure
![Right atrial pressure](Right%20atrial%20pressure.jpg)

`Pra` follows a similar pattern, decreasing from 4.0 mmHg to around 2.88 mmHg during hemorrhage, then slightly recovering to around 2.93 mmHg.

### 4. Cardiac Output
![Cardiac output](Cardiac%20output.jpg)

Cardiac output decreases from about 83.3 ml/s to about 40.5 ml/s during hemorrhage, then recovers slightly and stabilizes near 42.3 ml/s. This confirms reduced venous return and reduced pump output under volume depletion.

### 5. Systemic Filling Volume
![Systemic filling volume](Systemic%20filling%20Volume.jpg)

Total systemic filling volume decreases from approximately 1080 ml to approximately 680 ml, matching the imposed 400 ml blood loss. After `t = 60 s`, the volume remains constant because the perturbation returns to zero.

## Discussion
The trajectories are consistent with the expected behavior of an uncontrolled circulation model under hemorrhage. As blood is removed, total filling volume falls, venous pressure decreases, and right atrial pressure declines. Because cardiac output depends directly on right atrial pressure in this model, flow also drops substantially.

A key point is that the system does not recover to baseline after hemorrhage stops. Instead, it settles at a new steady state with lower pressures and lower cardiac output. This is physiologically reasonable for a model without reflex compensation (for example, baroreflex-mediated vasoconstriction or heart-rate changes).

Overall, the simulation clearly captures the direct hemodynamic consequences of sustained blood loss and provides a useful baseline for later comparison with controlled or feedback-enabled models.

## Conclusion
The Exercise 02 simulation successfully demonstrates the effects of a 400 ml hemorrhage on an uncontrolled systemic circulation model.

Main outcomes:

1. Significant reductions in `Psa`, `Psv`, `Pra`, and `q` during blood loss.
2. Systemic filling volume decreases exactly according to the imposed hemorrhage profile.
3. After hemorrhage ends, the system stabilizes at a lower operating point rather than returning to baseline.

These results are coherent with first-principles cardiovascular dynamics and support the validity of the implemented model for this scenario.
