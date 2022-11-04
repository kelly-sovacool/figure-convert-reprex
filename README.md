# figure-convert-reprex

A minimal reproducible example for converting a bunch of unique figure names
to the canonical form `figure_{num}` without repetitive code.

![dag](figures/dag.png)


The magic is in defining a dictionary that maps figure numbers to figure names:
```python
figures_dict = {1: 'figures/alpha_beta.tiff', 2: 'figures/false_pos.tiff'}
```

And using an input function for the repetitive conversion step to access the 
input figure name from the output figure number:
```python
rule convert_tiff_to_png:
    input:
        tiff=lambda wildcards: f"{figures_dict[int(wildcards.fig_num)]}"
    output:
        png="submission/figure_{fig_num}.png"
    shell:
        """
        convert {input.tiff} {output.png}
        """
```