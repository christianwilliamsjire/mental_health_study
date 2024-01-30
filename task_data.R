#load the readxl library used to read Excel files
library(readxl)

#function reads the data from the Excel file and stores it in a data frame named task_data
task_data <- read_excel("C:/Users/chris/Downloads/task_data.xlsx")

#function is used to open a data frame in a viewer pane
View(task_data)

#tidyverse is a package that helps users transform and present data
install.packages("tidyverse")

#Load the tidyverse library which installs packages used for data import, tidying, manipulation, and visualization
library(tidyverse)

#this function shows a preview of the data frame 
head(task_data)

#this function shows the structure of the data frame
str(task_data)

#this function shows the column names of the data fame
colnames(task_data)

#this packages make it easier to clean up data
install.packages("here")

library("here")
install.packages("skimr")

library("skimr")
install.packages("janitor")

library("janitor")
install.packages("dplyr")

library("dplyr")

#this function provides a summary of a data set
skim_without_charts(task_data)

# this function makes it possible to see every column in a data frame
glimpse(task_data)

#This code renames the columns in the data frame to make them more uniform and easier to work with
task_data <- task_data %>%
  rename(
    time = Time,
    study_id = Study_ID,
    condition = Condition,
    PHQ_1 = `1.\tLittle interest or pleasure in doing things?`,
    PHQ_2 = `2.\tFeeling sad, depressed or hopeless?`,
    PHQ_3 = `3.\tTrouble falling or staying asleep, or sleeping too much?`,
    PHQ_4 = `4.\tFeeling tired or having little energy?`,
    PHQ_5 = `5.\tPoor appetite or eating too much (overeating)?`,
    PHQ_6 = `6.\tFeeling bad about yourself – or that you are a failure or have let yourself or your family down?`,
    PHQ_7 = `7.\tTrouble concentrating on things, such as reading a book?`,
    PHQ_8 = `8.\tMoving or speaking so slowly that other people could have noticed. Or the opposite — being so energetic or nervous that you have been moving around a lot more than usual?`,
    GAD_1 = `1.\tFeeling nervous, anxious, restless, or uneasy?`,
    GAD_2 = `2.\tNot being able to stop or control worrying about things?`,
    GAD_3 = `3.\tWorrying too much about different things?`,
    GAD_4 = `4.\tTrouble relaxing?`,
    GAD_5 = `5.\tBeing so restless or uneasy that it's hard to sit still?`,
    GAD_6 = `6.\tBecoming easily annoyed or irritable?`,
    GAD_7  = `7.\tFeeling afraid as if something bad might happen?`,
    age = Age,
    form = Form,
    gender = Gender
  )


#This code transforms the answers to their numeric counterpart to easily work with them
# List of columns to transform
columns_to_transform <- c("PHQ_1", "PHQ_2",
                          "PHQ_3", "PHQ_4",
                          "PHQ_5", "PHQ_6", "PHQ_7",
                          "PHQ_8", "GAD_1", "GAD_2",
                          "GAD_3", "GAD_4", "GAD_5",
                          "GAD_6", "GAD_7")

# Recode values in specified columns
task_data <- task_data %>%
  mutate_at(vars(matches(columns_to_transform)), ~recode(., 
                                                         "Not at all" = 0,
                                                         "Several days (between Over half the days (more than 7 days)  and 7 days)" = 1,
                                                         "Over half the days (more than 7 days)" = 2,
                                                         "Nearly/almost every day" = 3))


head(task_data)

#this code checks if there are any null values in the dataframe
# Checking for null values in the entire dataset
any_nulls <- any(is.na(task_data))
if (any_nulls) {
  cat("There are null values in the dataset.\n")
} else {
  cat("There are no null values in the dataset.\n")
}

# Checking for null values in each column
null_counts <- colSums(is.na(task_data))
print(null_counts)

glimpse(task_data)

# install.packages("ggplot2")
library(ggplot2)

install.packages("reshape2")

library("reshape2")



#This code is for calculating and plotting data to measure for depression for students 
# List of columns
columns_to_sum <- c("PHQ_1", "PHQ_2", "PHQ_3", "PHQ_4", "PHQ_5", "PHQ_6", "PHQ_7", "PHQ_8")

# Summing up values for each student
task_data$depression_measure <- rowSums(task_data[, columns_to_sum])

str(task_data)

# Remove null values
task_data <- na.omit(task_data)

# Categorize depression_measure values
task_data$depression_category <- cut(task_data$depression_measure,
                                             breaks = c(-Inf, 10, 15, 20, 24),
                                             labels = c("Mild", "Moderate", "Moderately Severe", "Severe"),
                                             include.lowest = TRUE)

# Define colors for each category
category_colors <- c("#8B5F99", "#A74FA7", "#AD6FCC", "#D4A6FF")

# Plotting a bar chart with different colors
barplot(table(task_data$depression_category),
        main = "Depression Measure for All Students",
        xlab = "Depression Category",
        ylab = "Number of Students",
        col = category_colors,
        legend.text = TRUE)

