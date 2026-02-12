
output$full_joined_table <- DT::renderDataTable(
  if (analysis$ready){
    top_genes<-get_top_genes_df(df$genes_df, 10)
    DT::datatable(
      get_top_genes_joined_df(top_genes, df$samples_df)
    )
  } else{
    NULL
  }
)