# 
# Author: Sebastiano Panichella
###############################################################################


library(data.table)
library(ggplot2)
library(ggthemes)
library(effsize)
library(plyr)
library(lmPerm)
library(stringr)

### ggplot configuration
ggplot.defaults <- 
		#theme(axis.text.x = element_text(size = 15)) +
		#theme(axis.text.y = element_text(size = 15)) +
		theme_few() +
		#theme(legend.key = element_blank()) +
		#theme(axis.title.x = element_blank(), axis.title.y = element_blank())  +
		theme(axis.text.x = element_text(size = 12)) + 
		theme(axis.text.y = element_text(size = 12)) +
		theme(axis.title.x = element_text(size = 18, vjust = 1)) +
		theme(axis.title.y = element_text(size = 18, vjust = 1)) +
		theme(legend.text = element_text(size = 16))  +
		theme(legend.title = element_text(size = 18))
ggplot.small.defaults <-
		ggplot.defaults + theme(axis.title.x = element_text(size = 18, vjust = -0.5)) +
		theme(axis.title.y = element_text(size = 18, hjust = 0.5, vjust = 1.5))


plot.location <- function(filename) {
	file.path("....../data-analysis/data/figs", filename)
}

save.plot <- function(filename) {
	ggsave(plot.location(filename))
}

save.pdf <- function(plot, filename, width = 7, height = 7) {
	pdf(plot.location(filename), height = height, width = width)
	print(p)
	dev.off()
}

### Visualize function

visualize_data <- function(dist1, dist2) {
	boxplot(dist1$N..Smells, dist2$N..Smells)
	boxplot(dist1$time_in_s, dist2$time_in_s)
}


### Actual data analysis
## <Sebastiano Panichella>: I changed the path to the file
data <- data.table(read.csv('....../data-analysis/data/full_results-testsmelldescriber-anonymized.csv', numerals=c("no.loss")))

# Convert time to something sane
# Note: myData$TIME_h is not actually hours, it is minutes! Similarly, myData$TIME_min is seconds, not minutes! 
data$time_in_s <- data$TIME_h * 60 + data$TIME_m
data$match <- data$Task == data$SummaryFor


#### Basic statistics
warnIfNormal <- function (shapiro) {
	if (shapiro$p > 0.1) {
		print ("Warning!!!!!! Shapiro says dist. is normal!")
	}
}

############################## Preamble
# Shapiro Wilk on number of smells
warnIfNormal(shapiro.test(data$N..Smells))
# RESULT:
# non-normal -> use non-parametric tests


summaries <- subset(data, match == T)
withoutSummaries <- subset(data, match == F)
############################## RQ 2
### RQ2.1
# 1 Compare bug-finding capabilities between participants
data$match_str <- factor(data$match, levels=c(T, F), labels=c("With Summaries", "Without Summaries"))

write.csv(data, "r-parsed-results.csv")

p <- ggplot(data, aes(x=data$match_str, y=data$N..Smells)) + labs(y = "Found/Removed Smells", x="") + 
		geom_boxplot(outlier.colour="red", outlier.size=4) + ggplot.defaults
save.pdf(p, "rq21_summaries_boxplot.pdf")
## RESULT: wilcox test
print("##################################################")
print("RQ2.1")
wilcox.test(summaries$N..Smells, withoutSummaries$N..Smells,alternative = "greater")
VD.A(summaries$N..Smells, withoutSummaries$N..Smells)

data$Task <- str_replace_all(as.character(data$Task)," ","")
FlexibleStringExpanderTests = subset(data, Task=="FlexibleStringExpanderTests")
FlexibleStringExpanderTests.with.summaries = subset(FlexibleStringExpanderTests, match == T)
FlexibleStringExpanderTests.without.summaries = subset(FlexibleStringExpanderTests, match == F)
p <- ggplot(FlexibleStringExpanderTests, aes(x=FlexibleStringExpanderTests$match_str, y=FlexibleStringExpanderTests$N..Smells)) + labs(y = "Found/Removed Smells", x="") + 
		geom_boxplot(outlier.colour="red", outlier.size=4) + ggplot.defaults
