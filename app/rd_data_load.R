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
    
    box(title = "Data Summary", status = "primary", width = 800,  collapsible = TRUE
        # DT::dataTableOutput("control_descr_table2")
    )
  )
})


# Funcions ----

dt_load_csv <- function(input_data, hdr, separator, decimal, str_as_factor = FALSE, max_rows_read = "all") {
  
  # check the file extension
  if (tolower(tools::file_ext(input_data$datapath)) %in% c("csv")) {
    # importing file
    datapath <- paste0(path, "/")
    df <- read.csv2(input_data$datapath, 
                    header = hdr, 
                    sep = separator, 
                    dec = decimal, 
                    stringsAsFactors = str_as_factor,
                    nrows = max_rows_read,
                    fill = TRUE)
  
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
  
  # importing file
  datapath <- input$dt_load_csv$datapath
  
  csv <- read.table(datapath, header = FALSE, sep = ";", 
                    col.names = paste0("v",seq_len(27)), fill = TRUE, stringsAsFactors = FALSE)
  
})





