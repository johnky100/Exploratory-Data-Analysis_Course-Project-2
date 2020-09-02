setwd('F:/1. PROYECTOS DE TRABAJO/RStudio/4. Exploratory Data Analysis')

## This first line will likely take a few seconds. Be patient!
if(!exists('NEI')){
  NEI <- readRDS('F:/1. PROYECTOS DE TRABAJO/RStudio/4. Exploratory Data Analysis/Exploratory-Data-Analysis_Course-Project-2/summarySCC_PM25.rds' )
}
if(!exists("SCC")){
  SCC <- readRDS("Exploratory-Data-Analysis_Course-Project-2/Source_Classification_Code.rds")
}

# Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

subsetNEI  <- NEI[NEI$fips=="24510", ]

ATBY2 <- aggregate(Emissions ~ year, subsetNEI, sum)

png('plot2.png')
colors2 <- c('orange', 'green', 'purple', 'yellow')
x2 <- barplot(height=ATBY2$Emissions/1000, names.arg=ATBY2$year, xlab="years", 
        ylab=expression('total PM'[2.5]*' emission in kilotons'), ylim=c(0,4), 
        main=expression('Total PM'[2.5]*' in the Baltimore City - MD emissions in kilotons'), 
        col = colors2)

# Add text at top of bars
text(x = x2, y = round(ATBY2$Emissions/1000,2), label = round(ATBY2$Emissions/1000,2), pos = 3, cex = 0.8, col = "black")
dev.off()



