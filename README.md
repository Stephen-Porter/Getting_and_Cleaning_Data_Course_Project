# README.md
Stephen Porter  
October 24, 2015  

The basic overall work flow is described in the codebook.md included in the
GitHub repository. 
https://github.com/Stephen-Porter/Getting_and_Cleaning_Data_Course_Project.git

# Obtain the data from the original data source.

Before we start the steps of analyising the code.  We must first download it,
unzip it, and load any appropriate r libraries to work with the data.  The
original data file comes form the following address:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The following r code will download the raw data to the current working directory
and unzip it into included subdirectories.


```r
zipfile <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,zipfile)
unzip(zipfile, files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = ".", unzip = "internal",
      setTimes = FALSE)
unlink(zipfile)
```

The dplyr library was used for many of the data manipulations in the project.
The following code will load the `dplyr` library:


```r
library(dplyr)
```

When the data was unzipped, several subdirectories and files were created.  The 
files for training or test data sets end in _train.txt or _test.txt respectively.
In the following code each file will be read in using `read.table` as well as 
'tbl_df' to load each file as data frame that works wiht `dplyr`.


```r
subject_train <- tbl_df(read.table("./UCI HAR Dataset/train/subject_train.txt"))
subject_test  <- tbl_df(read.table("./UCI HAR Dataset/test/subject_test.txt" ))
activity_train <- tbl_df(read.table("./UCI HAR Dataset/train/Y_train.txt"))
activity_test  <- tbl_df(read.table("./UCI HAR Dataset/test/Y_test.txt" ))
train_df <- tbl_df(read.table("./UCI HAR Dataset/train/X_train.txt" ))
test_df  <- tbl_df(read.table("./UCI HAR Dataset/test/X_test.txt" ))
```

### 1. Merge the training and the test sets to create one data set.

Combine the training and test data tables to one data table called dat then use
'rm()` function to remove the raw train and test data sets.


```r
dat <- rbind(train_df, test_df)
rm(train_df, test_df)
```

Then read in the features from features.txt an rename the columns in `dat` to
the names from the `features$V2` column.


```r
features <- tbl_df(read.table("./UCI HAR Dataset/features.txt"))
colnames(dat) <- features$V2 
```
Now that the combined data set has names, both Activity and Subject files will
need to merge the training and the test sets.  Using `bind_rows` from `dplyr`,
and `rename` to combine the test and trainings sets and rename columns "subject"
and "activitynum" for the new variables `subj` and `active`.  The last line in 
this code block will remove the raw data with `rm()` like before to clean up the
active variables.  Keeping the work space tidy.


```r
subj <- bind_rows(subject_train, subject_test) %>% 
        rename(subject = V1)

activ <- bind_rows(activity_train, activity_test) %>%
        rename(activitynum = V1)

rm(subject_train, subject_test, activity_train, activity_test)
```

### 2. Extracts only the measurements on the mean AND standard deviation for 
### each measurement. 

With 561 feature names form the features.txt as the column names for the `dat`
data frame the raw data is quite a mess.  "How messy is it?", you ask.  Let's
find out by running by looking at tne names from `features`  


```r
features$V2
```

