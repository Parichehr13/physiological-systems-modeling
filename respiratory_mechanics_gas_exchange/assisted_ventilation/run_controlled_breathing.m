function results = run_controlled_breathing()
%RUN_CONTROLLED_BREATHING Mouth-pressure assisted ventilation scenario.

close all

project_root = fileparts(fileparts(mfilename("fullpath")));
addpath(fullfile(project_root, "shared"));

params = respiratory_mechanics_params();
time_s = 0:0.0001:params.simulation.default_duration_s;

drive_config = struct( ...
    "type", "sinusoidal_offset", ...
    "amplitude_cmH2O", 2, ...
    "period_s", params.simulation.default_period_s, ...
    "phase_shift_rad", 0.75 * 2 * pi, ...
    "scale_factor", 0.5);

simulation_config.time_s = time_s;
simulation_config.period_s = params.simulation.default_period_s;
simulation_config.startup_ignore_s = params.simulation.default_startup_ignore_s;
simulation_config.muscle_pressure_cmH2O = make_muscle_pressure_drive(time_s, drive_config);
simulation_config.mouth_pressure_mode = "controlled";
simulation_config.controller_time_constant_s = 2;
simulation_config.controller_gain = 22;
simulation_config.reference_flow_L_s = 8.0 * pi / 60 * sin(2 * pi / params.simulation.default_period_s * time_s);

results = simulate_respiratory_mechanics(params, simulation_config);
figure_specs = plot_mechanics_outputs(results, params, struct( ...
    "base_name", "controlled", ...
    "include_mouth_vs_muscle", true, ...
    "include_flow_tracking", true));
export_project_figures(figure_specs, fullfile(fileparts(mfilename("fullpath")), "figures"));
end
