
fluidRow(
  inputPanel(
    numericInput("break_val",
                 "Choose breaks",
                 min = 10,
                 max = 100,
                 value = 15,
                 step =1)
  ),
  
  plotOutput("myplot1")
)
