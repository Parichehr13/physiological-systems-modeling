function results = run_spontaneous_breathing()
%RUN_SPONTANEOUS_BREATHING Baseline spontaneous breathing mechanics scenario.

close all

project_root = fileparts(fileparts(mfilename("fullpath")));
addpath(fullfile(project_root, "shared"));

params = respiratory_mechanics_params();
time_s = 0:0.0002:params.simulation.default_duration_s;

drive_config = struct( ...
    "type", "sinusoidal_offset", ...
    "amplitude_cmH2O", 3, ...
    "period_s", params.simulation.default_period_s);

simulation_config.time_s = time_s;
simulation_config.period_s = params.simulation.default_period_s;
simulation_config.startup_ignore_s = params.simulation.default_startup_ignore_s;
simulation_config.muscle_pressure_cmH2O = make_muscle_pressure_drive(time_s, drive_config);
simulation_config.mouth_pressure_mode = "prescribed";
simulation_config.mouth_pressure_cmH2O = zeros(size(time_s));

results = simulate_respiratory_mechanics(params, simulation_config);
figure_specs = plot_mechanics_outputs(results, params, struct( ...
    "base_name", "spontaneous", ...
    "include_mouth_vs_muscle", false, ...
    "include_flow_tracking", false));
export_project_figures(figure_specs, fullfile(fileparts(mfilename("fullpath")), "figures"));
end
