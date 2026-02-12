

get_choice_vals <- function(samples_df){
  choice_vals <- names(samples_df %>% select(-c("ENTREZID","SYMBOL","GENENAME")))
  samples_choices <- list()
  for (i in 1:length(choice_vals)){
    samples_choices[[ choice_vals[i] ]] = choice_vals[i]
  }
  return(samples_choices)
}

get_top_genes_df <- function(genes_df, num_genes){
  top_genes_df <- genes_df %>%
    filter(adj.P.Val < 0.01,
           abs(logFC) > 0.58) %>%
    arrange(P.Value)%>%
    slice(1:num_genes)
  return(top_genes_df)
}

get_top_genes_joined_df <- function(top_genes, samples_df){
  sample_cols <- get_choice_vals(samples_df) %>% unlist()
  top_joined_df <- inner_join(x = top_genes,
                              y = samples_df,
                              by = "ENTREZID") %>%
    select(SYMBOL.x,P.Value, logFC, sample_cols)
}