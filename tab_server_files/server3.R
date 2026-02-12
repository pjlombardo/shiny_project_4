
output$full_joined_table <- DT::renderDataTable(
  if (analysis$ready){
    DT::datatable(iris)
  } else{
    NULL
  }
)