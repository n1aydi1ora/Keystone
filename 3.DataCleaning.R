
all.data <- all.data[-1,]

stage1 <- data.frame(all.data$sand, all.data$defect.1)
names(stage1) <- c("sand", "defects")

stage2 <- data.frame(all.data$temp, all.data$defect.2)
names(stage2) <- c("temp", "defects")

stage3 <- data.frame(all.data$carb, all.data$defect.3)
names(stage3) <- data.frame("carb", "defect")