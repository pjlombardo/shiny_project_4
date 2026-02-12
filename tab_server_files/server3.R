
output$full_joined_table <- DT::renderDataTable(
  if (analysis$ready){
    sample_cols <- get_choice_vals(df$samples_df) %>% unlist()
    DT::datatable(
        inner_join(x = df$genes_df,
                 y = df$samples_df,
                 by = "ENTREZID") %>%
        mutate(SYMBOL = SYMBOL.x) %>%
        select(SYMBOL,P.Value, logFC, sample_cols) %>%
          mutate(P.Value = sapply(P.Value,
                          function(x){formatC(x, digits = 3, format = 'e')})) %>%
          mutate(across(where(is.numeric),
                        function(x){round(x,3)})),
      options = list(
        scrollX = TRUE
      ),
      filter = 'top'
    )
  } else{
    NULL
  }
)