
output$heatmap <-renderPlot(
  if (analysis$ready){
    top_genes <- get_top_genes_df(df$genes_df, input$num_genes_t1)
    top_genes_joined_df <- get_top_genes_joined_df(top_genes, df$samples_df)
    plot_df <- make_plot_df(top_genes_joined_df,
                            top_genes,
                            df$samples_df,
                            input$sample_t1)
    make_plot(plot_df)
    
  } else {
    NULL
  }
)

