install.packages("hunspell")
library(hunspell)

getwd()
setwd("C:/Users/harsh/Downloads")
data <- read.csv("Covid19.csv", header = TRUE, sep = ",")
df <- as.data.frame(data)
df

#########################all columns empty#################################

df_all_null <- df[grepl("^\\s*$", df$Country.Region), ]
df_remaining <- df[!grepl("^\\s*$", df$Country.Region), ]


all_cols_empty <- data.frame(
  ID = df_all_null$ID,                                   # ID of the rows with misspelled words
  Column = rep("All Columns empty",length(df_all_null$ID)),                 # Column name (here it's "Words")
  Description = rep("All columns are empty",length(df_all_null$ID))  # Description of the issue
)


#########################Country 

misspelled <- !hunspell_check(df_remaining[[3]])
misspelled

misspelled_count <- sum(misspelled)
misspelled_count

#df_remaining[[3]][misspelled]  # Returns misspelled words

result <- data.frame(
  ID = df_remaining$ID[misspelled],                                   # ID of the rows with misspelled words
  Column = rep("Country", sum(misspelled)),                 # Column name (here it's "Words")
  Description = rep("Incorrect spelling", sum(misspelled))  # Description of the issue
)
result

total_rows <- nrow(result)
total_rows


###################### WHO Region

# Filtering out 3 regions since hunspell package is considering as incorrect region names
df_filtered <- df_remaining[!df_remaining$WHO.Region %in% c("Eastern Mediterranean", "Western Pacific", "South-East Asia"), ]

misspelled1 <- !hunspell_check(df_filtered[[11]])
misspelled1

misspelled_count1 <- sum(misspelled1)
misspelled_count1

#df_remaining[[11]][misspelled1]  # Returns misspelled words


result_WHO <- data.frame(
  ID = df_filtered$ID[misspelled1],  # IDs of misspelled words in 'ColumnB'
  Column = rep("WHO", sum(misspelled1)),  # Column name 'ColumnB'
  Description = rep("Incorrect spelling", sum(misspelled1))  # Description for 'ColumnB'
)
result_WHO


total_rows_WHO <- nrow(result_WHO)
total_rows_WHO

###############################Latitude

# Function to check if the latitude value is valid (allows negative values)
is_valid_latitude <- function(x) {
  # Check if the value contains any alphabet or special character (except negative sign and decimal point)
  valid_format <- grepl("^-?([0-9]+\\.?[0-9]*|[0-9]*\\.[0-9]+)$", x)  # Matches valid decimal number, allowing for negative
  
  # If it's a valid format, check the range for valid latitude (-90 to 90)
  if (valid_format) {
    # Convert to numeric and check if within valid latitude range (-90 to 90)
    lat_val <- as.numeric(x)
    return(lat_val >= -90 & lat_val <= 90)  # Check if within valid latitude range
  }
  
  # Return FALSE if not a valid format
  return(FALSE)
}


# Check if latitude values are valid
valid_latitude <- sapply(df_remaining[[4]], is_valid_latitude)

# Create result data frame for invalid latitudes
invalid_latitude <- data.frame(
  ID = df_remaining$ID[!valid_latitude],  # IDs of rows with invalid latitude values
  Column = rep("Latitude", sum(!valid_latitude)),  # Column name
  Description = rep("Incorrect latitude", sum(!valid_latitude))  # Description for invalid latitudes
)

# View the invalid latitude data
print(invalid_latitude)

total_rows_lat <- nrow(invalid_latitude)
total_rows_lat[1]


##########################Logitude

# Function to check if the Logitude value is valid (allows negative values)
is_valid_longitude <- function(x) {
  # Check if the value contains any alphabet or special character (except negative sign and decimal point)
  valid_format <- grepl("^-?([0-9]+\\.?[0-9]*|[0-9]*\\.[0-9]+)$", x)  # Matches valid decimal number, allowing for negative
  
  # If it's a valid format, check the range for valid longitude (-180 to 180)
  if (valid_format) {
    # Convert to numeric and check if within valid longitude range (-180 to 180)
    long_val <- as.numeric(x)
    return(long_val >= -180 & long_val <= 180)  # Check if within valid longitude range
  }
  
  # Return FALSE if not a valid format
  return(FALSE)
}


# Check if longitudes values are valid
valid_longitude <- sapply(df_remaining[[5]], is_valid_longitude)

# Create result data frame for invalid longitudes
invalid_longitude <- data.frame(
  ID = df_remaining$ID[!valid_longitude],  # IDs of rows with invalid longitudes values
  Column = rep("Longitude", sum(!valid_longitude)),  # Column name
  Description = rep("Incorrect longitudes", sum(!valid_longitude))  # Description for invalid longitudes
)

# View the invalid longitudes data
print(invalid_longitude)

total_rows_long <- nrow(invalid_longitude)
total_rows_long

############################ Date

# Function to check if the date value is valid (allows only digits and slashes)
is_valid_date <- function(x) {
  # Check if the value contains only digits and slashes (valid date format)
  valid_format <- grepl("^[0-9/]+$", x)  # Valid if only digits and slashes
  
  # Return TRUE if valid format, FALSE if invalid
  return(valid_format)
}

