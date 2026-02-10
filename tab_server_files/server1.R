
output$myplot1 <-renderPlot(
  hist(iris$Sepal.Length, breaks = input$break_val)
)

