function export_project_figures(figure_specs, output_dir)
%EXPORT_PROJECT_FIGURES Save a standardized set of figure outputs to disk.

if ~exist(output_dir, "dir")
    mkdir(output_dir);
end

for idx = 1:numel(figure_specs)
    exportgraphics(figure_specs(idx).handle, ...
        fullfile(output_dir, figure_specs(idx).filename), ...
        "Resolution", 150);
end
end
