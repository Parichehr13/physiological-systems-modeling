function figure_handles = plot_circulation_time_series(result_sets, params)
%PLOT_CIRCULATION_TIME_SERIES Standardized plots for circulation outputs.

if ~isstruct(result_sets)
    error("result_sets must be a struct or struct array.");
end

result_sets = result_sets(:).';

signals = { ...
    "systemic_arterial_pressure_mmHg", "Systemic Arterial Pressure", "mmHg"; ...
    "systemic_venous_pressure_mmHg", "Systemic Venous Pressure", "mmHg"; ...
    "right_atrial_pressure_mmHg", "Right Atrial Pressure", "mmHg"; ...
    "cardiac_output_ml_s", "Cardiac Output", "mL/s"; ...
    "filling_volume_ml", "Systemic Filling Volume", "mL"};

figure_handles = gobjects(size(signals, 1), 1);

for signal_idx = 1:size(signals, 1)
    figure_handles(signal_idx) = figure( ...
        "Name", signals{signal_idx, 2}, ...
        "Color", "w");
    hold on

    for result_idx = 1:numel(result_sets)
        line_color = resolve_plot_field(result_sets(result_idx), "plot_color", []);
        line_style = resolve_plot_field(result_sets(result_idx), "plot_style", "-");
        legend_label = resolve_plot_field(result_sets(result_idx), ...
            "legend_label", sprintf("Result %d", result_idx));

        plot( ...
            result_sets(result_idx).time_s, ...
            result_sets(result_idx).(signals{signal_idx, 1}), ...
            "LineWidth", params.plot.line_width, ...
            "Color", line_color, ...
            "LineStyle", line_style, ...
            "DisplayName", legend_label);
    end

    grid on
    box on
    title(signals{signal_idx, 2}, "FontSize", params.plot.font_size)
    xlabel("Time (s)", "FontSize", params.plot.font_size)
    ylabel(signals{signal_idx, 3}, "FontSize", params.plot.font_size)
    set(gca, "FontSize", params.plot.font_size)

    if numel(result_sets) > 1
        legend("Location", "best")
    end
end
end

function value = resolve_plot_field(result_set, field_name, default_value)
if isfield(result_set, field_name)
    value = result_set.(field_name);
else
    value = default_value;
end
end
