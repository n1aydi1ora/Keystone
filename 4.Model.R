#Modeling and plotting dataset

# This file focuses on running a logistic regression model on the datasets and
# plotting a line in the graph of explanatory and response variable
# the plots will be only 0s and 1s as these are two only possible outcomes

# To run this code independently from data simulation and data cleaning files
#upload a csv from b.data.clean folder (code commented below)
# stage1 <- read.csv(paste(p.data.clean, "stage1.csv", sep = ""),header = TRUE)
# stage2 <- read.csv(paste(p.data.clean, "stage2.csv", sep = ""),header = TRUE)
# stage3 <- read.csv(paste(p.data.clean, "stage3.csv", sep = ""),header = TRUE)


#running a logistic regression model on our datasets
#

#Creating a glm model: explanatory variable - sand, response - defects
model.1 <- glm(defects ~ sand, family=binomial(link='logit'), data=stage1)
summary(model.1)

#Setting a range of values for x (based on range) and y (based on model)
xweight.1 <- seq(sand.bad.good[1], sand.bad.good[2], 0.1)
yweight.1 <- predict(model.1, list(sand = xweight.1), type = "response")

#Plotting the model and saving plot in 4.Figures folder
pdf(paste(p.fig, "model.1.pdf", sep = ""))
plot(stage1$sand, stage1$defects, xlab = "sand", ylab = "defects", main = 
       "Logistic Regression for stage1")
lines(xweight.1, yweight.1)
dev.off()

#Similar process as in model1
model.2 <- glm(defects ~ temp, family=binomial(link='logit'), data=stage2)
summary(model.2)

#checking temperature range
range(stage2$temp)
#setting x values in the range of temperature
xweight.2 <- seq(200, 300, 1)
yweight.2 <- predict(model.2, list(temp = xweight.2), type = "response")

#plotting model for stage 2
pdf(paste(p.fig, "model.2.pdf", sep = ""))
plot(stage2$temp, stage2$defects, xlab = "temperature", ylab = "defects", main = 
       "Logistic Regression for stage2")
lines(xweight.2, yweight.2)
dev.off()

model.3 <- glm(defects ~ carb, family=binomial(link='logit'), data=stage3)
summary(model.3)

xweight.3 <- seq(carb.good.bad[1], carb.good.bad[2], 0.001)
yweight.3 <- predict(model.3, list(carb = xweight.3), type = "response")

pdf(paste(p.fig, "model.3.pdf", sep = ""))
plot(stage3$carb, stage3$defects, xlab = "carb", ylab = "defects", main = 
       "Logistic Regression for stage3")
lines(xweight.3, yweight.3)
dev.off()

#Logistic regression model on the practice dataset with 2 factors
model.4 <- glm(new ~ carb + temp, family = binomial(link='logit'), data=practice)
summary(model.4)


# model.5 <- glm(new ~ carb + temp + time, family = binomial(link='logit'), data=practice)
# summary(model.5)

