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

rule convert_figure_1:
    input:
        tiff='figures/diversity.tiff'
    output:
        png="paper/figure_1.png"
    shell:
        """
        convert {input.tiff} {output.png}
        """

rule convert_figure_2:
    input:
        tiff='figures/error_rates.tiff'
    output:
        png="paper/figure_2.png"
    shell:
        """
        convert {input.tiff} {output.png}
        """

rule render_paper:
    input:
        Rmd="paper/paper.Rmd",
        R="workflow/scripts/render_rmd.R",
        figures=['paper/figure_1.png', 'paper/figure_2.png']
    output:
        pdf="paper/paper.pdf"
    script:
        "scripts/render_rmd.R"