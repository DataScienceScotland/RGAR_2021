
# 1 HEALTH INEQUALITY --------------------------------------------------------------

# simd ------------------------------------------------------


plots[["INEQUALITY_SIMD"]] <-
  hchart(
    datasets[["INEQUALITY_SIMD"]] %>%
      filter(cause_of_death != "COVID-19"),
    "line",
    hcaes(x = year,
          y = ratio_of_differences,
          group = cause_of_death),
    color = c(
      col_grey_light, #alcohol
      col_nrs_purple,#all causes
      col_grey_light,#Dementia
      col_nrs_purple,#Drugs
      col_grey_light #Suicide
    ),
    dashStyle = c("Dash",
                  "Dash",
                  "Solid",
                  "Solid",
                  "dot")) %>%
  hc_add_series(
    datasets[["INEQUALITY_SIMD"]] %>%
      filter(cause_of_death == "COVID-19"),
    "line",
    hcaes(x = year,
          y = ratio_of_differences,
          group = cause_of_death),
    marker = list(
      symbol= "triangle"),
    color = c(
      col_gss_orange)
  ) %>% 
  hc_add_theme(hc_theme) %>%
  hc_plotOptions(line = list(marker = list(enabled = T,
                                           radius = 6))) %>%
  hc_yAxis(title = list(text = "Ratio of differences"),
           tickPositions = c(seq(0, 20, 2))) %>%
  hc_xAxis(title = F,
           tickPositions = seq(2001, 2021, 2)) %>%
  hc_tooltip(
    valueDecimals = 2,
    formatter = JS(
      "function () { return 'In <b>'
      + this.point.x
      + '</b> the '
      + this.series.name
      + ' death rate in the <b>most</b> deprived areas'
      + '<br/>'
      + 'was <b>'
      + Highcharts.numberFormat(this.point.y)
      + ' times </b> the rate in the <b>least</b> deprived areas.';}"
    )
  ) %>%
  hc_add_annotation(
    draggable = '',
    labelOptions = list(
      borderColor = "transparent",
      shape = 'connector',
      align = 'right',
      justify = F,
      style = list(fontFamily = windowsFont("Arial"),
                   fontSize = "18px")
    ),
    labels = list(
      list(
        point = list(
          xAxis = 0,
          yAxis = 0,
          align = "right",
          x = min(datasets[["INEQUALITY_SIMD"]]$year),
          y = 19
        ),
        text =
          "In <b>2021</b> the drug death rate in the <b>most</b>  <br>
        deprived areas was more than <b>15 times</b> <br>
        the rate in the <b>least</b> deprived areas.",
        x = 40,
        style = list(color = col_nrs_purple)
      )
    )
  ) %>%
  hc_exporting(
    enabled = TRUE,
    filename = "death_rate_SIMD_ratios",
    buttons = list(contextButton = list(
      menuItems = c(
        'downloadPNG',
        'downloadSVG',
        'separator',
        'downloadCSV',
        'downloadXLS'
      )
    ))
  )
plots[["INEQUALITY_SIMD"]]

# Life Expectancy ---------------------------------------------------------


# Create a separate plot for each sex

data <- datasets[["INEQUALITY_life_expectancy"]] %>%
  filter(sex == "Females")

