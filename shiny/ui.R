# initialization 
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel(
    h1("PM25 Emissions per type and year in Baltimore",align="center"),
  ),
  
  # Sidebar Panel with UI controls
  sidebarLayout(
    
    sidebarPanel(
      strong("Options to play with graphic:"),
      br(), 
      br(),

      checkboxGroupInput("graph_options", "Graph Options:",
                         c("Single Graphic" = "1",
                           "Show mean" = "2",
                           "Show point labels" = "3")),
      
      radioButtons("show_legend", "Legend:",
                   c("On" = "on",
                     "Off" = "off")),
      
      
      sliderInput("text_size",
                  "Text Size:",
                  min = 1,
                  max = 10,
                  step=1,
                  value = 1),
      

      br(),
      br(),
      h4('Output messages responding to input selected options:'),
      verbatimTextOutput("message1"),      
      verbatimTextOutput("message2"),      
      verbatimTextOutput("message3"),
      verbatimTextOutput("message4"),
      br()
      
    ), # sidebarPanel  

    # Show the plot and output messages
    mainPanel(
      plotOutput("plot", width = "100%", height = "400px"),
      br(),
      br(),
      p("This is a just simple shiny app to play with plotting options."),            
      p("The simple calculation done is the adjusting of the scale of text labels from 1/10 to 2/5 in graphic."),                  
      p("Note in the left side the output messages according the selected input options."),
      p("This data set used is the one used in the Peer Assignment 2 of previous course Exploratory Data Analysis. It contains data about pollutants in the US."),
      p("You can see the source code of that assignment ",
        a("here.", 
          href = "https://github.com/miquel-corral/ExData_Plotting2.git")),   
      p("The source code of this Shiny App is ",
        a("here.", 
          href = "https://github.com/miquel-corral/Data_Products_PA1.git"))   
      
    )
  ) # sidebarLayout  
  ) # fluidPage
) # shinyUI