# Read files ------------------------------------------------------------------
# These files are used multiple times - so we read them in once here. Other
# files are only used once, so they are read in as and when needed.
datasets[["input_data"]] <- paths[["input_data"]] %>%
  excel_sheets() %>%
  set_names() %>%
  map(read_excel, path = paths[["input_data"]], skip = 4, na = "NA")



# 1 HEALTH INEQUALITY -------------------------------------------------------------

# SIMD --------------------------------------------------------------------

datasets[["INEQUALITY_SIMD"]] <- datasets[["input_data"]][["INEQUALITY_SIMD"]] %>% 
  janitor::clean_names() %>% 
  filter(cause_of_death %in% c("All causes",
                               "Drugs",
                               "Alcohol-specific",
                               "Probable suicides",
                               "Dementia and Alzheimer's disease",
                               "COVID-19"))


# Life Expectancy --------------------------------------------------------------------
datasets[["INEQUALITY_life_expectancy"]] <- datasets[["input_data"]][["INEQUALITY_life_expectancy"]] %>% 
  janitor::clean_names()








# 2 COVID-19 ----------------------------------------------------------------

# Deaths by location ------------------------------------------------------

datasets[["COVID_location"]] <- datasets[["input_data"]][["COVID_location"]] %>%
  filter(Location != "All") %>% 
  mutate(Date = as.Date(Date),
         Location = ordered(Location, levels = c(
           "Other institution",
           "Home / Non-institution",
           "Care Home",
           "Hospital"))) %>% 
  janitor::clean_names()


# Other deaths by type ------------------------------------------------------
datasets[["COVID_other_deaths"]] <- datasets[["input_data"]][["COVID_other_deaths"]] %>%
  janitor::clean_names() 






# 3 POPULATION ----------------------------------------------------------------

# Net migration & Natural change & population --------------------------------------------

datasets[["POPULATION_migration"]] <- datasets[["input_data"]][["POPULATION_migration"]] %>% 
  janitor::clean_names() 



# Population change map --------------------------------------------

datasets[["POPULATION_change"]] <- datasets[["input_data"]][["POPULATION_change"]] %>% 
  janitor::clean_names() 









# 4 MARRIAGE --------------------------------------------------------------------

datasets[["MARRIAGE_marriages"]] <- datasets[["input_data"]][["MARRIAGE_marriages"]] %>% 
  janitor::clean_names() 
