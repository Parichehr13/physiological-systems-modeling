function muscle_pressure_cmH2O = make_muscle_pressure_drive(time_s, drive_config)
%MAKE_MUSCLE_PRESSURE_DRIVE Generate respiratory muscle pressure waveforms.

switch string(drive_config.type)
    case "sinusoidal_offset"
        amplitude = drive_config.amplitude_cmH2O;
        phase_shift = resolve_field(drive_config, "phase_shift_rad", 0);
        scale_factor = resolve_field(drive_config, "scale_factor", 1);
        muscle_pressure_cmH2O = scale_factor * ( ...
            amplitude * cos(2 * pi / drive_config.period_s * time_s + phase_shift) ...
            - amplitude);

    case "physiologic_piecewise"
        amplitude = drive_config.amplitude_cmH2O;
        period_s = drive_config.period_s;
        inspiratory_time_s = drive_config.inspiratory_time_s;
        expiratory_time_s = drive_config.expiratory_time_s;
        tau_s = resolve_field(drive_config, "expiratory_tau_s", expiratory_time_s / 5);

        phase_time_s = time_s - period_s * floor(time_s / period_s);
        inspiratory_component = (phase_time_s < inspiratory_time_s) .* ( ...
            -amplitude / inspiratory_time_s / expiratory_time_s .* phase_time_s .^ 2 ...
            + amplitude * period_s / inspiratory_time_s / expiratory_time_s .* phase_time_s);
        expiratory_component = (phase_time_s >= inspiratory_time_s) .* ( ...
            amplitude / (1 - exp(-expiratory_time_s / tau_s)) ...
            .* (exp(-(phase_time_s - inspiratory_time_s) / tau_s) ...
            - exp(-expiratory_time_s / tau_s)));
        muscle_pressure_cmH2O = inspiratory_component + expiratory_component;

    otherwise
        error("Unsupported muscle pressure drive type: %s", drive_config.type);
end
end

function value = resolve_field(config, field_name, default_value)
if isfield(config, field_name)
    value = config.(field_name);
else
    value = default_value;
end
end
