plot-protein
============

Plot Protein: Visualization of Mutations

Author: Tychele N. Turner, Laboratory of Aravinda Chakravarti, Ph.D.

Licenses: GNU General Public License version 3.0 (GPLv3), MIT License

Short Description: Protein Plotting Script to Visualize Amino Acid Changes

Programming Language: R

Current version: 2.0.0

Readme Date: 05/25/2015

Description: This script takes mutation information at the protein level and plots out the mutation above the schematic of the protein. It also plots the domains. It now has additional features for specifying the tick size of the x-axis, capability to show labels, and also the option to zoom to a particular region of the protein. 

NOTE: All files should be referring to the same isoform of the protein. This is imperative for drawing the plot correctly.

Required files:

*Mutation file: tab-delimited file containing 5 columns (ProteinId, GeneName, ProteinPositionOfMutation, ReferenceAminoAcid, AlternateAminoAcid) NO HEADER FOR NEEDED FOR THIS FILE

*Protein architecture file: tab-delimited file containing 3 columns (architecture_name, start_site, end_site). This file NEEDS the header and it is the same as what was previously written. This information can be downloaded from the HPRD (http://hprd.org/). Although the most recent files are quite old so looking in the web browser you can get much more up to date information.

*Post-translational modification file: This is a tab-delimited file with only one column and that is the site. This file NEEDS a header and is as previously written.


Basic Usage:
==================================================
Rscript plotProtein.R -m psen1_mutation_file.txt -a psen1_architecture_file.txt -p psen1_post_translation_file.txt -l 463

Advanced usage:
==================================================
Rscript plotProtein.R -m psen1_mutation_file.txt -a psen1_architecture_file.txt -p psen1_post_translation_file.txt -l 464 -n Disease -t 25 -s yes -z yes -b 50 -c 100
