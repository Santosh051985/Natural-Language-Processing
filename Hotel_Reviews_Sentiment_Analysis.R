# Import All required Library for use the functions to perform calculation
library(dplyr)
library(readr)
library(lubridate)
library(ggplot2)
library(tidytext)
library(tidyverse)
library(stringr)
library(tidyr)
library(scales)
library(broom)
library(purrr)
library(widyr)
library(igraph)
library(ggraph)
library(SnowballC)
library(wordcloud)
library(reshape2)
theme_set(theme_minimal())
df <- read_csv("C:/Users/HP/Desktop/hilton-hawaiian-village/Hilton_Hawaiian_Village_Waikiki_Beach_Resort-Honolulu_Oahu_Hawaii__en.csv")
df <- df[complete.cases(df), ]
# Convert Date Format from " 1 April 2202" to 2002-04-01"
df$review_date <- as.Date(df$review_date, format = "%d-%b-%y")
# Display Min means initial Review Date, Max represent Last Review Date
dim(df); min(df$review_date); max(df$review_date)

# Visualize the Review data per Week
df %>%
  count(Week = round_date(review_date, "week")) %>%
  ggplot(aes(Week, n)) +
  geom_line() + 
  ggtitle('The Number of Reviews Per Week')
