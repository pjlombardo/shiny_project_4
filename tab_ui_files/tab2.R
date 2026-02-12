fluidRow(
  ################################
  # ChatGPT: "basic html code for two side-by-side divs"
  div(style = "background-color: #eee; display: flex; padding: 20px;",
      div(style = "width: 30%; padding: 20px; box-sizing: border-box;",
          numericInput("num_genes_t2",
                       "Choose the number of top genes.",
                       value = 5,
                       min = 1,
                       max = 30)
      ),
      div(style = "width: 70%; padding: 20px; box-sizing: border-box;",
          selectInput("sample_t2",
                      "Select which samples to include in the plot.",
                      choices = list("choices" = "choices"),
                      # choices = m_choices,
                      multiple = TRUE
                      # selected = m_choices
          )
      )
  ),
  ###############################################
  
  gt::gt_output("top_genes_table")
  
)

