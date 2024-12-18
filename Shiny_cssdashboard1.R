## app.R ##
#library(semantic.dashboard)
#library(shiny.semantic)
library(shiny)
library(shinydashboard)
library(tidyverse)
library(readr)
library(shinyTime)
library(lubridate)
library(ggplot2)
library(dplyr)

# Importing data
setwd("~/R/MScA/2024/Capstone Project")
demand_supply <- read.csv("demand_supply.csv")
head(demand_supply)

# Getting Date and Time field
date_field <- as.POSIXct(demand_supply$trip_start, format="%Y-%m-%d %H:%M:%S")
 
# Extract the date
demand_supply$start_date <- as.Date(date_field)

# Extract the hour
demand_supply$start_time <- hour(date_field)

demand_supply %>%
    filter(Community == 8 & start_date == '2023-06-30' & start_time == 23)


ui <- dashboardPage(skin = 'green',
    dashboardHeader(title = "E-Scooter Dashboard"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard"))
            )
    ),
    dashboardBody(
        
        # Add custom CSS for valueBox
        tags$head(
            tags$style(HTML("
                .row {
                    margin-top: 25px;
                }
                .box:has(.control-label) {
                    border-radius: 12px !important;
                    height: 128px !important;
                    margin-bottom: 20px !important;
                }
                .control-label {
                    margin-bottom: 14px !important;
                    font-size: 18px !important;
                    color: grey !important;
                }
                .selectize-input {
                    font-size: 17px !important;
                    min-height: 45px !important;
                    border-radius: 3px !important;
                }
                .box-body {
                    border-radius: 12px !important;
                }
                .form-control {
                    border-radius: 3px !important;
                    height: 45px !important;
                    font-size: 17px !important;
                }
                .selectize-input .item{
                    vertical-align: sub !important;
                }
                .small-box {
                    height: 343px !important;
                    /*border: 1px solid #000000 !important;*/
                    border-radius: 12px !important;
                    padding-left: 18px !important;
                    border-bottom: 5px solid #00a65a !important;
                    background-color: #FFFFFF !important;
                    /*box-shadow: 0 9px 7px rgb(0 0 0 / 10%) !important;*/
                }
                .small-box h3 {
                    font-size: 100px !important;
                    font-size: 5.5vw !important;
                    color: grey;
                }
                .small-box p {
                    font-size: 23px !important;
                    color: #00a65a !important;
                    font-weight: bold;
                }
                .small-box p.description {
                    font-size: 16px !important;
                    font-weight: normal;
                    color: gray;
                }
                .small-box .icon-large {
                    right: 35px !important;
                }
                .box.box-solid.box-info, .box.box-solid.box-success {
                    border: 0px;
                    border-radius: 12px !important;
                }
                .box.box-solid.box-info>.box-header, .box.box-solid.box-success>.box-header {
                    color: #FFFFFF;
                    background-color: #7e8380;
                    border-top-left-radius: 12px;
                    border-top-right-radius: 12px;
                    padding: 14px 0 14px 14px;
                }
                .box-header .box-title {
                    font-size: 20px;
                }
                .description {
                    font-size: 17px;
                    font-weight: normal;
                    color: grey;
                    display: block;
                    line-height: 1.3;
                    margin-top: 5px;
                }
            "))
        ),
        
        fluidRow(
            box(selectInput("Community", "Select Community", choices = unique(demand_supply$Community)), width = 4),
            box(dateInput("start_date", "Select Date", value = as.Date("2023-06-30")), width = 4),
            box(selectInput("start_time", "Select Time", choices =  unique(demand_supply$start_time)), width = 4)
        ),
        
        fluidRow(
            valueBoxOutput("start_count", width = 3),
            valueBoxOutput("end_count", width = 3),
            valueBoxOutput("supply_index",  width = 3),
            valueBoxOutput("demand_index",  width = 3)
        ),
        
        fluidRow(
            box(title = "Count of Trips for the Day", plotOutput("barplot"), status = "info", solidHeader = T, width = 6),
            box(title = "Supply-Demand Index Variation Throughout the Day", plotOutput("lineplot"), status = "success", solidHeader = T, width = 6)
        )
    )
)         
           

server <- function(input, output) { 
    
    selected_df <- reactive({
        demand_supply %>%
            filter(Community == input$Community & start_date == input$start_date & start_time == input$start_time)
    })
    
    output$start_count <- renderValueBox({
        valueBox(
            subtitle = HTML(paste("Predicted Start Count", "<br>", "<span class=\"description\">The number of trips that started in the specified community at a particular date and time</span>")),
            value = selected_df()$Predicted_start_count,
            icon = icon("bicycle")
            
        )
    })
    
    output$end_count <- renderValueBox({
        valueBox(
            subtitle = HTML(paste("Predicted End Count", "<br>", "<span class=\"description\">The number of trips that ended in the specified community at a particular date and time</span>")),
            value = selected_df()$Predicted_end_count,
            icon = icon("bicycle")
            
        )
    })
    
    output$supply_index <- renderValueBox({
        valueBox(
            subtitle = HTML(paste("Low Supply Index", "<br>", "<span class=\"description\">The index showing likelihood of inadequate scooter stock, scale 0 - 3</span>")),
            value = selected_df()$supply_index,
            icon = icon("arrow-up-from-ground-water")
        )
    })
    
    output$demand_index <- renderValueBox({
        valueBox(
            subtitle = HTML(paste("Unmet Demand Index", "<br>", "<span class=\"description\">The index showing likelihood of unmet demand, scale 0 - 7</span>")),
            value = selected_df()$unmet_demand_index,
            icon = icon("chart-simple")
        )
    })
    
    output$barplot <- renderPlot({
        demand_supply %>%
            filter(Community == input$Community & start_date == input$start_date) %>%
            ggplot(aes(x = factor(start_time), y = Predicted_start_count)) + 
            geom_col(fill = "#00a65a") +
            labs(x = "Hours", y = "E-Scooter Trips Taken") +
            theme_bw() +
            theme(
                axis.text.x = element_text(size = 14),
                axis.text.y = element_text(size = 14),
                axis.title.x = element_text(size = 16),
                axis.title.y = element_text(size = 16)
            )
            
    })
    
    output$lineplot <- renderPlot({
        demand_supply %>%
            filter(Community == input$Community & start_date == input$start_date) %>%
            pivot_longer(cols = c(supply_index, unmet_demand_index), names_to = "Index_Type", values_to = "Index_Value") %>%
            ggplot(aes(x = start_time, y = Index_Value, color = Index_Type)) +
            geom_line(size = 1) +
            geom_point() +
            scale_color_manual(values = c("supply_index" = "turquoise2", "unmet_demand_index" = "#00a65a"),
                               labels = c("Supply Index", "Unmet Demand Index")) +
            labs(
                x = "Hour of the Day",
                y = "Index Value",
                color = "Index Type") +
            theme_bw() +
            scale_x_continuous(breaks = seq(0, 23, by = 1)) +
            theme(
                axis.text.x = element_text(size = 14),
                axis.text.y = element_text(size = 14),
                axis.title.x = element_text(size = 16),
                axis.title.y = element_text(size = 16)
            )
    
    })

}

shinyApp(ui, server)