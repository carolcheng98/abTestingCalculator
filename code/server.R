library(shiny)
library(ggplot2)
tryIE <- function(code, silent=F){
  tryCatch(code, error = function(c) 'Error: Please check your input or consult the developer',
           warning = function(c) 'Error: Please check your input or consult the developer',
           message = function(c) 'Error: Please check your input or consult the developer')
}

shinyServer(
  function(input, output) {    
    
    url <- a("Tutorial", href="https://www.notion.so/Hypothesis-Test-Sample-Size-Calculator-Tutorial-d9e75337ce60401cbbc9ff98eaef0106")
    
    # proportion test
    numlift <- reactive({
      switch(input$lift,"1%"=0.01,"5%" =0.05,
             "10%" = 0.10,"15%"=0.15,"20%"=0.20, "50%"=0.50, "100%"=1.00)
    })
    numsif <- reactive({
      switch(input$sif,"80%"=0.80,"85%" =0.85,
             "90%" = 0.90,"95%"=0.95)
    })
    
    texttime_unit <- reactive({
      switch(input$time_unit, "Day(s)"="Daily","Week(s)"="Weekly",
             "Month(s)"="Monthly","Year(s)"="Annually")
    })
    
    textperiod <- reactive({
      switch(input$period, "Daily"="days","Weekly"="weeks",
             "Monthly"="months","Annually"="years")
    })
    
    number <- reactive({ceiling(power.prop.test(p1=input$avgRR/100,
                                                p2=input$avgRR/100*(1+input$lift/100),
                                                sig.level=1-numsif(), 
                                                power=0.8)[[1]])
    })
    
    output$liftText <- renderText({
      paste('Statistically significant differences can be observed if the response rate is', 
            as.character(input$avgRR*(1+input$lift/100)),'% or higher.'
      )
    })
    
    output$text1 <- renderText({ 
      "The number of samples in each group is "
    })
    
    output$value1<-renderText({
      
      tryIE(number())
    })
    
    output$text2 <- renderText({ 
      "The total number of samples you need is "
    })
    
    output$value2 <- renderText({
      
      tryIE(number()*input$num)
      
    })
    
    output$text3 <- renderText({ 
      paste('The time period needed for getting the minimum sample size (for all groups) is
            from', 
            as.character(tryIE(floor(number()*input$num/input$imps))), 
            'to',
            as.character(tryIE(ceiling(number()*input$num/input$imps))),
            as.character(textperiod())
      )
    })
    
    output$text4 <- renderText({ 
      paste(as.character(texttime_unit()),
            'traffic for getting the minimum sample size (for all groups) is', 
            as.character(tryIE(ceiling(number()*input$num/input$time)))
      )
    })
    
    output$tab <- renderUI({
      tagList("If you want to know more details, please check out the ",url)
    })
    

    # t-test
    numsif_t <- reactive({
      switch(input$conf_level,"80%"=0.80,"85%" =0.85,
             "90%" = 0.90,"95%"=0.95)
    })
    
    alt_t <- reactive({
      switch(input$alt,"mu1!=mu2"="two.sided","mu1>mu2"="one.sided","mu1<mu2"="one.sided")
    })
    
    texttime_unit_t <- reactive({
      switch(input$unit, "Day(s)"="Daily","Week(s)"="Weekly",
             "Month(s)"="Monthly","Year(s)"="Annually")
    })
    
    textperiod_t <- reactive({
      switch(input$prd, "Daily"="days","Weekly"="weeks",
             "Monthly"="months","Annually"="years")
    })
    
    
    number_t <- reactive({ceiling(power.t.test(delta=input$d,
                                                sig.level=1-numsif_t(), 
                                               sd=input$std,
                                                power=0.8,
                                               alternative=alt_t(),
                                               type ="two.sample")[[1]])
    })
    

    
    output$oup1 <- renderText({ 
      "The number of samples in each group is "
    })
    
    output$val1<-renderText({
      
      tryIE(number_t())
    })
    
    output$oup2 <- renderText({ 
      "The total number of samples you need is "
    })
    
    output$val2 <- renderText({
      
      tryIE(number_t()*input$groups)
      
    })
    
    output$oup3 <- renderText({ 
      paste('The time period needed for getting the minimum sample size (for all groups) is
            from', 
            as.character(tryIE(floor(number_t()*input$groups/input$samprd))), 
            'to',
            as.character(tryIE(ceiling(number_t()*input$groups/input$samprd))),
            as.character(textperiod())
      )
    })
    
    output$oup4 <- renderText({ 
      paste(as.character(texttime_unit_t()),
            'traffic for getting the minimum sample size (for all groups) is', 
            as.character(tryIE(ceiling(number_t()*input$groups/input$duration)))
      )
    })
    
  })

