#data <- as.data.frame(read.csv("data.csv"))

library (stringr)

#----------------------------------------
#           The most common drugs
#----------------------------------------

selectDrug <- function(drugName){
  matching_vector <- c( (str_detect(data$category, drugName)))
  return(matching_vector)
}

drugs <- c("Cocaine", "Meth", "LSD", "Opioids", "Cannabis", "Steroids", "Ecstasy", "Ketamine", "Heroin","Shrooms", "Tobacco", "Benzos", "Paraphernalia")

freq <- c()
for(i in 1:length(drugs)){
  matching_vector <- selectDrug(drugs[i]);
  sumup<-summary(matching_vector)
  freq[i] <- sumup[3]
}

freq <- as.numeric(freq)

res <- data.frame(drugs, freq)
res <- res[order(res$freq, decreasing = TRUE),]

# Calculation in percentage
piepercent<- round(100*res$freq/sum(res$freq), 1)
  # round(a,1) : one digit after the comma

#----------------------------------------
#               Pie Chart 
#----------------------------------------

  # 1 - Labels :
  lab <- c()
  
  for(i in 1:length(piepercent)) {
    lab[i] <- paste(piepercent[[i]], "%", sep=" ")
  }
  
  # 2 - Title :
  title <- "Distribution of drugs"
  
  # 3 - Colors :
  c <- rainbow(length(piepercent))
  
  library(plotrix)
  #par(mar=c(10,1,1,1))
  
  # 4 - Plot :
  pie3D(piepercent,labels = lab, main = title ,col=c, theta = 0.9, explode = 0.05)
  pie3D
  
  # 5 - Legend :
  legend(x=-1.5,y=-1,res$drugs, cex = 0.9, fill = c,ncol=5,border=NA, xpd=NA)

  