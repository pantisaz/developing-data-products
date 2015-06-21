library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Ranking hospitals"),
  
  sidebarPanel(
    selectInput("outcome", "Medical Problem:",
                list("Heart Attack" = "heart attack", 
                     "Heart Failure" = "heart failure", 
                     "Pneumonia" = "pneumonia")),
    
    selectInput("num", "Best or Worst:", 
                list("Best" = "best", "Worst" = "worst"))
  ),
  mainPanel(dataTableOutput(outputId="table"))
    
  ))