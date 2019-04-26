# SphereFlame

An analogue of IFS or flame fractals, which use repeated affine mappings to create self-similar structures. This uses repeated rotations to map points on the surface of a sphere.

It's a Processing sketch I first put together years ago and am overhauling to work with P3 and have a nice user interface. The current UX is rubbish:

* drag with left or right mouse button click to shift the fractal transforms
* 'a' key reduces fractal depth, 'z' key increases it
* space bar saves the current frame as a PNG
* 'c' and 'd' are supposed to do something with colour, but that seems to be broken
* 's' saves the settings to a file called settings-N.txt, where N is 0-9, and hitting '0' through '9' is meant to load the settings, but this doesn't work either.