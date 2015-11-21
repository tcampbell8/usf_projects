library(base)
library(rjson)
trans <- read.csv(file.choose()) #Choose transactions.csv

unique_id_list <- unique(trans$profile_id)

for (i in unique_id_list){
  data <- subset(trans, trans$profile_id == i)
  data <- data[order(data$created),]
  N <- nrow(data)
  times <- array()
  if (N>1){
    for (j in 1:(N-1)){
      times[j] <- (as.POSIXlt(data$created[j+1]) - as.POSIXlt(data$created[1]))
    }
    FF <- as.matrix(t(sort(times)))
    write.table(FF, file = "freshstep_lifecycles.csv", sep = ",", col.names = FALSE, append=TRUE)
  }
}
