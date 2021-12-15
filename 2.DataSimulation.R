#
#testing?
#

n.batch <- c(1:50)
n.pieces <- c(1:10)

#Stage 1 factor
people.1 <- c("Nora", "Thor", "Jimmy")
sand.bad.good <- c(30, 40)

#Stage 2 factor
#lower temperature = higher defect rate (defect = 1)
temp.bad.good <- c(200, 300)
#people
people.2 <- c("Cagney", "Lacey")
#time of a melt
time.good.bad <- c(60, 80)

#Stage 3 factors
carb.good.bad <- c(0.2, 0.4)

#Stage 4 factors
people.4 <- c("Lyla", "Mary")



# let's make a data set
names.col <- c("batch", "unique.ID", 
               "person.1.1", "person.1.2", "sand", 
               "temp",  
               "carb", 
               "defect.1", "defect.2", "defect.3")


all.data <- as.data.frame(matrix(NA, nrow = 1,
                                 ncol = length(names.col)))
head(all.data)
colnames(all.data) <- names.col




# defects for different variables
# define which variable determines the defect
var.defect <- "person"


#defect set at a normal pace
defect.normal <- 0.1
defect.middle <- 0.3
defect.high <- 0.9
defect.person <- "Thor"





for(i in 1:length(n.batch)){
  
  # i <- 1
  name.batch.t <- rep(n.batch[i], length(n.pieces))
  unique.ID.t <- paste( rep(n.batch[i], length(n.pieces)), n.pieces, sep = "." )
  people.1.t <- sample(people.1, 2)
  person.1.t <- rep(people.1.t[1], length(n.pieces))
  person.2.t <- rep(people.1.t[2], length(n.pieces))
  
  #for sand
  sand.t <- rep(round(runif(1, sand.bad.good[1], sand.bad.good[2]),2), 
                length(n.pieces))
  # make temp
  temp.t <- rep(round(runif(1, temp.bad.good[1], temp.bad.good[2]),2), 
                length(n.pieces)) 
  carb.t <- rep(round(runif(1, carb.good.bad[1], carb.good.bad[2]),2), 
                length(n.pieces)) 
  
  # ----add defects linked with specific variable
  
    #sand stuff
    sand.range <- sand.bad.good[2] - sand.bad.good[1]
    sand.fail <- (sand.t[1] - sand.bad.good[1])/sand.range
    
    carb.range <- carb.good.bad[2] - carb.good.bad[1]
    carb.fail <- (carb.t[1] - carb.good.bad[1])/carb.range

    # determine probability defect
    # what is temperate range?
    temp.range <- temp.bad.good[2] -  temp.bad.good[1]
    temp.fail <- (temp.t[1] - temp.bad.good[1])/temp.range
    # draw defects from
    defect.1.t <- rbinom(length(n.pieces), size = 1, sand.fail)
    defect.2.t <- rbinom(length(n.pieces), size = 1, temp.fail)
    #defect.3.t <- rbinom(length(n.pieces), size = 1, carb.fail)

if(carb.t[1] <= 0.3){
  defect.3.t <-rbinom(length(n.pieces), size = 1, defect.normal)
}else{
  defect.3.t <-rbinom(length(n.pieces), size = 1, defect.high)
}
  

    
    
    
  # if(var.defect == "person"){
  #   # let's add a defect based on the person
  #   # if thor is involved, defect rates goes to person.defect
  #   if(people.t[1] == defect.person || people.t[2] == defect.person){
  #     # persin is the 'defect person' so high faillure rate
  #     defect.t <- rbinom(length(n.pieces), size = 1, defect.high)
  #   }else{
  #     # person of interest is not in the 
  #     defect.t <- rbinom(length(n.pieces), size = 1, defect.normal)
  #   }
  # }
  
  
  
  # turn this into data frame
  data.t <- cbind.data.frame(name.batch.t, unique.ID.t, person.1.t, person.2.t, 
                             sand.t,  
                             temp.t,carb.t, defect.1.t, defect.2.t, defect.3.t)
  colnames(data.t) <- names.col
  
  # let's put this into the big data frame all.data
  all.data <- rbind.data.frame(all.data, data.t)
  
}

str(all.data)




