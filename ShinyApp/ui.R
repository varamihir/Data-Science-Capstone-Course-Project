library(shiny)
library(markdown)

## SHINY UI
shinyUI(
  fluidPage(
    br(),
    img(src = 'coursera-logo.jpg', height = 101, width = 200),
    img(src= 'download.png', height = 50,width = 250),
    br(),
    HTML("<strong>Author: VARAMIHIR</strong>"),
    br(),
    HTML("<strong>Date: Feb08, 2018</strong>"),
    navbarPage("Coursera Data Science Capstone Project",
               # multi page userinterface that includes a navigation bar
               tabPanel("Prediction of the word",
                        sidebarLayout(
                          sidebarPanel(
                            textInput("inputText", "ENTER THE TEXT/ WORD/ SENTENCE HERE",value = ""),
                            hr(),
                            helpText("1 - YOU HAVE TO ENTER A WORD / PARTIALLY TEXT TO SEE THE NEXT WORD PREDICTION",
                                     hr(),
                                     "2 - AFTER THE TEXT INPUT THE PREDICT NEXT WORD WILL BE DISPLAYED",
                                     hr(),
                                     "3 - THE FORWARD WORD IS SHOWED AT THE PREDICT NEXT WORD TEXT BOX ON THE RIGHT SIDE"),
                            hr()
                          ), # end of sidebar panel
                          
                          mainPanel(
                            strong(h4("FOLLOW THE PREDICT NEXT WORD")),
                            verbatimTextOutput("prediction"),
                            strong("WORD / TEXT / SENTENCE ENTERED:"),
                            strong(code(textOutput('sentence1'))),
                            br(),
                            strong("USING SEARCH AT N-GRAMS TO SHOW NEXT WORD:"),
                            strong(code(textOutput('sentence2')))
                          ) # mainPanel
                        ) #sidebar Layout
                        
               )# tabPanel Prediction
               
               
    ) #Navbar Page
  ) #fluid page
)  # shinyUI


