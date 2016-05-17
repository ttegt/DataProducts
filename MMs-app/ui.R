shinyUI(fluidPage(
        titlePanel("Chi-squared Testing with M&Ms"),
        
        sidebarLayout(
                sidebarPanel(
                        h2("Input"),
                       numericInput("blue", "Blue =",value=24),
                       numericInput("brown", "Brown =",value=13),
                       numericInput("green", "Green =",value=16),
                       numericInput("orange", "Orange =",value=20),
                       numericInput("red", "Red =",value=13),
                       numericInput("yellow", "Yellow =",value=14),
                       radioButtons("alpha","Level of Significance",
                                    choices=c(0.01,0.05,0.1),
                                    selected=0.01)
                       ),
                
                mainPanel(
                        h1("Output"),
                        tableOutput("Table"),
                        textOutput("total"),
                        textOutput("chisq"),
                        textOutput("pvalue"),
                        em(textOutput("conclusion")),
                        plotOutput("plot")
                )
        )
))