save.pdf(p, "rq21_FlexibleStringExpanderTests_summaries_boxplot.pdf")
## RESULT: wilcox test
print("##################################################")
print("RQ2.1 FlexibleStringExpanderTests")
wilcox.test(FlexibleStringExpanderTests.with.summaries$N..Smells, FlexibleStringExpanderTests.without.summaries$N..Smells)
VD.A(FlexibleStringExpanderTests.with.summaries$N..Smells, FlexibleStringExpanderTests.without.summaries$N..Smells)

data$Task <- str_replace_all(as.character(data$Task)," ","")
TimeDurationTests = subset(data, Task=="TimeDurationTests")
TimeDurationTests.with.summaries = subset(TimeDurationTests, match == T)
TimeDurationTests.without.summaries = subset(TimeDurationTests, match == F)
p <- ggplot(TimeDurationTests, aes(x=TimeDurationTests$match_str, y=TimeDurationTests$N..Smells)) + labs(y = "Found/Removed Smells", x="") + 
  geom_boxplot(outlier.colour="red", outlier.size=4) + ggplot.defaults
save.pdf(p, "rq21_TimeDurationTests_summaries_boxplot.pdf")
## RESULT: wilcox test
print("##################################################")
print("RQ2.1 TimeDurationTests")
wilcox.test(TimeDurationTests.with.summaries$N..Smells, TimeDurationTests.without.summaries$N..Smells)
VD.A(TimeDurationTests.with.summaries$N..Smells, TimeDurationTests.without.summaries$N..Smells)

data$Task <- str_replace_all(as.character(data$Task)," ","")
FlexibleMapAccessorTest = subset(data, Task=="FlexibleMapAccessorTest")
FlexibleMapAccessorTest.with.summaries = subset(FlexibleMapAccessorTest, match == T)
FlexibleMapAccessorTest.without.summaries = subset(FlexibleMapAccessorTest, match == F)
p <- ggplot(FlexibleMapAccessorTest, aes(x=FlexibleMapAccessorTest$match_str, y=FlexibleMapAccessorTest$N..Smells)) + labs(y = "Found/Removed Smells", x="") + 
  geom_boxplot(outlier.colour="red", outlier.size=4) + ggplot.defaults
save.pdf(p, "rq21_FlexibleMapAccessorTest_summaries_boxplot.pdf")
## RESULT: wilcox test
print("##################################################")
print("RQ2.1 FlexibleMapAccessorTest")
wilcox.test(FlexibleMapAccessorTest.with.summaries$N..Smells, FlexibleMapAccessorTest.without.summaries$N..Smells)
VD.A(FlexibleMapAccessorTest.with.summaries$N..Smells, FlexibleMapAccessorTest.without.summaries$N..Smells)

data$Task <- str_replace_all(as.character(data$Task)," ","")
  
FlexibleMapAccessorTest = subset(data, Task=="FlexibleMapAccessorTest")
FlexibleMapAccessorTest.with.summaries = subset(FlexibleMapAccessorTest, match == T)
FlexibleMapAccessorTest.without.summaries = subset(FlexibleMapAccessorTest, match == F)
p <- ggplot(FlexibleMapAccessorTest, aes(x=FlexibleMapAccessorTest$match_str, y=FlexibleMapAccessorTest$N..Smells)) + labs(y = "Found/Removed Smells", x="") + 
  geom_boxplot(outlier.colour="red", outlier.size=4) + ggplot.defaults
save.pdf(p, "rq21_FlexibleMapAccessorTest_summaries_boxplot.pdf")
## RESULT: wilcox test
print("##################################################")
print("RQ2.1 FlexibleMapAccessorTest")
wilcox.test(FlexibleMapAccessorTest.with.summaries$N..Smells, FlexibleMapAccessorTest.without.summaries$N..Smells)
VD.A(FlexibleMapAccessorTest.with.summaries$N..Smells, FlexibleMapAccessorTest.without.summaries$N..Smells)

data$Task <- str_replace_all(as.character(data$Task)," ","")
  
UtilCacheTests = subset(data, Task=="UtilCacheTests")
UtilCacheTests.with.summaries = subset(UtilCacheTests, match == T)
UtilCacheTests.without.summaries = subset(UtilCacheTests, match == F)
p <- ggplot(UtilCacheTests, aes(x=UtilCacheTests$match_str, y=UtilCacheTests$N..Smells)) + labs(y = "Found/Removed Smells", x="") + 
  geom_boxplot(outlier.colour="red", outlier.size=4) + ggplot.defaults
