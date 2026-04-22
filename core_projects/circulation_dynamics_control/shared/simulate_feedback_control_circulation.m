function results = simulate_feedback_control_circulation(params, simulation_config)
%SIMULATE_FEEDBACK_CONTROL_CIRCULATION Euler simulation with feedback adaptation.

time_s = simulation_config.time_s(:).';
dt_s = time_s(2) - time_s(1);
num_steps = numel(time_s);

nominal = params.model.nominal_pressures_mmHg;
nominal_resistance = params.model.resistance_mmHg_s_per_ml.systemic_arterial;
nominal_gain = params.model.cardiac_gain_ml_s_per_mmHg;

if isfield(simulation_config, "initial_state_mmHg")
    initial_state_mmHg = simulation_config.initial_state_mmHg(:);
else
    initial_state_mmHg = [ ...
        nominal.systemic_arterial; ...
        nominal.systemic_venous; ...
        nominal.right_atrial];
end

if isfield(simulation_config, "volume_input_ml_s")
    volume_input_ml_s = simulation_config.volume_input_ml_s(:).';
else
    volume_input_ml_s = zeros(1, num_steps);
end

state_history_mmHg = zeros(3, num_steps);
state_history_mmHg(:, 1) = initial_state_mmHg;

systemic_arterial_resistance = zeros(1, num_steps);
cardiac_gain = zeros(1, num_steps);
systemic_arterial_resistance(1) = nominal_resistance;
cardiac_gain(1) = nominal_gain;

for idx = 1:num_steps-1
    [A, b, B] = circulation_state_space( ...
        params, systemic_arterial_resistance(idx), cardiac_gain(idx));
    state_derivative = A * state_history_mmHg(:, idx) + b + B * volume_input_ml_s(idx);

    resistance_update = ...
        -(systemic_arterial_resistance(idx) - nominal_resistance) ...
        - params.control.resistance_feedback_gain ...
            * (state_history_mmHg(1, idx) - nominal.systemic_arterial);
    gain_update = ...
        -(cardiac_gain(idx) - nominal_gain) ...
        - params.control.cardiac_gain_feedback_gain ...
            * (state_history_mmHg(1, idx) - nominal.systemic_arterial);

    state_history_mmHg(:, idx + 1) = state_history_mmHg(:, idx) + dt_s * state_derivative;
    systemic_arterial_resistance(idx + 1) = systemic_arterial_resistance(idx) ...
        + dt_s / params.control.tau_resistance_s * resistance_update;
    cardiac_gain(idx + 1) = cardiac_gain(idx) ...
        + dt_s / params.control.tau_cardiac_gain_s * gain_update;
end

results = build_circulation_results( ...
    params, ...
    time_s, ...
    state_history_mmHg, ...
    volume_input_ml_s, ...
    systemic_arterial_resistance, ...
    cardiac_gain);
end
