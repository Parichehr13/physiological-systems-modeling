function results = simulate_co2_o2_regulation(params, scenario_config)
%SIMULATE_CO2_O2_REGULATION Coupled CO2/O2 transport with ventilatory control.

time_s = 0:scenario_config.dt_s:scenario_config.duration_s;
num_points = numel(time_s);

system = resolved_system_parameters(params);
delay_steps_peripheral = round(system.peripheral_delay_s / scenario_config.dt_s);
delay_steps_central = round(system.central_delay_s / scenario_config.dt_s);
start_idx = max(delay_steps_peripheral, delay_steps_central) + 1;

Paco2_mmHg = zeros(1, num_points);
Pvco2_mmHg = zeros(1, num_points);
Pao2_mmHg = zeros(1, num_points);
Pvo2_mmHg = zeros(1, num_points);
DVp_L_s = zeros(1, num_points);
DVc_L_s = zeros(1, num_points);
ventilation_command_L_s = zeros(1, num_points);
alveolar_o2_fraction = zeros(1, num_points);

Paco2_mmHg(1:start_idx) = scenario_config.initial_state.Paco2_mmHg;
Pvco2_mmHg(1:start_idx) = scenario_config.initial_state.Pvco2_mmHg;
Pao2_mmHg(1:start_idx) = scenario_config.initial_state.Pao2_mmHg;
Pvo2_mmHg(1:start_idx) = scenario_config.initial_state.Pvo2_mmHg;
ventilation_command_L_s(1:start_idx) = params.model.baseline_ventilation_L_s;

for idx = start_idx:num_points-1
    ventilation_command_L_s(idx) = params.model.baseline_ventilation_L_s + DVp_L_s(idx) + DVc_L_s(idx);

    alveolar_o2_fraction_now = oxygen_fraction(Pao2_mmHg(idx), params);
    venous_o2_fraction_now = oxygen_fraction(Pvo2_mmHg(idx), params);
    alveolar_o2_fraction_delayed = oxygen_fraction(Pao2_mmHg(idx - delay_steps_peripheral), params);

    dPaco2 = ((ventilation_command_L_s(idx) - params.model.dead_space_ventilation_L_s) ...
        * (scenario_config.inspired_co2_mmHg - Paco2_mmHg(idx)) ...
        + 863 * system.blood_flow_L_s * params.model.co2_transport_gain ...
            * (Pvco2_mmHg(idx) - Paco2_mmHg(idx))) ...
        / params.model.lung_volume_L;
    dPvco2 = (system.blood_flow_L_s * params.model.co2_transport_gain ...
        * (Paco2_mmHg(idx) - Pvco2_mmHg(idx)) + system.co2_metabolism_rate) ...
        / params.model.tissue_volume_L / params.model.co2_solubility;

    dPao2 = ((ventilation_command_L_s(idx) - params.model.dead_space_ventilation_L_s) ...
        * (scenario_config.inspired_o2_mmHg - Pao2_mmHg(idx)) ...
        + 863 * system.blood_flow_L_s * (venous_o2_fraction_now - alveolar_o2_fraction_now)) ...
        / params.model.lung_volume_L;
    dPvo2 = (system.blood_flow_L_s ...
        * (alveolar_o2_fraction_now - venous_o2_fraction_now) + system.o2_metabolism_rate) ...
        / params.model.tissue_volume_L / params.model.o2_solubility;

    dDVp = (-DVp_L_s(idx) + scenario_config.peripheral_co2_gain ...
        * (Paco2_mmHg(idx - delay_steps_peripheral) - params.control.peripheral_co2_threshold_mmHg)) ...
        / params.control.peripheral_time_constant_s ...
        - scenario_config.peripheral_o2_gain ...
        * (alveolar_o2_fraction_delayed - 0.2) / params.control.peripheral_time_constant_s;
    dDVc = (-DVc_L_s(idx) + scenario_config.central_co2_gain ...
        * (Paco2_mmHg(idx - delay_steps_central) - params.control.central_co2_threshold_mmHg)) ...
        / params.control.central_time_constant_s;

    Paco2_mmHg(idx + 1) = Paco2_mmHg(idx) + scenario_config.dt_s * dPaco2;
    Pvco2_mmHg(idx + 1) = Pvco2_mmHg(idx) + scenario_config.dt_s * dPvco2;
    Pao2_mmHg(idx + 1) = Pao2_mmHg(idx) + scenario_config.dt_s * dPao2;
    Pvo2_mmHg(idx + 1) = Pvo2_mmHg(idx) + scenario_config.dt_s * dPvo2;
    DVp_L_s(idx + 1) = DVp_L_s(idx) + scenario_config.dt_s * dDVp;
    DVc_L_s(idx + 1) = DVc_L_s(idx) + scenario_config.dt_s * dDVc;
    ventilation_command_L_s(idx + 1) = params.model.baseline_ventilation_L_s ...
        + DVp_L_s(idx + 1) + DVc_L_s(idx + 1);
end

alveolar_o2_fraction = oxygen_fraction(Pao2_mmHg, params);

results.time_s = time_s;
results.Paco2_mmHg = Paco2_mmHg;
results.Pvco2_mmHg = Pvco2_mmHg;
results.Pao2_mmHg = Pao2_mmHg;
results.Pvo2_mmHg = Pvo2_mmHg;
results.alveolar_o2_fraction = alveolar_o2_fraction;
results.DVp_L_s = DVp_L_s;
results.DVc_L_s = DVc_L_s;
results.ventilation_command_L_s = ventilation_command_L_s;
end

function fraction = oxygen_fraction(pressure_mmHg, params)
fraction = 0.2 ./ (1 + exp(-params.model.o2_sigmoid_gain ...
    * (pressure_mmHg - params.model.o2_half_pressure_mmHg)));
end

function system = resolved_system_parameters(params)
system.failure_scale = params.system.failure_scale;
system.blood_flow_L_s = params.system.blood_flow_L_s * system.failure_scale;
system.peripheral_delay_s = params.system.peripheral_delay_s / system.failure_scale;
system.central_delay_s = params.system.central_delay_s / system.failure_scale;
system.co2_metabolism_rate = params.system.co2_metabolism_rate * params.system.metabolism_scale;
system.o2_metabolism_rate = params.system.o2_metabolism_rate * params.system.metabolism_scale;
end
