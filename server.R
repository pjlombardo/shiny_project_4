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
  # cotent here
  
  # tab 1
  source('tab_server_files/server1.R', local = TRUE)$value
  
  
  # tab 2
  source('tab_server_files/server2.R', local = TRUE)$value
  
  
  # tab3
  source('tab_server_files/server3.R', local = TRUE)$value
  
  
}
