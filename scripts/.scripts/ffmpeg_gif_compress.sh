ffmpeg -i input.gif -filter_complex "[0:v] fps=12,scale=480:-1:flags=lanczos,mpdecimate,split [a][b];[a] palettegen=max_colors=64 [p];[b][p] paletteuse=dither=bayer:bayer_scale=5" output.gif
