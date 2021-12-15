#running a model


model.1 <- glm(stage1$defects ~ stage1$sand, family=binomial(link='logit'), data=stage1)
summary(model.1)


xweight.1 <- seq(sand.bad.good[1], sand.bad.good[2], 1)
yweight.1 <- predict(model.1, list(sand = xweight.1), type = "response")

pdf(paste(p.fig, "model.1", sep = ""))
plot(stage1$sand, stage1$defects)
lines(xweight.1, yweight.1)
dev.off()


model.2 <- glm(stage2$defects ~ stage2$temp, family=binomial(link='logit'), data=stage2)
summary(model.2)

range(stage2$temp)
xweight.2 <- seq(200, 300, 1)
yweight.2 <- predict(model.2, list(temp = xweight.2), type = 'response')

pdf(paste(p.fig, "model.2", sep = ""))
plot(stage2$temp, stage2$defects)
lines(xweight.2, yweight.2)
dev.off()

