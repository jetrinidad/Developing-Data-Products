
library(shiny)
library(shinyjs)
library(V8)
jscode <- "shinyjs.refresh = function() { history.go(0); }"
shinyUI(fluidPage(
        
         useShinyjs(),
        extendShinyjs(text = jscode),
        
  titlePanel("Rock Paper Scissors"),
  sidebarLayout(
    sidebarPanel(
       h3("Player 1"),
       selectInput("choice","Your Choice:",c("rock","paper","scissors")),
       submitButton("Submit")
       ),
    
    mainPanel(
      h3("Player 2"),
      h5("AI Chooses:"),
      textOutput("AI"),
      h5("RESULT OF GAME:"),
      textOutput("result"),
      actionButton("refresh", "Refresh app"),
      checkboxInput("show","Show/Hide Results",value=FALSE)
    )
   
  )
))