plots[["life_expectancy_a"]] <-
  hchart(
    data %>%
      filter(country == "Eastern European Countries"),
    "arearange",
    name = "Eastern European Countries",
    hcaes(x = year, low = min,
          high = max),
    color = col_grey_light) %>%
  hc_add_series(
    data %>%
      filter(country == "Western European Countries"),
    "arearange",
    name = "Western European Countries",
    hcaes(x = year,
          low = min,
          high = max),
    color = col_nrs_adjusted) %>%
  hc_add_series(
    data %>%
      filter(country == "Scotland"),
    "line",
    name = "Scotland",
    hcaes(x = year,
          y = life_expectancy),
    color = col_grey_dark) %>%
  hc_add_series(
    data %>%
      filter(country == "UK"),
    "line",
    name = "UK",
    hcaes(x = year,
          y = life_expectancy),
    color = col_grey_dark,
    dashStyle = "Dash") %>%
  hc_yAxis(min = 60,
           max = 90,
           gridLineWidth = 0,
           title = list(text = "Life expectancy")) %>%
  hc_xAxis(tickPositions = c(min(data$year), max(data$year)),
           title = F) %>%
  hc_title(text = unique(data$sex)) %>%
  hc_add_theme(hc_theme) %>%
  hc_add_annotation(
    draggable = '',
    labelOptions = list(
      borderColor = "transparent",
      shape = 'connector',
      align = "right",
      rotation = 90,
      justify = 'right',
      style = list(fontFamily = windowsFont("Arial"),
                   fontSize = "18px")
    ),
    labels = list(
      list(
        point = list(
          xAxis = 0,
          yAxis = 0,
          x = min(data$year),
          y = 66
        ),
        text = "<b>Eastern</b> European <br/>Countries",
        style = list(color = col_grey_light)
      ),
      list(
        point = list(
          xAxis = 0,
          yAxis = 0,
          x = min(data$year),
          y = 85
        ),
        text = "<b>Western</b> European <br/>Countries",
        style = list(color = col_nrs_purple)
      )
    )
  ) %>%
  hc_add_annotation(
    draggable = '',
    labelOptions = list(
      shape = 'connector',
      align = "right",
      rotation = 90,
      justify = 'right',
      style = list(fontFamily = windowsFont("Arial"),
                   fontSize = "18px")
    ),
    labels = list(
      list(
        point = list(
          xAxis = 0,
          yAxis = 0,
          x = max(data$year),
          y = 80.7
        ),
        y = 40,
        text = "<b>Scotland"
      ),
      list(
        point = list(
          xAxis = 0,
          yAxis = 0,
          x = max(data$year),
          y = 82.4
        ),
        y = -16,
        text = "<b>UK"
      )
    )
  ) %>%
  hc_exporting(
    enabled = TRUE,
    filename = "female_life_expectancy",
    buttons = list(
      contextButton = list(
        menuItems = c('downloadPNG',
                      'downloadSVG',
                      'separator',
                      'downloadCSV',
                      'downloadXLS'))))


data <- datasets[["INEQUALITY_life_expectancy"]] %>%
  filter(sex == "Males")

plots[["life_expectancy_b"]] <-
  hchart(
    data %>%
      filter(country == "Eastern European Countries"),
    "arearange",
    name = "Eastern European Countries",
    hcaes(x = year, low = min,
          high = max),
    color = col_grey_light
  ) %>%
  
  hc_add_series(
    data %>%
      filter(country == "Western European Countries"),
    "arearange",
    name = "Western European Countries",
    hcaes(x = year,
          low = min,
          high = max),
    color = col_nrs_adjusted
  ) %>%
  hc_add_series(
    data %>%
      filter(country == "Scotland"),
    "line",
    name = "Scotland",
    hcaes(x = year,
          y = life_expectancy),
    color = col_grey_dark
  ) %>%
  hc_add_series(
    data %>%
      filter(country == "UK"),
    "line",
    name = "UK",
    hcaes(x = year,
          y = life_expectancy),
    color = col_grey_dark,
    dashStyle = "Dash"
  ) %>%
  hc_yAxis(min = 60,
           max = 90,
           gridLineWidth = 0,
           title = list(text = "Life expectancy")) %>%
  hc_xAxis(tickPositions = c(min(data$year), max(data$year)),
           title = F) %>%
  hc_title(text = unique(data$sex)) %>%
  hc_add_theme(hc_theme) %>%
  hc_add_annotation(
    draggable = '',
    labelOptions = list(
      shape = 'connector',
      align = "right",
      rotation = 90,
      justify = 'right',
      style = list(fontFamily = windowsFont("Arial"),
                   fontSize = "18px")
    ),
    labels = list(
      list(
        point = list(
          xAxis = 0,
          yAxis = 0,
          x = max(data$year),
          y = 76.08
        ),
        y = 50,
        text = "<b>Scotland"
      ),
      list(
        point = list(
          xAxis = 0,
          yAxis = 0,
          x = max(data$year),
          y = 78.36
        ),
        y = -20,
        text = "<b>UK"
      )
    )
  )%>%
  hc_exporting(
    enabled = TRUE,
    filename = "male_life_expectancy",
    buttons = list(
      contextButton = list(
        menuItems = c('downloadPNG',
                      'downloadSVG',
                      'separator',
                      'downloadCSV',
                      'downloadXLS'))))

plots[["INEQUALITY_life_expectancy"]] <-  hw_grid(plots[["life_expectancy_a"]], plots[["life_expectancy_b"]]) %>%
  htmltools::browsable()

plots[["INEQUALITY_life_expectancy"]]




# 2 COVID-19 --------------------------------------------------------------

# Location deaths ---------------------------------------------------------

