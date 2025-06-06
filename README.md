# Data-Cleaning-Dataset
Using the "Healthcare Insurance" dataset from Kaggle, perform 10 operations in R to clean the data, perform operations on the data, and create visualizations of the data.

Link: https://www.kaggle.com/datasets/willianoliveiragibin/healthcare-insurance/data

# Description:
The selected dataset was taken from Kaggle.com. The dataset is called, “Healthcare Insurance,” and it is a csv file consisting of 7 columns and 1339 rows. The 7 columns are: Age, sex, BMI, children, smoker, and region. While “age,” “bmi”, “children”, and “charges” are numerical, “sex,” “smoker,” and “region” are categorical values. The “age” column lists the insured person’s age. The “sex” column lists the gender (male/female) of the insured individual. The “bmi” (Body Mass Index) column lists the measure of body fat based on height and weight. The “children” column lists the number of dependents covered. The “smoker” column lists whether the insured is a smoker (yes/no). The “region” column lists the geographic area of coverage (southwest/southeast, northwest, northeast). The “charges” column lists the medical insurance costs incurred by the insured person. 

List of 10 Operations:
1.	Randomly selected 150 rows and creating/exporting new csv 
2.	Finding R^2 (linear relationship) between bmi and charges and plotting the linear regression 
3.	Create data frame containing only the BMI column in each region stated in the column, “Region,” ie. southwest, southeast, northwest, northeast and create a histogram
4.	Calculate average charges and max/min charges for each region from the reduced data and visualize the regional disparities (region vs charges) in a bar plot
5.	Create bins that categorize the BMI and calculate average charges for each category with original dataset 
6.	Find standard deviation of the charges for each category and visualize the charges with the BMI bins
7.	Calculate average charges between smokers and nonsmokers in the original dataset vs reduced dataset 
8.	Find outliers in the dataset for bmi and charges group by plotting them as a boxplot
9.	Find average charges of all smokers (yes) who are male from the original vs reduced data set
10.	Find average charges of individuals with <23 BMI in each of the four regions from the reduced dataset and create a bar plot with a legend to visualize this.

The output of the 10 operations can be found in output_file.pdf.