```
##   [1] tBodyAcc-mean()-X                   
##   [2] tBodyAcc-mean()-Y                   
##   [3] tBodyAcc-mean()-Z                   
##   [4] tBodyAcc-std()-X                    
##   [5] tBodyAcc-std()-Y                    
##   [6] tBodyAcc-std()-Z                    
##   [7] tBodyAcc-mad()-X                    
##   [8] tBodyAcc-mad()-Y                    
##   [9] tBodyAcc-mad()-Z                    
##  [10] tBodyAcc-max()-X                    
##  [11] tBodyAcc-max()-Y                    
##  [12] tBodyAcc-max()-Z                    
##  [13] tBodyAcc-min()-X                    
##  [14] tBodyAcc-min()-Y                    
##  [15] tBodyAcc-min()-Z                    
##  [16] tBodyAcc-sma()                      
##  [17] tBodyAcc-energy()-X                 
##  [18] tBodyAcc-energy()-Y                 
##  [19] tBodyAcc-energy()-Z                 
##  [20] tBodyAcc-iqr()-X                    
##  [21] tBodyAcc-iqr()-Y                    
##  [22] tBodyAcc-iqr()-Z                    
##  [23] tBodyAcc-entropy()-X                
##  [24] tBodyAcc-entropy()-Y                
##  [25] tBodyAcc-entropy()-Z                
##  [26] tBodyAcc-arCoeff()-X,1              
##  [27] tBodyAcc-arCoeff()-X,2              
##  [28] tBodyAcc-arCoeff()-X,3              
##  [29] tBodyAcc-arCoeff()-X,4              
##  [30] tBodyAcc-arCoeff()-Y,1              
##  [31] tBodyAcc-arCoeff()-Y,2              
##  [32] tBodyAcc-arCoeff()-Y,3              
##  [33] tBodyAcc-arCoeff()-Y,4              
##  [34] tBodyAcc-arCoeff()-Z,1              
##  [35] tBodyAcc-arCoeff()-Z,2              
##  [36] tBodyAcc-arCoeff()-Z,3              
##  [37] tBodyAcc-arCoeff()-Z,4              
##  [38] tBodyAcc-correlation()-X,Y          
##  [39] tBodyAcc-correlation()-X,Z          
##  [40] tBodyAcc-correlation()-Y,Z          
##  [41] tGravityAcc-mean()-X                
##  [42] tGravityAcc-mean()-Y                
##  [43] tGravityAcc-mean()-Z                
##  [44] tGravityAcc-std()-X                 
##  [45] tGravityAcc-std()-Y                 
##  [46] tGravityAcc-std()-Z                 
##  [47] tGravityAcc-mad()-X                 
##  [48] tGravityAcc-mad()-Y                 
##  [49] tGravityAcc-mad()-Z                 
##  [50] tGravityAcc-max()-X                 
##  [51] tGravityAcc-max()-Y                 
##  [52] tGravityAcc-max()-Z                 
##  [53] tGravityAcc-min()-X                 
##  [54] tGravityAcc-min()-Y                 
##  [55] tGravityAcc-min()-Z                 
##  [56] tGravityAcc-sma()                   
##  [57] tGravityAcc-energy()-X              
##  [58] tGravityAcc-energy()-Y              
##  [59] tGravityAcc-energy()-Z              
##  [60] tGravityAcc-iqr()-X                 
##  [61] tGravityAcc-iqr()-Y                 
##  [62] tGravityAcc-iqr()-Z                 
##  [63] tGravityAcc-entropy()-X             
##  [64] tGravityAcc-entropy()-Y             
##  [65] tGravityAcc-entropy()-Z             
##  [66] tGravityAcc-arCoeff()-X,1           
##  [67] tGravityAcc-arCoeff()-X,2           
##  [68] tGravityAcc-arCoeff()-X,3           
##  [69] tGravityAcc-arCoeff()-X,4           
##  [70] tGravityAcc-arCoeff()-Y,1           
##  [71] tGravityAcc-arCoeff()-Y,2           
##  [72] tGravityAcc-arCoeff()-Y,3           
##  [73] tGravityAcc-arCoeff()-Y,4           
##  [74] tGravityAcc-arCoeff()-Z,1           
##  [75] tGravityAcc-arCoeff()-Z,2           
##  [76] tGravityAcc-arCoeff()-Z,3           
##  [77] tGravityAcc-arCoeff()-Z,4           
##  [78] tGravityAcc-correlation()-X,Y       
##  [79] tGravityAcc-correlation()-X,Z       
##  [80] tGravityAcc-correlation()-Y,Z       
##  [81] tBodyAccJerk-mean()-X               
##  [82] tBodyAccJerk-mean()-Y               
##  [83] tBodyAccJerk-mean()-Z               
##  [84] tBodyAccJerk-std()-X                
##  [85] tBodyAccJerk-std()-Y                
##  [86] tBodyAccJerk-std()-Z                
##  [87] tBodyAccJerk-mad()-X                
##  [88] tBodyAccJerk-mad()-Y                
##  [89] tBodyAccJerk-mad()-Z                
##  [90] tBodyAccJerk-max()-X                
##  [91] tBodyAccJerk-max()-Y                
##  [92] tBodyAccJerk-max()-Z                
##  [93] tBodyAccJerk-min()-X                
##  [94] tBodyAccJerk-min()-Y                
##  [95] tBodyAccJerk-min()-Z                
##  [96] tBodyAccJerk-sma()                  
##  [97] tBodyAccJerk-energy()-X             
##  [98] tBodyAccJerk-energy()-Y             
##  [99] tBodyAccJerk-energy()-Z             
## [100] tBodyAccJerk-iqr()-X                
## [101] tBodyAccJerk-iqr()-Y                
## [102] tBodyAccJerk-iqr()-Z                
## [103] tBodyAccJerk-entropy()-X            
## [104] tBodyAccJerk-entropy()-Y            
## [105] tBodyAccJerk-entropy()-Z            
## [106] tBodyAccJerk-arCoeff()-X,1          
## [107] tBodyAccJerk-arCoeff()-X,2          
## [108] tBodyAccJerk-arCoeff()-X,3          
## [109] tBodyAccJerk-arCoeff()-X,4          
## [110] tBodyAccJerk-arCoeff()-Y,1          
## [111] tBodyAccJerk-arCoeff()-Y,2          
## [112] tBodyAccJerk-arCoeff()-Y,3          
## [113] tBodyAccJerk-arCoeff()-Y,4          
## [114] tBodyAccJerk-arCoeff()-Z,1          
## [115] tBodyAccJerk-arCoeff()-Z,2          
## [116] tBodyAccJerk-arCoeff()-Z,3          
## [117] tBodyAccJerk-arCoeff()-Z,4          
## [118] tBodyAccJerk-correlation()-X,Y      
## [119] tBodyAccJerk-correlation()-X,Z      
## [120] tBodyAccJerk-correlation()-Y,Z      
## [121] tBodyGyro-mean()-X                  
## [122] tBodyGyro-mean()-Y                  
## [123] tBodyGyro-mean()-Z                  
## [124] tBodyGyro-std()-X                   
## [125] tBodyGyro-std()-Y                   
## [126] tBodyGyro-std()-Z                   
## [127] tBodyGyro-mad()-X                   
## [128] tBodyGyro-mad()-Y                   
## [129] tBodyGyro-mad()-Z                   
## [130] tBodyGyro-max()-X                   
## [131] tBodyGyro-max()-Y                   
## [132] tBodyGyro-max()-Z                   
## [133] tBodyGyro-min()-X                   
## [134] tBodyGyro-min()-Y                   
## [135] tBodyGyro-min()-Z                   
## [136] tBodyGyro-sma()                     
## [137] tBodyGyro-energy()-X                
## [138] tBodyGyro-energy()-Y                
## [139] tBodyGyro-energy()-Z                
## [140] tBodyGyro-iqr()-X                   
## [141] tBodyGyro-iqr()-Y                   
## [142] tBodyGyro-iqr()-Z                   
## [143] tBodyGyro-entropy()-X               
## [144] tBodyGyro-entropy()-Y               
## [145] tBodyGyro-entropy()-Z               
## [146] tBodyGyro-arCoeff()-X,1             
## [147] tBodyGyro-arCoeff()-X,2             
## [148] tBodyGyro-arCoeff()-X,3             
## [149] tBodyGyro-arCoeff()-X,4             
## [150] tBodyGyro-arCoeff()-Y,1             
## [151] tBodyGyro-arCoeff()-Y,2             
## [152] tBodyGyro-arCoeff()-Y,3             
## [153] tBodyGyro-arCoeff()-Y,4             
## [154] tBodyGyro-arCoeff()-Z,1             
## [155] tBodyGyro-arCoeff()-Z,2             
## [156] tBodyGyro-arCoeff()-Z,3             
## [157] tBodyGyro-arCoeff()-Z,4             
## [158] tBodyGyro-correlation()-X,Y         
## [159] tBodyGyro-correlation()-X,Z         
## [160] tBodyGyro-correlation()-Y,Z         
## [161] tBodyGyroJerk-mean()-X              
## [162] tBodyGyroJerk-mean()-Y              
## [163] tBodyGyroJerk-mean()-Z              
## [164] tBodyGyroJerk-std()-X               
## [165] tBodyGyroJerk-std()-Y               
## [166] tBodyGyroJerk-std()-Z               
## [167] tBodyGyroJerk-mad()-X               
## [168] tBodyGyroJerk-mad()-Y               
## [169] tBodyGyroJerk-mad()-Z               
## [170] tBodyGyroJerk-max()-X               
## [171] tBodyGyroJerk-max()-Y               
## [172] tBodyGyroJerk-max()-Z               
## [173] tBodyGyroJerk-min()-X               
## [174] tBodyGyroJerk-min()-Y               
## [175] tBodyGyroJerk-min()-Z               
## [176] tBodyGyroJerk-sma()                 
## [177] tBodyGyroJerk-energy()-X            
## [178] tBodyGyroJerk-energy()-Y            
## [179] tBodyGyroJerk-energy()-Z            
## [180] tBodyGyroJerk-iqr()-X               
## [181] tBodyGyroJerk-iqr()-Y               
## [182] tBodyGyroJerk-iqr()-Z               
## [183] tBodyGyroJerk-entropy()-X           
## [184] tBodyGyroJerk-entropy()-Y           
## [185] tBodyGyroJerk-entropy()-Z           
## [186] tBodyGyroJerk-arCoeff()-X,1         
## [187] tBodyGyroJerk-arCoeff()-X,2         
## [188] tBodyGyroJerk-arCoeff()-X,3         
## [189] tBodyGyroJerk-arCoeff()-X,4         
## [190] tBodyGyroJerk-arCoeff()-Y,1         
## [191] tBodyGyroJerk-arCoeff()-Y,2         
## [192] tBodyGyroJerk-arCoeff()-Y,3         
## [193] tBodyGyroJerk-arCoeff()-Y,4         
## [194] tBodyGyroJerk-arCoeff()-Z,1         
## [195] tBodyGyroJerk-arCoeff()-Z,2         
## [196] tBodyGyroJerk-arCoeff()-Z,3         
## [197] tBodyGyroJerk-arCoeff()-Z,4         
## [198] tBodyGyroJerk-correlation()-X,Y     
## [199] tBodyGyroJerk-correlation()-X,Z     
## [200] tBodyGyroJerk-correlation()-Y,Z     
## [201] tBodyAccMag-mean()                  
## [202] tBodyAccMag-std()                   
## [203] tBodyAccMag-mad()                   
## [204] tBodyAccMag-max()                   
## [205] tBodyAccMag-min()                   
## [206] tBodyAccMag-sma()                   
## [207] tBodyAccMag-energy()                
## [208] tBodyAccMag-iqr()                   
## [209] tBodyAccMag-entropy()               
## [210] tBodyAccMag-arCoeff()1              
## [211] tBodyAccMag-arCoeff()2              
## [212] tBodyAccMag-arCoeff()3              
## [213] tBodyAccMag-arCoeff()4              
## [214] tGravityAccMag-mean()               
## [215] tGravityAccMag-std()                
## [216] tGravityAccMag-mad()                
## [217] tGravityAccMag-max()                
## [218] tGravityAccMag-min()                
## [219] tGravityAccMag-sma()                
## [220] tGravityAccMag-energy()             
## [221] tGravityAccMag-iqr()                
## [222] tGravityAccMag-entropy()            
## [223] tGravityAccMag-arCoeff()1           
## [224] tGravityAccMag-arCoeff()2           
## [225] tGravityAccMag-arCoeff()3           
## [226] tGravityAccMag-arCoeff()4           
## [227] tBodyAccJerkMag-mean()              
## [228] tBodyAccJerkMag-std()               
## [229] tBodyAccJerkMag-mad()               
## [230] tBodyAccJerkMag-max()               
## [231] tBodyAccJerkMag-min()               
## [232] tBodyAccJerkMag-sma()               
## [233] tBodyAccJerkMag-energy()            
## [234] tBodyAccJerkMag-iqr()               
## [235] tBodyAccJerkMag-entropy()           
## [236] tBodyAccJerkMag-arCoeff()1          
## [237] tBodyAccJerkMag-arCoeff()2          
## [238] tBodyAccJerkMag-arCoeff()3          
## [239] tBodyAccJerkMag-arCoeff()4          
## [240] tBodyGyroMag-mean()                 
## [241] tBodyGyroMag-std()                  
## [242] tBodyGyroMag-mad()                  
## [243] tBodyGyroMag-max()                  
## [244] tBodyGyroMag-min()                  
## [245] tBodyGyroMag-sma()                  
## [246] tBodyGyroMag-energy()               
## [247] tBodyGyroMag-iqr()                  
## [248] tBodyGyroMag-entropy()              
## [249] tBodyGyroMag-arCoeff()1             
## [250] tBodyGyroMag-arCoeff()2             
## [251] tBodyGyroMag-arCoeff()3             
## [252] tBodyGyroMag-arCoeff()4             
## [253] tBodyGyroJerkMag-mean()             
## [254] tBodyGyroJerkMag-std()              
## [255] tBodyGyroJerkMag-mad()              
## [256] tBodyGyroJerkMag-max()              
## [257] tBodyGyroJerkMag-min()              
## [258] tBodyGyroJerkMag-sma()              
## [259] tBodyGyroJerkMag-energy()           
## [260] tBodyGyroJerkMag-iqr()              
## [261] tBodyGyroJerkMag-entropy()          
## [262] tBodyGyroJerkMag-arCoeff()1         
## [263] tBodyGyroJerkMag-arCoeff()2         
## [264] tBodyGyroJerkMag-arCoeff()3         
## [265] tBodyGyroJerkMag-arCoeff()4         
## [266] fBodyAcc-mean()-X                   
## [267] fBodyAcc-mean()-Y                   
## [268] fBodyAcc-mean()-Z                   
## [269] fBodyAcc-std()-X                    
## [270] fBodyAcc-std()-Y                    
## [271] fBodyAcc-std()-Z                    
## [272] fBodyAcc-mad()-X                    
## [273] fBodyAcc-mad()-Y                    
## [274] fBodyAcc-mad()-Z                    
## [275] fBodyAcc-max()-X                    
## [276] fBodyAcc-max()-Y                    
## [277] fBodyAcc-max()-Z                    
## [278] fBodyAcc-min()-X                    
## [279] fBodyAcc-min()-Y                    
## [280] fBodyAcc-min()-Z                    
## [281] fBodyAcc-sma()                      
## [282] fBodyAcc-energy()-X                 
## [283] fBodyAcc-energy()-Y                 
## [284] fBodyAcc-energy()-Z                 
## [285] fBodyAcc-iqr()-X                    
## [286] fBodyAcc-iqr()-Y                    
## [287] fBodyAcc-iqr()-Z                    
## [288] fBodyAcc-entropy()-X                
## [289] fBodyAcc-entropy()-Y                
## [290] fBodyAcc-entropy()-Z                
## [291] fBodyAcc-maxInds-X                  
## [292] fBodyAcc-maxInds-Y                  
## [293] fBodyAcc-maxInds-Z                  
## [294] fBodyAcc-meanFreq()-X               
## [295] fBodyAcc-meanFreq()-Y               
## [296] fBodyAcc-meanFreq()-Z               
## [297] fBodyAcc-skewness()-X               
## [298] fBodyAcc-kurtosis()-X               
## [299] fBodyAcc-skewness()-Y               
## [300] fBodyAcc-kurtosis()-Y               
## [301] fBodyAcc-skewness()-Z               
## [302] fBodyAcc-kurtosis()-Z               
## [303] fBodyAcc-bandsEnergy()-1,8          
## [304] fBodyAcc-bandsEnergy()-9,16         
## [305] fBodyAcc-bandsEnergy()-17,24        
## [306] fBodyAcc-bandsEnergy()-25,32        
## [307] fBodyAcc-bandsEnergy()-33,40        
## [308] fBodyAcc-bandsEnergy()-41,48        
## [309] fBodyAcc-bandsEnergy()-49,56        
## [310] fBodyAcc-bandsEnergy()-57,64        
## [311] fBodyAcc-bandsEnergy()-1,16         
## [312] fBodyAcc-bandsEnergy()-17,32        
## [313] fBodyAcc-bandsEnergy()-33,48        
## [314] fBodyAcc-bandsEnergy()-49,64        
## [315] fBodyAcc-bandsEnergy()-1,24         
## [316] fBodyAcc-bandsEnergy()-25,48        
## [317] fBodyAcc-bandsEnergy()-1,8          
## [318] fBodyAcc-bandsEnergy()-9,16         
## [319] fBodyAcc-bandsEnergy()-17,24        
## [320] fBodyAcc-bandsEnergy()-25,32        
## [321] fBodyAcc-bandsEnergy()-33,40        
## [322] fBodyAcc-bandsEnergy()-41,48        
## [323] fBodyAcc-bandsEnergy()-49,56        
## [324] fBodyAcc-bandsEnergy()-57,64        
## [325] fBodyAcc-bandsEnergy()-1,16         
## [326] fBodyAcc-bandsEnergy()-17,32        
## [327] fBodyAcc-bandsEnergy()-33,48        
## [328] fBodyAcc-bandsEnergy()-49,64        
## [329] fBodyAcc-bandsEnergy()-1,24         
## [330] fBodyAcc-bandsEnergy()-25,48        
## [331] fBodyAcc-bandsEnergy()-1,8          
## [332] fBodyAcc-bandsEnergy()-9,16         
## [333] fBodyAcc-bandsEnergy()-17,24        
## [334] fBodyAcc-bandsEnergy()-25,32        
## [335] fBodyAcc-bandsEnergy()-33,40        
## [336] fBodyAcc-bandsEnergy()-41,48        
## [337] fBodyAcc-bandsEnergy()-49,56        
## [338] fBodyAcc-bandsEnergy()-57,64        
## [339] fBodyAcc-bandsEnergy()-1,16         
## [340] fBodyAcc-bandsEnergy()-17,32        
## [341] fBodyAcc-bandsEnergy()-33,48        
## [342] fBodyAcc-bandsEnergy()-49,64        
## [343] fBodyAcc-bandsEnergy()-1,24         
## [344] fBodyAcc-bandsEnergy()-25,48        
## [345] fBodyAccJerk-mean()-X               
## [346] fBodyAccJerk-mean()-Y               
## [347] fBodyAccJerk-mean()-Z               
## [348] fBodyAccJerk-std()-X                
## [349] fBodyAccJerk-std()-Y                
## [350] fBodyAccJerk-std()-Z                
## [351] fBodyAccJerk-mad()-X                
## [352] fBodyAccJerk-mad()-Y                
## [353] fBodyAccJerk-mad()-Z                
## [354] fBodyAccJerk-max()-X                
## [355] fBodyAccJerk-max()-Y                
## [356] fBodyAccJerk-max()-Z                
## [357] fBodyAccJerk-min()-X                
## [358] fBodyAccJerk-min()-Y                
## [359] fBodyAccJerk-min()-Z                
## [360] fBodyAccJerk-sma()                  
## [361] fBodyAccJerk-energy()-X             
## [362] fBodyAccJerk-energy()-Y             
## [363] fBodyAccJerk-energy()-Z             
## [364] fBodyAccJerk-iqr()-X                
## [365] fBodyAccJerk-iqr()-Y                
## [366] fBodyAccJerk-iqr()-Z                
## [367] fBodyAccJerk-entropy()-X            
## [368] fBodyAccJerk-entropy()-Y            
## [369] fBodyAccJerk-entropy()-Z            
## [370] fBodyAccJerk-maxInds-X              
## [371] fBodyAccJerk-maxInds-Y              
## [372] fBodyAccJerk-maxInds-Z              
## [373] fBodyAccJerk-meanFreq()-X           
## [374] fBodyAccJerk-meanFreq()-Y           
## [375] fBodyAccJerk-meanFreq()-Z           
## [376] fBodyAccJerk-skewness()-X           
## [377] fBodyAccJerk-kurtosis()-X           
## [378] fBodyAccJerk-skewness()-Y           
## [379] fBodyAccJerk-kurtosis()-Y           
## [380] fBodyAccJerk-skewness()-Z           
## [381] fBodyAccJerk-kurtosis()-Z           
## [382] fBodyAccJerk-bandsEnergy()-1,8      
## [383] fBodyAccJerk-bandsEnergy()-9,16     
## [384] fBodyAccJerk-bandsEnergy()-17,24    
## [385] fBodyAccJerk-bandsEnergy()-25,32    
## [386] fBodyAccJerk-bandsEnergy()-33,40    
## [387] fBodyAccJerk-bandsEnergy()-41,48    
## [388] fBodyAccJerk-bandsEnergy()-49,56    
## [389] fBodyAccJerk-bandsEnergy()-57,64    
## [390] fBodyAccJerk-bandsEnergy()-1,16     
## [391] fBodyAccJerk-bandsEnergy()-17,32    
## [392] fBodyAccJerk-bandsEnergy()-33,48    
## [393] fBodyAccJerk-bandsEnergy()-49,64    
## [394] fBodyAccJerk-bandsEnergy()-1,24     
## [395] fBodyAccJerk-bandsEnergy()-25,48    
## [396] fBodyAccJerk-bandsEnergy()-1,8      
## [397] fBodyAccJerk-bandsEnergy()-9,16     
## [398] fBodyAccJerk-bandsEnergy()-17,24    
## [399] fBodyAccJerk-bandsEnergy()-25,32    
## [400] fBodyAccJerk-bandsEnergy()-33,40    
## [401] fBodyAccJerk-bandsEnergy()-41,48    
## [402] fBodyAccJerk-bandsEnergy()-49,56    
## [403] fBodyAccJerk-bandsEnergy()-57,64    
## [404] fBodyAccJerk-bandsEnergy()-1,16     
## [405] fBodyAccJerk-bandsEnergy()-17,32    
## [406] fBodyAccJerk-bandsEnergy()-33,48    
## [407] fBodyAccJerk-bandsEnergy()-49,64    
## [408] fBodyAccJerk-bandsEnergy()-1,24     
## [409] fBodyAccJerk-bandsEnergy()-25,48    
## [410] fBodyAccJerk-bandsEnergy()-1,8      
## [411] fBodyAccJerk-bandsEnergy()-9,16     
## [412] fBodyAccJerk-bandsEnergy()-17,24    
## [413] fBodyAccJerk-bandsEnergy()-25,32    
## [414] fBodyAccJerk-bandsEnergy()-33,40    
## [415] fBodyAccJerk-bandsEnergy()-41,48    
## [416] fBodyAccJerk-bandsEnergy()-49,56    
## [417] fBodyAccJerk-bandsEnergy()-57,64    
## [418] fBodyAccJerk-bandsEnergy()-1,16     
## [419] fBodyAccJerk-bandsEnergy()-17,32    
## [420] fBodyAccJerk-bandsEnergy()-33,48    
## [421] fBodyAccJerk-bandsEnergy()-49,64    
## [422] fBodyAccJerk-bandsEnergy()-1,24     
## [423] fBodyAccJerk-bandsEnergy()-25,48    
## [424] fBodyGyro-mean()-X                  
## [425] fBodyGyro-mean()-Y                  
## [426] fBodyGyro-mean()-Z                  
## [427] fBodyGyro-std()-X                   
## [428] fBodyGyro-std()-Y                   
## [429] fBodyGyro-std()-Z                   
## [430] fBodyGyro-mad()-X                   
## [431] fBodyGyro-mad()-Y                   
## [432] fBodyGyro-mad()-Z                   
## [433] fBodyGyro-max()-X                   
## [434] fBodyGyro-max()-Y                   
## [435] fBodyGyro-max()-Z                   
## [436] fBodyGyro-min()-X                   
## [437] fBodyGyro-min()-Y                   
## [438] fBodyGyro-min()-Z                   
## [439] fBodyGyro-sma()                     
## [440] fBodyGyro-energy()-X                
## [441] fBodyGyro-energy()-Y                
## [442] fBodyGyro-energy()-Z                
## [443] fBodyGyro-iqr()-X                   
## [444] fBodyGyro-iqr()-Y                   
## [445] fBodyGyro-iqr()-Z                   
## [446] fBodyGyro-entropy()-X               
## [447] fBodyGyro-entropy()-Y               
## [448] fBodyGyro-entropy()-Z               
## [449] fBodyGyro-maxInds-X                 
## [450] fBodyGyro-maxInds-Y                 
## [451] fBodyGyro-maxInds-Z                 
## [452] fBodyGyro-meanFreq()-X              
## [453] fBodyGyro-meanFreq()-Y              
## [454] fBodyGyro-meanFreq()-Z              
## [455] fBodyGyro-skewness()-X              
## [456] fBodyGyro-kurtosis()-X              
## [457] fBodyGyro-skewness()-Y              
## [458] fBodyGyro-kurtosis()-Y              
## [459] fBodyGyro-skewness()-Z              
## [460] fBodyGyro-kurtosis()-Z              
## [461] fBodyGyro-bandsEnergy()-1,8         
## [462] fBodyGyro-bandsEnergy()-9,16        
## [463] fBodyGyro-bandsEnergy()-17,24       
## [464] fBodyGyro-bandsEnergy()-25,32       
## [465] fBodyGyro-bandsEnergy()-33,40       
## [466] fBodyGyro-bandsEnergy()-41,48       
## [467] fBodyGyro-bandsEnergy()-49,56       
## [468] fBodyGyro-bandsEnergy()-57,64       
## [469] fBodyGyro-bandsEnergy()-1,16        
## [470] fBodyGyro-bandsEnergy()-17,32       
## [471] fBodyGyro-bandsEnergy()-33,48       
## [472] fBodyGyro-bandsEnergy()-49,64       
## [473] fBodyGyro-bandsEnergy()-1,24        
## [474] fBodyGyro-bandsEnergy()-25,48       
## [475] fBodyGyro-bandsEnergy()-1,8         
## [476] fBodyGyro-bandsEnergy()-9,16        
## [477] fBodyGyro-bandsEnergy()-17,24       
## [478] fBodyGyro-bandsEnergy()-25,32       
## [479] fBodyGyro-bandsEnergy()-33,40       
## [480] fBodyGyro-bandsEnergy()-41,48       
## [481] fBodyGyro-bandsEnergy()-49,56       
## [482] fBodyGyro-bandsEnergy()-57,64       
## [483] fBodyGyro-bandsEnergy()-1,16        
## [484] fBodyGyro-bandsEnergy()-17,32       
## [485] fBodyGyro-bandsEnergy()-33,48       
## [486] fBodyGyro-bandsEnergy()-49,64       
## [487] fBodyGyro-bandsEnergy()-1,24        
## [488] fBodyGyro-bandsEnergy()-25,48       
## [489] fBodyGyro-bandsEnergy()-1,8         
## [490] fBodyGyro-bandsEnergy()-9,16        
## [491] fBodyGyro-bandsEnergy()-17,24       
## [492] fBodyGyro-bandsEnergy()-25,32       
## [493] fBodyGyro-bandsEnergy()-33,40       
## [494] fBodyGyro-bandsEnergy()-41,48       
## [495] fBodyGyro-bandsEnergy()-49,56       
## [496] fBodyGyro-bandsEnergy()-57,64       
## [497] fBodyGyro-bandsEnergy()-1,16        
## [498] fBodyGyro-bandsEnergy()-17,32       
## [499] fBodyGyro-bandsEnergy()-33,48       
## [500] fBodyGyro-bandsEnergy()-49,64       
## [501] fBodyGyro-bandsEnergy()-1,24        
## [502] fBodyGyro-bandsEnergy()-25,48       
## [503] fBodyAccMag-mean()                  
## [504] fBodyAccMag-std()                   
## [505] fBodyAccMag-mad()                   
## [506] fBodyAccMag-max()                   
## [507] fBodyAccMag-min()                   
## [508] fBodyAccMag-sma()                   
## [509] fBodyAccMag-energy()                
## [510] fBodyAccMag-iqr()                   
## [511] fBodyAccMag-entropy()               
## [512] fBodyAccMag-maxInds                 
## [513] fBodyAccMag-meanFreq()              
## [514] fBodyAccMag-skewness()              
## [515] fBodyAccMag-kurtosis()              
## [516] fBodyBodyAccJerkMag-mean()          
## [517] fBodyBodyAccJerkMag-std()           
## [518] fBodyBodyAccJerkMag-mad()           
## [519] fBodyBodyAccJerkMag-max()           
## [520] fBodyBodyAccJerkMag-min()           
## [521] fBodyBodyAccJerkMag-sma()           
## [522] fBodyBodyAccJerkMag-energy()        
## [523] fBodyBodyAccJerkMag-iqr()           
## [524] fBodyBodyAccJerkMag-entropy()       
## [525] fBodyBodyAccJerkMag-maxInds         
## [526] fBodyBodyAccJerkMag-meanFreq()      
## [527] fBodyBodyAccJerkMag-skewness()      
## [528] fBodyBodyAccJerkMag-kurtosis()      
## [529] fBodyBodyGyroMag-mean()             
## [530] fBodyBodyGyroMag-std()              
## [531] fBodyBodyGyroMag-mad()              
## [532] fBodyBodyGyroMag-max()              
## [533] fBodyBodyGyroMag-min()              
## [534] fBodyBodyGyroMag-sma()              
## [535] fBodyBodyGyroMag-energy()           
## [536] fBodyBodyGyroMag-iqr()              
## [537] fBodyBodyGyroMag-entropy()          
## [538] fBodyBodyGyroMag-maxInds            
## [539] fBodyBodyGyroMag-meanFreq()         
## [540] fBodyBodyGyroMag-skewness()         
## [541] fBodyBodyGyroMag-kurtosis()         
## [542] fBodyBodyGyroJerkMag-mean()         
## [543] fBodyBodyGyroJerkMag-std()          
## [544] fBodyBodyGyroJerkMag-mad()          
## [545] fBodyBodyGyroJerkMag-max()          
## [546] fBodyBodyGyroJerkMag-min()          
## [547] fBodyBodyGyroJerkMag-sma()          
## [548] fBodyBodyGyroJerkMag-energy()       
## [549] fBodyBodyGyroJerkMag-iqr()          
## [550] fBodyBodyGyroJerkMag-entropy()      
## [551] fBodyBodyGyroJerkMag-maxInds        
## [552] fBodyBodyGyroJerkMag-meanFreq()     
## [553] fBodyBodyGyroJerkMag-skewness()     
## [554] fBodyBodyGyroJerkMag-kurtosis()     
## [555] angle(tBodyAccMean,gravity)         
## [556] angle(tBodyAccJerkMean),gravityMean)
## [557] angle(tBodyGyroMean,gravityMean)    
## [558] angle(tBodyGyroJerkMean,gravityMean)
## [559] angle(X,gravityMean)                
## [560] angle(Y,gravityMean)                
## [561] angle(Z,gravityMean)                
## 477 Levels: angle(tBodyAccJerkMean),gravityMean) ...
```
### Let's never do that again
That is a whole lot of names and not very clear what it all means.  Luckily for this
project the data set will be reduced down to a smaller size.  To do this the
`grepl` funcition will be used to search for text strings that contain either
`"mean("` or `"std("` to account for the open parenthesis "\\(" had to be used.
The following code selects all rows and only the column with the mean or 
standard deviation for a reading.


