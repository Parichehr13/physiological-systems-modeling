close all

project_root = fileparts(fileparts(mfilename("fullpath")));
addpath(fullfile(project_root, "shared"));

params = circulation_params();
nominal = params.model.nominal_pressures_mmHg;

time_s = 0:params.simulation.default_dt_s:params.baseline.duration_s;
volume_input_ml_s = make_hemorrhage_profile(time_s, params.hemorrhage);

simulation_config.time_s = time_s;
simulation_config.initial_state_mmHg = [ ...
    nominal.systemic_arterial; ...
    nominal.systemic_venous; ...
    nominal.right_atrial];
simulation_config.volume_input_ml_s = volume_input_ml_s;

baseline_results = simulate_open_loop_circulation(params, simulation_config);
baseline_results.legend_label = "Open loop";
baseline_results.plot_color = params.plot.colors.open_loop;
baseline_results.plot_style = "-";

figure_handles = plot_circulation_time_series(baseline_results, params);
export_circulation_figures( ...
    figure_handles, ...
    fullfile(fileparts(mfilename("fullpath")), "figures"), ...
    params.output.common_figure_filenames);
