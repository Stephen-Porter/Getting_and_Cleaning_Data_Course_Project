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
Quoted from the readme.txt file from the data set,
"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details."" [1]

###Notes on the original (raw) data 
The original raw data came from 6 different files.  Training and test data for
the subjects, the activities, and the actual sensor data.  Each of these file
is read into R and combined into a single dataset.

Here is a link to teh viedo of one of the subjects performing the 6 activiies
from the collection of raw data:
http://www.youtube.com/watch?v=XOEN9W05_4A


##Creating the tidy datafile

###Guide to create the tidy data file
* 1. Download the data
* 2. Unzip the data
* 3. Read in test and training sets for the subjects, activities, and data, and feature names
* 4. Subset out the data to only include the columns with mean and standard deviation 
* 5. Assign the activity names to the data
* 6. Combine all the data sets together
* 7. Make the names for variables readable and meaningful
* 8. Break down the data buy each subject, activity, and find the mean
* 9. Output the data

###Cleaning of the data
The main cleaning of the data after combining the data was really working with 
the names to make them easier to read using string manipulation function to 
change and/or replace names and characters. 
[readme document that describes the code in greater detail](https://github.com/Stephen-Porter/Getting_and_Cleaning_Data_Course_Project/blob/master/README.md)

##Description of the variables in the tiny_averages.txt file


General description of the file including:
 
 - Dimensions of the dataset

```
## [1] 180  68
```
 - Summary of the data

```
##     subject                 activityname time_body_acceleration_mean_x
##  Min.   : 1.0   LAYING            :30    Min.   :0.2216               
##  1st Qu.: 8.0   SITTING           :30    1st Qu.:0.2712               
##  Median :15.5   STANDING          :30    Median :0.2770               
##  Mean   :15.5   WALKING           :30    Mean   :0.2743               
##  3rd Qu.:23.0   WALKING_DOWNSTAIRS:30    3rd Qu.:0.2800               
##  Max.   :30.0   WALKING_UPSTAIRS  :30    Max.   :0.3015               
##  time_body_acceleration_mean_y time_body_acceleration_mean_z
##  Min.   :-0.040514             Min.   :-0.15251             
##  1st Qu.:-0.020022             1st Qu.:-0.11207             
##  Median :-0.017262             Median :-0.10819             
##  Mean   :-0.017876             Mean   :-0.10916             
##  3rd Qu.:-0.014936             3rd Qu.:-0.10443             
##  Max.   :-0.001308             Max.   :-0.07538             
##  time_body_acceleration_standard_deviation_x
##  Min.   :-0.9961                            
##  1st Qu.:-0.9799                            
##  Median :-0.7526                            
##  Mean   :-0.5577                            
##  3rd Qu.:-0.1984                            
##  Max.   : 0.6269                            
##  time_body_acceleration_standard_deviation_y
##  Min.   :-0.99024                           
##  1st Qu.:-0.94205                           
##  Median :-0.50897                           
##  Mean   :-0.46046                           
##  3rd Qu.:-0.03077                           
##  Max.   : 0.61694                           
##  time_body_acceleration_standard_deviation_z
##  Min.   :-0.9877                            
##  1st Qu.:-0.9498                            
##  Median :-0.6518                            
##  Mean   :-0.5756                            
##  3rd Qu.:-0.2306                            
##  Max.   : 0.6090                            
##  time_gravity_acceleration_mean_x time_gravity_acceleration_mean_y
##  Min.   :-0.6800                  Min.   :-0.47989                
##  1st Qu.: 0.8376                  1st Qu.:-0.23319                
##  Median : 0.9208                  Median :-0.12782                
##  Mean   : 0.6975                  Mean   :-0.01621                
##  3rd Qu.: 0.9425                  3rd Qu.: 0.08773                
##  Max.   : 0.9745                  Max.   : 0.95659                
##  time_gravity_acceleration_mean_z
##  Min.   :-0.49509                
##  1st Qu.:-0.11726                
##  Median : 0.02384                
##  Mean   : 0.07413                
##  3rd Qu.: 0.14946                
##  Max.   : 0.95787                
##  time_gravity_acceleration_standard_deviation_x
##  Min.   :-0.9968                               
##  1st Qu.:-0.9825                               
##  Median :-0.9695                               
##  Mean   :-0.9638                               
##  3rd Qu.:-0.9509                               
##  Max.   :-0.8296                               
##  time_gravity_acceleration_standard_deviation_y
##  Min.   :-0.9942                               
##  1st Qu.:-0.9711                               
##  Median :-0.9590                               
##  Mean   :-0.9524                               
##  3rd Qu.:-0.9370                               
##  Max.   :-0.6436                               
##  time_gravity_acceleration_standard_deviation_z
##  Min.   :-0.9910                               
##  1st Qu.:-0.9605                               
##  Median :-0.9450                               
##  Mean   :-0.9364                               
##  3rd Qu.:-0.9180                               
##  Max.   :-0.6102                               
##  time_body_acceleration_jerk_mean_x time_body_acceleration_jerk_mean_y
##  Min.   :0.04269                    Min.   :-0.0386872                
##  1st Qu.:0.07396                    1st Qu.: 0.0004664                
##  Median :0.07640                    Median : 0.0094698                
##  Mean   :0.07947                    Mean   : 0.0075652                
##  3rd Qu.:0.08330                    3rd Qu.: 0.0134008                
##  Max.   :0.13019                    Max.   : 0.0568186                
##  time_body_acceleration_jerk_mean_z
##  Min.   :-0.067458                 
##  1st Qu.:-0.010601                 
##  Median :-0.003861                 
##  Mean   :-0.004953                 
##  3rd Qu.: 0.001958                 
##  Max.   : 0.038053                 
##  time_body_acceleration_jerk_standard_deviation_x
##  Min.   :-0.9946                                 
##  1st Qu.:-0.9832                                 
##  Median :-0.8104                                 
##  Mean   :-0.5949                                 
##  3rd Qu.:-0.2233                                 
##  Max.   : 0.5443                                 
##  time_body_acceleration_jerk_standard_deviation_y
##  Min.   :-0.9895                                 
##  1st Qu.:-0.9724                                 
##  Median :-0.7756                                 
##  Mean   :-0.5654                                 
##  3rd Qu.:-0.1483                                 
##  Max.   : 0.3553                                 
##  time_body_acceleration_jerk_standard_deviation_z
##  Min.   :-0.99329                                
##  1st Qu.:-0.98266                                
##  Median :-0.88366                                
##  Mean   :-0.73596                                
##  3rd Qu.:-0.51212                                
##  Max.   : 0.03102                                
##  time_body_angular_velocity_mean_x time_body_angular_velocity_mean_y
##  Min.   :-0.20578                  Min.   :-0.20421                 
##  1st Qu.:-0.04712                  1st Qu.:-0.08955                 
##  Median :-0.02871                  Median :-0.07318                 
##  Mean   :-0.03244                  Mean   :-0.07426                 
##  3rd Qu.:-0.01676                  3rd Qu.:-0.06113                 
##  Max.   : 0.19270                  Max.   : 0.02747                 
##  time_body_angular_velocity_mean_z
##  Min.   :-0.07245                 
##  1st Qu.: 0.07475                 
##  Median : 0.08512                 
##  Mean   : 0.08744                 
##  3rd Qu.: 0.10177                 
##  Max.   : 0.17910                 
##  time_body_angular_velocity_standard_deviation_x
##  Min.   :-0.9943                                
##  1st Qu.:-0.9735                                
##  Median :-0.7890                                
##  Mean   :-0.6916                                
##  3rd Qu.:-0.4414                                
##  Max.   : 0.2677                                
##  time_body_angular_velocity_standard_deviation_y
##  Min.   :-0.9942                                
##  1st Qu.:-0.9629                                
##  Median :-0.8017                                
##  Mean   :-0.6533                                
##  3rd Qu.:-0.4196                                
##  Max.   : 0.4765                                
##  time_body_angular_velocity_standard_deviation_z
##  Min.   :-0.9855                                
##  1st Qu.:-0.9609                                
##  Median :-0.8010                                
##  Mean   :-0.6164                                
##  3rd Qu.:-0.3106                                
##  Max.   : 0.5649                                
##  time_body_angular_velocity_jerk_mean_x
##  Min.   :-0.15721                      
##  1st Qu.:-0.10322                      
##  Median :-0.09868                      
##  Mean   :-0.09606                      
##  3rd Qu.:-0.09110                      
##  Max.   :-0.02209                      
##  time_body_angular_velocity_jerk_mean_y
##  Min.   :-0.07681                      
##  1st Qu.:-0.04552                      
##  Median :-0.04112                      
##  Mean   :-0.04269                      
##  3rd Qu.:-0.03842                      
##  Max.   :-0.01320                      
##  time_body_angular_velocity_jerk_mean_z
##  Min.   :-0.092500                     
##  1st Qu.:-0.061725                     
##  Median :-0.053430                     
##  Mean   :-0.054802                     
##  3rd Qu.:-0.048985                     
##  Max.   :-0.006941                     
##  time_body_angular_velocity_jerk_standard_deviation_x
##  Min.   :-0.9965                                     
##  1st Qu.:-0.9800                                     
##  Median :-0.8396                                     
##  Mean   :-0.7036                                     
##  3rd Qu.:-0.4629                                     
##  Max.   : 0.1791                                     
##  time_body_angular_velocity_jerk_standard_deviation_y
##  Min.   :-0.9971                                     
##  1st Qu.:-0.9832                                     
##  Median :-0.8942                                     
##  Mean   :-0.7636                                     
##  3rd Qu.:-0.5861                                     
##  Max.   : 0.2959                                     
##  time_body_angular_velocity_jerk_standard_deviation_z
##  Min.   :-0.9954                                     
##  1st Qu.:-0.9848                                     
##  Median :-0.8610                                     
##  Mean   :-0.7096                                     
##  3rd Qu.:-0.4741                                     
##  Max.   : 0.1932                                     
##  time_body_acceleration_magnitude_mean
##  Min.   :-0.9865                      
##  1st Qu.:-0.9573                      
##  Median :-0.4829                      
##  Mean   :-0.4973                      
##  3rd Qu.:-0.0919                      
##  Max.   : 0.6446                      
##  time_body_acceleration_magnitude_standard_deviation
##  Min.   :-0.9865                                    
##  1st Qu.:-0.9430                                    
##  Median :-0.6074                                    
##  Mean   :-0.5439                                    
##  3rd Qu.:-0.2090                                    
##  Max.   : 0.4284                                    
##  time_gravity_acceleration_magnitude_mean
##  Min.   :-0.9865                         
##  1st Qu.:-0.9573                         
##  Median :-0.4829                         
##  Mean   :-0.4973                         
##  3rd Qu.:-0.0919                         
##  Max.   : 0.6446                         
##  time_gravity_acceleration_magnitude_standard_deviation
##  Min.   :-0.9865                                       
##  1st Qu.:-0.9430                                       
##  Median :-0.6074                                       
##  Mean   :-0.5439                                       
##  3rd Qu.:-0.2090                                       
##  Max.   : 0.4284                                       
##  time_body_acceleration_jerk_magnitude_mean
##  Min.   :-0.9928                           
##  1st Qu.:-0.9807                           
##  Median :-0.8168                           
##  Mean   :-0.6079                           
##  3rd Qu.:-0.2456                           
##  Max.   : 0.4345                           
##  time_body_acceleration_jerk_magnitude_standard_deviation
##  Min.   :-0.9946                                         
##  1st Qu.:-0.9765                                         
##  Median :-0.8014                                         
##  Mean   :-0.5842                                         
##  3rd Qu.:-0.2173                                         
##  Max.   : 0.4506                                         
##  time_body_angular_velocity_magnitude_mean
##  Min.   :-0.9807                          
##  1st Qu.:-0.9461                          
##  Median :-0.6551                          
##  Mean   :-0.5652                          
##  3rd Qu.:-0.2159                          
##  Max.   : 0.4180                          
##  time_body_angular_velocity_magnitude_standard_deviation
##  Min.   :-0.9814                                        
##  1st Qu.:-0.9476                                        
##  Median :-0.7420                                        
##  Mean   :-0.6304                                        
##  3rd Qu.:-0.3602                                        
##  Max.   : 0.3000                                        
##  time_body_angular_velocity_jerk_magnitude_mean
##  Min.   :-0.99732                              
##  1st Qu.:-0.98515                              
##  Median :-0.86479                              
##  Mean   :-0.73637                              
##  3rd Qu.:-0.51186                              
##  Max.   : 0.08758                              
##  time_body_angular_velocity_jerk_magnitude_standard_deviation
##  Min.   :-0.9977                                             
##  1st Qu.:-0.9805                                             
##  Median :-0.8809                                             
##  Mean   :-0.7550                                             
##  3rd Qu.:-0.5767                                             
##  Max.   : 0.2502                                             
##  frequency_body_acceleration_mean_x frequency_body_acceleration_mean_y
##  Min.   :-0.9952                    Min.   :-0.98903                  
##  1st Qu.:-0.9787                    1st Qu.:-0.95361                  
##  Median :-0.7691                    Median :-0.59498                  
##  Mean   :-0.5758                    Mean   :-0.48873                  
##  3rd Qu.:-0.2174                    3rd Qu.:-0.06341                  
##  Max.   : 0.5370                    Max.   : 0.52419                  
##  frequency_body_acceleration_mean_z
##  Min.   :-0.9895                   
##  1st Qu.:-0.9619                   
##  Median :-0.7236                   
##  Mean   :-0.6297                   
##  3rd Qu.:-0.3183                   
##  Max.   : 0.2807                   
##  frequency_body_acceleration_standard_deviation_x
##  Min.   :-0.9966                                 
##  1st Qu.:-0.9820                                 
##  Median :-0.7470                                 
##  Mean   :-0.5522                                 
##  3rd Qu.:-0.1966                                 
##  Max.   : 0.6585                                 
##  frequency_body_acceleration_standard_deviation_y
##  Min.   :-0.99068                                
##  1st Qu.:-0.94042                                
##  Median :-0.51338                                
##  Mean   :-0.48148                                
##  3rd Qu.:-0.07913                                
##  Max.   : 0.56019                                
##  frequency_body_acceleration_standard_deviation_z
##  Min.   :-0.9872                                 
##  1st Qu.:-0.9459                                 
##  Median :-0.6441                                 
##  Mean   :-0.5824                                 
##  3rd Qu.:-0.2655                                 
##  Max.   : 0.6871                                 
##  frequency_body_acceleration_jerk_mean_x
##  Min.   :-0.9946                        
##  1st Qu.:-0.9828                        
##  Median :-0.8126                        
##  Mean   :-0.6139                        
##  3rd Qu.:-0.2820                        
##  Max.   : 0.4743                        
##  frequency_body_acceleration_jerk_mean_y
##  Min.   :-0.9894                        
##  1st Qu.:-0.9725                        
##  Median :-0.7817                        
##  Mean   :-0.5882                        
##  3rd Qu.:-0.1963                        
##  Max.   : 0.2767                        
##  frequency_body_acceleration_jerk_mean_z
##  Min.   :-0.9920                        
##  1st Qu.:-0.9796                        
##  Median :-0.8707                        
##  Mean   :-0.7144                        
##  3rd Qu.:-0.4697                        
##  Max.   : 0.1578                        
##  frequency_body_acceleration_jerk_standard_deviation_x
##  Min.   :-0.9951                                      
##  1st Qu.:-0.9847                                      
##  Median :-0.8254                                      
##  Mean   :-0.6121                                      
##  3rd Qu.:-0.2475                                      
##  Max.   : 0.4768                                      
##  frequency_body_acceleration_jerk_standard_deviation_y
##  Min.   :-0.9905                                      
##  1st Qu.:-0.9737                                      
##  Median :-0.7852                                      
##  Mean   :-0.5707                                      
##  3rd Qu.:-0.1685                                      
##  Max.   : 0.3498                                      
##  frequency_body_acceleration_jerk_standard_deviation_z
##  Min.   :-0.993108                                    
##  1st Qu.:-0.983747                                    
##  Median :-0.895121                                    
##  Mean   :-0.756489                                    
##  3rd Qu.:-0.543787                                    
##  Max.   :-0.006236                                    
##  frequency_body_angular_velocity_mean_x
##  Min.   :-0.9931                       
##  1st Qu.:-0.9697                       
##  Median :-0.7300                       
##  Mean   :-0.6367                       
##  3rd Qu.:-0.3387                       
##  Max.   : 0.4750                       
##  frequency_body_angular_velocity_mean_y
##  Min.   :-0.9940                       
##  1st Qu.:-0.9700                       
##  Median :-0.8141                       
##  Mean   :-0.6767                       
##  3rd Qu.:-0.4458                       
##  Max.   : 0.3288                       
##  frequency_body_angular_velocity_mean_z
##  Min.   :-0.9860                       
##  1st Qu.:-0.9624                       
##  Median :-0.7909                       
##  Mean   :-0.6044                       
##  3rd Qu.:-0.2635                       
##  Max.   : 0.4924                       
##  frequency_body_angular_velocity_standard_deviation_x
##  Min.   :-0.9947                                     
##  1st Qu.:-0.9750                                     
##  Median :-0.8086                                     
##  Mean   :-0.7110                                     
##  3rd Qu.:-0.4813                                     
##  Max.   : 0.1966                                     
##  frequency_body_angular_velocity_standard_deviation_y
##  Min.   :-0.9944                                     
##  1st Qu.:-0.9602                                     
##  Median :-0.7964                                     
##  Mean   :-0.6454                                     
##  3rd Qu.:-0.4154                                     
##  Max.   : 0.6462                                     
##  frequency_body_angular_velocity_standard_deviation_z
##  Min.   :-0.9867                                     
##  1st Qu.:-0.9643                                     
##  Median :-0.8224                                     
##  Mean   :-0.6577                                     
##  3rd Qu.:-0.3916                                     
##  Max.   : 0.5225                                     
##  frequency_body_acceleration_magnitude_mean
##  Min.   :-0.9868                           
##  1st Qu.:-0.9560                           
##  Median :-0.6703                           
##  Mean   :-0.5365                           
##  3rd Qu.:-0.1622                           
##  Max.   : 0.5866                           
##  frequency_body_acceleration_magnitude_standard_deviation
##  Min.   :-0.9876                                         
##  1st Qu.:-0.9452                                         
##  Median :-0.6513                                         
##  Mean   :-0.6210                                         
##  3rd Qu.:-0.3654                                         
##  Max.   : 0.1787                                         
##  frequency_body_acceleration_jerk_magnitude_mean
##  Min.   :-0.9940                                
##  1st Qu.:-0.9770                                
##  Median :-0.7940                                
##  Mean   :-0.5756                                
##  3rd Qu.:-0.1872                                
##  Max.   : 0.5384                                
##  frequency_body_acceleration_jerk_magnitude_standard_deviation
##  Min.   :-0.9944                                              
##  1st Qu.:-0.9752                                              
##  Median :-0.8126                                              
##  Mean   :-0.5992                                              
##  3rd Qu.:-0.2668                                              
##  Max.   : 0.3163                                              
##  frequency_body_angular_velocity_magnitude_mean
##  Min.   :-0.9865                               
##  1st Qu.:-0.9616                               
##  Median :-0.7657                               
##  Mean   :-0.6671                               
##  3rd Qu.:-0.4087                               
##  Max.   : 0.2040                               
##  frequency_body_angular_velocity_magnitude_standard_deviation
##  Min.   :-0.9815                                             
##  1st Qu.:-0.9488                                             
##  Median :-0.7727                                             
##  Mean   :-0.6723                                             
##  3rd Qu.:-0.4277                                             
##  Max.   : 0.2367                                             
##  frequency_body_angular_velocity_jerk_magnitude_mean
##  Min.   :-0.9976                                    
##  1st Qu.:-0.9813                                    
##  Median :-0.8779                                    
##  Mean   :-0.7564                                    
##  3rd Qu.:-0.5831                                    
##  Max.   : 0.1466                                    
##  frequency_body_angular_velocity_jerk_magnitude_standard_deviation
##  Min.   :-0.9976                                                  
##  1st Qu.:-0.9802                                                  
##  Median :-0.8941                                                  
##  Mean   :-0.7715                                                  
##  3rd Qu.:-0.6081                                                  
##  Max.   : 0.2878
```
 - Variables present in the dataset

```
##  [1] "subject"                                                          
##  [2] "activityname"                                                     
##  [3] "time_body_acceleration_mean_x"                                    
##  [4] "time_body_acceleration_mean_y"                                    
##  [5] "time_body_acceleration_mean_z"                                    
##  [6] "time_body_acceleration_standard_deviation_x"                      
##  [7] "time_body_acceleration_standard_deviation_y"                      
##  [8] "time_body_acceleration_standard_deviation_z"                      
##  [9] "time_gravity_acceleration_mean_x"                                 
## [10] "time_gravity_acceleration_mean_y"                                 
## [11] "time_gravity_acceleration_mean_z"                                 
## [12] "time_gravity_acceleration_standard_deviation_x"                   
## [13] "time_gravity_acceleration_standard_deviation_y"                   
## [14] "time_gravity_acceleration_standard_deviation_z"                   
## [15] "time_body_acceleration_jerk_mean_x"                               
## [16] "time_body_acceleration_jerk_mean_y"                               
## [17] "time_body_acceleration_jerk_mean_z"                               
## [18] "time_body_acceleration_jerk_standard_deviation_x"                 
## [19] "time_body_acceleration_jerk_standard_deviation_y"                 
## [20] "time_body_acceleration_jerk_standard_deviation_z"                 
## [21] "time_body_angular_velocity_mean_x"                                
## [22] "time_body_angular_velocity_mean_y"                                
## [23] "time_body_angular_velocity_mean_z"                                
## [24] "time_body_angular_velocity_standard_deviation_x"                  
## [25] "time_body_angular_velocity_standard_deviation_y"                  
## [26] "time_body_angular_velocity_standard_deviation_z"                  
## [27] "time_body_angular_velocity_jerk_mean_x"                           
## [28] "time_body_angular_velocity_jerk_mean_y"                           
## [29] "time_body_angular_velocity_jerk_mean_z"                           
## [30] "time_body_angular_velocity_jerk_standard_deviation_x"             
## [31] "time_body_angular_velocity_jerk_standard_deviation_y"             
## [32] "time_body_angular_velocity_jerk_standard_deviation_z"             
## [33] "time_body_acceleration_magnitude_mean"                            
## [34] "time_body_acceleration_magnitude_standard_deviation"              
## [35] "time_gravity_acceleration_magnitude_mean"                         
## [36] "time_gravity_acceleration_magnitude_standard_deviation"           
## [37] "time_body_acceleration_jerk_magnitude_mean"                       
## [38] "time_body_acceleration_jerk_magnitude_standard_deviation"         
## [39] "time_body_angular_velocity_magnitude_mean"                        
## [40] "time_body_angular_velocity_magnitude_standard_deviation"          
## [41] "time_body_angular_velocity_jerk_magnitude_mean"                   
## [42] "time_body_angular_velocity_jerk_magnitude_standard_deviation"     
## [43] "frequency_body_acceleration_mean_x"                               
## [44] "frequency_body_acceleration_mean_y"                               
## [45] "frequency_body_acceleration_mean_z"                               
## [46] "frequency_body_acceleration_standard_deviation_x"                 
## [47] "frequency_body_acceleration_standard_deviation_y"                 
## [48] "frequency_body_acceleration_standard_deviation_z"                 
## [49] "frequency_body_acceleration_jerk_mean_x"                          
## [50] "frequency_body_acceleration_jerk_mean_y"                          
## [51] "frequency_body_acceleration_jerk_mean_z"                          
## [52] "frequency_body_acceleration_jerk_standard_deviation_x"            
## [53] "frequency_body_acceleration_jerk_standard_deviation_y"            
## [54] "frequency_body_acceleration_jerk_standard_deviation_z"            
## [55] "frequency_body_angular_velocity_mean_x"                           
## [56] "frequency_body_angular_velocity_mean_y"                           
## [57] "frequency_body_angular_velocity_mean_z"                           
## [58] "frequency_body_angular_velocity_standard_deviation_x"             
## [59] "frequency_body_angular_velocity_standard_deviation_y"             
## [60] "frequency_body_angular_velocity_standard_deviation_z"             
## [61] "frequency_body_acceleration_magnitude_mean"                       
## [62] "frequency_body_acceleration_magnitude_standard_deviation"         
## [63] "frequency_body_acceleration_jerk_magnitude_mean"                  
## [64] "frequency_body_acceleration_jerk_magnitude_standard_deviation"    
## [65] "frequency_body_angular_velocity_magnitude_mean"                   
## [66] "frequency_body_angular_velocity_magnitude_standard_deviation"     
## [67] "frequency_body_angular_velocity_jerk_magnitude_mean"              
## [68] "frequency_body_angular_velocity_jerk_magnitude_standard_deviation"
```
## Description of variables

Of all of the variables listed above, the following 2 are unique

* "subject"

Interger value for each subject.  Class int, range 1 to 30.

* "activityname"

Factor value for each of the six activities, WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING

The rest of the varaiables names give descriptions of what each variable contains and are of the class double.

* Any time a variavle has x, y, or z on the end it relates to x,y, or z direction respectively.
* Any variable that begins "time" is in the time domain.
* Any variable that begins "frequency" is in the frequency domain produced from Fast Fourier Transform (FFT)
* Any that have "acceleration" and "mean" in them are in standard units of gravity 'g'.
* Any that contain "angular velocity" and "mean" have the units are radians/second. 
* Any that contain standard deviation do not have units.
* The body acceleration signal obtained by subtracting the gravity from the total acceleration.
* The body linear acceleration and angular velocity were derived in time to obtain "jerk' signals.

##Sources
Sources you used if any, otherise leave out.

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

##Annex
Unseen code used in this codebook

Loading the tidy_averages.txt file

```r
library(dplyr)
tidy  <- tbl_df(read.table("tidy_averages.txt", header = TRUE ))
```

Looking at the deminsions of the data

```r
dim(tidy)
```

Looking at a summary of the data

```r
summary(tidy)
```

Printing the names of all variables

```r
names(tidy)
```

