
wd <- "E:\\Kaggle\\Leaf-Classification\\raw"
setwd(wd)

train <- read.csv("train.csv",header = T)[,-1]
X.train <- train[,-1]
Y.train <- train[,1]


# error <- 1
a <- proc.time()
for (i in 1:1000){
  model.current <- randomForest(species ~ ., data=train, importance=TRUE, proximity=TRUE)
  error.current <- tail(model.current$err.rate[,1],1)
  if (error.current < error){
    moder <- model.current
    error <- error.current
  }
  print(paste("No. ",i," model completed.",sep=""))
  print(paste("OOB Error of best model by now: ", error, sep=""))
  print(paste("Time elapsed:", proc.time()[3]-a[3],sep=""))
}
error

# ## Look at variable importance:
# round(importance(data.rf), 2)
# ## Do MDS on 1 - proximity:
# data.mds <- cmdscale(1 - data.rf$proximity, eig=TRUE)
# op <- par(pty="s")
# pairs(cbind(iris[,1:4], data.mds$points), cex=0.6, gap=0,
#       col=c("red", "green", "blue")[as.numeric(train$Species)],
#       main="Leaf Data: Predictors and MDS of Proximity Based on RandomForest")
# par(op)
# print(iris.mds$GOF)


library(jpeg)
data <- readJPEG("./images/1.jpg")