
output$top_genes_table <- gt::render_gt(
  if (analysis$ready){
    top_genes <- get_top_genes_df(df$genes_df, input$num_genes_t2)
    get_top_genes_joined_df(top_genes, df$samples_df) %>%
      select(SYMBOL.x, P.Value, logFC, input$sample_t2) %>%
    # you can make this look nicer by using kable() kableExtra formatting
    # (You can also try out gt package)
      gt() %>%
      tab_header(
        title = "Comparing Top Genes and Samples",
        subtitle = "Explore using interactive elements above."
      )

  } else {
    NULL
  }
)

