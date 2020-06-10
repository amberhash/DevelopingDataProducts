#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(randomForest)
library(gridExtra)
library(mlbench)
data("PimaIndiansDiabetes")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    rf_model<-
        randomForest(diabetes ~., data = PimaIndiansDiabetes, mtry = 8, ntree=50, importance = TRUE)
    rf_pred<-reactive({
        pregnantInput <- input$pregnant
        glucoseInput <-input$glucose
        pressureInput <- input$pressure
        tricepsInput <- input$triceps
        insulinInput <- input$insulin
        massInput <- input$mass
        pedigreeInput <- input$pedigree
        ageInput <- input$age

        predict(rf_model, 
                newdata = data.frame(pregnant = pregnantInput,glucose = glucoseInput,
                                     pressure = pressureInput, triceps = tricepsInput,
                                     insulin = insulinInput, mass = massInput,
                                     pedigree = pedigreeInput, age = ageInput),type="prob")
    })   
    output$TotalPlot <- renderPlot({
        pregnantInput <- input$pregnant
       p1<- ggplot(data=PimaIndiansDiabetes,aes(x=pregnant,col=diabetes))+geom_histogram()+geom_vline(xintercept= pregnantInput,col="red",size=1)

        glucoseInput <- input$glucose
       p2<-ggplot(data=PimaIndiansDiabetes,aes(x=glucose,col=diabetes))+geom_histogram()+geom_vline(xintercept= glucoseInput,col="red",size=1)

        pressureInput <- input$pressure
        p3<-ggplot(data=PimaIndiansDiabetes,aes(x=pressure,col=diabetes))+geom_histogram()+geom_vline(xintercept= pressureInput,col="red",size=1)

        tricepsInput <- input$triceps
        p4<-ggplot(data=PimaIndiansDiabetes,aes(x=triceps,col=diabetes))+geom_histogram()+geom_vline(xintercept= tricepsInput,col="red",size=1)
        
        insulinInput <- input$insulin
        p5<-ggplot(data=PimaIndiansDiabetes,aes(x=insulin,col=diabetes))+geom_histogram()+geom_vline(xintercept= insulinInput,col="red",size=1)

        massInput <- input$mass
        p6<-ggplot(data=PimaIndiansDiabetes,aes(x=mass,col=diabetes))+geom_histogram()+geom_vline(xintercept= massInput,col="red",size=1)

        pedigreeInput <- input$pedigree
        p7<-ggplot(data=PimaIndiansDiabetes,aes(x=pedigree,col=diabetes))+geom_histogram()+geom_vline(xintercept=pedigreeInput,col="red",size=1)

        ageInput <- input$age
        p8<-ggplot(data=PimaIndiansDiabetes,aes(x=age,col=diabetes))+geom_histogram()+geom_vline(xintercept= ageInput,col="red",size=1)
        grid.arrange(p1,p2,p3,p4,p5,p6,p7,p8,ncol=4)
    })
    output$pred1 <- renderText({
        rf_pred()[1,1]
    })
    output$pred2 <- renderText({
        rf_pred()[1,2]
    })
})
