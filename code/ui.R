library(shiny)
library(ggplot2)
shinyUI(fluidPage(
   titlePanel("A/B Test Sample Size Estimator"),

   br(),
   
  navlistPanel(
    
    tabPanel("Example & Tutorial",
             column(6,
                    
                            helpText("We want to test the performance of a new text ad.
                                      Our control text ad has a 5% CTR, and we want to
                                      be able to detect a lift of at least 10% at 90%
                                      confidence."),
                             helpText("Enter Response Rate: 5%"),
                             helpText("Enter number of groups: 2"),
                             helpText("Select lift threshold of 10%"),
                             helpText("Select confidence level of 90%"),
                             helpText("The number of samples in each group is 24603,
                                      and the total number of samples is 49206."),
                             br(),
                             uiOutput("tab")
                             )
                    ),
    "Choose Your Metric Type",
    tabPanel("Rate (CTR, conversion rate, signup rate, purchase rate, etc.)",
             column(6, 
               h4("Choose the appropriate inputs for your test:"),
               numericInput("avgRR", label = "Baseline Conversion Rate", value = 5,
                            min = 0, step=1),
               helpText("Enter the baseline Conversion Rate, usually from your control."
               ),
               helpText("Ex: if your control has a 5% Conversion Rate, enter 5"
               ),
               hr(),
               
               numericInput("lift", label = "Minimum Detectable Lift", value = 5,
                            min = 0, step=1),
               helpText("Select the smallest expected lift relative to the Control group."
               ),
               helpText("Ex: if you expect a minimum lift of 5%, enter 5."
               ),
               helpText("Recommanded lift range: 1% ~ 100%."
               ),
               helpText("Higher lift thresholds require fewer samples."
               ),
               textOutput("liftText"),
               hr(),
               
               numericInput("num", label = "Number of Groups", value = 2),
               helpText("Enter the total number of groups in your test, 
                        including the control."
               ),
               helpText("Ex: if you're testing 1 control vs 2 treatments, enter 3.  (Assuming each group including control has the same size)"
               ),
               hr(),
               
               radioButtons("sif", label = "Confidence Level",
                            choices = list("80%","85%","90%","95%"),
                            selected = "95%",inline=T),
               helpText("Select the desired confidence level."
               ),
               helpText("Recommended confidence level: 95%."
               ),
               helpText("Higher confidence
                        levels require more samples."),
               hr()
             ),
               
               column(5,
                      tabsetPanel(
                        tabPanel("Results",
                                 br(),
                                 textOutput("text1"),
                                 verbatimTextOutput("value1"),
                                 textOutput("text2"),
                                 verbatimTextOutput("value2")
                        ),
                        tabPanel("Duration (Traffic Known)",
                                 br(),
                                 numericInput("imps", label = "Samples/Period", value=10000),
                                 helpText("Enter the number of samples per period."
                                 ),
                                 radioButtons("period", label = "Period",
                                              choices = list("Daily", "Weekly","Monthly","Annually"),
                                              selected ="Weekly",inline=T),
                                 helpText("Select the period."
                                 ),
                                 textOutput("text3")
                                 
                        ),
                        tabPanel("Traffic (Duration Known)",
                                 br(),
                                 numericInput("time", label = "Time Length", value=7),
                                 helpText("Enter how long you could run the test."
                                 ),
                                 radioButtons("time_unit", label = "Time Unit",
                                              choices = list("Day(s)", "Week(s)","Month(s)","Year(s)"),
                                              selected ="Day(s)",inline=T),
                                 helpText("Select the Time Unit"
                                 ),
                                 textOutput("text4")
                                 
                        )
                        )#tabsetpanel end
                      )#column end
                ),#Rate tab end
    
    tabPanel("Continuous/Counts (billing, time spend, frequency, downloads , etc.)",
             
             column(6, 
                    h4("Choose the appropriate inputs for your test:"),
                    # numericInput("baseline", label = "Mean Value for Metric in Control Group", value = 15,
                    #              min = 0, step=1),
                    # helpText("Enter the baseline value, usually from your control."
                    # ),
                    # helpText("Ex: if your control spends 15 minutes on the webpage on average, enter 15. "
                    # ),
            
                    
                    numericInput("d", label = "Minimum Detectable Lift", value = 5,
                                 min = 0, step=1),
                    helpText("Enter the smallest absolute lift compared to the Control group."
                    ),
                    helpText("Ex: if you expect a minimum lift of 5 minutes in time spent, enter 5."
                    ),
                    helpText("Higher lift thresholds require fewer samples."
                    ),
                    #textOutput("liftText_t"),
        
                    
                    numericInput("std", label = "Population Standard Deviation", value = 10
                                 ),
                    
                    numericInput("groups", label = "Number of Groups", value = 2),
                    helpText("Enter the total number of groups in your test, 
                             including the control."
                    ),
                    helpText("Ex: if you're testing 1 control vs 2 treatments, enter 3.  (Assuming each group including control has the same size)"
                    ),
                    hr(),
                    
                    radioButtons("alt", label = "Hypothesis Type",
                                 choices = list("mu1!=mu2","mu1>mu2","mu1<mu2"),
                                 selected = "mu1!=mu2",inline=T),
                  
                    radioButtons("conf_level", label = "Confidence Level",
                                 choices = list("80%","85%","90%","95%"),
                                 selected = "95%",inline=T),
                    helpText("Select the desired confidence level."
                    ),
                    helpText("Recommended confidence level: 95%."
                    ),
                    helpText("Higher confidence
                             levels require more samples."),
                    hr()
                    ),#column1 ends
             
             column(5,
                    tabsetPanel(
                      tabPanel("Results",
                               br(),
                               textOutput("oup1"),
                               verbatimTextOutput("val1"),
                               textOutput("oup2"),
                               verbatimTextOutput("val2")
                      ),
                      tabPanel("Duration (Traffic Known)",
                               br(),
                               numericInput("samprd", label = "Samples/Period", value=10000),
                               helpText("Enter the number of samples per period."
                               ),
                               radioButtons("prd", label = "Period",
                                            choices = list("Daily", "Weekly","Monthly","Annually"),
                                            selected ="Weekly",inline=T),
                               helpText("Select the period."
                               ),
                               textOutput("oup3")
                               
                      ),
                      tabPanel("Traffic (Duration Known)",
                               br(),
                               numericInput("duration", label = "Time Length", value=7),
                               helpText("Enter how long you could run the test."
                               ),
                               radioButtons("unit", label = "Time Unit",
                                            choices = list("Day(s)", "Week(s)","Month(s)","Year(s)"),
                                            selected ="Day(s)",inline=T),
                               helpText("Select the Time Unit"
                               ),
                               textOutput("oup4")
                               
                      )
                      )#tabsetpanel end
                    )#column2 ends
            )
  
)))
   

    # column(3, wellPanel(
    #   h4("Choose the appropriate inputs for your test:"),
    #   numericInput("avgRR", label = "Baseline Conversion Rate", value = 5,
    #                min = 0, step=1),
    #   helpText("Enter the baseline Conversion Rate, usually from your control."
    #   ),
    #   helpText("Ex: if your control has a 5% Conversion Rate, enter 5"
    #   ),
    #   hr(),
    #   numericInput("lift", label = "Minimum Detectable Lift", value = 5,
    #                min = 0, step=1),
    #   helpText("Select the smallest expected lift relative to the Control group."
    #   ),
    #   helpText("Ex: if you expect a minimum lift of 5%, enter 5."
    #   ),
    #   helpText("Recommanded lift range: 1% ~ 100%."
    #   ),
    #   helpText("Higher lift thresholds require fewer samples."
    #   ),
    #   textOutput("liftText"),
    #   hr()
    # )),
    # 
    # column(4, wellPanel(  
    #   numericInput("num", label = "Number of Groups", value = 2),
    #   helpText("Enter the total number of groups in your test, 
    #            including the control."
    #   ),
    #   helpText("Ex: if you're testing 1 control vs 2 treatments, enter 3.  (Assuming each group including control has the same size)"
    #   ),
    #   hr()
    #   )),
    # 
    # column(4,wellPanel(
    #   radioButtons("sif", label = "Confidence Level",
    #                choices = list("80%","85%","90%","95%"),
    #                selected = "95%",inline=T),
    #   helpText("Select the desired confidence level."
    #   ),
    #   helpText("Recommended confidence level: 95%."
    #   ),
    #   helpText("Higher confidence
    #            levels require more samples."
    #   ),
    #   hr()
    #   )),
    # 
    # column(5,
    #   tabsetPanel(
    #     tabPanel("Results",
    #              br(),
    #              textOutput("text1"),
    #              verbatimTextOutput("value1"),
    #              textOutput("text2"),
    #              verbatimTextOutput("value2")
    #     ),
    #     tabPanel("Duration (Traffic Known)",
    #              br(),
    #              numericInput("imps", label = "Samples/Period", value=10000),
    #              helpText("Enter the number of samples per period."
    #              ),
    #              radioButtons("period", label = "Period",
    #                           choices = list("Daily", "Weekly","Monthly","Annually"),
    #                           selected ="Weekly",inline=T),
    #              helpText("Select the period."
    #              ),
    #              textOutput("text3")
    #              
    #     ),
    #     tabPanel("Traffic (Duration Known)",
    #              br(),
    #              numericInput("time", label = "Time Length", value=7),
    #              helpText("Enter how long you could run the test."
    #              ),
    #              radioButtons("time_unit", label = "Time Unit",
    #                           choices = list("Day(s)", "Week(s)","Month(s)","Year(s)"),
    #                           selected ="Day(s)",inline=T),
    #              helpText("Select the Time Unit"
    #              ),
    #              textOutput("text4")
    #              
    #     ),
    #     tabPanel("Example/Tutorial",
    #              br(),
    #              helpText("We want to test the performance of a new text ad.
    #                       Our control text ad has a 5% CTR, and we want to
    #                       be able to detect a lift of at least 10% at 90%
    #                       confidence."),
    #              helpText("Enter Response Rate: 5%"),
    #              helpText("Enter number of groups: 2"),
    #              helpText("Select lift threshold of 10%"),
    #              helpText("Select confidence level of 90%"),
    #              helpText("The number of samples in each group is 24603,
    #                       and the total number of samples is 49206."),
    #              br(),
    #              uiOutput("tab")
    #     )
    #     
    #   )
    #   
    #   
    # )

    

# 
# fluidPage(
#   #title panel
#   titlePanel("A/B Test Sample Size Calculator"),
#   br(),
#   
#   #main panel
#   navlistPanel(
#     "Metric Type",
#     
#     #main page
#     tabPanel("Rate (CTR, conversion rate, signup rate, purchase rate, etc.)", 
#              
#              column(6,
#     
#                     #baseline
#                     numericInput("baseline1", label = "Baseline Value", value = 5),
#                     helpText("Enter the value of your baseline measurement, usually from your control. "
#                     ),
#                     hr()
#                     ,
#                     
#                     #lift
#                     numericInput("lift1", label = "Minimum Detectable Lift", value = 5,
#                                  min = 0, step=1),
#                     helpText("Select the smallest expected lift relative to the Control group."
#                     ),
#                     helpText("Ex: if you expect a minimum lift of 5%, enter 5."
#                     ),
#                     helpText("Recommanded lift range: 1% ~ 100%."
#                     ),
#                     helpText("Higher lift thresholds require fewer samples."
#                     ),
#                     textOutput("liftText"),
#                     hr()
#                     ,
#                     
#                     #number of groups
#                     numericInput("num1", label = "Number of Groups", value = 2),
#                     helpText("Enter the total number of groups in your test, 
#                              including the control."
#                     ),
#                     helpText(textOutput("test")),
#                     helpText("Ex: if you're testing 1 control vs 2 treatments, enter 3.  (Assuming each group including control has the same size)"
#                     ),
#                     hr()
#                     ,
#                     
#                     #condidence level
#                     selectInput(
#                       inputId = "conf_level1",
#                       label = "Confidence Level:",
#                       choice = list("80%" = "0.8", 
#                                     "85%" = "0.85", 
#                                     "90%" = "0.90",
#                                     "95%" = "0.95",
#                                     "99%" = "0.99"),
#                       
#                       "Select the desired confidence level.\n Recommended confidence level: 95%.\n
#                       Higher confidence levels require more samples."
#                     )
#                     ),
#              
#              column(5,
#                     
#                     tabsetPanel(
#                       tabPanel("Results",
#                                br(),
#                                textOutput("text1"),
#                                verbatimTextOutput("res"),
#                                textOutput("text2"),
#                                verbatimTextOutput("value2")
#                       ),
#                       tabPanel("Duration (Traffic Known)",
#                                br(),
#                                numericInput("imps", label = "Samples/Period", value=10000),
#                                helpText("Enter the number of samples per period."
#                                ),
#                                radioButtons("period", label = "Period",
#                                             choices = list("Daily", "Weekly","Monthly","Annually"),
#                                             selected ="Weekly",inline=T),
#                                helpText("Select the period."
#                                ),
#                                textOutput("text3")
#                                
#                       ),
#                       tabPanel("Traffic (Duration Known)",
#                                br(),
#                                numericInput("time", label = "Time Length", value=7),
#                                helpText("Enter how long you could run the test."
#                                ),
#                                radioButtons("time_unit", label = "Time Unit",
#                                             choices = list("Day(s)", "Week(s)","Month(s)","Year(s)"),
#                                             selected ="Day(s)",inline=T),
#                                helpText("Select the Time Unit"
#                                ),
#                                textOutput("text4")
#                                
#                                
#                       )
#                     )
#              )
#                     ),
#     
#     tabPanel("Count (billing, time spend, frequency, downloads , etc.)",
#              value="#ttest",

#                       column(6,
#                              
#                              #baseline
#                              numericInput("baseline2", label = "Baseline Value", value = 5),
#                              helpText("Enter the value of your baseline measurement, usually from your control. "
#                              ),
#                              hr()
#                              ,
#                              
#                              #lift
#                              numericInput("lift2", label = "Minimum Detectable Lift", value = 5,
#                                           min = 0, step=1),
#                              helpText("Select the smallest expected lift relative to the Control group."
#                              ),
#                              helpText("Ex: if you expect a minimum lift of 5%, enter 5."
#                              ),
#                              helpText("Recommanded lift range: 1% ~ 100%."
#                              ),
#                              helpText("Higher lift thresholds require fewer samples."
#                              ),
#                              textOutput("liftText"),
#                              hr()
#                              ,
#                              
#                              #number of groups
#                              numericInput("num2", label = "Number of Groups", value = 2),
#                              helpText("Enter the total number of groups in your test, 
#                                       including the control."
#                              ),
#                              helpText(textOutput("test")),
#                              helpText("Ex: if you're testing 1 control vs 2 treatments, enter 3.  (Assuming each group including control has the same size)"
#                              ),
#                              hr()
#                              ,
#                              
#                              #condidence level
#                              selectInput(
#                                inputId = "conf_level2",
#                                label = "Confidence Level:",
#                                choice = list("80%" = 0.8, 
#                                              "85%" = 0.85, 
#                                              "90%" = 0.90,
#                                              "95%" = 0.95,
#                                              "99%" = 0.99),
#                                
#                                "Select the desired confidence level.\n Recommended confidence level: 95%.\n
#                                Higher confidence levels require more samples."
#                              )
#                              ),
#                       
#                       column(5,
#                              
#                              tabsetPanel(
#                                tabPanel("Results",
#                                         br(),
#                                         textOutput("text1"),
#                                         verbatimTextOutput("value1"),
#                                         textOutput("text2"),
#                                         verbatimTextOutput("value2")
#                                ),
#                                tabPanel("Duration (Traffic Known)",
#                                         br(),
#                                         numericInput("imps", label = "Samples/Period", value=10000),
#                                         helpText("Enter the number of samples per period."
#                                         ),
#                                         radioButtons("period", label = "Period",
#                                                      choices = list("Daily", "Weekly","Monthly","Annually"),
#                                                      selected ="Weekly",inline=T),
#                                         helpText("Select the period."
#                                         ),
#                                         textOutput("text3")
#                                         
#                                ),
#                                tabPanel("Traffic (Duration Known)",
#                                         br(),
#                                         numericInput("time", label = "Time Length", value=7),
#                                         helpText("Enter how long you could run the test."
#                                         ),
#                                         radioButtons("time_unit", label = "Time Unit",
#                                                      choices = list("Day(s)", "Week(s)","Month(s)","Year(s)"),
#                                                      selected ="Day(s)",inline=T),
#                                         helpText("Select the Time Unit"
#                                         ),
#                                         textOutput("text4")
#                                         
#                                         
#                                )
#                              )
#                       
#                              )
#              
#     )
#     
#     )
#   
#   
#   
#   )