save.pdf(p, "rq21_UtilCacheTests_summaries_boxplot.pdf")
## RESULT: wilcox test
print("##################################################")
print("RQ2.1 UtilCacheTests")
wilcox.test(UtilCacheTests.with.summaries$N..Smells, UtilCacheTests.without.summaries$N..Smells)
VD.A(UtilCacheTests.with.summaries$N..Smells, UtilCacheTests.without.summaries$N..Smells)



## RESULT: two-way permutation test
# FlexibleStringExpanderTests
print("##################################################")
print("RQ2.2: two-way permutation test for FlexibleStringExpanderTests")
perm.results <- summary(aovp(FlexibleStringExpanderTests$N..Smells ~ FlexibleStringExpanderTests$SummaryFor*FlexibleStringExpanderTests$Programming_exp, FlexibleStringExpanderTests, maxIter=500000, perm="Prob", Ca=0.0001))
p.values <- perm.results[[1]]$Pr

# combination of the two variables
if (p.values[3] < 0.05){
  print(paste("Statistical significant interaction between 'SummaryFor' and 'Programming_exp'===> p-value = ", p.values[3]))
} else{
  print(paste("NO interaction between 'SummaryFor' and 'Programming_exp'===> p-value = ", p.values[3]))
}

## RESULT: two-way permutation test
# TimeDurationTests
print("##################################################")
print("RQ2.2: two-way permutation test for TimeDurationTests")
perm.results <- summary(aovp(TimeDurationTests$N..Smells ~ TimeDurationTests$SummaryFor*TimeDurationTests$Programming_exp, TimeDurationTests, maxIter=500000, perm="Prob", Ca=0.0001))
p.values <- perm.results[[1]]$Pr

# combination of the two variables
if (p.values[3] < 0.05){
  print(paste("Statistical significant interaction between 'SummaryFor' and 'Programming_exp'===> p-value = ", p.values[3]))
} else{
  print(paste("NO interaction between 'SummaryFor' and 'Programming_exp'===> p-value = ", p.values[3]))
}


## RESULT: two-way permutation test
# FlexibleMapAccessorTest
print("##################################################")
print("RQ2.2: two-way permutation test for FlexibleMapAccessorTest")
perm.results <- summary(aovp(FlexibleMapAccessorTest$N..Smells ~ FlexibleMapAccessorTest$SummaryFor*FlexibleMapAccessorTest$Programming_exp, FlexibleMapAccessorTest, maxIter=500000, perm="Prob", Ca=0.0001))
p.values <- perm.results[[1]]$Pr

# combination of the two variables
if (p.values[3] < 0.05){
  print(paste("Statistical significant interaction between 'SummaryFor' and 'Programming_exp'===> p-value = ", p.values[3]))
} else{
  print(paste("NO interaction between 'SummaryFor' and 'Programming_exp'===> p-value = ", p.values[3]))
}

## RESULT: two-way permutation test
# UtilCacheTests
print("##################################################")
print("RQ2.2: two-way permutation test for UtilCacheTests")
perm.results <- summary(aovp(UtilCacheTests$N..Smells ~ UtilCacheTests$SummaryFor*UtilCacheTests$Programming_exp, UtilCacheTests, maxIter=500000, perm="Prob", Ca=0.0001))
p.values <- perm.results[[1]]$Pr

# combination of the two variables
if (p.values[3] < 0.05){
  print(paste("Statistical significant interaction between 'SummaryFor' and 'Programming_exp'===> p-value = ", p.values[3]))
} else{
  print(paste("NO interaction between 'SummaryFor' and 'Programming_exp'===> p-value = ", p.values[3]))
}

#testing experience..

## RESULT: two-way permutation test
# FlexibleStringExpanderTests
print("##################################################")
print("RQ2.2: two-way permutation test for FlexibleStringExpanderTests")
perm.results <- summary(aovp(FlexibleStringExpanderTests$N..Smells ~ FlexibleStringExpanderTests$SummaryFor*FlexibleStringExpanderTests$Testing_exp, FlexibleStringExpanderTests, maxIter=500000, perm="Prob", Ca=0.0001))
p.values <- perm.results[[1]]$Pr

