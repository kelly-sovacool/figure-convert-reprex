configfile: "config/default.yml"
figures_dict=config['figures']

rule targets:
    input:
        "paper/paper.pdf"

rule plot_diversity:
    input:
        R='workflow/scripts/plot_diversity.R'
    output:
        tiff='figures/diversity.tiff'
    conda: 'envs/Rtidy.yml'
    script:
        'scripts/plot_diversity.R'

rule plot_error_rates:
    input:
        R='workflow/scripts/plot_error_rates.R'
    output:
        tiff='figures/error_rates.tiff'
    conda: 'envs/Rtidy.yml'
    script:
        'scripts/plot_error_rates.R'

rule convert_tiff_to_png:
    input:
        tiff=lambda wildcards: f"figures/{figures_dict[int(wildcards.fig_num)]}.tiff"
    output:
        png="paper/figure_{fig_num}.png"
    conda: 'envs/shell.yml'
    shell:
        """
        convert {input.tiff} {output.png}
        """

rule render_paper:
    input:
        Rmd="paper/paper.Rmd",
        R="workflow/scripts/render_rmd.R",
        figures=expand(rules.convert_tiff_to_png.output.png, 
                       fig_num = range(1, len(figures_dict)+1))
    output:
        pdf="paper/paper.pdf",
    conda: "envs/Rtidy.yml",
    script:
        "scripts/render_rmd.R"
