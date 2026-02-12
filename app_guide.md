# Quick Reference

This shiny app is designed to allow the user to upload a genes data set and a samples data set and explore using heatmaps and summary tables.

The data is available [here](https://zenodo.org/records/2529926).

[Shiny Gallery for Quick Reference](https://shiny.posit.co/r/gallery/)

### Layout description
This shiny app is designed to allow the user to upload a genes data set and a samples data set, and the user will use three tabs to explore these data sets.

* **Tab1**: here we allow the user to choose a number of top genes, as well as select which samples they want, and creates a heatmap.
* **Tab2**:  User can separately assign number of top genes and samples and view a table to that affect. (The table of values for the heatmap.)
* **Tab3**: create an interactive DT::datatable based on the joined data, but with all the information.

### Inputs
The bullets below take the general form:

> tab | shiny Component  |  **variable_name** | optional: args

* APP | fileInput | **genes_data** | none
* APP | fileInput | **samples_data** | none

***

* TAB1 | numericInput | **num_genes_t1** | value = 5, min = 1, max = 30
* TAB1 | selectInput | **sample_t1** | multiple = TRUE, choices =...

***

* TAB2 | numericInput | **num_genes_t2** | value = 5, min = 1, max = 30
* TAB2 | selectInput | **sample_t2** | multiple = TRUE, choices =...



### Outputs
The bullets below take the general form:

> tab | Shiny Component  |  **variable_name**  | (inputs required)  | optional: function used

* TAB1 | plotOutput | **heatmap** | none... | none...
* TAB2 | gt::gt_output | **top_genes_table** | none... | none...
* TAB3 | DT::dataTableOutput | **full_joined_table** | none... | DT::datatable(), probably more ...

### Reactive components and Server

> tab | component type | **variable_name(s)** | Events that trigger | data type

> APP | reactiveValues() | **df$genes_df** | input$genes_data | dataframe
> APP | reactiveValues() | **df$sample_df** | input$sample_data | dataframe
> APP | reactiveValues() | **analyis$ready** | input$genes_data, input$samples_data | bool

* To render DT::datatable, need DT::renderDataTable().
* To render gt table, need gt::render_gt()

### Functions and Set up

> tab | **function_name**  |  (inputs)  | purpose
> TAB1, TAB2 | **get_choice_vals**  |  (df$samples_df)  | population our choices for the multiple selection.
> TAB1, TAB2 | **get_top_genes_df** | (df$genes_df, num_genes) | get the top # of genes from genes_df
> TAB1, TAB2 | **get_top_genes_joined_df** | (top_genes, df$samples_df) | get the top # of genes from genes_df
> TAB1 | **make_plot_df** | (top_genes_joined_df,top_genes,samples_df, chosen_samples) | creates our plotting dataframe
> TAB1 | **make_plot** | (plot_df) | makes the actual heatmap.
> TAB3 | **make_data_table** | (df$samples_df, df$genes_df) | formats a table to pass into DT::datable() on the server side.

