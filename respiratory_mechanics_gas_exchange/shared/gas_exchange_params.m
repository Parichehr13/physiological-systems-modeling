function params = gas_exchange_params()
%GAS_EXCHANGE_PARAMS Shared parameters for gas-exchange scenarios.

params.model.lung_volume_L = 2.5;
params.model.dead_space_ventilation_L_s = 0.03;
params.model.co2_transport_gain = 0.012;
params.model.o2_sigmoid_gain = 0.1;
params.model.o2_half_pressure_mmHg = 30;
params.model.tissue_volume_L = 40;
params.model.co2_solubility = 0.001;
params.model.o2_solubility = 0.0031 * 10 / 1000;
params.model.baseline_ventilation_L_s = 0.12;

params.control.peripheral_time_constant_s = 20;
params.control.central_time_constant_s = 120;
params.control.peripheral_co2_threshold_mmHg = 40;
params.control.central_co2_threshold_mmHg = 40;

params.system.failure_scale = 1;
params.system.blood_flow_L_s = 0.083;
params.system.peripheral_delay_s = 6.1;
params.system.central_delay_s = 7.1;
params.system.metabolism_scale = 1;
params.system.co2_metabolism_rate = 0.25 / 60;
params.system.o2_metabolism_rate = -16 / 3600;

params.open_loop.duration_s = 2000;
params.open_loop.dt_s = 0.1;
params.open_loop.initial_state = struct( ...
    "Paco2_mmHg", 0, ...
    "Pvco2_mmHg", 0, ...
    "DVp_L_s", 0, ...
    "DVc_L_s", 0);
params.open_loop.inspired_co2_mmHg = 0;
params.open_loop.peripheral_gain = 0;
params.open_loop.central_gain = 0;

params.controlled.duration_s = 1000;
params.controlled.dt_s = 0.1;
params.controlled.initial_state = struct( ...
    "Paco2_mmHg", 40, ...
    "Pvco2_mmHg", 44.1817, ...
    "Pao2_mmHg", 107.34, ...
    "Pvo2_mmHg", 40, ...
    "DVp_L_s", 0, ...
    "DVc_L_s", 0);
params.controlled.inspired_co2_mmHg = 30;
params.controlled.inspired_o2_mmHg = 100;
params.controlled.peripheral_co2_gain = 0.02;
params.controlled.peripheral_o2_gain = 1;
params.controlled.central_co2_gain = 0.04;

params.plot.font_size = 16;
params.plot.line_width = 1.5;
params.plot.colors = struct( ...
    "alveolar", [0.00, 0.45, 0.74], ...
    "venous", [0.85, 0.33, 0.10], ...
    "total_ventilation", [0.47, 0.67, 0.19], ...
    "peripheral", [0.49, 0.18, 0.56], ...
    "central", [0.30, 0.30, 0.30]);
end
