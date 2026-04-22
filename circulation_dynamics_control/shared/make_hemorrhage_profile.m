function volume_input_ml_s = make_hemorrhage_profile(time_s, hemorrhage_config)
%MAKE_HEMORRHAGE_PROFILE Create a piecewise-constant hemorrhage input profile.

volume_input_ml_s = zeros(size(time_s));

loss_rate_ml_s = hemorrhage_config.volume_loss_ml / hemorrhage_config.duration_s;
start_time_s = hemorrhage_config.start_time_s;
end_time_s = hemorrhage_config.start_time_s + hemorrhage_config.duration_s;

is_active = time_s >= start_time_s & time_s < end_time_s;
volume_input_ml_s(is_active) = -loss_rate_ml_s;
end