```r
dat <- dat[ , grepl("mean\\(|std\\(", features$V2)]
```

The new data set contians 66 variables and is 10299 rows.  This can be seen by
using the `dim()` funciton.  We can also run `names(dat)` to see the list of 
column names has been greatly reduced.


```r
dim(dat)
```

```
## [1] 10299    66
```

```r
names(dat)
```

```
##  [1] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"          
##  [3] "tBodyAcc-mean()-Z"           "tBodyAcc-std()-X"           
##  [5] "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
##  [7] "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"       
##  [9] "tGravityAcc-mean()-Z"        "tGravityAcc-std()-X"        
## [11] "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
## [13] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"      
## [15] "tBodyAccJerk-mean()-Z"       "tBodyAccJerk-std()-X"       
## [17] "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
## [19] "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"         
## [21] "tBodyGyro-mean()-Z"          "tBodyGyro-std()-X"          
## [23] "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
## [25] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"     
## [27] "tBodyGyroJerk-mean()-Z"      "tBodyGyroJerk-std()-X"      
## [29] "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
## [31] "tBodyAccMag-mean()"          "tBodyAccMag-std()"          
## [33] "tGravityAccMag-mean()"       "tGravityAccMag-std()"       
## [35] "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
## [37] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"         
## [39] "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"     
## [41] "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
## [43] "fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"           
## [45] "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"           
## [47] "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
## [49] "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"       
## [51] "fBodyAccJerk-std()-Y"        "fBodyAccJerk-std()-Z"       
## [53] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
## [55] "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"          
## [57] "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"          
## [59] "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
## [61] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"  
## [63] "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroMag-std()"     
## [65] "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()"
```

