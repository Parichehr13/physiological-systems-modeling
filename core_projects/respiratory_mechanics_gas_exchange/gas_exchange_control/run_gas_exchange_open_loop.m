function results = run_gas_exchange_open_loop()
%RUN_GAS_EXCHANGE_OPEN_LOOP Open-loop CO2 transport scenario.

close all

project_root = fileparts(fileparts(mfilename("fullpath")));
addpath(fullfile(project_root, "shared"));

params = gas_exchange_params();
results = simulate_co2_open_loop(params, params.open_loop);
figure_specs = plot_gas_exchange_outputs(results, params, struct( ...
    "base_name", "open_loop"));
export_project_figures(figure_specs, fullfile(fileparts(mfilename("fullpath")), "figures"));
end
