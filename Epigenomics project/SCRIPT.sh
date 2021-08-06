#!/bash/bin

# 1.- SELECT FRAGMENTS CORRESPONDING TO STATE3 FROM BOTH BIOLOGICAL REPLICATES

# filter out genome fragments that correspond to enhancer state (E3)

grep "E3" Monocyte1_11_Master_11_segments.bed > Monocyte1_11_state3.bed
grep "E3" Monocyte2_11_Master_11_segments.bed > Monocyte2_11_state3.bed

# find fragments that correspond to both biological replicates with bedtools (at least overlaped an 85%)

bedtools intersect -f 0.85 -F 0.85 -e -a Monocyte1_11_state3.bed -b Monocyte2_11_state3.bed > Monoc1_2_state3.bed

# 2.- ANNOTATION (WITH HOMER)

# first, we create an environment to install homer

conda create --name homer-env
conda activate homer-env

# install homer using conda

conda install -c bioconda homer

# install version of the genome (hg19)

perl /home/sergiom/anaconda3/envs/homer-env/share/homer/.//configureHomer.pl -install hg19

# create the output directories for gene ontology and genome ontology analysis

mkdir geneO
mkdir genomeO

# annotate the segments with homer

annotatePeaks.pl Monoc1_2_state3.bed hg19 -go ./geneO/ -genomeOntology ./genomeO/ -annStats annotation_stats.txt > state3_annotated.txt

conda deactivate

# 3.- CALCULATE OVERLAPPED DNase SEGMENTS

# download and extract the peaks from DNase file

wget http://hgdownload.cse.ucsc.edu/goldenpath/hg19/encodeDCC/wgEncodeOpenChromDnase/wgEncodeOpenChromDnaseMonocd14Pk.narrowPeak.gz 
gunzip wgEncodeOpenChromDnaseMonocd14Pk.narrowPeak.gz 


# once downloaded the narrowPeak file, we can transform it to .bed file (this may be optional, as the narrowPeak file is basically a bed file)

cut -f 1-6 wgEncodeOpenChromDnaseMonocd14Pk.narrowPeak > dnase_Monoc.bed

# we merge the file with our state3 peaks and the DNase peaks with the command window from bedtools. With a pipe we can directly see which segments are overlapped

bedtools window -a ./state3/Monoc1_2_state3.bed -b dnase_Monoc.bed | bedtools overlap -i stdin -cols 2,3,6,7 > overlap_dnase_state3.tsv

# the last column of the overlap_dnase_state3.tsv is positive indicating the number of bases overlapped (in case of overlap) or negative indicating the distance between the segments (in case of no overlap) so the percentage can be easily calculated with Python (see script overlap_percentage.ipynb)

# 4.- UCSC Genome Browser visualization

# with the script biggest_overlap.ipynb we see that the length of the maximum overlapped peaks is 3836

# with a grep we can find the coordinates and choose them to visualize it in the genome browser

grep -w "3836" overlap_dnase_state3.tsv 
grep -w "2082" overlap_dnase_state3.tsv 
grep -w "1779" overlap_dnase_state3.tsv 
grep -w "1751" overlap_dnase_state3.tsv 
grep -w "1636" overlap_dnase_state3.tsv 

# the result is chr9:137259400-137264600; chr9:137255000-137257200; chr22:21846200-21848000; chr22:40810600-40813600; chr2:240386200-240388200

# 1st peak corresponds to SE_00_00600063 super enhancer, that can be found in SEdb

# 5.- FINDING MOTIFS (WITH HOMER)

findMotifsGenome.pl Monoc1_2_state3.bed hg19 ./motifs_homer/ -size 200 -mask

# 6.- OVERLAP WITH METHYLATED REGIONS

# first, download the methylated regions from patient C001UY as told in the work rules

# once downloaded, calculate the overlap with bedtools (hyper metilated)

bedtools window -a Monoc1_2_state3.bed -b C001UYA3bs.hyper_meth.bs_call.GRCh38.20150707.bed | bedtools overlap -i stdin -cols 2,3,6,7 > overlap_hypermeth.tsv

# and hypo metilated

bedtools window -a Monoc1_2_state3.bed -b C001UYA3bs.hypo_meth.bs_call.GRCh38.20150707.bed | bedtools overlap -i stdin -cols 2,3,6,7 > overlap_hypometh.tsv

# and do the same as in the step 3 with the python notebook and these files
