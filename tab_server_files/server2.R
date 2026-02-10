
output$top_genes_table <-renderTable(
  iris %>%
    group_by(Species) %>%
    summarise(mean = mean(Sepal.Width),
              sample_size = n())
)