# Plotting a bar chart comparing male and female students
barplot(table(task_data$depression_category, task_data$gender),
        main = "Depression Measure by Gender",
        xlab = "Depression Category",
        ylab = "Number of Students",
        col = c("#8B5F99", "#A74FA7", "#AD6FCC", "#D4A6FF"),
        legend.text = TRUE,
        beside = TRUE)

# Plotting a stacked bar chart comparing baseline and endpoint
barplot(table(task_data$time, task_data$depression_category),
        main = "Depression Measure by Time Points at which Survey Was Taken",
        xlab = "Time",
        ylab = "Number of Students",
        col = c("purple", "darkblue"),
        legend.text = TRUE,
        beside = FALSE)

# Define colors for each form
form_colors <- c("#8B5F99", "#A74FA7", "#AD6FCC", "#D4A6FF")  # Adjust colors as needed

# Plotting a stacked bar chart comparing Form 1, Form 2, and Form 3
barplot(table(task_data$depression_category, task_data$form),
        main = "Depression Measure by Form",
        xlab = "Depression Category",
        ylab = "Number of Students",
        col = form_colors,
        legend.text = TRUE,
        args.legend = list(x = "topright", bty = "n", inset = c(0, -0.1)),
        beside = FALSE)

# Plotting a stacked bar chart comparing Condition in which Survey was Taken
barplot(table(task_data$condition, task_data$depression_category),
        main = "Depression Measure by Condition in which Survey was Taken",
        xlab = "Condition",
        ylab = "Number of Students",
        col = c("purple", "darkblue"),
        legend.text = TRUE,
        beside = FALSE)

# Plotting a stacked bar chart comparing depression for different ages
barplot(table(task_data$age, task_data$depression_category),
        main = "Depression Measure by Ages of Students",
        xlab = "Age",
        ylab = "Number of Students",
        col = c("purple", "darkblue", "lightblue", "lightgreen", "orange", "darkred"),
        legend.text = TRUE,
        beside = FALSE)

#end of depression measure code


#This code is for calculating and plotting data to measure for Anxiety for students
# List of columns for anxiety scores
anxiety_columns <- c("GAD_1", "GAD_2", "GAD_3", "GAD_4", "GAD_5", "GAD_6", "GAD_7")

# Summing up values for each student and creating a new column
task_data$anxiety_measure <- rowSums(task_data[, anxiety_columns])

# Remove null values
task_data <- na.omit(task_data)

# Define the anxiety measure categories
task_data$anxiety_categories <- cut(task_data$anxiety_measure,
                          breaks = c(-Inf, 10, 15, 21),
                          labels = c("Mild", "Moderate", "Severe"),
                          include.lowest = TRUE)

# Plotting a bar chart for Anxiety Measure
barplot(table(task_data$anxiety_categories),
        main = "Anxiety Measure for Students",
        xlab = "Anxiety Category",
        ylab = "Number of Students",
        col = c("lightblue", "lightgreen", "darkred"),
        legend.text = TRUE)

str(task_data)

# Plotting a bar chart comparing male and female students
barplot(table(task_data$anxiety_categories, task_data$gender),
        main = "Anxiety Measure by Gender",
        xlab = "Anxiety Category",
        ylab = "Number of Students",
        col = c("lightblue", "lightgreen", "darkred"),
        legend.text = TRUE,
        beside = TRUE)

# Plotting a stacked bar chart comparing baseline and endpoint
barplot(table(task_data$time, task_data$anxiety_categories),
        main = "Anxiety Measure by Time Points at which Survey Was Taken",
        xlab = "Time",
        ylab = "Number of Students",
        col = c("purple", "darkblue"),
        legend.text = TRUE,
        beside = FALSE)

# Define colors for each form
form_colors <- c("lightblue", "lightgreen", "darkred")  # Adjust colors as needed

# Plotting a stacked bar chart comparing Form 1, Form 2, and Form 3
barplot(table(task_data$anxiety_categories, task_data$form),
        main = "Anxiety Measure by Form",
        xlab = "Anxiety Category",
        ylab = "Number of Students",
        col = form_colors,
        legend.text = TRUE,
        args.legend = list(x = "topright", bty = "n", inset = c(0, -0.1)),
        beside = FALSE)

# Plotting a stacked bar chart comparing Condition in which Survey was Taken
barplot(table(task_data$condition, task_data$anxiety_categories),
        main = "Anxiety Measure by Condition in which Survey was Taken",
        xlab = "Condition",
        ylab = "Number of Students",
        col = c("purple", "darkblue"),
        legend.text = TRUE,
        beside = FALSE)

# Plotting a stacked bar chart comparing anxiety for different ages
barplot(table(task_data$age, task_data$anxiety_categories),
        main = "Anxiety Measure by Ages of Students",
        xlab = "Age",
        ylab = "Number of Students",
        col = c("purple", "darkblue", "lightblue", "lightgreen", "orange", "darkred"),
        legend.text = TRUE,
        beside = FALSE)

#end of anxiety measure code

write.csv(task_data, "D:\\Data Analytics Projects\\Mental Health Study\\Greyson task\\task_data.csv", row.names=FALSE)