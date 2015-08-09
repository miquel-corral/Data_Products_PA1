# initialization code
library(ggplot2)
par(bg="transparent")
dev.off() 

# load dataset code
dataset <- read.csv("PM25EmissionsBaltimore.csv")

# function to set scale of text labels
setLabelSize <- function(inputSize){
  graphicSize = inputSize/2
  if (graphicSize < 2){
    graphicSize = 2
  }
  graphicSize
}

# shiny server function
shinyServer(
  function(input, output) {

    output$plot <- renderPlot({
      g <- ggplot(dataset, aes(year, emissions))
      g <- g + geom_line(aes(color=type)) + 
        geom_point(aes(color=type)) + 
        labs(title="Total Emissions per type and year in Baltimore") + 
        labs(x="Year") + labs(y="Total Emissions (thousands of tons)") + 
        theme_bw(base_family="Times")
      if("1" %in% input$graph_options){
        output$message1 <- renderPrint({"Single plot all types"})        
      }else{
        g <- g + facet_grid(. ~ type)         
        output$message1 <- renderPrint({"Sepparate plot per type"})        
      }
      if("2" %in% input$graph_options){
        g <- g + geom_line(stat = "hline", yintercept = "mean")        
        output$message2 <- renderPrint({"Show mean line"})                
      }else{
        output$message2 <- renderPrint({"Do not show mean line"})                        
      }
      if("3" %in% input$graph_options){
        g <- g + geom_text(hjust=0, vjust= 1, size=setLabelSize(input$text_size), angle=45, aes(label=emissions))  
        output$message3 <- renderPrint({"Show text labels"})                
      }else{
        output$message3 <- renderPrint({"Do not show text lables"})                        
      }      
      if(input$show_legend == "on"){
        output$message4 <- renderPrint({"Legend On"})                        
      }else{
        g <- g + theme(legend.position="none")
        output$message4 <- renderPrint({"Legend Off"})                                
      }
      print(g)
    })
    output$graph_options <- renderPrint({input$graph_options})
  }
)