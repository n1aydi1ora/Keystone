#Data cleaning/dividing by stages

# To run this code independently from data simulation upload a csv from 
# a.data.raw folder (code commented below)
# need to run 1.Main.R before
# uncomment command below
# all.data <- read.csv(paste(p.data.raw, "rawData.csv", sep = ""),header = TRUE)


#Removing first row of NAs
all.data <- all.data[-1,]

#For stage 1, sand is the factor
stage1 <- data.frame(all.data$sand, all.data$defect.1)
names(stage1) <- c("sand", "defects")

#For stage 2, temp is the factor
stage2 <- data.frame(all.data$temp, all.data$defect.2)
names(stage2) <- c("temp", "defects")

#For stage 3, carb is the factor
stage3 <- data.frame(all.data$carb, all.data$defect.3)
names(stage3) <- data.frame("carb", "defects")

#Practice dataset with 2 factors
#Trying to set two explanatory variable for one response variable
practice <- data.frame(all.data$carb, all.data$temp, all.data$defect.2, 
                       all.data$defect.3)
names(practice) <- data.frame("carb", "temp", "defects.1", "defects.2")
#if defect occured in stage 2 and didn't occur in stage 2, product is defected
#use OR to assign a final verdict whether the product is defected or not
practice$new <- ifelse(practice$defects.1 == 1 | practice$defects.2 == 1, 1, 0)

#For practice with 3 factors
#Model didn't work
# doesn't like time variable
practice.2 <- data.frame(all.data$carb, all.data$temp, all.data$time,
                        all.data$defect.2, all.data$defect.3, all.data$defect.4)
names(practice.2) <- data.frame("carb", "temp", "time", "defects.2", "defects.3", 
                              "defects.4")
practice.2$new <- ifelse(practice.2$defects.2 == 1 | practice.2$defects.3 | 
                           practice.2$defects.4 == 1, 1, 0)

#we can save clean data as separate documents in b.data.clean folder
write.csv(stage1, paste(p.data.clean, "stage1.csv", sep = ""), 
          row.names = FALSE)
write.csv(stage2, paste(p.data.clean, "stage2.csv", sep = ""), 
          row.names = FALSE)
write.csv(stage3, paste(p.data.clean, "stage3.csv", sep = ""), 
          row.names = FALSE)
write.csv(practice, paste(p.data.clean, "practice.csv", sep = ""), 
          row.names = FALSE)