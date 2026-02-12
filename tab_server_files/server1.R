
output$heatmap <-renderPlot(
  if (analysis$ready){
    hist(iris$Sepal.Length)
  } else {
    NULL
  }
)

