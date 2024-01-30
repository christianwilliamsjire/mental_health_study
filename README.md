# Project Title: Task Data Analysis

## Overview
This project involves the analysis of task data obtained from students to measure depression levels. The data is collected through a survey containing questions related to depressive symptoms and other demographic information. The goal is to process and analyze this data to gain insights into depression levels among students.

## Repository Structure
- **task_data.R**: This script contains the R code for loading, cleaning, transforming, and analyzing the task data.
- **README.md**: This file provides an overview of the project, instructions for running the R script, and other relevant information.

## Instructions
To run the analysis:
1. Ensure you have R installed on your machine.
2. Clone this repository to your local machine.
3. Open the `task_data.R` script in RStudio or any other R environment.
4. Run the script to execute the analysis.

## Data
The data is stored in an Excel file named `task_data.xlsx`. It includes columns for various survey questions related to depressive symptoms, as well as demographic information such as age, gender, and study ID.

## Analysis Steps
1. Load the necessary libraries, including `readxl`, `tidyverse`, `here`, `skimr`, `janitor`, `dplyr`, `ggplot2`, and `reshape2`.
2. Read the data from the Excel file using the `read_excel` function from the `readxl` library.
3. Explore the structure and summary statistics of the data using functions like `str`, `colnames`, `head`, `skim_without_charts`, and `glimpse`.
4. Clean and preprocess the data by renaming columns, transforming categorical responses into numeric values, and handling missing values.
5. Calculate a depression measure by summing up scores from relevant survey questions.
6. Categorize depression measures into distinct levels.
7. Visualize the data using plots to gain insights into depression levels among students.

## Results
The analysis provides insights into the depression levels among students based on the survey responses. Visualizations such as histograms or bar charts may be used to illustrate these findings.

## Conclusion
This project demonstrates how to analyze task data related to depressive symptoms among students. The insights gained from this analysis can be valuable for understanding mental health issues in educational settings and guiding intervention strategies.

For any questions or inquiries, please contact the project owner, Chris, at christianwilliamsjire@gmail.com.

