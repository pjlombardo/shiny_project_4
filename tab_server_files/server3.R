
output$full_joined_table <- DT::renderDataTable(
  if (analysis$ready){
    top_genes<-get_top_genes_df(df$genes_df, input$num_genes_t1)
    top_genes_joined <- get_top_genes_joined_df(top_genes, df$samples_df)
    DT::datatable(
      make_plot_df(top_genes_joined,
                   top_genes,
                   df$samples_df,
                   input$sample_t1)
    )
  } else{
    NULL
  }
)