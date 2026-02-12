
output$top_genes_table <-renderTable(
  if (analysis$ready){
    iris %>%
      group_by(Species) %>%
      summarise(mean = mean(Sepal.Width),
                sample_size = n())
  } else {
    NULL
  }
)