# combination of the two variables
if (p.values[3] < 0.05){
  print(paste("Statistical significant interaction between 'SummaryFor' and 'Testing_exp'===> p-value = ", p.values[3]))
} else{
  print(paste("NO interaction between 'SummaryFor' and 'Testing_exp'===> p-value = ", p.values[3]))
}

## RESULT: two-way permutation test
# TimeDurationTests
print("##################################################")
print("RQ2.2: two-way permutation test for TimeDurationTests")
perm.results <- summary(aovp(TimeDurationTests$N..Smells ~ TimeDurationTests$SummaryFor*TimeDurationTests$Testing_exp, TimeDurationTests, maxIter=500000, perm="Prob", Ca=0.0001))
p.values <- perm.results[[1]]$Pr

# combination of the two variables
if (p.values[3] < 0.05){
  print(paste("Statistical significant interaction between 'SummaryFor' and 'Testing_exp'===> p-value = ", p.values[3]))
} else{
  print(paste("NO interaction between 'SummaryFor' and 'Testing_exp'===> p-value = ", p.values[3]))
}


## RESULT: two-way permutation test
# FlexibleMapAccessorTest
print("##################################################")
print("RQ2.2: two-way permutation test for FlexibleMapAccessorTest")
perm.results <- summary(aovp(FlexibleMapAccessorTest$N..Smells ~ FlexibleMapAccessorTest$SummaryFor*FlexibleMapAccessorTest$Testing_exp, FlexibleMapAccessorTest, maxIter=500000, perm="Prob", Ca=0.0001))
p.values <- perm.results[[1]]$Pr

# combination of the two variables
if (p.values[3] < 0.05){
  print(paste("Statistical significant interaction between 'SummaryFor' and 'Testing_exp'===> p-value = ", p.values[3]))
} else{
  print(paste("NO interaction between 'SummaryFor' and 'Testing_exp'===> p-value = ", p.values[3]))
}

## RESULT: two-way permutation test
# UtilCacheTests
print("##################################################")
print("RQ2.2: two-way permutation test for UtilCacheTests")
perm.results <- summary(aovp(UtilCacheTests$N..Smells ~ UtilCacheTests$SummaryFor*UtilCacheTests$Testing_exp, UtilCacheTests, maxIter=500000, perm="Prob", Ca=0.0001))
p.values <- perm.results[[1]]$Pr

# combination of the two variables
if (p.values[3] < 0.05){
  print(paste("Statistical significant interaction between 'SummaryFor' and 'Testing_exp'===> p-value = ", p.values[3]))
} else{
  print(paste("NO interaction between 'SummaryFor' and 'Testing_exp'===> p-value = ", p.values[3]))
}
#end of tests for testing experience



print("##################################################")
print("RQ2.3: two-way permutation test for TASK")
perm.results <- summary(aovp(data$N..Smells ~ data$SummaryFor*data$Task, data, maxIter=500000, perm="Prob", Ca=0.0001))
p.values <- perm.results[[1]]$Pr

# combination of the two variables
if (p.values[3] < 0.05){
  print(paste("Statistical significant interaction between 'SummaryFor' and 'Tasks'===> p-value = ", p.values[3]))
} else{
  print(paste("NO interaction between 'SummaryFor' and 'Task'===> p-value = ", p.values[3]))
}

# Threat: 2 Compare bug-finding capabilities between tasks (directly to be used when speaking about 1)
p <- ggplot(data, aes(x=data$Task, y=data$N..Smells)) + labs(y = "Detected/Removed Test Smells", x="") + 
		geom_boxplot(outlier.colour="red", outlier.size=4) + ggplot.defaults + 
  theme(text = element_text(size=0.5), axis.text.x = element_text(angle=90, hjust=1))
save.pdf(p, "threats_tasks_summaries.pdf")
wilcox.test(FlexibleStringExpanderTests$N..Smells, TimeDurationTests$N..Smells)
wilcox.test(FlexibleStringExpanderTests$N..Smells, FlexibleMapAccessorTest$N..Smells)
wilcox.test(FlexibleStringExpanderTests$N..Smells, UtilCacheTests$N..Smells)
wilcox.test(TimeDurationTests$N..Smells, FlexibleMapAccessorTest$N..Smells)
wilcox.test(TimeDurationTests$N..Smells, UtilCacheTests$N..Smells)
wilcox.test(FlexibleMapAccessorTest$N..Smells, UtilCacheTests$N..Smells)


