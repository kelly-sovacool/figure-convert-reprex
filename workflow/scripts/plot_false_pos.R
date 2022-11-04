library(cowplot)
library(dplyr)
library(ggplot2)
p <- ggplot() +
    draw_label("fig 2: false pos", size = 80, angle = 45)

ggsave(filename = snakemake@output[['tiff']], 
       plot = p,
       device = 'tiff')