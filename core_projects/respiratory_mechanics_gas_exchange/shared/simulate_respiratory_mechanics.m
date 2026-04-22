function results = simulate_respiratory_mechanics(params, simulation_config)
%SIMULATE_RESPIRATORY_MECHANICS Euler simulation of the compartmental model.

time_s = simulation_config.time_s(:).';
num_points = numel(time_s);
dt_s = time_s(2) - time_s(1);

if isfield(simulation_config, "muscle_pressure_cmH2O")
    muscle_pressure_cmH2O = simulation_config.muscle_pressure_cmH2O(:).';
else
    muscle_pressure_cmH2O = zeros(1, num_points);
end

controller_mode = resolve_field(simulation_config, "mouth_pressure_mode", "prescribed");
if controller_mode == "prescribed"
    mouth_pressure_cmH2O = simulation_config.mouth_pressure_cmH2O(:).';
else
    mouth_pressure_cmH2O = zeros(1, num_points);
end

pressure_state = zeros(5, num_points);
pressure_state(:, 1) = [ ...
    params.initial.pressure_state_cmH2O.p1; ...
    params.initial.pressure_state_cmH2O.p2; ...
    params.initial.pressure_state_cmH2O.p3; ...
    params.initial.pressure_state_cmH2O.p4; ...
    params.initial.pressure_state_cmH2O.p5];

for idx = 1:num_points-1
    derived = derive_mechanics_signals(pressure_state(:, idx), ...
        muscle_pressure_cmH2O(idx), mouth_pressure_cmH2O(idx), params);

    if controller_mode == "controlled"
        mouth_pressure_derivative = ( ...
            -mouth_pressure_cmH2O(idx) ...
            + simulation_config.controller_gain ...
                * (simulation_config.reference_flow_L_s(idx) - derived.total_flow_L_s)) ...
            / simulation_config.controller_time_constant_s;
        mouth_pressure_cmH2O(idx + 1) = mouth_pressure_cmH2O(idx) ...
            + dt_s * mouth_pressure_derivative;
    end

    pressure_state(:, idx + 1) = pressure_state(:, idx) + dt_s * [ ...
        mechanics_derivative_p1(derived, mouth_pressure_cmH2O(idx), params); ...
        mechanics_derivative_p2(derived, params); ...
        mechanics_derivative_p3(derived, params); ...
        mechanics_derivative_p4(derived, params); ...
        mechanics_derivative_p5(derived, params)];
end

results = package_mechanics_results(pressure_state, muscle_pressure_cmH2O, ...
    mouth_pressure_cmH2O, time_s, params, simulation_config);
end

function value = resolve_field(config, field_name, default_value)
if isfield(config, field_name)
    value = string(config.(field_name));
else
    value = string(default_value);
end
end

function results = package_mechanics_results( ...
    pressure_state, muscle_pressure_cmH2O, mouth_pressure_cmH2O, time_s, params, simulation_config)

num_points = numel(time_s);

pleural_pressure_cmH2O = zeros(1, num_points);
laryngeal_pressure_cmH2O = zeros(1, num_points);
thoracic_pressure_cmH2O = zeros(1, num_points);
bronchial_pressure_cmH2O = zeros(1, num_points);
alveolar_pressure_cmH2O = zeros(1, num_points);
total_flow_L_s = zeros(1, num_points);
alveolar_flow_L_s = zeros(1, num_points);
dead_space_flow_L_s = zeros(1, num_points);
laryngeal_volume_L = zeros(1, num_points);
thoracic_volume_L = zeros(1, num_points);
bronchial_volume_L = zeros(1, num_points);
alveolar_volume_L = zeros(1, num_points);
dead_space_volume_L = zeros(1, num_points);
total_volume_L = zeros(1, num_points);

