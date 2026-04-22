function verify_respiratory_project()
%VERIFY_RESPIRATORY_PROJECT Lightweight execution and sanity checks.

close all

project_root = fileparts(mfilename("fullpath"));
addpath(fullfile(project_root, "shared"));
addpath(fullfile(project_root, "spontaneous_breathing"));
addpath(fullfile(project_root, "assisted_ventilation"));
addpath(fullfile(project_root, "gas_exchange_control"));

spontaneous_results = run_spontaneous_breathing();
assert_valid_mechanics_results(spontaneous_results, "spontaneous_results");
assert_output_files(fullfile(project_root, "spontaneous_breathing", "figures"), [ ...
    "spontaneous_pressures_and_flow.jpg", ...
    "spontaneous_volumes.jpg"]);
close all

natural_results = run_natural_breathing();
assert_valid_mechanics_results(natural_results, "natural_results");
assert_output_files(fullfile(project_root, "assisted_ventilation", "figures"), [ ...
    "natural_pressures_and_flow.jpg", ...
    "natural_volumes.jpg"]);
close all

controlled_results = run_controlled_breathing();
assert_valid_mechanics_results(controlled_results, "controlled_results");
assert(isfield(controlled_results, "reference_flow_L_s"), ...
    "controlled_results is missing reference_flow_L_s.");
assert_output_files(fullfile(project_root, "assisted_ventilation", "figures"), [ ...
    "controlled_pressures_and_flow.jpg", ...
    "controlled_volumes.jpg", ...
    "controlled_mouth_vs_muscle_pressure.jpg", ...
    "controlled_flow_tracking.jpg"]);
close all

open_loop_gas_results = run_gas_exchange_open_loop();
assert_valid_gas_results(open_loop_gas_results, "open_loop_gas_results", false);
assert_output_files(fullfile(project_root, "gas_exchange_control", "figures"), [ ...
    "open_loop_co2_pressures.jpg", ...
    "open_loop_ventilation_components.jpg"]);
close all

controlled_gas_results = run_gas_exchange_controlled();
assert_valid_gas_results(controlled_gas_results, "controlled_gas_results", true);
assert_output_files(fullfile(project_root, "gas_exchange_control", "figures"), [ ...
    "controlled_co2_pressures.jpg", ...
    "controlled_o2_pressures.jpg", ...
    "controlled_alveolar_o2_fraction.jpg", ...
    "controlled_ventilation_components.jpg"]);
close all

disp("VERIFY_OK_RESPIRATORY_PROJECT")
end

function assert_output_files(output_dir, expected_files)
for idx = 1:numel(expected_files)
    file_path = fullfile(output_dir, expected_files(idx));
    assert(exist(file_path, "file") == 2, "Expected output file was not created: %s", file_path);
    file_info = dir(file_path);
    assert(~isempty(file_info) && file_info.bytes > 0, "Output file is empty: %s", file_path);
end
end

function assert_valid_mechanics_results(results, label)
required_fields = { ...
    "time_s", ...
    "muscle_pressure_cmH2O", ...
    "pleural_pressure_cmH2O", ...
    "alveolar_pressure_cmH2O", ...
    "total_flow_L_s", ...
    "alveolar_flow_L_s", ...
    "alveolar_volume_L", ...
    "dead_space_volume_L", ...
    "total_volume_L"};

assert_common_time_series(results, label, required_fields)
assert(all(isfinite(results.alveolar_ventilation_L_min)), ...
    "%s.alveolar_ventilation_L_min contains invalid values.", label);
assert(all(isfinite(results.minute_ventilation_L_min)), ...
    "%s.minute_ventilation_L_min contains invalid values.", label);
end

function assert_valid_gas_results(results, label, include_o2)
required_fields = { ...
    "time_s", ...
    "Paco2_mmHg", ...
    "Pvco2_mmHg", ...
    "DVp_L_s", ...
    "DVc_L_s", ...
    "ventilation_command_L_s"};

if include_o2
    required_fields = [required_fields, {"Pao2_mmHg", "Pvo2_mmHg", "alveolar_o2_fraction"}];
end

assert_common_time_series(results, label, required_fields)
end

function assert_common_time_series(results, label, required_fields)
assert(isfield(results, "time_s"), "%s is missing time_s.", label);
num_points = numel(results.time_s);
assert(num_points > 1, "%s.time_s must contain more than one point.", label);
assert(all(diff(results.time_s) > 0), "%s.time_s must be strictly increasing.", label);

for idx = 1:numel(required_fields)
    field_name = required_fields{idx};
    assert(isfield(results, field_name), "%s is missing field %s.", label, field_name);
    values = results.(field_name);
    assert(~isempty(values), "%s.%s is empty.", label, field_name);
    assert(all(isfinite(values)), "%s.%s contains NaN or Inf.", label, field_name);
    assert(numel(values) == num_points, "%s.%s length does not match time_s.", label, field_name);
end
end
