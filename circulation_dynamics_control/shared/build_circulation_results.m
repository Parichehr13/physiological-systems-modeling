function results = build_circulation_results( ...
    params, ...
    time_s, ...
    state_history_mmHg, ...
    volume_input_ml_s, ...
    systemic_arterial_resistance, ...
    cardiac_gain)
%BUILD_CIRCULATION_RESULTS Package raw states into reusable outputs.

compliance = params.model.compliance_ml_per_mmHg;
pra_offset = params.model.pra_flow_offset_mmHg;

time_s = time_s(:).';
volume_input_ml_s = volume_input_ml_s(:).';
systemic_arterial_resistance = systemic_arterial_resistance(:).';
cardiac_gain = cardiac_gain(:).';

results.time_s = time_s;
results.volume_input_ml_s = volume_input_ml_s;

results.systemic_arterial_pressure_mmHg = state_history_mmHg(1, :);
results.systemic_venous_pressure_mmHg = state_history_mmHg(2, :);
results.right_atrial_pressure_mmHg = state_history_mmHg(3, :);

results.cardiac_output_ml_s = ...
    cardiac_gain .* (results.right_atrial_pressure_mmHg - pra_offset);
results.filling_volume_ml = ...
    compliance.systemic_arterial * results.systemic_arterial_pressure_mmHg ...
    + compliance.systemic_venous * results.systemic_venous_pressure_mmHg ...
    + compliance.right_atrial * results.right_atrial_pressure_mmHg;

results.systemic_arterial_resistance_mmHg_s_per_ml = systemic_arterial_resistance;
results.cardiac_gain_ml_s_per_mmHg = cardiac_gain;
results.model_description = sprintf("q = Kr * (Pra - %.2f)", pra_offset);
end