plots[["COVID_location"]] <-
  hchart(
    datasets[["COVID_location"]],
    "line",
    hcaes(x = date,
          y = deaths,
          group = location),
    color = c(col_grey_light,
              col_nrs_purple,
              col_grey_light,
              col_nrs_purple),
    dashStyle = c("Solid",
                  "Dash",
                  "Dash",
                  "Solid")
  ) %>%
  hc_plotOptions(line = list(
    dataLabels = list(enabled = F)#,
    # marker = list(enabled = T,
    #               radius = 6)
  )) %>%
  hc_yAxis(
    min = 0,
    max = 500,
    labels = list(format = "{value:,.0f}"),
    title = list(text = "COVID-19 deaths")
  ) %>%
  hc_xAxis(
    tickPositions = c(datetime_to_timestamp(min(datasets[["COVID_location"]]$date)),
                      datetime_to_timestamp(as.Date("2021/01/01")),
                      datetime_to_timestamp(as.Date("2021/10/01")),
                      datetime_to_timestamp(max(datasets[["COVID_location"]]$date))),
    type = "datetime",
    labels = list(
      allowOverlap = F,
      style = list(textOverflow = 'none'),
      formatter = JS(
        "function() {
          return Highcharts.dateFormat('%b %Y', this.value);}"
      )
    ),
     title = F,
    plotLines = list(
      list(
        label = list(text = "Wave 1 <br/>
                     starts",
                     rotation = 0,
                     style = list(
                       fontFamily = windowsFont("Arial"),
                       fontSize = "18px"
                     )),
        color = col_grey_light,
        width = 1,
        value = datetime_to_timestamp(as.Date("2020-03-16")),
        dashStyle = "shortdash"
      ),
      list(
        label = list(text = "Wave 2 <br/> starts",
                     rotation = 0,
                     style = list(
                       fontFamily = windowsFont("Arial"),
                       fontSize = "18px"
                     )),
        color = col_grey_light,
        width = 1,
        value = datetime_to_timestamp(as.Date("2020-08-31")),
        dashStyle = "shortdash"
      ),
      list(
        label = list(text = "Wave 3 <br/>
                            starts",
                     rotation = 0,
                     style = list(
                       fontFamily = windowsFont("Arial"),
                       fontSize = "18px"
                     )),
        color = col_grey_light,
        width = 1,
        value = datetime_to_timestamp(as.Date("2021-05-31")),
        dashStyle = "shortdash"
      )
    )
    ) %>%
  hc_add_theme(hc_theme) %>%
  hc_tooltip(
    formatter = JS(
      "function () { return '<b>'
      + this.series.name
      + '</b><br /> '
      + 'Deaths: '
      + Highcharts.numberFormat(this.point.y, -1)
      + ' <br />'
      + Highcharts.dateFormat('%e %b %Y',
      new Date(this.x));}"
    )
  ) %>%
  hc_legend(reversed = T) %>%
  hc_exporting(
    enabled = TRUE,
    filename = "covid_19_deaths_by_location",
    buttons = list(
      contextButton = list(
        menuItems = c('downloadPNG',
                      'downloadSVG',
                      'separator',
                      'downloadCSV',
                      'downloadXLS'))))

plots[["COVID_location"]]




# Other Deaths -----------------------------------------------------------


plots[["COVID_other_deaths"]] <-
  hchart(
    datasets[["COVID_other_deaths"]],
    "line",
    hcaes(x = year,
          y = number_of_deaths,
          group = type),
    color = c(col_nrs_purple,
              col_grey_light,
              col_nrs_purple,
              col_grey_light,
              col_nrs_purple),
    dashStyle = c("Solid",
                  "Solid",
                  "Dash",
                  "Dash",
                  "Dot")) %>%
  # hc_plotOptions(line = list(
  #   marker = list(enabled = T,
  #                 radius = 6)
  # )) %>%
  hc_yAxis(
    min = 0,
    max = 18000,
    title = list(text = "Number of deaths"),
    labels = list(format = "{value:,.0f}")
  ) %>%
  hc_xAxis(tickPositions = c(1994, 2000, 2005, 2010, 2015, 2021),
           title = F,
           plotLines = list(
             list(
               label = list(text = "The 1st lockdown began in March 2020",
                            rotation = 0,
                            align = "right",
                            x = -5,
                            y = 15,
                            style = list(
                              fontFamily = windowsFont("Arial"),
                              fontSize = "18px")),
               color = col_grey_light,
               width = 1,
               value = 2020,
               dashStyle = "dash"
             ))) %>% 
  hc_add_theme(hc_theme) %>%
  hc_tooltip(
    valueDecimals = 2,
    formatter = JS(
      "function () { return 'In <b>'
      + this.point.x
      + '</b> the age-standardsied death rate for <b>'
      + this.series.name 
      + '</b> was <b>'
      + Highcharts.numberFormat(this.point.y, 0)
      + '.';}"
    )
  ) %>%
  hc_exporting(
    enabled = TRUE,
    filename = "age_standardised_death_rates",
    buttons = list(contextButton = list(
      menuItems = c(
        'downloadPNG',
        'downloadSVG',
        'separator',
        'downloadCSV',
        'downloadXLS'))))

