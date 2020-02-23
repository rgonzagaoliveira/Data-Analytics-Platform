### RENDERS DATA LOAD TAB

#### FIXED UI ----

output$rd_data_load <- renderUI({

  fluidPage(
    #useShinyjs(),
    #useShinyalert(),
    box(title = "Data Load", status = "primary", width = 300, collapsible = TRUE,
        
        fluidRow(
          column(2,
            radioButtons("dt_type", "File Extension", 
                         choices = c("csv" = "csv",
                                     "xlsx" = "xlsx"),
                         inline = TRUE)
          ),
          
          conditionalPanel(
            condition = "input.dt_type == 'csv'",
            
            column(2,
              materialSwitch(inputId = "dt_csv_header", label = "Header", status = "success")
            ),
            
            column(6,
              radioButtons("dt_csv_separator", "Separator", 
                           choices = c("Comma" = ",",
                                       "Semicolon" = ";",
                                       "Tab" = " ",
                                       "Other" = "other"),
                           inline = TRUE),
              conditionalPanel(
                condition = "input.dt_csv_separator == 'other'",
                textInput( "dt_csv_separator_other", "Type Data Separator", value = "type here", width = "200px")
                )
            ),
            
        
            column(2,
              radioButtons("dt_csv_decimal", "Decimal",
                          choices=c("Period" = ".", 
                                    "Comma" = ","), 
                          inline = TRUE)
            ),
            
            column(3,
              fileInput("dt_load_csv", "Choose CSV File", accept = c(".csv"), width = "80%")
            )
          )
      )
        # plotOutput("control_chart", width = "80%")),
    ),
    
    box(title = "Data Summary", status = "primary", width = 800,  collapsible = TRUE,
        DT::dataTableOutput("dt_explore")
    )
  )
})


# Funcions ----

dt_load_csv <- function(datapath, hdr, separator, decimal, str_as_factor = FALSE, max_rows_read = -1) {
  
  # check the file extension
  if (tolower(tools::file_ext(datapath)) %in% c("csv")) {
    
    # importing file
    df <- read.csv2(datapath, 
                    header = hdr, 
                    sep = separator, 
                    dec = decimal, 
                    stringsAsFactors = str_as_factor,
                    nrows = max_rows_read,
                    fill = TRUE)
    
    return(df)
  
  } else {
    cat("File Extension doesn't match")
  }
}

  
dt_load_excel <- function(datapath) {

}


#### REACTIVE VALUES -----


#### REACTIVE EXPRESSIONS -----


#### OBSERVERS -----


# __observer -> load data ----
observeEvent(input$dt_load_csv, {
  
  # variables
  data_path <- input$dt_load_csv$datapath
  header <- input$dt_csv_header
  sep <- input$dt_csv_separator
  dec <- input$dt_csv_decimal
  
  # inporting file
  data_csv <- dt_load_csv(data_path, header, sep, dec, str_as_factor = FALSE, max_rows_read = -1)
  
  output$dt_explore <- DT::renderDataTable({
    DT::datatable(
      data_csv,
      filter = 'top',
      options = list(lengthMenu = c(5, 10, 20, 50), pageLength = 15, scrollX = TRUE, searching = T),
      escape = FALSE,
      rownames = TRUE)
  })
    
})