### 3. Uses descriptive activity names to name the activities in the data set

Like before the code will read in labels for activities from activity_labels.txt
Then the next line will rename the columns to latter match with other data.  The
third line of code will join the data frame `activ` and `act_labels` together.
`inner_join` fom `dplyr` will find the common variable `activitynum` and join on
it for both data frames.


```r
act_labels <- tbl_df(read.table("./UCI HAR Dataset/activity_labels.txt"))
act_labels <- rename(act_labels, activitynum = V1, activityname = V2)
activ <- inner_join(activ, act_labels)  
```

```
## Joining by: "activitynum"
```

Might as well put it all together at this point.  The next line of code
combines the columns of `subj`, `activ`, and `dat` into one data set `dat`.

```r
dat <- bind_cols(subj, activ, dat)
```

### 4. Appropriately labels the data set with descriptive variable names. 

To make the names tidy the code will remove parenthesis and change from hyphens
to underscores.  Also to make the names more readable underscores will also be 
added were appropriate.  All names will be made lower case for easier data 
manipulation later.  The `names` and `gsub` functions will be used find and 
replace the text strings in the code below for the following substitutions.

* "f" will be turned to "frequency"
* "t" will be turned to "time"
* "Acc" to "acceleration""
* "Gyro" to "angular_velocity""
* "Mag"" to "magnitude""
* "BodyBody"" to "body"
* "Body" to "body""
* "std" to "standard_deviation"

