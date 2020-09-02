setwd('F:/1. PROYECTOS DE TRABAJO/RStudio/4. Exploratory Data Analysis')

library(ggplot2)

## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
# merge the two data sets 
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}



# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
# 24510 is Baltimore, see plot2.R
# Searching for ON-ROAD type in NEI
# Don't actually know it this is the intention, but searching for 'motor' in SCC only gave a subset (non-cars)

subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

ATBY5 <- aggregate(Emissions ~ year, subsetNEI, sum)

png("plot5.png", width=840, height=480)
g <- ggplot(ATBY5, aes(x = factor(year), y = Emissions, fill = year,
  label = round(Emissions, 2))) + 
  geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Emissions from motor vehicle sources in Baltimore City') +
  geom_label(aes(fill = year), colour = "white", fontface = "bold")
print(g)
dev.off()
