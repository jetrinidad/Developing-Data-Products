Reproducible Pitch:Rock Paper Scissors
========================================================
author: Miquo Trinidad
date: August 15, 2019
autosize: true

But Why???
========================================================

- Tired of losing at rock,paper,scissors?
- Have no friends in real life?
- Just bored and have nothing better to do?

Then this app is perfect for you!<br>
Introducing the coolest Shiny app <br> Rock,Paper,Scissors!


User Instructions
========================================================
1. select from input box the your action; rock,paper, or scissors
2. Click the show/hide check box
3. Press Submit
4. Press the refresh button
5. Press Submit to play again
6. Profit!
7. Repeat from step 1

User Interface Shiny Code
========================================================


```r
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
    ))))
```

<!--html_preserve--><div class="container-fluid">
<!--SHINY.SINGLETON[b8d79706b067e925accf37c2d5d6cf4524fed520]-->
<!--/SHINY.SINGLETON[b8d79706b067e925accf37c2d5d6cf4524fed520]-->
<!--SHINY.SINGLETON[59bb28b81c7f3957d690d48ed248cb5e62e275de]-->
<!--/SHINY.SINGLETON[59bb28b81c7f3957d690d48ed248cb5e62e275de]-->
<h2>Rock Paper Scissors</h2>
<div class="row">
<div class="col-sm-4">
<form class="well">
<h3>Player 1</h3>
<div class="form-group shiny-input-container">
<label class="control-label" for="choice">Your Choice:</label>
<div>
<select id="choice"><option value="rock" selected>rock</option>
<option value="paper">paper</option>
<option value="scissors">scissors</option></select>
<script type="application/json" data-for="choice" data-nonempty="">{}</script>
</div>
</div>
<div>
<button type="submit" class="btn btn-primary">Submit</button>
</div>
</form>
</div>
<div class="col-sm-8">
<h3>Player 2</h3>
<h5>AI Chooses:</h5>
<div id="AI" class="shiny-text-output"></div>
<h5>RESULT OF GAME:</h5>
<div id="result" class="shiny-text-output"></div>
<button id="refresh" type="button" class="btn btn-default action-button">Refresh app</button>
<div class="form-group shiny-input-container">
<div class="checkbox">
<label>
<input id="show" type="checkbox"/>
<span>Show/Hide Results</span>
</label>
</div>
</div>
</div>
</div>
</div><!--/html_preserve-->

Shiny Server Code
========================================================


```r
library(shiny)
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
 })})
```
