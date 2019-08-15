
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   player_move <- reactive({
           
           if(input$choice=="rock"){1}
           else if(input$choice=="paper"){2}
           else{3}
   })
   
   ai <- reactive({
           rng <- runif(1,0,100)
           ifelse(rng<=33,1,ifelse(rng<=66,2,3))
   })
   
   output$AI <- renderText({
           if(input$show){
           ifelse(ai() ==1,'rock',ifelse(ai() ==2,'paper','scissors'))
           }
           else{"Click Show"}
   })
 
  
 result <- reactive({
          if(player_move() ==ai()){result=0}
          else if(player_move() == 1 & ai()==2){result=-1}
         else if(player_move() == 1 & ai() == 3){result=1}
         else if(player_move() == 2 & ai() == 1){result=1}
         else if(player_move()== 2 & ai() == 3){result=-1}
         else if(player_move() == 3 & ai() == 1){result=-1}
         else {result=1}
        })
 
 output$result <- renderText({
         if(input$show){
            if(result() == 0){"The Game is a Tie"}
                else if(result() == 1){"You Win!"}
                else{"You Lose"}
         }
         else{"Click Show"}
        })
 observeEvent(input$refresh, {
         js$refresh();
 })
       
})
