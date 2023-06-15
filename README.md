# Scotland's Population 2020 - The Registrar General's Annual Review of Demographic Trends

**Published**: 31 August 2021

## Scripts explained

### 0_define_variables.R

### 1_read_data.R

* For reading and wrangling the data from `/data/RGAR_2020_input_data.xlsx`
* This is exactly the same for the PDF and HTML versions so this file can be copied to `/pdf_scripts/0_define_variables.R` if any changes occur

### 2_read_text.R

* For reading the input text from `data/NRS - RGAR 2020 - 3 - Create - 3 - Final - Text spreadsheet.xlsx` and crteating the fuction `text_output()` function.
* This is mostly the same for the PDF and HTML versions so any changes to this file will need to be added to the matching file in `/pdf_scripts/2_read_text.R`
* The difference is that the function does not convert text to HTML for the PDF version
 
### 3_plot_charts.r

* Creates all the plots for the RGAR 
* This is not included in the PDF version as knit to PDF does not correctly knit the Highcharts



## How to run this project

### HTML version

1. Knit from `RGAR_2020.Rmd`

### PDF version

1. Knit from `RGAR_2020.Rmd`

## Updating the text input spreadsheet

### If adding new rows	

* New rows need to be added into the `.Rmd` at the location of the new text with the following code: 
    * `text_output("SHEET_NAME", "SECTION_NAME", subtitle = TRUE/FALSE)`
    * If there is not a subtitle to this section of text you should specify `subtitle = FALSE` - It default to `TRUE`
* News rows won't break the workflow but won't be picked up in the output wihtout this 

### If updating existing text	

* No need to do anything more as this will be picked up in the RAP (Unless any names have changed in the section column)

### Naming convention 	

* *subsection_name_location* e.g *population_after_chart*
* Just needs to be unique to that chapter 
* I arbitrarily picked *_text* for the first text in a subsection and then a location within the subsection thereafter. 

### H tags	

* Subtitles are *H3*
* If there's new text that needs to be *H4* or smaller create a new column named something like *subheading_2* then let Rhi know - and I can add it to the function
* Currently all subtitles are **H3**
* **H2** is for chapter names and these are in the markdown

## Updating the data input spreadsheet

## Highcharts

* The higchharts annotations are somwhat fiddly and the best way to achieve a verticle lined annotation is using plotlines. The drawback of this is that the plotlines track the full height of width of the chart. (This can be combatted with an opaque white arearange series hidding a section of the line - but is again quite fiddly)
* When charts reduce in size the plotline labels overlap - There is no automated way for them to hide/concatenate when they get too close (like with annotations) see [this forum](https://www.highcharts.com/forum/viewtopic.php?t=40483) explains the issue in more detail.
* There is no equivalent of ggplot's faceting in Highcharts. The alternative is to create multiple highchart objects using `map()` and feed them into `hw_grid()` where it displays them together. More information on achieving this can be found in this [StackOverflow question](https://stackoverflow.com/questions/53277199/facet-wrap-facet-grid-any-similar-function-in-highcharter)


## Issues

* Knit to PDF can knit images of the Highcharts but it doesn't work correctly with the Highcharts we have.
    * If this is fixed we can likely have the whole project under one .RMD for PDF and HTML
* Could improve workflow by having only 1 version of `2_read_text.R` as this remains the same for PDF and HTML
* Annotations in highcharts are awkward
* Small multiples in highcharts are not omptimised
    * Not simple to include 1 legend for all charts
    * Changes to one facet of the small multiple may shift the size of that facet but not the others. 
