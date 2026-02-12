# load necessary packages
# and source your functions.R file

library(shiny)
library(tidyverse)
library(DT)

source('functions.R')

# this function defines your server logic
server <- function(input, output){
  # you will put your interactions here
  
  # for all three tabs
  # content here, dealing with the uploads and the loading the data.
  # we can access the path to the uploaded data: (input$genes_data)$datapath
  
  df <- reactiveValues(genes_df = NULL,
                       samples_df = NULL)
  
  analysis <- reactiveValues(ready = FALSE)
  
  renderText(input$boolteset)
  
  observeEvent(input$genes_data, {
    df$genes_df <- read.csv((input$genes_data)$datapath, sep = '\t')
    if (!(is.null(df$genes_df) | is.null(df$samples_df))){
      analysis$ready <- TRUE
    }
    
  })
  
  observeEvent(input$samples_data, {
    df$samples_df <- read.csv((input$samples_data)$datapath, sep = '\t')
    if (!(is.null(df$genes_df) | is.null(df$samples_df))){
      analysis$ready <- TRUE
    }
    
  })
  
  
  
  # tab 1
  source('tab_server_files/server1.R', local = TRUE)$value
  
  
  # tab 2
  source('tab_server_files/server2.R', local = TRUE)$value
  
  
  # tab3
  source('tab_server_files/server3.R', local = TRUE)$value
  
  
}
