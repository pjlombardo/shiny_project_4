
output$full_joined_table <- DT::renderDataTable(
  DT::datatable(iris)
)