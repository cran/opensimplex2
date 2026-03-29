## ----include = FALSE----------------------------------------------------------
do_render <- Sys.getenv("RENDER_OPENSIMPLEX2_VIGNETTE") == "TRUE"
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  out.width = "400px"
)
knitr::opts_knit$set(upload.fun = identity)
knitr::knit_hooks$set(
  fullbleed = function(before, options, envir) {
  if (before) {
    par(mar = c(0,0,0,0), oma = c(0,0,0,0))
  }
},
document = function(x) {
    fig_dir <- knitr::opts_chunk$get("fig.path")
    all_gifs <- list.files(fig_dir, pattern = "\\.gif$", full.names = TRUE)
    file.copy(all_gifs, "../pkgdown/vignette/", overwrite = TRUE)
    return(x)
})

library(ragg)
library(gifski)

## ----setup-space--------------------------------------------------------------
library(opensimplex2)
w <- 100L
h <- 100L
nframes <- 100L
scale <- .05
coords <- expand.grid(x = scale*seq_len(w), y = scale*seq_len(h))

fire_pal <- colorRampPalette(c("#000000", "#330000", "#FF0000", "#FFCC00", "#FFFFCC"))

set.seed(0)
space <- opensimplex_space(dimensions = 3)

## ----hot-bubbles, fig.width=10, fig.height=10, fig.dpi=10, out.width="200px", animation.hook='gifski', interval=0.05, message=FALSE, fullbleed=TRUE, eval=do_render----
# speed1 <- .02
# for (i in 1:nframes) {
#   time <- rep(i*speed1, nrow(coords))
#   feed <- matrix(space$sample(coords$x, coords$y, time), w, h)
#   feed <- (4 + feed)/5
#   image(feed,
#         axes = FALSE, ann = FALSE, xaxs = "i", yaxs = "i",
#         zlim = c(0, 1), col = fire_pal(100))
# }

## ----heat-gradient, fig.width=10, fig.height=10, fig.dpi=10, out.width="200px", animation.hook='gifski', interval=0.05, message=FALSE, fullbleed=TRUE, eval=do_render----
# cooling <- matrix(1 - seq_len(h)/h, w, h, byrow = TRUE)
# for (i in 1:nframes) {
#   time <- rep(i*speed1, nrow(coords))
#   feed <- matrix(space$sample(coords$x, coords$y, time), w, h)
#   feed <- (4 + feed)/5
#   image(feed*cooling,
#         axes = FALSE, ann = FALSE, xaxs = "i", yaxs = "i",
#         zlim = c(0, 1), col = fire_pal(100))
# }

## ----flames, fig.width=10, fig.height=10, fig.dpi=10, out.width="200px", animation.hook='gifski', interval=0.05, message=FALSE, fullbleed=TRUE, eval=do_render----
# speed2 <- .05
# for (i in 1:nframes) {
#   time <- rep(i*speed1, nrow(coords))
#   feed <- matrix(space$sample(coords$x, coords$y - speed2*i, time), w, h)
#   feed <- (4 + feed)/5
#   image(feed*cooling,
#         axes = FALSE, ann = FALSE, xaxs = "i", yaxs = "i",
#         zlim = c(0, 1), col = fire_pal(100))
# }

## ----seamless, fig.width=10, fig.height=10, fig.dpi=10, out.width="200px", animation.hook='gifski', interval=0.05, message=FALSE, fullbleed=TRUE, eval=do_render----
# space4d <- opensimplex_space(dimensions = 4)
# 
# coords_cyl   <- expand.grid(x = scale*seq_len(w), i = seq_len(nframes))
# cyl_radius   <- 1
# time_scale   <- 2
# time_cycle   <- time_scale*2*abs(nframes/2 - 1:nframes)/nframes
# for (i in 1:nframes) {
#   time <- rep(time_cycle[i], nrow(coords_cyl))
#   feed <- matrix(space4d$sample(coords_cyl$x,
#                                 cyl_radius*sin(2*pi*(i - coords_cyl$i)/nframes),
#                                 cyl_radius*cos(2*pi*(i - coords_cyl$i)/nframes),
#                                 time), w, h)
#   feed <- (4 + feed)/5
#   image(feed*cooling,
#         axes = FALSE, ann = FALSE, xaxs = "i", yaxs = "i",
#         zlim = c(0, 1), col = fire_pal(100))
# }