`names(dat)` will be re-run to see the change in readablity of the names.


```r
names(dat)<-gsub("yG", "y_G", names(dat))
names(dat)<-gsub("yA", "y_A", names(dat))
names(dat)<-gsub("cJ", "c_j", names(dat))
names(dat)<-gsub("oJ", "o_j", names(dat))
names(dat)<-gsub("cM", "c_M", names(dat))
names(dat)<-gsub("oM", "o_M", names(dat))
names(dat)<-gsub("kM", "k_M", names(dat))
names(dat)<-gsub("-", "_", names(dat))
names(dat)<-gsub("std\\(\\)", "standard_deviation", names(dat))
names(dat)<-gsub("mean\\(\\)", "mean", names(dat))
names(dat)<-gsub("^t", "time_", names(dat))
names(dat)<-gsub("^f", "frequency_", names(dat))
names(dat)<-gsub("Acc", "acceleration", names(dat))
names(dat)<-gsub("Gyro", "angular_velocity", names(dat))
names(dat)<-gsub("Mag", "magnitude", names(dat))
names(dat)<-gsub("BodyBody", "body", names(dat))
names(dat)<-gsub("Body", "body", names(dat))
names(dat)<-gsub("G", "g", names(dat))
names(dat)<-gsub("X", "x", names(dat))
names(dat)<-gsub("Y", "y", names(dat))
names(dat)<-gsub("Z", "z", names(dat))
names(dat)
```

