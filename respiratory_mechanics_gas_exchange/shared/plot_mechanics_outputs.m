function figure_specs = plot_mechanics_outputs(results, params, plot_config)
%PLOT_MECHANICS_OUTPUTS Standardized mechanics figures for respiratory scenarios.

figure_specs = struct("handle", {}, "filename", {});
spec_idx = 1;

figure_specs(spec_idx) = make_pressures_and_flow_figure(results, params, plot_config);
spec_idx = spec_idx + 1;

figure_specs(spec_idx) = make_volume_figure(results, params, plot_config);
spec_idx = spec_idx + 1;

if isfield(plot_config, "include_mouth_vs_muscle") && plot_config.include_mouth_vs_muscle
    figure_specs(spec_idx) = make_mouth_vs_muscle_figure(results, params, plot_config);
    spec_idx = spec_idx + 1;
end

if isfield(plot_config, "include_flow_tracking") && plot_config.include_flow_tracking
    figure_specs(spec_idx) = make_flow_tracking_figure(results, params, plot_config);
end
end

function figure_spec = make_pressures_and_flow_figure(results, params, plot_config)
handle = figure("Name", plot_config.base_name + "_pressures_and_flow", "Color", "w");
tiledlayout(2, 2)

nexttile
plot(results.time_s, results.muscle_pressure_cmH2O, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.muscle_pressure)
hold on
if any(abs(results.mouth_pressure_cmH2O) > 0)
    plot(results.time_s, results.mouth_pressure_cmH2O, ...
        "LineWidth", params.plot.line_width, ...
        "Color", params.plot.colors.mouth_pressure)
    legend("Muscle pressure", "Mouth pressure", "Location", "best")
else
    legend("Muscle pressure", "Location", "best")
end
grid on
box on
title("Drive Pressures", "FontSize", params.plot.font_size)
xlabel("Time (s)", "FontSize", params.plot.font_size)
ylabel("cmH2O", "FontSize", params.plot.font_size)
set(gca, "FontSize", params.plot.font_size)

nexttile
plot(results.time_s, results.pleural_pressure_cmH2O, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.pleural_pressure)
grid on
box on
title("Pleural Pressure", "FontSize", params.plot.font_size)
xlabel("Time (s)", "FontSize", params.plot.font_size)
ylabel("cmH2O", "FontSize", params.plot.font_size)
set(gca, "FontSize", params.plot.font_size)

nexttile
plot(results.time_s, results.alveolar_pressure_cmH2O, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.alveolar_pressure)
grid on
box on
title("Alveolar Pressure", "FontSize", params.plot.font_size)
xlabel("Time (s)", "FontSize", params.plot.font_size)
ylabel("cmH2O", "FontSize", params.plot.font_size)
set(gca, "FontSize", params.plot.font_size)

nexttile
plot(results.time_s, results.alveolar_flow_L_s, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.flow)
grid on
box on
title("Alveolar Flow", "FontSize", params.plot.font_size)
xlabel("Time (s)", "FontSize", params.plot.font_size)
ylabel("L/s", "FontSize", params.plot.font_size)
set(gca, "FontSize", params.plot.font_size)

figure_spec.handle = handle;
figure_spec.filename = plot_config.base_name + "_pressures_and_flow.jpg";
end

function figure_spec = make_volume_figure(results, params, plot_config)
handle = figure("Name", plot_config.base_name + "_volumes", "Color", "w");
tiledlayout(3, 1)

nexttile
plot(results.time_s, results.total_volume_L, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.total_volume)
grid on
box on
title("Total Volume", "FontSize", params.plot.font_size)
xlabel("Time (s)", "FontSize", params.plot.font_size)
ylabel("L", "FontSize", params.plot.font_size)
set(gca, "FontSize", params.plot.font_size)

nexttile
plot(results.time_s, results.alveolar_volume_L, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.alveolar_volume)
grid on
box on
title("Alveolar Volume", "FontSize", params.plot.font_size)
xlabel("Time (s)", "FontSize", params.plot.font_size)
ylabel("L", "FontSize", params.plot.font_size)
set(gca, "FontSize", params.plot.font_size)

nexttile
plot(results.time_s, results.dead_space_volume_L, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.dead_space_volume)
grid on
box on
title("Dead-Space Volume", "FontSize", params.plot.font_size)
xlabel("Time (s)", "FontSize", params.plot.font_size)
ylabel("L", "FontSize", params.plot.font_size)
set(gca, "FontSize", params.plot.font_size)

figure_spec.handle = handle;
figure_spec.filename = plot_config.base_name + "_volumes.jpg";
end

function figure_spec = make_mouth_vs_muscle_figure(results, params, plot_config)
handle = figure("Name", plot_config.base_name + "_mouth_vs_muscle_pressure", "Color", "w");
plot(results.time_s, results.mouth_pressure_cmH2O, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.mouth_pressure)
hold on
plot(results.time_s, results.muscle_pressure_cmH2O, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.muscle_pressure)
grid on
box on
title("Mouth vs Muscle Pressure", "FontSize", params.plot.font_size)
xlabel("Time (s)", "FontSize", params.plot.font_size)
ylabel("cmH2O", "FontSize", params.plot.font_size)
legend("Mouth pressure", "Muscle pressure", "Location", "best")
set(gca, "FontSize", params.plot.font_size)

figure_spec.handle = handle;
figure_spec.filename = plot_config.base_name + "_mouth_vs_muscle_pressure.jpg";
end

function figure_spec = make_flow_tracking_figure(results, params, plot_config)
handle = figure("Name", plot_config.base_name + "_flow_tracking", "Color", "w");
plot(results.time_s, results.reference_flow_L_s, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.reference_flow)
hold on
plot(results.time_s, results.total_flow_L_s, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.flow)
grid on
box on
title("Flow Tracking", "FontSize", params.plot.font_size)
xlabel("Time (s)", "FontSize", params.plot.font_size)
ylabel("L/s", "FontSize", params.plot.font_size)
legend("Reference flow", "Mouth-to-lung flow", "Location", "best")
set(gca, "FontSize", params.plot.font_size)

figure_spec.handle = handle;
figure_spec.filename = plot_config.base_name + "_flow_tracking.jpg";
end
