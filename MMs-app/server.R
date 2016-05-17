library(shiny)
library(reshape2); library(ggplot2)
mcolors<-c("Blue","Brown","Green","Orange","Red","Yellow")
cp<-c(0.24,0.13,0.16,0.20,0.13,0.14)
testfunction<-function(p,alpha){
        if(p<alpha) "is"
        else "is not"
}
shinyServer(
        function(input, output) {
                
                colorvec<-reactive({
                        c(input$blue,input$brown,input$green,
                                  input$orange,input$red,input$yellow)
                })
                expected<-reactive({
                        sum(colorvec())*cp
                })
                chisq<-reactive({
                        sum((colorvec()-expected())^2/expected())
                })
                dfr<-reactive(data.frame(color=mcolors,
                                         observed=colorvec(),
                                         expected=expected(),
                                         chisq=(colorvec()-expected())^2/expected()))
                dfm<-reactive({
                        melt(data.frame(color=mcolors,observed=colorvec(),
                                    expected=expected()),id.vars="color")
                })
                pvalue<-reactive({pchisq(chisq(),df=5,lower.tail=FALSE)})
                output$Table<-renderTable(dfr())
                output$total<-renderText({paste("Total M&Ms =",sum(colorvec()))})
                output$chisq<-renderText({paste("Chi-Squared =",round(chisq(),3))
                  })
                output$pvalue<-renderText({paste("P-value =",round(pvalue(),3))})
                output$conclusion<-renderText({paste("There",
                                                     testfunction(pvalue(),input$alpha),
                                                     "sufficient evidence to conclude
                                                     that the color distribution does not
                                                     match the assumed distribution.")
                        })
                
                output$plot<-renderPlot({
                        ggplot(dfm(),aes(x=color,value,fill=variable))+
                                geom_bar(stat="identity",position="dodge")+
                                labs(title="Observed and expected color frequencies")+
                                labs(x="Color")+
                                labs(y="Frequency")
               })
                        
               
        }
)