close all

project_root = fileparts(fileparts(mfilename("fullpath")));
addpath(fullfile(project_root, "shared"));

params = circulation_params();
nominal = params.model.nominal_pressures_mmHg;

time_s = 0:params.simulation.default_dt_s:params.control.duration_s;
volume_input_ml_s = make_hemorrhage_profile(time_s, params.hemorrhage);
initial_state_mmHg = [ ...
    nominal.systemic_arterial; ...
    nominal.systemic_venous; ...
    nominal.right_atrial];

simulation_config.time_s = time_s;
simulation_config.initial_state_mmHg = initial_state_mmHg;
simulation_config.volume_input_ml_s = volume_input_ml_s;

open_loop_results = simulate_open_loop_circulation(params, simulation_config);
controlled_results = simulate_feedback_control_circulation(params, simulation_config);

open_loop_results.legend_label = "Open loop";
open_loop_results.plot_color = params.plot.colors.open_loop;
open_loop_results.plot_style = "-";

controlled_results.legend_label = "Feedback control";
controlled_results.plot_color = params.plot.colors.controlled;
controlled_results.plot_style = "-";

figure_handles = plot_circulation_time_series([controlled_results, open_loop_results], params);
adaptation_figure_handle = plot_control_adaptation(controlled_results, params);

export_circulation_figures( ...
    figure_handles, ...
    fullfile(fileparts(mfilename("fullpath")), "figures"), ...
    params.output.common_figure_filenames);
export_circulation_figures( ...
    adaptation_figure_handle, ...
    fullfile(fileparts(mfilename("fullpath")), "figures"), ...
    params.output.feedback_adaptation_filename);
