library(cowplot)
library(dplyr)
library(ggplot2)
p <- ggplot() +
    draw_label("fig 1: alpha beta", size = 80, angle = 45)

ggsave(filename = snakemake@output[['tiff']], 
       plot = p,
       device = 'tiff')