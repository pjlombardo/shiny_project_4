
output$full_joined_table <- DT::renderDataTable(
  if (analysis$ready){
    DT::datatable(
      make_data_table(df$samples_df, df$genes_df),
      options = list(
        scrollX = TRUE
      ),
      filter = 'top'
    )
  } else{
    NULL
  }
)