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



# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# fetch all NEIxSCC records with Short.Name (SCC) Coal
coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]

ATBY4 <- aggregate(Emissions ~ year, subsetNEISCC, sum)



png("plot4.png", width=640, height=480)
g <- ggplot(ATBY4, aes(x = factor(year), y = Emissions/1000, fill = year,
                       label = round(Emissions/1000,2))) + 
                       geom_bar(stat="identity") +
                       xlab("year") +
                       ylab(expression('Total PM'[2.5]*" Emissions in kilotons")) +
                       ggtitle('Total Emissions from coal sources from 1999 to 2008')+
                       geom_label(aes(fill = year), colour = 'white', fontface = 'bold')
print(g)
dev.off()
