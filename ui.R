# Build your UI page here


ui <- fluidPage(
  # Fill in your details here
  h1("Here is our title"),
  br(),
  p("descriptions here"),
  br(),
  inputPanel(
    fileInput("genes_data","Please upload your tab-separated genes data file:"),
    fileInput("samples_data","Please upload your tab-separated samples data file:"),
  ),
  
  
  tabsetPanel(
    tabPanel(
      "tab 1",
      # all the ui content for tab 1 goes here
      # # old content, moved to tab1.R file: plotOuput("myplot1")
      # put something that loads the ui content from another file.
      
      source("tab_ui_files/tab1.R", local = TRUE)$value
      
    ),
    
    tabPanel(
      "tab 2",
      # all the ui content for tab 2 goes here
      source("tab_ui_files/tab2.R", local = TRUE)$value
    ),
    
    tabPanel(
      "tab 3",
      # all the ui content for tab 3 goes here
      source("tab_ui_files/tab3.R", local = TRUE)$value
    )
  
  )
  
  
  
)