# 3 Compare bug-finding capabilities between programming experience (directly to be used when speaking about 1)
p <- ggplot(data.frame(data), aes(x=data$Programming_exp, y=data$N..Smells)) + labs(y = "Found/Removed Smells", x="Programming Experience") + 
		geom_boxplot(outlier.colour="red", outlier.size=4) + ggplot.defaults
save.pdf(p, "rq24_experience_summaries.pdf")
print("##################################################")
print("RQ2.4")

### RQ2.5
# 1 Compare time finishing capabilities between participants
data$match_str <- factor(data$match, levels=c(T, F), labels=c("With Summaries", "Without Summaries"))

p <- ggplot(data, aes(x=data$match_str, y=data$time_in_s)) + labs(y = "Task Completion Time", x="") + 
		geom_boxplot(outlier.colour="red", outlier.size=4) + ggplot.defaults
save.pdf(p, "rq25_time_summaries.pdf")
## RESULT: wilcox test
print("##################################################")
print("RQ2.5")
wilcox.test(summaries$time_in_s, withoutSummaries$time_in_s)
VD.A(summaries$time_in_s, withoutSummaries$time_in_s)

p <- ggplot(data, aes(x=data$match_str, y=data$editDist)) + labs(y = "Edit Distance", x="") + 
		geom_boxplot(outlier.colour="red", outlier.size=4) + ggplot.defaults
save.pdf(p, "rq26_edit_distance.pdf")
print("##################################################")
print("RQ2.6 editDistance")
wilcox.test(summaries$editDist, withoutSummaries$editDist)
VD.A(summaries$editDist, withoutSummaries$editDist)


# ADD further figures
p <- ggplot(data, aes(x=data$Task, y=data$N..Smells, fill=data$match_str)) + labs(y = "N. Fixed Tets Smells", x="") + 
  geom_boxplot(outlier.colour="red", outlier.size=4, position=position_dodge(1)) +
  scale_fill_manual(values=c("grey75", "white"),name="") +
  ggplot.defaults + theme(legend.position="bottom", legend.text=element_text(size=20))+ 
  theme(text = element_text(size=0.5), axis.text.x = element_text(angle=90, hjust=1)) 

save.pdf(p, "rq2_all_boxplot.pdf",7,6)

boxplot(withoutSummaries$N..Smells,summaries$N..Smells)



# ADD further figures
p <- ggplot(data, aes(x=data$Task, y=data$time_in_s, fill=data$match_str)) + labs(y = "Task Completion Time", x="") + 
  geom_boxplot(outlier.colour="red", outlier.size=4, ,position=position_dodge(1)) +
  scale_fill_manual(values=c("grey75", "white"),name="") +
  ggplot.defaults + theme(legend.position="bottom", legend.text=element_text(size=20))+
  theme(text = element_text(size=0.5), axis.text.x = element_text(angle=90, hjust=1))
save.pdf(p, "rq2_all_time_boxplot.pdf",7,6)


p <- ggplot(data, aes(x=data$Task, y=data$editDist,fill=data$match_str)) + labs(y = "Edit lines", x="") + 
  geom_boxplot(outlier.colour="red", outlier.size=4, ,position=position_dodge(1)) +
  scale_fill_manual(values=c("grey75", "white"),name="") +
  ggplot.defaults + theme(legend.position="bottom", legend.text=element_text(size=20)) + 
  theme(text = element_text(size=0.5), axis.text.x = element_text(angle=90, hjust=1))
save.pdf(p, "rq2_all_edit_lines.pdf")

## Threat
# ProgrammingExp
programmingExp <- count(data, "Programming_exp")
programmingExp$freq <- programmingExp$freq/2
programmingExp$rel_freq <- programmingExp$freq/sum(programmingExp$freq)
programmingExp

## Average number of smells fixed with summaries
 mean(summaries$N..Smells)
## Average number of smells fixed without summaries
 mean(withoutSummaries$N..Smells)

