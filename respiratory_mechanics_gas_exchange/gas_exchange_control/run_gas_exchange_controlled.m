function results = run_gas_exchange_controlled()
%RUN_GAS_EXCHANGE_CONTROLLED Coupled CO2/O2 ventilatory-regulation scenario.

close all

project_root = fileparts(fileparts(mfilename("fullpath")));
addpath(fullfile(project_root, "shared"));

params = gas_exchange_params();
results = simulate_co2_o2_regulation(params, params.controlled);
figure_specs = plot_gas_exchange_outputs(results, params, struct( ...
    "base_name", "controlled"));
export_project_figures(figure_specs, fullfile(fileparts(mfilename("fullpath")), "figures"));
end
