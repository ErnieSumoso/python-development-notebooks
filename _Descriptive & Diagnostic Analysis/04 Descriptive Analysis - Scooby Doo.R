### Scooby Dataset - Descriptive Analysis ###
##################  Nov 7  ####################

# library to read csv files
  install.packages('readr')
  library('readr')

# read dataset from csv
  df <- read.csv("scooby-dataset.csv")
  
View(df)
names(df)
str(df)
library("dplyr")

# display: rows, cols, cols, types, & unique values
  glimpse(df)
# calculate mean from numeric col
  mean(df$run.time)
# calculate mean from categorical col with missing values
  df$imdb <- as.double(df$imdb) # convert col data type
  mean(df$imdb, na.rm = TRUE) # calculate mean removing (na.rm) missing values
# (same in 1 line)
  mean(as.double(df$imdb), na.rm = TRUE)

names(df)

# select some cols into new dataframe
  scooby <- df %>% 
    select(series.name : format) # select range of cols first:last both inclusive

dim(scooby)
names(scooby)
str(scooby)
# dataset without duplicates or unique vals of col
  unique(scooby)
  unique(scooby$network)

# scatterplot (2 vars)
library("ggplot2")
ggplot(scooby, aes(x=date.aired, y=imdb)) + 
  geom_point() + 
  labs(x="Date Aired", y="IMDB")

unique(scooby$format)

# scatterplot with colors (3 vars)
ggplot(scooby, aes(x=date.aired, y=imdb, color = format)) +
  geom_point() + 
  labs(x="Date Aired", y="IMDB")

# library for more colors
install.packages("RColorBrewer")
library("RColorBrewer")
display.brewer.all() # display all color palettes

# scatterplot with colors (3 vars) using palette
ggplot(scooby, aes(x=date.aired, y=imdb, color = format)) +
  geom_point() + 
  scale_color_brewer(palette = "Dark2")
  labs(x="Date Aired", y="IMDB")
  
##################  Nov 14  ####################
  table(scooby$format)
  library(dplyr)
  
# filter complete rows with specific val on col
  scooby_crossover <- filter(scooby, format == 'Crossover')
  
  View(scooby_crossover)
  str(scooby)
  
# Drop rows (into new dataframe) to have only episodes rows (drop crossovers and movies)
  scooby_epi <- scooby %>% 
                filter(format != "Crossover",
                       format != "Movie",
                       format != "Movie (Theatrical)")
  dim(scooby_epi) # 549 * 9, down from 603 * 9
  View(scooby_epi)
  colnames(scooby_epi)
  table(scooby_epi$format)

# save & display only rows with TV Series (segmented)
  segmented_epi <- scooby_epi %>% 
                    filter(format == "TV Series (segmented)")
  dim(segmented_epi)
  View(segmented_epi)
  
# Collapse/Group TV Series (Segmented) rows into unique instances
# because these values mean 1 episode split into multiple parts, thus the IMDB rating will be affected
  segmented_epi <- scooby_epi %>% 
                    filter(format == "TV Series (segmented)") %>%   # 175 rows
                    group_by(date.aired) %>% 
                    summarise(imdb = mean(imdb),
                              network = unique(network),
                              series.name = unique(series.name),
                              total_runtime_per_epi = sum(run.time))
  dim(segmented_epi) # 75 rows down from 175
  View(segmented_epi)

# Create a nonsegmented_epi dataframe with same columns as segmented_epi
  nonsegmented_epi <- scooby_epi %>% 
                    filter(format != "TV Series (segmented)") %>%   # 374 rows
                    select(date.aired, imdb, network, series.name, total_runtime_per_epi = run.time)
  dim(nonsegmented_epi)
  View(nonsegmented_epi)
  
# Merge both dataframes segmented_epi and nonsegmented_epi
  scooby_cleaned <- rbind(segmented_epi, nonsegmented_epi)
  dim(scooby_cleaned)
  View(scooby_cleaned)
  
# Re-create visualization:
  ggplot(scooby_cleaned, aes(x=date.aired, y=imdb, color=network)) +
    geom_point() + 
    scale_color_brewer(palette = "Dark2")
  labs(x="Date Aired", y="IMDB")

# Reduce clutter along the x-axis labels
  str(scooby_cleaned) # date.aired is chr data-type
  scooby_cleaned$date.aired_2 <- as.Date(scooby_cleaned$date.aired, format="%Y-%m-%d")
  dim(scooby_cleaned)
  
  # check that date.aired_2 does not have null values
  colSums(!is.na(scooby_cleaned))

  # check the min-max values of date.aired_2
  range(scooby_cleaned$date.aired_2)
  
  # plot without clutter
  ggplot(scooby_cleaned, aes(x=date.aired_2, y=imdb, color=network)) +
    geom_point() + 
    scale_color_brewer(palette = "Dark2") +
    scale_x_date(breaks = seq(as.Date("1969-09-13"), as.Date("2021-02-25"),
                              by = "5 years"),
                 date_labels = "%b %Y")
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
      
  
  