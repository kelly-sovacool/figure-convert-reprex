figures_dict = {'1': 'diversity', '2': 'error_rates', 'abc': 123}

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

def get_fig_name(wildcards):
    return f'figures/{figures_dict[wildcards.fig_num]}.tiff'

rule convert_tiff_to_png:
    input:
        tiff=get_fig_name
    output:
        png="paper/figure_{fig_num}.png"
    shell:
        """
        convert {input.tiff} {output.png}
        """

rule render_paper:
    input:
        Rmd="paper/paper.Rmd",
        R="workflow/scripts/render_rmd.R",
        figures=expand(rules.convert_tiff_to_png.output.png, fig_num = figures_dict.keys())
    output:
        pdf="paper/paper.pdf"
    script:
        "scripts/render_rmd.R"