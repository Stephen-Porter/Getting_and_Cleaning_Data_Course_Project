# Codebook.md
Stephen Porter  
10-24-2015  

## Project Description
The purpose of this project is to demonstrate the student's ability to collect, 
work with, and clean a data set. The goal is to prepare tidy data that can be 
used for later analysis. The student will be required to submit: 

* A tidy data set 
* A link to a Github repository with your script for performing the analysis
* This code book that describes the variables, the data, and any transformations
    or work that ws performed to clean up the data called CodeBook.md. 
* You should also include a README.md in the repo with your scripts. This repo 
    explains how all of the scripts work and how they are connected.  

##Study design and data processing

###Collection of the raw data
Description of how the data was collected.

###Notes on the original (raw) data 
Some additional notes (if avaialble, otherwise you can leave this section out).

##Creating the tidy datafile

###Guide to create the tidy data file
Description on how to create the tidy data file (1. download the data, ...)/

###Cleaning of the data
Short, high-level description of what the cleaning script does. [link to the readme document that describes the code in greater detail]()

##Description of the variables in the tiny_data.txt file
General description of the file including:
 - Dimensions of the dataset
 - Summary of the data
 - Variables present in the dataset

(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

###Variable 1 (repeat this section for all variables in the dataset)
Short description of what the variable describes.

Some information on the variable including:
 - Class of the variable
 - Unique values/levels of the variable
 - Unit of measurement (if no unit of measurement list this as well)
 - In case names follow some schema, describe how entries were constructed (for example time-body-gyroscope-z has 4 levels of descriptors. Describe these 4 levels). 

(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

####Notes on variable 1:
If available, some additional notes on the variable not covered elsewehere. If no notes are present leave this section out.

##Sources
Sources you used if any, otherise leave out.

##Annex
If you used any code in the codebook that had the echo=FALSE attribute post this here (make sure you set the results parameter to 'hide' as you do not want the results to show again)





```r
summary(cars)
```

```
##      speed           dist       
##  Min.   : 4.0   Min.   :  2.00  
##  1st Qu.:12.0   1st Qu.: 26.00  
##  Median :15.0   Median : 36.00  
##  Mean   :15.4   Mean   : 42.98  
##  3rd Qu.:19.0   3rd Qu.: 56.00  
##  Max.   :25.0   Max.   :120.00
```

You can also embed plots, for example:

![](Codebook_files/figure-html/unnamed-chunk-2-1.png) 

