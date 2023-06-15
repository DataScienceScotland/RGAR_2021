# Load libraries ----------------------------------------------------------
library(readxl)
library(tidyverse)
library(highcharter)
library(lubridate)
library(tidyr)
library(purrr)
library(dplyr)


# Define data paths -------------------------------------------------------
datasets <- plots <- list()

paths <- list(
  input_data = "data/NRS - 2 - Create - 2 - data - statistics.xlsx",
  input_text = "data/NRS - 2 - Create - 1 - data - text.xlsx"
)



# Theme for highcharts
hc_theme <- hc_theme(
  chart = list(style = list(fontFamily = windowsFont("Arial")),
               animation = F),
  xAxis = list(labels = list(style = list(fontSize = "18px")),
               title = list(style = list(fontSize = "18px")),
               tickLength = 0,
               lineColor = "transparent"),
  yAxis = list(labels = list(style = list(fontSize = "18px")),
               title = list(style = list(fontSize = "18px")),
               gridLineWidth = 0),
  legend = list(symbolWidth = 40,
                itemStyle = list(fontSize = "18px",
                                 fontStyle = "normal",
                                 fontWeight = "light")),
  plotOptions = list(line = list(marker = list(enabled = F),
                                 lineWidth = 4,
                                 clip = F),
                     arearange = list(lineWidth = 0,
                                      marker = list(enabled = F))))
  
# Globally format thousands separator for highcharts
hcoptslang <- getOption("highcharter.lang")
hcoptslang$thousandsSep <- ","
options(highcharter.lang = hcoptslang)




# # Style colors

col_grey_dark <- "#333333"
col_grey_light <- "#949494"
col_nrs_purple <- "#6C297F"
col_nrs_light <- "#BF78D3"
col_gss_orange <- "#F46A25"
col_nrs_adjusted <- "#4e0064"


