#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Predicate Diabetes Status"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
                sliderInput("pregnant","Number of times pregnant",min = 0,max = 17,value = 3),
            sliderInput("glucose","Plasma glucose conentration",min = 0,max = 199,value = 117),
            sliderInput("pressure","Diastolic blood pressure",min = 0,max = 122, value = 72),
            sliderInput("triceps", "Triceps skin fold thickness (mm)", min = 0,max = 99, value = 23),
            sliderInput("insulin", "2-Hour serum insulin (mu U/ml)", min = 0, max = 846, value = 30.5),
            sliderInput("mass", "Body mass index ((weight in kg/height in m)^2)", min =0 , max = 67.1,value = 32),
            sliderInput("pedigree","Diabetes pedigree function", min = 0.078, max=2.420, value = 0.3725),
            sliderInput("age", "Age(years)",min = 21, max = 81, value = 29)
            ),

        # Show a plot of the generated distribution
        mainPanel(

            tabPanel("Main Panel"),
            plotOutput("TotalPlot"),
            h3("Probability of negative test for diabetes"),
            textOutput("pred1"),
            h3("Probability of positive test for diabetes"),
            textOutput("pred2"),
            h3("Instruction:"),
            h5("This R shiny application used the PimaIndiansDiabetes data from mlbench package to train the random forest algorithm to predict the test of diabetes. Please enter a valid patient characteristic and lab test. You can get the probability of getting a negative diabetes test and the probability of getting a positive diabetes test from this application.") 


        )
        
        )
    )
)
