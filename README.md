# mat-symbolic-analysis
Computational symbolic analysis of Pedro Navaja, by Rubén Blades

Please refer to these blog posts for in-detail explanations of this analysis: [Part I](https://danielbalcells.com/2017/02/26/pedro-navaja-part-i-computational-symbolic-analysis/) and [Part II](https://danielbalcells.com/2017/03/02/pedro-navaja-part-ii-generating-latin-bass-lines/)

# Requirements
Besides having a valid MATLAB installation, you should download the [MIDI Toolbox](http://www.jyu.fi/hum/laitokset/musiikki/en/research/coe/materials/miditoolbox/) for MATLAB developed at the University of Jyväskylä, Finland. Most of the code in this repository assumes that the MIDI data is imported into MATLAB in the MIDI Toolbox `nmat` note-matrix format.

# Usage
All of the analysis in [Part I](https://danielbalcells.com/2017/02/26/pedro-navaja-part-i-computational-symbolic-analysis/) was performed using the functions `getPitchClassSequence()`, `getKeySequence()`, `my_ssm()` and `transpositionInvariantCosineDistance()`. I load the MIDI score into MATLAB using the MIDI Toolbox function `readmidi()`, and keep only the bass line (which is in MIDI channel 2 in `pedronavaja.mid`) for analysis using `getmidich()`.

The bass line synthesis covered in [Part II](https://danielbalcells.com/2017/03/02/pedro-navaja-part-ii-generating-latin-bass-lines/) uses the four different `markovGenenerator` functions. Versions 2, 3 and 4 require you to manually annotate the key of each note and the interval between each note and the root note. Use `help markovGeneratorv2` or read the blog post for more info.
