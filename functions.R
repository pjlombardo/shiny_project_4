

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

make_plot_df <- function(top_genes_joined_df, 
                         top_genes,
                         samples_df, 
                         chosen_samples){
  
  sample_cols <- get_choice_vals(samples_df) %>% unlist()
  plot_df <- top_genes_joined_df %>% 
    select(SYMBOL.x, sample_cols) %>%
    
    # Pivot longer stuff
    pivot_longer(cols = unname(sample_cols),
                 names_to = "samples",
                 values_to = "NormCounts") %>%
    pivot_wider(names_from = "SYMBOL.x",
                values_from = "NormCounts") %>%

    # apply across all the SYMBOLS the scaling function
    mutate(across(-c("samples"),scale)) %>%
    as.data.frame() %>%

    # Put this back into a long format, where we have a variable
    # for samples, SYMBOL, and normalized counts.
    pivot_longer(cols = -c("samples"),
                 names_to = "SYMBOL",
                 values_to = "NormCounts") %>%
    as.data.frame() %>%

    # Join on the P.Value, so we can reorder the SYMBOL variable
    # as a factor with levels based on P.Value.
    inner_join(x = .,
               y = top_genes,
               by = "SYMBOL") %>%
    select(samples:NormCounts, P.Value) %>%
    mutate(SYMBOL = fct_reorder(SYMBOL, -P.Value)) %>%
    filter(samples %in% chosen_samples)
  
  return(plot_df)
}


# make_plot   make my ggplot.
make_plot <- function(plot_df){
  
  ggplot(data = plot_df,
         aes(x = samples,
             y = SYMBOL,
             fill = NormCounts)) + 
    geom_tile() + 
    scale_fill_gradient2(low = "blue",
                         mid = 'white',
                         high = 'red',
                         midpoint = 0,
                         limits = c(-2.2, 2.2))+
    scale_y_discrete(position="right")+
    labs(x = "Samples",
         y = "Gene Symbols")+
    theme_bw() + 
    theme(
      legend.position = "top",
      legend.title = element_blank(),
      legend.key.size = unit(1.5, "cm")
    )
  
}


make_data_table <- function(samples_df, genes_df){
  
  sample_cols <- get_choice_vals(samples_df) %>% unlist()
  
    data_table<- inner_join(x = genes_df,
               y = samples_df,
               by = "ENTREZID") %>%
      mutate(SYMBOL = SYMBOL.x) %>%
      select(SYMBOL,P.Value, logFC, sample_cols) %>%
      mutate(P.Value = sapply(P.Value,
                              function(x){formatC(x, digits = 3, format = 'e')})) %>%
      mutate(across(where(is.numeric),
                    function(x){round(x,3)}))
    
    return(data_table)

}


