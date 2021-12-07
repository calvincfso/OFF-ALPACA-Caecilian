# R Script associated with https://github.com/calvincfso/OFF-ALPACA-Caecilian/
# By Jonathan Huie, Calvin So, Jake Galvin

rm(list = ls())
install.packages("geomorph")
library(geomorph)

# Load Data ---------------------------------------------------------------

# load in the file called "pcScores.csv" from the GitHub repo
# when running line 8, a pop-up with appear for you to select that file
scores <- read.csv(file.choose())


# PCA ---------------------------------------------------------------------

# plot the PCA showing shape variation between landmarking methods and sex
ggplot(data.frame(scores), aes(x = PC.1, y = PC.2, colour = Method, shape = Sex)) + geom_point(size = 4) +
  geom_text(aes(label=ID),hjust=-0.25, vjust=-0.25) + scale_shape_manual(values=c(17,19,15)) +
  labs(x = "PC 1", y = "PC 2")
# some overlap in colored points indicate general similarity between the two methods
# there is one automated outlier that differs from all other manual and automated points
# separation of shapes suggest differences in shape related to sex


# Regressions -------------------------------------------------------------

# plot PC 1 Scores for the manual versus the automated landmarks
# done with and without the obvious outlier
data <- cbind(scores$PC.1[which(scores$Method == "MANUAL")],scores$PC.1[which(scores$Method == "ALPACA")])
colnames(data) <- c("man", "alpaca")
data2 <- data[-11,]

# plot with outlier
ggplot(data.frame(data), aes(x = man, y= alpaca)) + geom_point(size = 3)+
  stat_smooth(method = "lm",formula = y~x) +
  labs(x = "Manual Shape", y = "ALPACA Shape", title = "With Outlier")
# lm with outlier
summary(lm(alpaca~man, data = data.frame(data))) # Rsquared ~= 0; no correlation

# plot without outlier
ggplot(data.frame(data2), aes(x = man, y= alpaca)) + geom_point(size = 3)+
  stat_smooth(method = "lm",formula = y~x) +
  labs(x = "Manual Shape", y = "ALPACA Shape", title = "Outlier Removed")
# lm without outlier
summary(lm(alpaca~man, data = data.frame(data2))) # Rsquared = 0.197; weak correlation
# the weak correlation suggests the automated landmarks do accurately capture 
# some of the manual landmarks...to an extent



