# Register and Rotate

Scans a directory of all tiff files containing images of metaphase budding yeast. GFP tag on various inner kinetochore proteins (NDC80-C, NDC80-N, AME1, MIF2, CSE4) and RFP tag on SPC42 (spindle pole bodies). The images are already cropped/segmented and the coordinates of the tags have already been manually selected (using [Josh Lawrimore's Image Analysis Gui](https://github.com/ddfulton/yeast-image-analysis)).

This program takes *one half* of the spindle (spindle pole body and an inner kinetochore protein of interest), sets the spindle pole body (RFP) as the origin, and then rotates the image such that the GFP tag (of the inner kinetochore protein of interest) such that it is on the horizontal axis. In other words, it registers the tags, and then rotates them.

This enables many different types of statistical analysis to be conducted on the resulting data, including heatmaps (for which there is a script) and line scans.