for idx = 1:num_points
    derived = derive_mechanics_signals(pressure_state(:, idx), ...
        muscle_pressure_cmH2O(idx), mouth_pressure_cmH2O(idx), params);

    laryngeal_pressure_cmH2O(idx) = derived.laryngeal_pressure_cmH2O;
    pleural_pressure_cmH2O(idx) = derived.pleural_pressure_cmH2O;
    thoracic_pressure_cmH2O(idx) = derived.thoracic_pressure_cmH2O;
    bronchial_pressure_cmH2O(idx) = derived.bronchial_pressure_cmH2O;
    alveolar_pressure_cmH2O(idx) = derived.alveolar_pressure_cmH2O;
    total_flow_L_s(idx) = derived.total_flow_L_s;
    alveolar_flow_L_s(idx) = derived.alveolar_flow_L_s;
    dead_space_flow_L_s(idx) = derived.dead_space_flow_L_s;
    laryngeal_volume_L(idx) = derived.laryngeal_volume_L;
    thoracic_volume_L(idx) = derived.thoracic_volume_L;
    bronchial_volume_L(idx) = derived.bronchial_volume_L;
    alveolar_volume_L(idx) = derived.alveolar_volume_L;
    dead_space_volume_L(idx) = derived.dead_space_volume_L;
    total_volume_L(idx) = derived.total_volume_L;
end

startup_ignore_idx = find(time_s >= simulation_config.startup_ignore_s, 1, "first");
if isempty(startup_ignore_idx)
    startup_ignore_idx = 1;
end

period_s = simulation_config.period_s;
results.time_s = time_s;
results.pressure_state_cmH2O = pressure_state;
results.muscle_pressure_cmH2O = muscle_pressure_cmH2O;
results.mouth_pressure_cmH2O = mouth_pressure_cmH2O;
results.laryngeal_pressure_cmH2O = laryngeal_pressure_cmH2O;
results.pleural_pressure_cmH2O = pleural_pressure_cmH2O;
results.thoracic_pressure_cmH2O = thoracic_pressure_cmH2O;
results.bronchial_pressure_cmH2O = bronchial_pressure_cmH2O;
results.alveolar_pressure_cmH2O = alveolar_pressure_cmH2O;
results.total_flow_L_s = total_flow_L_s;
results.alveolar_flow_L_s = alveolar_flow_L_s;
results.dead_space_flow_L_s = dead_space_flow_L_s;
results.laryngeal_volume_L = laryngeal_volume_L;
results.thoracic_volume_L = thoracic_volume_L;
results.bronchial_volume_L = bronchial_volume_L;
results.alveolar_volume_L = alveolar_volume_L;
results.dead_space_volume_L = dead_space_volume_L;
results.total_volume_L = total_volume_L;
results.alveolar_ventilation_L_min = ...
    (max(alveolar_volume_L(startup_ignore_idx:end)) ...
    - min(alveolar_volume_L(startup_ignore_idx:end))) * 60 / period_s;
results.minute_ventilation_L_min = ...
    (max(total_volume_L(startup_ignore_idx:end)) ...
    - min(total_volume_L(startup_ignore_idx:end))) * 60 / period_s;

if isfield(simulation_config, "reference_flow_L_s")
    results.reference_flow_L_s = simulation_config.reference_flow_L_s(:).';
end
end

function derived = derive_mechanics_signals(pressure_state, muscle_pressure_cmH2O, mouth_pressure_cmH2O, params)
compliance = params.model.compliance_L_per_cmH2O;
unstressed = params.model.unstressed_volume_L;
resistance = params.model.resistance_cmH2O_s_per_L;

derived.laryngeal_pressure_cmH2O = pressure_state(1);
derived.pleural_pressure_cmH2O = pressure_state(5) + muscle_pressure_cmH2O;
derived.thoracic_pressure_cmH2O = pressure_state(2) + derived.pleural_pressure_cmH2O;
derived.bronchial_pressure_cmH2O = pressure_state(3) + derived.pleural_pressure_cmH2O;
derived.alveolar_pressure_cmH2O = pressure_state(4) + derived.pleural_pressure_cmH2O;