```
##  [1] "subject"                                                          
##  [2] "activitynum"                                                      
##  [3] "activityname"                                                     
##  [4] "time_body_acceleration_mean_x"                                    
##  [5] "time_body_acceleration_mean_y"                                    
##  [6] "time_body_acceleration_mean_z"                                    
##  [7] "time_body_acceleration_standard_deviation_x"                      
##  [8] "time_body_acceleration_standard_deviation_y"                      
##  [9] "time_body_acceleration_standard_deviation_z"                      
## [10] "time_gravity_acceleration_mean_x"                                 
## [11] "time_gravity_acceleration_mean_y"                                 
## [12] "time_gravity_acceleration_mean_z"                                 
## [13] "time_gravity_acceleration_standard_deviation_x"                   
## [14] "time_gravity_acceleration_standard_deviation_y"                   
## [15] "time_gravity_acceleration_standard_deviation_z"                   
## [16] "time_body_acceleration_jerk_mean_x"                               
## [17] "time_body_acceleration_jerk_mean_y"                               
## [18] "time_body_acceleration_jerk_mean_z"                               
## [19] "time_body_acceleration_jerk_standard_deviation_x"                 
## [20] "time_body_acceleration_jerk_standard_deviation_y"                 
## [21] "time_body_acceleration_jerk_standard_deviation_z"                 
## [22] "time_body_angular_velocity_mean_x"                                
## [23] "time_body_angular_velocity_mean_y"                                
## [24] "time_body_angular_velocity_mean_z"                                
## [25] "time_body_angular_velocity_standard_deviation_x"                  
## [26] "time_body_angular_velocity_standard_deviation_y"                  
## [27] "time_body_angular_velocity_standard_deviation_z"                  
## [28] "time_body_angular_velocity_jerk_mean_x"                           
## [29] "time_body_angular_velocity_jerk_mean_y"                           
## [30] "time_body_angular_velocity_jerk_mean_z"                           
## [31] "time_body_angular_velocity_jerk_standard_deviation_x"             
## [32] "time_body_angular_velocity_jerk_standard_deviation_y"             
## [33] "time_body_angular_velocity_jerk_standard_deviation_z"             
## [34] "time_body_acceleration_magnitude_mean"                            
## [35] "time_body_acceleration_magnitude_standard_deviation"              
## [36] "time_gravity_acceleration_magnitude_mean"                         
## [37] "time_gravity_acceleration_magnitude_standard_deviation"           
## [38] "time_body_acceleration_jerk_magnitude_mean"                       
## [39] "time_body_acceleration_jerk_magnitude_standard_deviation"         
## [40] "time_body_angular_velocity_magnitude_mean"                        
## [41] "time_body_angular_velocity_magnitude_standard_deviation"          
## [42] "time_body_angular_velocity_jerk_magnitude_mean"                   
## [43] "time_body_angular_velocity_jerk_magnitude_standard_deviation"     
## [44] "frequency_body_acceleration_mean_x"                               
## [45] "frequency_body_acceleration_mean_y"                               
## [46] "frequency_body_acceleration_mean_z"                               
## [47] "frequency_body_acceleration_standard_deviation_x"                 
## [48] "frequency_body_acceleration_standard_deviation_y"                 
## [49] "frequency_body_acceleration_standard_deviation_z"                 
## [50] "frequency_body_acceleration_jerk_mean_x"                          
## [51] "frequency_body_acceleration_jerk_mean_y"                          
## [52] "frequency_body_acceleration_jerk_mean_z"                          
## [53] "frequency_body_acceleration_jerk_standard_deviation_x"            
## [54] "frequency_body_acceleration_jerk_standard_deviation_y"            
## [55] "frequency_body_acceleration_jerk_standard_deviation_z"            
## [56] "frequency_body_angular_velocity_mean_x"                           
## [57] "frequency_body_angular_velocity_mean_y"                           
## [58] "frequency_body_angular_velocity_mean_z"                           
## [59] "frequency_body_angular_velocity_standard_deviation_x"             
## [60] "frequency_body_angular_velocity_standard_deviation_y"             
## [61] "frequency_body_angular_velocity_standard_deviation_z"             
## [62] "frequency_body_acceleration_magnitude_mean"                       
## [63] "frequency_body_acceleration_magnitude_standard_deviation"         
## [64] "frequency_body_acceleration_jerk_magnitude_mean"                  
## [65] "frequency_body_acceleration_jerk_magnitude_standard_deviation"    
## [66] "frequency_body_angular_velocity_magnitude_mean"                   
## [67] "frequency_body_angular_velocity_magnitude_standard_deviation"     
## [68] "frequency_body_angular_velocity_jerk_magnitude_mean"              
## [69] "frequency_body_angular_velocity_jerk_magnitude_standard_deviation"
```

