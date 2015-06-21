library(shiny)



# Define a server for the Shiny app
shinyServer(function(input, output) {
  
  # Filter data based on selections
  output$table <- renderDataTable({
    
    num<- input$num
    outcome<- input$outcome
    
    bigdata<-read.csv("outcome-of-care-measures.csv", colClasses = "character", na.string = "Not Available")
    
    findoutcome<-any(c("heart attack", "heart failure", "pneumonia")==outcome)
    
    hospitals<- character()
    
    if (findoutcome == FALSE){
      stop("invalid outcome")
    }
    
    if (outcome == "heart attack"){
      outcomecol<- 11
    } else if (outcome == "heart failure") {
      outcomecol <- 17
    } else if (outcome == "pneumonia") {
      outcomecol <-23 
    }
    
    subset1<-bigdata[, c(2,7, outcomecol)]
    
    statelist<-sort((unique(bigdata[,7])))
    
    for (i in 1:54){
      data<-subset(subset1, State == statelist[i])
      
      sortdata<-data[order(as.numeric(as.character(data[,3])), data$Hospital.Name, na.last = NA, decreasing = FALSE), ]
      
      if (num == "best") {
        hnum <- 1
      }  else if (num == "worst"){
        hnum <- which.max(sortdata[,3])
      } else {
        hnum <- num
      }
      
      rowdata<- sortdata[hnum, ]
      
      hospitals[i]<-rowdata[[1]] 
    }
    
    data<-data.frame(hospital=hospitals, state=statelist)
    
  
    
    data
  })
  
})