derived.total_flow_L_s = ...
    (mouth_pressure_cmH2O - derived.laryngeal_pressure_cmH2O) ...
    / resistance.mouth_to_laryngeal;
derived.alveolar_flow_L_s = ...
    (derived.bronchial_pressure_cmH2O - derived.alveolar_pressure_cmH2O) ...
    / resistance.bronchial_to_alveolar;
derived.dead_space_flow_L_s = derived.total_flow_L_s - derived.alveolar_flow_L_s;

derived.laryngeal_volume_L = ...
    compliance.laryngeal * derived.laryngeal_pressure_cmH2O + unstressed.laryngeal;
derived.thoracic_volume_L = ...
    compliance.thoracic ...
    * (derived.thoracic_pressure_cmH2O - derived.pleural_pressure_cmH2O) ...
    + unstressed.thoracic;
derived.bronchial_volume_L = ...
    compliance.bronchial ...
    * (derived.bronchial_pressure_cmH2O - derived.pleural_pressure_cmH2O) ...
    + unstressed.bronchial;
derived.alveolar_volume_L = ...
    compliance.alveolar ...
    * (derived.alveolar_pressure_cmH2O - derived.pleural_pressure_cmH2O) ...
    + unstressed.alveolar;
derived.dead_space_volume_L = ...
    derived.laryngeal_volume_L + derived.thoracic_volume_L + derived.bronchial_volume_L;
derived.total_volume_L = derived.alveolar_volume_L + derived.dead_space_volume_L;
end

function derivative = mechanics_derivative_p1(derived, mouth_pressure_cmH2O, params)
resistance = params.model.resistance_cmH2O_s_per_L;
compliance = params.model.compliance_L_per_cmH2O;

derivative = 1 / compliance.laryngeal * ( ...
    (mouth_pressure_cmH2O - derived.laryngeal_pressure_cmH2O) ...
        / resistance.mouth_to_laryngeal ...
    - (derived.laryngeal_pressure_cmH2O - derived.thoracic_pressure_cmH2O) ...
        / resistance.laryngeal_to_thoracic);
end

function derivative = mechanics_derivative_p2(derived, params)
resistance = params.model.resistance_cmH2O_s_per_L;
compliance = params.model.compliance_L_per_cmH2O;

derivative = 1 / compliance.thoracic * ( ...
    (derived.laryngeal_pressure_cmH2O - derived.thoracic_pressure_cmH2O) ...
        / resistance.laryngeal_to_thoracic ...
    - (derived.thoracic_pressure_cmH2O - derived.bronchial_pressure_cmH2O) ...
        / resistance.thoracic_to_bronchial);
end

function derivative = mechanics_derivative_p3(derived, params)
resistance = params.model.resistance_cmH2O_s_per_L;
compliance = params.model.compliance_L_per_cmH2O;

derivative = 1 / compliance.bronchial * ( ...
    (derived.thoracic_pressure_cmH2O - derived.bronchial_pressure_cmH2O) ...
        / resistance.thoracic_to_bronchial ...
    - (derived.bronchial_pressure_cmH2O - derived.alveolar_pressure_cmH2O) ...
        / resistance.bronchial_to_alveolar);
end

function derivative = mechanics_derivative_p4(derived, params)
resistance = params.model.resistance_cmH2O_s_per_L;
compliance = params.model.compliance_L_per_cmH2O;

derivative = 1 / compliance.alveolar * ( ...
    (derived.bronchial_pressure_cmH2O - derived.alveolar_pressure_cmH2O) ...
    / resistance.bronchial_to_alveolar);
end

function derivative = mechanics_derivative_p5(derived, params)
resistance = params.model.resistance_cmH2O_s_per_L;
compliance = params.model.compliance_L_per_cmH2O;

derivative = 1 / compliance.chest_wall * ( ...
    (derived.laryngeal_pressure_cmH2O - derived.thoracic_pressure_cmH2O) ...
    / resistance.laryngeal_to_thoracic);
end