### 5. From the data set in step 4, creates a second, independent tidy data set with 
### the average of each variable for each activity and each subject.

Using the `dplyr` library again, the following code witl `selecet` all of the 
columns except `activitynum`, `group_by` each `subject` and the name for each
activity(`activityname`), then it will `summarize_each` variable column by its 
`mean` except the `group_by` columns.  The new variable `tidy` is now the tidy
data set.  After running `dim` on tidy we see that now the data is 180 row by 68
colums.   We will give a quick `glimpse` of `tidy also to see how the data
looks.


```r
tidy <- dat %>%
        select (-activitynum) %>%
        group_by(subject, activityname) %>%
        summarize_each(funs(mean))

dim(tidy)
```

```
## [1] 180  68
```

```r
glimpse(tidy)
```

```
## Observations: 180
## Variables: 68
## $ subject                                                           (int) ...
## $ activityname                                                      (fctr) ...
## $ time_body_acceleration_mean_x                                     (dbl) ...
## $ time_body_acceleration_mean_y                                     (dbl) ...
## $ time_body_acceleration_mean_z                                     (dbl) ...
## $ time_body_acceleration_standard_deviation_x                       (dbl) ...
## $ time_body_acceleration_standard_deviation_y                       (dbl) ...
## $ time_body_acceleration_standard_deviation_z                       (dbl) ...
## $ time_gravity_acceleration_mean_x                                  (dbl) ...
## $ time_gravity_acceleration_mean_y                                  (dbl) ...
## $ time_gravity_acceleration_mean_z                                  (dbl) ...
## $ time_gravity_acceleration_standard_deviation_x                    (dbl) ...
## $ time_gravity_acceleration_standard_deviation_y                    (dbl) ...
## $ time_gravity_acceleration_standard_deviation_z                    (dbl) ...
## $ time_body_acceleration_jerk_mean_x                                (dbl) ...
## $ time_body_acceleration_jerk_mean_y                                (dbl) ...
## $ time_body_acceleration_jerk_mean_z                                (dbl) ...
## $ time_body_acceleration_jerk_standard_deviation_x                  (dbl) ...
## $ time_body_acceleration_jerk_standard_deviation_y                  (dbl) ...
## $ time_body_acceleration_jerk_standard_deviation_z                  (dbl) ...
## $ time_body_angular_velocity_mean_x                                 (dbl) ...
## $ time_body_angular_velocity_mean_y                                 (dbl) ...
## $ time_body_angular_velocity_mean_z                                 (dbl) ...
## $ time_body_angular_velocity_standard_deviation_x                   (dbl) ...
## $ time_body_angular_velocity_standard_deviation_y                   (dbl) ...
## $ time_body_angular_velocity_standard_deviation_z                   (dbl) ...
## $ time_body_angular_velocity_jerk_mean_x                            (dbl) ...
## $ time_body_angular_velocity_jerk_mean_y                            (dbl) ...
## $ time_body_angular_velocity_jerk_mean_z                            (dbl) ...
## $ time_body_angular_velocity_jerk_standard_deviation_x              (dbl) ...
## $ time_body_angular_velocity_jerk_standard_deviation_y              (dbl) ...
## $ time_body_angular_velocity_jerk_standard_deviation_z              (dbl) ...
## $ time_body_acceleration_magnitude_mean                             (dbl) ...
## $ time_body_acceleration_magnitude_standard_deviation               (dbl) ...
## $ time_gravity_acceleration_magnitude_mean                          (dbl) ...
## $ time_gravity_acceleration_magnitude_standard_deviation            (dbl) ...
## $ time_body_acceleration_jerk_magnitude_mean                        (dbl) ...
## $ time_body_acceleration_jerk_magnitude_standard_deviation          (dbl) ...
## $ time_body_angular_velocity_magnitude_mean                         (dbl) ...
## $ time_body_angular_velocity_magnitude_standard_deviation           (dbl) ...
## $ time_body_angular_velocity_jerk_magnitude_mean                    (dbl) ...
## $ time_body_angular_velocity_jerk_magnitude_standard_deviation      (dbl) ...
## $ frequency_body_acceleration_mean_x                                (dbl) ...
## $ frequency_body_acceleration_mean_y                                (dbl) ...
## $ frequency_body_acceleration_mean_z                                (dbl) ...
## $ frequency_body_acceleration_standard_deviation_x                  (dbl) ...
## $ frequency_body_acceleration_standard_deviation_y                  (dbl) ...
## $ frequency_body_acceleration_standard_deviation_z                  (dbl) ...
## $ frequency_body_acceleration_jerk_mean_x                           (dbl) ...
## $ frequency_body_acceleration_jerk_mean_y                           (dbl) ...
## $ frequency_body_acceleration_jerk_mean_z                           (dbl) ...
## $ frequency_body_acceleration_jerk_standard_deviation_x             (dbl) ...
## $ frequency_body_acceleration_jerk_standard_deviation_y             (dbl) ...
## $ frequency_body_acceleration_jerk_standard_deviation_z             (dbl) ...
## $ frequency_body_angular_velocity_mean_x                            (dbl) ...
## $ frequency_body_angular_velocity_mean_y                            (dbl) ...
## $ frequency_body_angular_velocity_mean_z                            (dbl) ...
## $ frequency_body_angular_velocity_standard_deviation_x              (dbl) ...
## $ frequency_body_angular_velocity_standard_deviation_y              (dbl) ...
## $ frequency_body_angular_velocity_standard_deviation_z              (dbl) ...
## $ frequency_body_acceleration_magnitude_mean                        (dbl) ...
## $ frequency_body_acceleration_magnitude_standard_deviation          (dbl) ...
## $ frequency_body_acceleration_jerk_magnitude_mean                   (dbl) ...
## $ frequency_body_acceleration_jerk_magnitude_standard_deviation     (dbl) ...
## $ frequency_body_angular_velocity_magnitude_mean                    (dbl) ...
## $ frequency_body_angular_velocity_magnitude_standard_deviation      (dbl) ...
## $ frequency_body_angular_velocity_jerk_magnitude_mean               (dbl) ...
## $ frequency_body_angular_velocity_jerk_magnitude_standard_deviation (dbl) ...
```

This works out well.  30 subjects times 6 activites equals 180 observations.
The final data set has column for subject, activityname, and 66 other variables
totaling 68 columns.

Finally the `write.table` function is use to write `tidy` out to a file in the
current directory called 'tidy_averages.txt' to indicate the output is the mean
of the data.  We will give a quick `glimpse` of `tidy also to see how the data
looks.


```r
write.table(tidy, "tidy_averages.txt", row.name=FALSE)
```



























