# Load packages ----

library(shiny)

path <- getwd()
source(file = paste0(path, "/global.R"))


# Defining dashboard structure
dashboardPage(
  dashboardHeader(title = "Data Analytics Platform"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Data Explore", tabName = "dt_explore", icon = icon("table"), startExpanded = FALSE,
               menuSubItem("Data Load", tabName = "dt_load"))
      
      #menuItem("Widgets", tabName = "widgets", icon = icon("th"))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "dt_load", 
              uiOutput("rd_data_load")
              )
    
    )
  )
)