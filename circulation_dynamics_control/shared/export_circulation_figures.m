function export_circulation_figures(figure_handles, output_dir, file_names)
%EXPORT_CIRCULATION_FIGURES Save standardized figure outputs to disk.

if numel(figure_handles) ~= numel(file_names)
    error("Number of figure handles must match number of output file names.");
end

if ~exist(output_dir, "dir")
    mkdir(output_dir);
end

for idx = 1:numel(figure_handles)
    exportgraphics(figure_handles(idx), fullfile(output_dir, file_names(idx)), ...
        "Resolution", 150);
end
end
