Hello! The following explains what order to run the files in 
https://github.com/nmmacdo/econ771-assignment-2.git to replicate my work for 
assignment 2.

Step 1: Prepare the data. 

This step requires you to download the necessary data in 'data/input' and run 
one file in 'data-code' to clean this data:

1. Download the required data into data/input with subfolders for MD-PPAS and 
PUF data files.

2. Run 0-build-final.R in the data-code folder to clean the MD-PPAS, PUF, 
and PFS files. This will run 1-md-ppas.R and 2-puf.R as well.

Step 2: Perform the analysis.

This step requires you to run one file in 'analysis' to analyze the data stored 
in 'data/output':

1. Run main.R to complete the analyses required for assignment 2.

Step 3: Compile the results.

I have not fully automated the creating and saving of tables and plots, so edit
and save the tables and plots as necessary and transfer into Overleaf for 
manuscript preparation.