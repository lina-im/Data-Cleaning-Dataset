#import file
df <- read.csv("C:/Users/User/OneDrive/Documents/Desktop/miniproject1.csv")
df <- as.data.frame(df)

#randomly select 150 rows (roughly 11% of original dataset)
set.seed(100)
sample <- df[sample(1:nrow(df), 150), ]
#export as new csv, use this new set for rest of the operations
write.csv(sample,"C:/Users/User/OneDrive/Documents/Desktop/miniprojectsample.csv", row.names = FALSE)

#find linear relationship between bmi, charges using the sampled csv
linearreg <- lm(bmi ~ charges, data = sample)
rsquared <- summary(linearreg)$r.squared
#plot the linear regression
plot(linearreg$residuals, pch = 16, col = "red")
abline(linearreg, col = "red", lwd = 2)
text(50, 15, paste("R^2 Value: ", round(rsquared, 2)), col = "blue", cex = 1.2)


#dataframe containing just bmi in southwest region 
dfsw <- subset(sample, region == "southwest", select = c(bmi, region))
#histogram visualizing to compare smokers and charges
hist(dfsw$bmi, main = "BMI of Southwest Region", xlab = "BMI", col = "blue", border = "black")
#dataframe containing just bmi in southeast region
dfse <- subset(sample, region == "southeast", select = c(bmi, region))
hist(dfse$bmi, main = "BMI of Southeast Region", xlab = "BMI", col = "blue", border = "black")
#dataframe containing just bmi in northwest region
dfnw <- subset(sample, region == "northwest", select = c(bmi, region))
hist(dfnw$bmi, main = "BMI of Northwest Region", xlab = "BMI", col = "blue", border = "black")
#dataframe containing just bmi in northeast region
dfne <- subset(sample, region == "northeast", select = c(bmi, region))
hist(dfne$bmi, main = "BMI of Northeast Region", xlab = "BMI", col = "blue", border = "black")


#calculate average charges for each region and find the max/min charges for each region using the max and min function
avg <- aggregate(charges ~ region, data = sample, FUN = mean)
maxmin <- aggregate(charges ~ region, data = sample, function(x) c(max = max(x), min = min(x)))
cat("Max/Min charge ($) for each region: \n")
print(maxmin)
cat("Average charges ($) for each region: \n")
print(avg)
#visualize barplot to understand regional disparities for region vs charge
barplot(avg$charges, names.arg = avg$region, xlab = "Regions", ylab = "Average Charges in $", main = "Regional Disparities", col = "blue", border = "black")


#create BMI categories and calculate avg charges for each category
#use cut() to divide bmi column into bins
df$bmicategories <- cut(df$bmi, breaks = c(0, 18.5, 24.9, 29.9, 34.9, 39.9, Inf), labels = c("Underweight", "Normal", "Overweight", "Obese I", "Obese II", "Obese III"))
avgcharge <- aggregate(charges ~ bmicategories, data = df, FUN = mean)
cat("Average Charge ($) for Each BMI Category: \n")
print(avgcharge)


#find standard deviation for each category 
sdcharge <- aggregate(charges ~ bmicategories, data = df, FUN = sd)
#visualize the above into a barchart
barplot(avgcharge$charges, names.arg = avgcharge$bmicategories, xlab = "BMI Categories", ylab = "Average Charges in $", main = "BMI vs Avg Charges $", col = "blue", border = "black")
#create dataframe of the standard deviation values for each category 
result <- data.frame(
  BMICategories = avgcharge$bmicategories,
  SDCharges = sdcharge$charges
)
cat("Standard Deviation for Each BMI Category: \n")
print(result)

#avg number of (non)smokers from original dataset
avgoriginal <- aggregate(charges ~ smoker, data = df, mean)
#avg number of (non)smokers from reduced dataset
avgsample <- aggregate(charges ~ smoker, data = sample, mean)
cat("Average Charges ($) of (non)smokers from original dataset: \n")
print(avgoriginal)
cat("Average Charges ($) of (non)smokers from sample dataset: \n")
print(avgsample)


#find outliers in BMI and charges
boxplot(sample$bmi, main = "BMI Outliers", col = "blue")
summary <- boxplot.stats(sample$bmi)
cat("Outliers in BMI: \n")
#get outliers from the summary stats
print(summary$out)
boxplot(sample$charges, main = "Charges Outliers", col = "red")
summary <- boxplot.stats(sample$charges)
cat("Outliers in Charges: \n")
print(summary$out)


#find avg charges of all smokers (yes) who are male from the original dataset
msmoker <- subset(df, smoker == "yes" & sex == "male")
#compute avg charges from that group
avgoriginal <- mean(msmoker$charges)
#find avg charges of all smokers (yes) who are male from the reduced dataset
msmoker2 <- subset(sample, smoker == "yes" & sex == "male")
#compute avg charges from that group
avgsample <- mean(msmoker2$charges)
cat("Average charges ($) of all smokers who are male from original dataset \n")
print(avgoriginal)
cat("Average charges ($) of all smokers who are male from sample dataset \n")
print(avgsample)


#find avg charges of bmi <23 in southeast region from the reduced dataset
bmiSE <- subset(sample, bmi < 23 & region == "southeast")
avgBmiSe <- mean(bmiSE$charges)
#find avg charges of bmi <23 in southwest region from the reduced dataset
bmiSW <- subset(sample, bmi < 23 & region == "southwest")
avgBmiSw <- mean(bmiSW$charges)
#find avg charges of bmi <23 in northeast region from the reduced dataset
bmiNE <- subset(sample, bmi < 23 & region == "northeast")
avgBmiNe <- mean(bmiNE$charges)
#find avg charges of bmi <23 in northwest region from the reduced dataset
bmiNW <- subset(sample, bmi < 23 & region == "northwest")
avgBmiNw <- mean(bmiNW$charges)
cat("Average charges ($) of BMI <23 in southeast region from reduced dataset: \n")
print(avgBmiSe)
cat("Average charges ($) of BMI <23 in southwest region from reduced dataset: \n")
print(avgBmiSw)
cat("Average charges ($) of BMI <23 in northeast region from reduced dataset: \n")
print(avgBmiNe)
cat("Average charges ($) of BMI <23 in northwest region from reduced dataset: \n")
print(avgBmiNw)
#create a barchart with colors and legends with the information
barplot(
  c(avgBmiSe, avgBmiSw, avgBmiNe, avgBmiNw),
  names.arg = c("southeast", "southwest", "northeast", "northwest"),
  col = c("red", "blue", "green", "orange"),
  main = "Average Charges from Individuals w/ < 23 BMI in Regions: SE, SW, NE, NW",
  xlab = "Regions",
  ylab = "Average Charges ($) of Individuals w <23 BMI",
)
#add a legend for the barchart
legend("bottomleft", legend = c("southeast", "southwest", "northeast", "northwest"), fill = c("red", "blue", "green", "orange"), title = "Regions")