plots[["COVID_other_deaths"]]

# 3 POPULATION ------------------------------------------------------------------

# Net migration Natural change --------------------------------------------

hide_lines <- datasets[["POPULATION_migration"]] %>%
  filter(year %in% c(1960:1987),
         type == "Natural change")
hide_lines_2 <- datasets[["POPULATION_migration"]] %>%
  filter(year %in% c(2003:2017),
         type == "Net migration")

plots[["POPULATION_migration"]] <- hchart(
  datasets[["POPULATION_migration"]],
  "line",
  hcaes(x = year,
        y = total * 1000,
        group = type),
  color = c(col_grey_light, 
            col_nrs_purple, 
            col_grey_light, 
            col_nrs_purple),
  dashStyle = c("Solid",
                "Solid",
                "Dash",
                "Dash"
                ),
  showInLegend = F,
  zIndex = 7
) %>%
  hc_yAxis(
    min = -60000,
    max = 60000,
    tickPositions = c(-60000, -40000, -20000, 0, 20000, 40000, 60000),
    title = list(text = "People",
                 reserveSpace = F,
                 x = 10),
    labels = list(format = "{value:,.0f}"),
    plotLines = list(
      list(
        color = col_grey_dark,
        width = 1,
        value = 0,
        dashStyle = "dash",
        zIndex = 6
      )
    )
  ) %>%
  hc_xAxis(
    title = list(enabled = F),
    tickPositions = c(1956, 2021, 2045),
    plotLines = list(
      list(
        label = list(text = "Contraceptive <br/>pill
                             first available<br/>
                             on the NHS",
                     rotation = 0,
                     style = list(
                       fontFamily = windowsFont("Arial"),
                       fontSize = "18px")),
        color = col_grey_light,
        width = 1,
        value = 1961,
        dashStyle = "dash"
      ),
      list(
        label = list(text = "EU <br/>referendum",
                     rotation = 0,
                     align = "right",
                     x = -5,
                     style = list(
                       fontFamily = windowsFont("Arial"),
                       fontSize = "18px")),
        color = col_grey_light,
        width = 1,
        value = 2016,
        dashStyle = "dash"
      ),
      list(
        label = list(text = "2020-based <br/>Projections",
                     rotation = 0,
                     style = list(
                       fontFamily = windowsFont("Arial"),
                       fontSize = "18px")),
        color = col_grey_light,
        width = 1,
        value = 2021,
        dashStyle = "dash"
      )
    )
  ) %>%
hc_add_annotation(
  draggable = '',
  labelOptions = list(
    borderColor = "transparent",
    shape = 'connector',
    align = 'left',
    justify = F,
    style = list(
      fontFamily = windowsFont("Arial"),
      fontSize = "18px"
    )
  ),
  labels = list(
list(
  point = list(
    xAxis = 0,
    yAxis = 0,
    x = 2045,
    y = -60000
  ),
  text = "<b>Natural change</b><br>
   (births minus <br>deaths)",
 #y = 60,
  style = list(
    color = col_grey_light
  )
),
list(
  point = list(
    xAxis = 0,
    yAxis = 0,
   # align = "right",
    x = 2045,
    y = 45000
  ),
  text = "<b>Net migration</b><br>
  (migration in minus <br> migration out)",
  style = list(
    color = col_nrs_purple
  )
))
) %>%
  hc_add_series(hide_lines,
                "arearange",
                hcaes(
                  x = year,
                  low = -60000,
                  high = total*1000),
                zIndex = 4,
                color = "white") %>%
  hc_add_series(hide_lines_2,
                "arearange",
                hcaes(
                  x = year,
                  low = -60000,
                  high = total*1000),
                zIndex = 2,
                color = "white") %>%
  hc_plotOptions(arearange = list(
    fillOpacity = 3,
    animation = F,
    enableMouseTracking = F
  )) %>%
  hc_add_theme(hc_theme) %>%
  hc_legend(enabled = F) %>%
  hc_exporting(
    enabled = TRUE,
    filename = "natural_change_net_migration_projections",
    buttons = list(
      contextButton = list(
        menuItems = c('downloadPNG',
                      'downloadSVG',
                      'separator',
                      'downloadCSV',
                      'downloadXLS')))
  )

plots[["POPULATION_migration"]]



# Population change -------------------------------------------------------

