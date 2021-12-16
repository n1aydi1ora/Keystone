###
###This file is simulating a dataset for a foundry.
###Dataset needs: batch number, unique identifier, explanatory variable for each
###stage and response (defect) variable for each stage
###
###The script can be enhanced by fully putting in categorical variables into the 
###dataset. An example of adding defects based on people is commented below.
###Defects are done baed on numerical factors at this point

###Parameters can be changed to explore the behaviour of models


#Setting the length of the dataset to variables
#For each batch we will have a number of products (n.pieces)
n.batch <- c(1:50)
n.pieces <- c(1:10)

#Stage 1 explanatory variables: amount of sand and people working
#Three people work at this stage
people.1 <- c("Nora", "Thor", "Jimmy")
#range of sand 
sand.bad.good <- c(30, 40)

#Stage 2 explanatory variable: temperature of the melt, people, melting time
#range of temperature
temp.bad.good <- c(200, 300)
#people
people.2 <- c("Cagney", "Lacey")
#time of a melt
time.good.bad <- c(60, 80)

#Stage 3 explanatory variable
carb.good.bad <- c(0.2, 0.4)

#Stage 4 explanatory variable
people.4 <- c("Lyla", "Mary")



# let's make a data set
# a vector of column names
names.col <- c("batch", "unique.ID", 
               "person.1.1", "person.1.2", "sand", 
               "temp", "time", 
               "carb", 
               "defect.1", "defect.2", "defect.3", "defect.4")

#creating a dataframe with 1 row of NAS, and number of columns as in names.col
all.data <- as.data.frame(matrix(NA, nrow = 1,
                                 ncol = length(names.col)))
#checking all.data
head(all.data)
#naming columns by the vector of names above
colnames(all.data) <- names.col



#variables for defect rates
#will be used below
defect.normal <- 0.1
defect.almost.normal <- 0.12
defect.middle <- 0.3
defect.high <- 0.9

#currently in the commented section
defect.person <- "Thor"




#setting up data
# filling data for each batch (n.batch)
# number of rows in each batch is n.pieces
for(i in 1:length(n.batch)){
  
  ###
  # setting up each batch number 10 times(length of n.pieces)
  ###
  # all variables are set 10 times per batch
  # only identifiers will be numbered within a batch, all other parameters will
  # stay the same
  name.batch.t <- rep(n.batch[i], length(n.pieces))
  #assigning a unique number to each product
  #putting together a batch number and a number of product within a batch
  unique.ID.t <- paste( rep(n.batch[i], length(n.pieces)), n.pieces, sep = "." )
  #two people work on each batch
  #choosing two people out of people.1 randomly
  people.1.t <- sample(people.1, 2)
  #assigning each person to a different variable
  person.1.t <- rep(people.1.t[1], length(n.pieces))
  person.2.t <- rep(people.1.t[2], length(n.pieces))
  
  ###
  # setting numerical explanatory variables for each stage by generating random 
  ###
  # numbers using runif (uniform distribution) within each range
  # rounding each number to 2 decimal points
  #for sand
  sand.t <- rep(round(runif(1, sand.bad.good[1], sand.bad.good[2]),2), 
                length(n.pieces))
  # for temp
  temp.t <- rep(round(runif(1, temp.bad.good[1], temp.bad.good[2]),2), 
                length(n.pieces)) 
  #for carb
  carb.t <- rep(round(runif(1, carb.good.bad[1], carb.good.bad[2]),2), 
                length(n.pieces)) 
  #for time
  time.t <- rep(round(runif(1, time.good.bad[1], time.good.bad[2]),2), 
                length(n.pieces))
  
  ###
  # setting response variable (defects) for each explanatory variable
  ###
  #defected product will be as 1, successful product will be as 0
  
  
    #setting defects (if closer to the lower range, then higher prob to get 0)
    #closer to the max value means higher chance to get a 1 (defect)
    #for sand and temperature
    
    #setting up a range for sand 
    sand.range <- sand.bad.good[2] - sand.bad.good[1]
    #setting the probability of failure
    #to see how it behaves substitute sand.t with sand.bad.good[2] or 
    #sand.bad.good[1] and run
    sand.fail <- (sand.t - sand.bad.good[1])/sand.range
    
    # temperature
    # range and probability
    temp.range <- temp.bad.good[2] -  temp.bad.good[1]
    temp.fail <- (temp.t[1] - temp.bad.good[1])/temp.range
    
    #distributing defects for each batch 
    #sand to defect.1.t and temp to defect.2.t
    #using rbinom to get 0 or 1, with probability variables
    defect.1.t <- rbinom(length(n.pieces), size = 1, sand.fail)
    defect.2.t <- rbinom(length(n.pieces), size = 1, temp.fail)


    #different approach to stage 3
    #if carb is higher than 0.3, then defects rate is normal
    #if carb is lower than 0.3, then defects rate is high
    #can use other variables to see how the dataset behaves
    if(carb.t[1] >= 0.3){
      defect.3.t <-rbinom(length(n.pieces), size = 1, defect.normal)
    }else{
      defect.3.t <-rbinom(length(n.pieces), size = 1, defect.high)
    }
    #similar for time of the melt
    if(time.t[1] <= 70){
      defect.4.t <-rbinom(length(n.pieces), size = 1, defect.normal)
    }else{
      defect.4.t <-rbinom(length(n.pieces), size = 1, defect.high)
    }
    
    
  ###Commented section for assigning the defects probability by people
  # notice that col.names, data.t will need to include defect.t for this to run
    
    
  #   # let's add a defect based on the person
  #   # if thor is involved, defect rates goes to person.defect
  #   if(people.t[1] == defect.person || people.t[2] == defect.person){
  #     # persin is the 'defect person' so high faillure rate
  #     defect.t <- rbinom(length(n.pieces), size = 1, defect.high)
  #   }else{
  #     # person of interest is not in the 
  #     defect.t <- rbinom(length(n.pieces), size = 1, defect.normal)
  #   }

  
  
  # turning dataset into a dataframe (.t variables in the same order as 
  # col.names)
  data.t <- cbind.data.frame(name.batch.t, unique.ID.t, person.1.t, person.2.t, 
                             sand.t,  
                             temp.t, time.t,
                             carb.t, defect.1.t, defect.2.t, defect.3.t, 
                             defect.4.t)
  colnames(data.t) <- names.col
  
  # let's put this into the big data frame all.data
  all.data <- rbind.data.frame(all.data, data.t)
  
}

#Checking the structure of the data
str(all.data)
head(all.data)

#saving dataframe in raw data
write.csv(all.data, paste(p.data.raw, "rawData.csv", sep = ""), 
          row.names = FALSE)





