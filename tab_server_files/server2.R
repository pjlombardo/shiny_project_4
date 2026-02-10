
output$myplot2 <-renderPlot(
  boxplot(Sepal.Length~Species, data = iris)
)

