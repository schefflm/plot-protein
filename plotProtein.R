#!/bin/R
#Tychele N. Turner
#Laboratory of Aravinda Chakravarti, Ph.D.
#Johns Hopkins University School of Medicine
#Protein Plotting Script
#Programming Language: R
#Updated 3/24/2013

#Description: This script takes mutation information at the protein level and plots out the mutation above the schematic of the protein. It also plots the domains. 

#NOTE: All files should be referring to the same isoform of the protein. This is imperative for drawing the plot correctly.

#Required files:
##Mutation file: tab-delimited file containing 5 columns (ProteinId, GeneName, ProteinPositionOfMutation, ReferenceAminoAcid, AlternateAminoAcid) NO HEADER FOR NEEDED FOR THIS FILE
##Protein architecture file: tab-delimited file containing 3 columns (architecture_name, start_site, end_site). This file NEEDS the header and it is the same as what was previously written. This information can be downloaded from the HPRD (http://hprd.org/). Although the most recent files are quite old so looking in the web browser you can get much more up to date information.
##Post-translational modification file: This is a tab-delimited file with only one column and that is the site. This file NEEDS a header and is as previously written.

#Usage:
#R --slave --vanilla < plotProtein.R mutationFile proteinArchitectureFile postTranslationalModificationFile proteinLength nameOfYourQuery

#Example:
# R --slave --vanilla < scripts/plotProtein.R testFiles/psen1_mutation_file.txt testFiles/psen1_architecture_file.txt testFiles/psen1_post_translation_file.txt 463 Test

#Arguments:
argv <- function(x){
    args <- commandArgs()
    return(args[x])
}

mutationFile <- argv(4) #This is the mutation file
proteinArchitectureFile <- argv(5) #This is the protein architecture file
postTranslationalModificationFile <- argv(6) #This is the post-translation modification file
proteinLength <- argv(7) #Length of the protein isoform your looking at
nameOfYourQuery <- argv(8) #Here you can put whatever name you want to show up in the plot


####################ANALYSIS####################
#Read in the files
var <- read.table(mutationFile, sep="\t")
pa <- read.table(proteinArchitectureFile, sep="\t", header=TRUE)
pt <- read.table(postTranslationalModificationFile, sep="\t", header=TRUE)

############PLOTTING#############
#x is the input data, y is rpt, z is rpa from HPRD
pdf(paste(as.character(var[1,2]), "_protein_plot.pdf", sep=""), height=7.5, width=10)
par(oma=c(8, 1.2, 8, 1.2))

plot((1:as.numeric(proteinLength)), rep(-2, as.numeric(proteinLength)), type="l", lwd=5, main=paste("Amino Acid Changes in", " ", as.character(var[1,2]), " ", "(", as.character(var[1,1]), ")", sep=""), xlab="Amino Acid Position", ylab="", xlim=c(-145, as.numeric(proteinLength)), ylim=c(-1,-4), cex.lab=0.9, cex.main=1, yaxt="n")

#Plot mutations
points(var[,3], rep(-2.5, length(var[,3])), pch=19, col="blue", cex=0.7)

#Label mutations
#for(i in 1:nrow(var)){
#  text(var[i,3], rep(-2.7, length(var[i,3])), paste(as.character(var[i,4]), as.character(var[i,3]), as.character(var[i,5]), sep=""), col="blue", cex=0.7, srt=90, adj = 0)
#}

#labels
text(-100,-2.5,nameOfYourQuery, col="blue", cex=0.9)
for(i in 1:length(pt$site)){
	segments(as.numeric(pt$site[i]), -2, as.numeric(pt$site[i]), -2.25, lwd=2, col="black")
	points(as.numeric(pt$site[i]), -2.25, pch=19, col="deeppink", cex=0.7)
}
for(i in 1:length(pa$start_site)){
	rect(as.numeric(pa$start_site[i]), -2.05, as.numeric(pa$end_site[i]), -1.95, col="lightseagreen")
}
for(i in 1:length(pa$architecture_name)){
	text(median(c(as.numeric(pa$start_site[i]), as.numeric(pa$end_site[i]))), -1.80, pa$architecture_name[i], cex=0.6)
}
legend("topright", c("Protein Domain", "Post-Translational Modification"), fill=c("lightseagreen", "deeppink"), cex=0.7)
dev.off()

