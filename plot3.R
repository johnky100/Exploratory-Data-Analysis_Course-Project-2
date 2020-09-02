setwd('F:/1. PROYECTOS DE TRABAJO/RStudio/4. Exploratory Data Analysis')
library(ggplot2)



## This first line will likely take a few seconds. Be patient!
if(!exists('NEI')){
  NEI <- readRDS('F:/1. PROYECTOS DE TRABAJO/RStudio/4. Exploratory Data Analysis/Exploratory-Data-Analysis_Course-Project-2/summarySCC_PM25.rds' )
}
if(!exists("SCC")){
  SCC <- readRDS("Exploratory-Data-Analysis_Course-Project-2/Source_Classification_Code.rds")
}



# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# 24510 is Baltimore, see plot2.R
subsetNEI  <- NEI[NEI$fips=="24510", ]

ATBY3 <- aggregate(Emissions ~ year + type, subsetNEI, sum)



png("plot3.png", width=640, height=480)
g <- ggplot(ATBY3, aes(year, Emissions, color = type)) + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')
print(g)
dev.off()