# Check date values in the 6th column (Date column)
valid_date <- sapply(df_remaining[[6]], is_valid_date)

# Create result data frame for invalid dates
invalid_date <- data.frame(
  ID = df_remaining$ID[!valid_date],  # IDs of rows with invalid date values
  Column = rep("Date", sum(!valid_date)),  # Column name
  Description = rep("Incorrect date", sum(!valid_date))  # Description for invalid dates
)

# View the invalid date data
print(invalid_date)
total_rows_invaliddate <- nrow(invalid_date)
total_rows_invaliddate


#######################################Confirmed

# Function to check if the confirmed value is a valid positive integer (including 0)
is_valid_confirmed <- function(x) {
  # Check if the value is a valid positive integer (0 or any positive integer)
  valid_format <- grepl("^[0-9]+$", x)  # Valid if it's a non-negative integer, no decimal, no alphabets
  
  # Return TRUE if valid format, FALSE if invalid
  return(valid_format)
}

# Check confirmed values in the 7th column (Confirmed column)
valid_confirmed <- sapply(df_remaining[[7]], is_valid_confirmed)

# Create result data frame for invalid confirmed values
invalid_confirmed <- data.frame(
  ID = df_remaining$ID[!valid_confirmed],  # IDs of rows with invalid confirmed values
  Column = rep("Confirmed", sum(!valid_confirmed)),  # Column name
  Description = rep("Incorrect confirmed value", sum(!valid_confirmed))  # Description for invalid confirmed values
)

# View the invalid confirmed data
print(invalid_confirmed)
total_rows_CONF <- nrow(invalid_confirmed)
total_rows_CONF


#########################################Deaths


# Function to check if the death value is a valid positive integer (including 0)
is_valid_deaths <- function(x) {
  # Check if the value is a valid positive integer (0 or any positive integer)
  valid_format <- grepl("^[0-9]+$", x)  # Valid if it's a non-negative integer, no decimal, no alphabets
  
  # Return TRUE if valid format, FALSE if invalid
  return(valid_format)
}

# Check death values in the 8th column (death column)
valid_deaths <- sapply(df_remaining[[8]], is_valid_deaths)

# Create result data frame for invalid death values
invalid_deaths <- data.frame(
  ID = df_remaining$ID[!valid_deaths],  # IDs of rows with invalid death values
  Column = rep("Deaths", sum(!valid_deaths)),  # Column name
  Description = rep("Incorrect Death value", sum(!valid_deaths))  # Description for invalid death values
)

# View the invalid death data
print(invalid_deaths)
total_rows_death <- nrow(invalid_deaths)
total_rows_death




######################################Recovered


# Function to check if the Recovered value is a valid positive integer (including 0)
is_valid_recovered <- function(x) {
  # Check if the value is a valid positive integer (0 or any positive integer)
  valid_format <- grepl("^[0-9]+$", x)  # Valid if it's a non-negative integer, no decimal, no alphabets
  
  # Return TRUE if valid format, FALSE if invalid
  return(valid_format)
}

# Check Recovered values in the 9th column (Recovered column)
valid_recovered <- sapply(df_remaining[[9]], is_valid_recovered)

# Create result data frame for invalid Recovered values
invalid_recovered <- data.frame(
  ID = df_remaining$ID[!valid_recovered],  # IDs of rows with invalid Recovered values
  Column = rep("Recovered", sum(!valid_recovered)),  # Column name
  Description = rep("Incorrect Recovered value", sum(!valid_recovered))  # Description for invalid Recovered values
)

# View the invalid Recovered data
print(invalid_recovered)
total_rows_recovered <- nrow(invalid_recovered)
total_rows_recovered




################################################Active


# Function to check if the Active value is a valid positive integer (including 0)
is_valid_active <- function(x) {
  # Check if the value is a valid positive integer (0 or any positive integer)
  valid_format <- grepl("^[0-9]+$", x)  # Valid if it's a non-negative integer, no decimal, no alphabets
  
  # Return TRUE if valid format, FALSE if invalid
  return(valid_format)
}

# Check Active values in the 10th column (Active column)
valid_active <- sapply(df_remaining[[10]], is_valid_active)

# Create result data frame for invalid Active values
invalid_active <- data.frame(
  ID = df_remaining$ID[!valid_active],  # IDs of rows with invalid Active values
  Column = rep("Active", sum(!valid_active)),  # Column name
  Description = rep("Incorrect Active value", sum(!valid_active))  # Description for invalid Active values
)

# View the invalid Active data
print(invalid_active)
total_rows_active <- nrow(invalid_active)
total_rows_active



##############################


# Combine the results into a single data frame
final_result <- rbind(all_cols_empty, result, result_WHO, invalid_latitude, invalid_longitude, invalid_date, invalid_confirmed, invalid_deaths, invalid_recovered, invalid_active
)

# View the final result
print(final_result)
total_rows_final <- nrow(final_result)
total_rows_final



#################coverting dataframe to csv file

write.csv(final_result, "PollutedRows.csv", row.names = FALSE)

