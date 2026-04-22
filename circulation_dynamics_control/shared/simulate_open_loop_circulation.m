function results = simulate_open_loop_circulation(params, simulation_config)
%SIMULATE_OPEN_LOOP_CIRCULATION Euler simulation of open-loop circulation dynamics.

time_s = simulation_config.time_s(:).';
dt_s = time_s(2) - time_s(1);
num_steps = numel(time_s);

nominal = params.model.nominal_pressures_mmHg;

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

if isfield(simulation_config, "systemic_arterial_resistance_mmHg_s_per_ml")
    systemic_arterial_resistance = ...
        simulation_config.systemic_arterial_resistance_mmHg_s_per_ml(:).';
else
    systemic_arterial_resistance = repmat( ...
        params.model.resistance_mmHg_s_per_ml.systemic_arterial, 1, num_steps);
end

if isfield(simulation_config, "cardiac_gain_ml_s_per_mmHg")
    cardiac_gain = simulation_config.cardiac_gain_ml_s_per_mmHg(:).';
else
    cardiac_gain = repmat(params.model.cardiac_gain_ml_s_per_mmHg, 1, num_steps);
end

state_history_mmHg = zeros(3, num_steps);
state_history_mmHg(:, 1) = initial_state_mmHg;

for idx = 1:num_steps-1
    [A, b, B] = circulation_state_space( ...
        params, systemic_arterial_resistance(idx), cardiac_gain(idx));
    state_derivative = A * state_history_mmHg(:, idx) + b + B * volume_input_ml_s(idx);
    state_history_mmHg(:, idx + 1) = state_history_mmHg(:, idx) + dt_s * state_derivative;
end

results = build_circulation_results( ...
    params, ...
    time_s, ...
    state_history_mmHg, ...
    volume_input_ml_s, ...
    systemic_arterial_resistance, ...
    cardiac_gain);
end
