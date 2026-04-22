close all

project_root = fileparts(fileparts(mfilename("fullpath")));
addpath(fullfile(project_root, "shared"));

params = circulation_params();
nominal = params.model.nominal_pressures_mmHg;

time_s = 0:params.simulation.default_dt_s:params.validation.duration_s;
initial_state_mmHg = [ ...
    params.validation.initial_arterial_pressure_scale * nominal.systemic_arterial; ...
    nominal.systemic_venous; ...
    nominal.right_atrial];

simulation_config.time_s = time_s;
simulation_config.initial_state_mmHg = initial_state_mmHg;
simulation_config.volume_input_ml_s = zeros(size(time_s));

% Validate the same offset-flow circulation model used elsewhere in the
% project. The analytic solutions therefore solve an affine linear system
% around its steady-state shift rather than a homogeneous system.
euler_results = simulate_open_loop_circulation(params, simulation_config);
analytic_solutions = solve_linear_circulation_analytic(params, simulation_config);

euler_results.legend_label = "Euler";
euler_results.plot_color = params.plot.colors.open_loop;
euler_results.plot_style = "-";

analytic_solutions.eigen.legend_label = "Eigen-decomposition";
analytic_solutions.eigen.plot_color = params.plot.colors.eigen;
analytic_solutions.eigen.plot_style = "--";

analytic_solutions.matrix_exponential.legend_label = "Matrix exponential";
analytic_solutions.matrix_exponential.plot_color = params.plot.colors.matrix_exponential;
analytic_solutions.matrix_exponential.plot_style = ":";

validation_results = [ ...
    euler_results, ...
    analytic_solutions.eigen, ...
    analytic_solutions.matrix_exponential];

figure_handles = plot_circulation_time_series(validation_results, params);
export_circulation_figures( ...
    figure_handles, ...
    fullfile(fileparts(mfilename("fullpath")), "figures"), ...
    params.output.common_figure_filenames);
