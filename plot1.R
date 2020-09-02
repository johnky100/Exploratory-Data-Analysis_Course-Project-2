## This first line will likely take a few seconds. Be patient!
setwd('F:/1. PROYECTOS DE TRABAJO/RStudio/4. Exploratory Data Analysis')
#getwd()
if(!exists('NEI')){
  NEI <- readRDS('F:/1. PROYECTOS DE TRABAJO/RStudio/4. Exploratory Data Analysis/Exploratory-Data-Analysis_Course-Project-2/summarySCC_PM25.rds' )
}
if(!exists("SCC")){
  SCC <- readRDS("Exploratory-Data-Analysis_Course-Project-2/Source_Classification_Code.rds")
}
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

ATBY <- aggregate(Emissions ~ year, NEI, sum)

png('plot1.png')
colors <- c('red', 'orange', 'green', 'blue')
x1 <- barplot(height=ATBY$Emissions/1000, names.arg=ATBY$year, xlab="years", ylab=expression('total PM'[2.5]*' emission in kilotons'), ylim=c(0, 8000), main=expression('Total PM'[2.5]*' emissions at various years in kilotons'), col=colors)
## Add text at top of bars
text(x = x1, y = round(ATBY$Emissions/1000,2), label = round(ATBY$Emissions/1000,2), pos = 3, cex = 0.8, col = "black")
dev.off()


