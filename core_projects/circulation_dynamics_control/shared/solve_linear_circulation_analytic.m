function solutions = solve_linear_circulation_analytic(params, simulation_config)
%SOLVE_LINEAR_CIRCULATION_ANALYTIC Exact solutions for the affine linear model.
%
% This validation helper uses the same flow law as the hemorrhage and
% feedback scenarios, q = Kr * (Pra - offset). The offset makes the model
% affine rather than homogeneous, so the analytic solutions are computed
% around the equilibrium state x_eq satisfying A*x_eq + b = 0.

time_s = simulation_config.time_s(:).';
num_steps = numel(time_s);

if isfield(simulation_config, "initial_state_mmHg")
    initial_state_mmHg = simulation_config.initial_state_mmHg(:);
else
    nominal = params.model.nominal_pressures_mmHg;
    initial_state_mmHg = [ ...
        nominal.systemic_arterial; ...
        nominal.systemic_venous; ...
        nominal.right_atrial];
end

if isfield(simulation_config, "volume_input_ml_s")
    volume_input_ml_s = simulation_config.volume_input_ml_s(:).';
else
    volume_input_ml_s = zeros(1, num_steps);
end

if any(abs(volume_input_ml_s) > 0)
    error("Analytic solver currently supports only zero external input.");
end

if isfield(simulation_config, "systemic_arterial_resistance_mmHg_s_per_ml")
    systemic_arterial_resistance = ...
        simulation_config.systemic_arterial_resistance_mmHg_s_per_ml(:).';
else
    systemic_arterial_resistance = repmat( ...
        params.model.resistance_mmHg_s_per_ml.systemic_arterial, 1, num_steps);
end

if isfield(simulation_config, "cardiac_gain_ml_s_per_mmHg")
    cardiac_gain = simulation_config.cardiac_gain_ml_s_per_mmHg(:).';
else
    cardiac_gain = repmat(params.model.cardiac_gain_ml_s_per_mmHg, 1, num_steps);
end

if any(abs(systemic_arterial_resistance - systemic_arterial_resistance(1)) > 0) ...
        || any(abs(cardiac_gain - cardiac_gain(1)) > 0)
    error("Analytic solver requires constant Rsa and Kr.");
end

[A, ~] = circulation_state_space( ...
    params, systemic_arterial_resistance(1), cardiac_gain(1));
compliance = params.model.compliance_ml_per_mmHg;
initial_filling_volume_ml = ...
    compliance.systemic_arterial * initial_state_mmHg(1) ...
    + compliance.systemic_venous * initial_state_mmHg(2) ...
    + compliance.right_atrial * initial_state_mmHg(3);
equilibrium_state_mmHg = circulation_equilibrium_state( ...
    params, ...
    initial_filling_volume_ml, ...
    systemic_arterial_resistance(1), ...
    cardiac_gain(1));

shifted_initial_state = initial_state_mmHg - equilibrium_state_mmHg;
[eigenvectors, eigenvalues_matrix] = eig(A);
eigenvalues = diag(eigenvalues_matrix);
modal_coefficients = eigenvectors \ shifted_initial_state;

modal_exponentials = exp(eigenvalues * time_s);
shifted_state_eigen = real(eigenvectors * (modal_coefficients .* modal_exponentials));
state_history_eigen = real(equilibrium_state_mmHg + shifted_state_eigen);

state_history_expm = zeros(3, num_steps);
for idx = 1:num_steps
    state_history_expm(:, idx) = real( ...
        equilibrium_state_mmHg + expm(A * time_s(idx)) * shifted_initial_state);
end

solutions.equilibrium_state_mmHg = equilibrium_state_mmHg;
solutions.eigen = build_circulation_results( ...
    params, ...
    time_s, ...
    state_history_eigen, ...
    volume_input_ml_s, ...
    systemic_arterial_resistance, ...
    cardiac_gain);
solutions.matrix_exponential = build_circulation_results( ...
    params, ...
    time_s, ...
    state_history_expm, ...
    volume_input_ml_s, ...
    systemic_arterial_resistance, ...
    cardiac_gain);
end