plots[["POPULATION_change"]] <- 
  hchart(
  datasets[["POPULATION_change"]],
  "area",
  hcaes(x = age,
        y = population_change),
  marker = list(enabled = F),
  negativeColor = col_grey_light,
  color = col_nrs_adjusted) %>% 
  hc_add_theme(hc_theme) %>%
  hc_yAxis(
    title = list(text = "Projected population change"),
    labels = list(format = "{value:,.0f}"),
    min = -25000,
    max = 25000
    ) %>%
  hc_xAxis(
    title = list(text = "Age"),
    tickPositions = c(seq(0, 100, 10))) %>%
  hc_tooltip(
    formatter = JS(
      "function () { return 'In <b>2045</b> the number of people aged <b>'
                            + this.point.x
                            + '</b> is projected to change by <b>'
                            + Highcharts.numberFormat(this.point.y, -1)
                            + ' </b>';}"
    )
  ) %>% 
  hc_add_annotation(
    draggable = '',
    labelOptions = list(
      borderColor = "transparent",
      shape = 'connector',
      align = 'right',
      justify = F,
      style = list(
        fontFamily = windowsFont("Arial"),
        fontSize = "18px"
      )
    ),
    labels = list(
      list(
        point = list(
          xAxis = 0,
          yAxis = 0,
          x = min(datasets[["POPULATION_change"]]$age),
          y = 25000
        ),
        text = "The number of people aged <b>74+</b> <br/>
        is projected to <b>increase</b> by 2045",
        y = 60,
        style = list(
          color = col_nrs_purple
        )
      ),
      list(
        point = list(
          xAxis = 0,
          yAxis = 0,
          x = max(datasets[["POPULATION_change"]]$age),
          y = -25000
        ),
        text = "The number of people aged <b>0-30</b> <br/> is 
        projected to <b>decrease</b> by 2045",
        style = list(
          color = col_grey_light
        )
      ))
  ) %>%
  hc_exporting(
    enabled = TRUE,
    filename = "projected_population_change",
    buttons = list(
      contextButton = list(
        menuItems = c('downloadPNG',
                      'downloadSVG',
                      'separator',
                      'downloadCSV',
                      'downloadXLS')))
  )
  




# 4 MARRIAGE --------------------------------------------------------------

# Marriage types ----------------------------------------------------------





plots[["MARRIAGE_marriages"]] <- hchart(
  datasets[["MARRIAGE_marriages"]],
  "line",
  hcaes(x = year,
        y = count,
        group = type),
  color = c(col_grey_light,
            col_nrs_purple)
 
) %>%
  hc_yAxis(
    min = 0,
    title = list(text = "Unions"),
    labels = list(format = "{value:,.0f}")
  ) %>%
  hc_xAxis(tickPositions = c( min(datasets[["MARRIAGE_marriages"]]$year),
                              max(datasets[["MARRIAGE_marriages"]]$year),
                              2014),
           title = list(enabled = F),
           lineColor = "transparent",
           plotLines = list(
             list(
               label = list(text = "Same-sex civil <br/>
                            partnerships <br/>
                            legally recognised",
                            rotation = 0,
                            style = list(fontSize = "18px"
                            )),
               color = col_grey_light,
               width = 1,
               value = 2005,
               dashStyle = "dash"
             ),
             list(
               label = list(text = "Same-sex marriage <br/>
                            legally recognised",
                            rotation = 0,
                            x = -5,
                            align = "right",
                            style = list(fontSize = "18px"
                            )),
               color = col_grey_light,
               width = 1,
               value = 2014,
               dashStyle = "dash"
             ),
             list(
               label = list(text = "Mixed-sex civil <br/>
                            partnerships legally <br/>
                            recognised",
                            rotation = 0,
                            x = -5,
                            y = 50,
                            align = "right",
                            style = list(fontSize = "18px"
                            )),
               color = col_grey_light,
               width = 1,
               value = 2021,
               dashStyle = "dash"
             ))) %>%
  hc_add_theme(hc_theme) %>%
  hc_tooltip(
    formatter = JS(
      "function () { return 'There were <b>'
      + Highcharts.numberFormat(this.point.y, 0)
      + ' '
      + this.series.name 
      + '</b> in the year <b>'
      + this.point.x
      + '</b>.';}"
    )
  ) %>% 
  hc_exporting(
    enabled = TRUE,
    filename = "same_sex_marriage_civil_partnerships",
    buttons = list(
      contextButton = list(
        menuItems = c('downloadPNG',
                      'downloadSVG',
                      'separator',
                      'downloadCSV',
                      'downloadXLS')))
  )

plots[["MARRIAGE_marriages"]]
