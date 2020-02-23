library(shiny)

function(input, output, session) {
  
  # Sourcing global
  source(file = paste0(path, "/global.R"), local = TRUE)$value
  
  # Loading render scripts
  source(file = paste0(path, "/rd_data_load.R"), local = TRUE)$value

  
}
