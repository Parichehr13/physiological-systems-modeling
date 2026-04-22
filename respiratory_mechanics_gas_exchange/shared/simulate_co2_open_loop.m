function results = simulate_co2_open_loop(params, scenario_config)
%SIMULATE_CO2_OPEN_LOOP Open-loop CO2 transport with fixed ventilation.

time_s = 0:scenario_config.dt_s:scenario_config.duration_s;
num_points = numel(time_s);

system = resolved_system_parameters(params);

Paco2_mmHg = zeros(1, num_points);
Pvco2_mmHg = zeros(1, num_points);
DVp_L_s = zeros(1, num_points);
DVc_L_s = zeros(1, num_points);
ventilation_command_L_s = zeros(1, num_points);

Paco2_mmHg(1) = scenario_config.initial_state.Paco2_mmHg;
Pvco2_mmHg(1) = scenario_config.initial_state.Pvco2_mmHg;
ventilation_command_L_s(1) = params.model.baseline_ventilation_L_s;

for idx = 1:num_points-1
    ventilation_command_L_s(idx) = params.model.baseline_ventilation_L_s + DVp_L_s(idx) + DVc_L_s(idx);

    dPaco2 = ((ventilation_command_L_s(idx) - params.model.dead_space_ventilation_L_s) ...
        * (scenario_config.inspired_co2_mmHg - Paco2_mmHg(idx)) ...
        + 863 * system.blood_flow_L_s * params.model.co2_transport_gain ...
            * (Pvco2_mmHg(idx) - Paco2_mmHg(idx))) ...
        / params.model.lung_volume_L;
    dPvco2 = (system.blood_flow_L_s * params.model.co2_transport_gain ...
        * (Paco2_mmHg(idx) - Pvco2_mmHg(idx)) + system.co2_metabolism_rate) ...
        / params.model.tissue_volume_L / params.model.co2_solubility;

    Paco2_mmHg(idx + 1) = Paco2_mmHg(idx) + scenario_config.dt_s * dPaco2;
    Pvco2_mmHg(idx + 1) = Pvco2_mmHg(idx) + scenario_config.dt_s * dPvco2;
    DVp_L_s(idx + 1) = DVp_L_s(idx);
    DVc_L_s(idx + 1) = DVc_L_s(idx);
end

ventilation_command_L_s(end) = params.model.baseline_ventilation_L_s + DVp_L_s(end) + DVc_L_s(end);

results.time_s = time_s;
results.Paco2_mmHg = Paco2_mmHg;
results.Pvco2_mmHg = Pvco2_mmHg;
results.DVp_L_s = DVp_L_s;
results.DVc_L_s = DVc_L_s;
results.ventilation_command_L_s = ventilation_command_L_s;
end

function system = resolved_system_parameters(params)
system.failure_scale = params.system.failure_scale;
system.blood_flow_L_s = params.system.blood_flow_L_s * system.failure_scale;
system.co2_metabolism_rate = params.system.co2_metabolism_rate * params.system.metabolism_scale;
end
