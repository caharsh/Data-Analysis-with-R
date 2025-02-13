# Data-Analysis-with-R

Problem Statement:
The provided dataset contains COVID-19-related data, but some of the entries are polluted, meaning they have inconsistencies such as missing data, incorrect formatting, outliers, and misspellings. The goal of this project is to identify and report as many polluted rows as possible. Polluted rows are defined as follows:
1.
Outliers or extreme values (e.g., for columns like latitude, longitude, and confirmed cases).
2.
Misspelled country names or region names.
3.
Rows with null or empty entries in certain columns.
4.
Data type inconsistencies, like mixing integers and decimals for columns that should contain only one type.
Data Understanding:
The dataset contains multiple columns:
•
Country/Region: The country or region where COVID-19 cases were reported.
•
Province/State: The province or state within the country.
•
WHO Region: The World Health Organization (WHO) region of the country.
•
Latitude and Longitude: Geographical coordinates.
•
Date: Date of the record.
•
Confirmed, Deaths, Recovered, Active: The number of confirmed cases, deaths, recoveries, and active cases.
Approach:
1.
Identify Rows with All Empty Columns: The first step is to identify rows where all columns are empty. These rows will be flagged as fully empty and reported with "All columns empty" in the description.
2.
Check for Misspelled Country Names: The hunspell package was used to identify misspelled country names. Entries that are misspelled are flagged, and their corresponding rows are reported with "Incorrect spelling" as the description.
3.
Filter for Valid WHO Regions: Since some WHO regions were incorrectly identified as "Eastern Mediterranean," "Western Pacific," or "South-East Asia," these were filtered out to ensure the remaining data contains valid WHO regions. Misspelled entries in the WHO region column were flagged.
4.
Validate Latitude and Longitude: Latitude values must lie between -90 and 90, and longitude values must lie between -180 and 180. Entries outside these valid ranges or that did not follow a valid format (e.g., containing letters or special characters) were flagged.
5.
Validate Date Format: Dates were validated to ensure they follow a valid format (only digits and slashes). Any rows with invalid date entries were flagged.
6.
Confirm Data Type Consistency for Case Counts: Columns such as Confirmed, Deaths, Recovered, and Active should contain valid non-negative integers. Any row with decimal or non-numeric values in these columns was flagged.
7.
Final Data Cleaning: After identifying and tagging all the polluted rows, the final dataset is consolidated. Each polluted row is recorded with its ID, the column containing the pollution, and a brief description of the issue.
Conclusion:
This project demonstrates how data pollution can be identified and cleaned using R. The final solution provided a CSV file containing the polluted rows, along with the respective columns and descriptions of the issues. This allows for easy identification and correction of data inconsistencies, enabling better data quality for analysis.
GitHub: The code for identifying and handling polluted rows in the dataset is available on GitHub. 
