function figure_specs = plot_gas_exchange_outputs(results, params, plot_config)
%PLOT_GAS_EXCHANGE_OUTPUTS Standardized gas-exchange figures.

figure_specs = struct("handle", {}, "filename", {});
spec_idx = 1;

figure_specs(spec_idx) = make_co2_figure(results, params, plot_config);
spec_idx = spec_idx + 1;

if isfield(results, "Pao2_mmHg")
    figure_specs(spec_idx) = make_o2_figure(results, params, plot_config);
    spec_idx = spec_idx + 1;

    figure_specs(spec_idx) = make_alveolar_o2_fraction_figure(results, params, plot_config);
    spec_idx = spec_idx + 1;
end

figure_specs(spec_idx) = make_ventilation_figure(results, params, plot_config);
end

function figure_spec = make_co2_figure(results, params, plot_config)
handle = figure("Name", plot_config.base_name + "_co2_pressures", "Color", "w");
plot(results.time_s, results.Paco2_mmHg, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.alveolar)
hold on
plot(results.time_s, results.Pvco2_mmHg, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.venous)
grid on
box on
title("CO2 Pressures", "FontSize", params.plot.font_size)
xlabel("Time (s)", "FontSize", params.plot.font_size)
ylabel("mmHg", "FontSize", params.plot.font_size)
legend("Alveolar CO2", "Venous CO2", "Location", "best")
set(gca, "FontSize", params.plot.font_size)

figure_spec.handle = handle;
figure_spec.filename = plot_config.base_name + "_co2_pressures.jpg";
end

function figure_spec = make_o2_figure(results, params, plot_config)
handle = figure("Name", plot_config.base_name + "_o2_pressures", "Color", "w");
plot(results.time_s, results.Pao2_mmHg, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.alveolar)
hold on
plot(results.time_s, results.Pvo2_mmHg, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.venous)
grid on
box on
title("O2 Pressures", "FontSize", params.plot.font_size)
xlabel("Time (s)", "FontSize", params.plot.font_size)
ylabel("mmHg", "FontSize", params.plot.font_size)
legend("Alveolar O2", "Venous O2", "Location", "best")
set(gca, "FontSize", params.plot.font_size)

figure_spec.handle = handle;
figure_spec.filename = plot_config.base_name + "_o2_pressures.jpg";
end

function figure_spec = make_alveolar_o2_fraction_figure(results, params, plot_config)
handle = figure("Name", plot_config.base_name + "_alveolar_o2_fraction", "Color", "w");
plot(results.time_s, results.alveolar_o2_fraction, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.alveolar)
grid on
box on
title("Alveolar O2 Fraction", "FontSize", params.plot.font_size)
xlabel("Time (s)", "FontSize", params.plot.font_size)
ylabel("Fraction", "FontSize", params.plot.font_size)
set(gca, "FontSize", params.plot.font_size)

figure_spec.handle = handle;
figure_spec.filename = plot_config.base_name + "_alveolar_o2_fraction.jpg";
end

function figure_spec = make_ventilation_figure(results, params, plot_config)
handle = figure("Name", plot_config.base_name + "_ventilation_components", "Color", "w");
plot(results.time_s, results.ventilation_command_L_s * 60, ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.total_ventilation)
hold on
plot(results.time_s, results.DVp_L_s * 60, "--", ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.peripheral)
plot(results.time_s, results.DVc_L_s * 60, "--", ...
    "LineWidth", params.plot.line_width, ...
    "Color", params.plot.colors.central)
grid on
box on
title("Ventilation Components", "FontSize", params.plot.font_size)
xlabel("Time (s)", "FontSize", params.plot.font_size)
ylabel("L/min", "FontSize", params.plot.font_size)
legend("Total ventilation", "Peripheral contribution", "Central contribution", ...
    "Location", "best")
set(gca, "FontSize", params.plot.font_size)

figure_spec.handle = handle;
figure_spec.filename = plot_config.base_name + "_ventilation_components.jpg";
end
