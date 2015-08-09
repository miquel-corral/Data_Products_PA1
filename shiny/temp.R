# load row dataset
dataset <- readRDS("summarySCC_PM25.rds")  
# filter for Baltimore city
df1 <- dataset[dataset$fips == "24510",]
# calculate total emissions per year
df2 <- aggregate(df1$Emissions,list(df1$year,df1$type),sum)
# arrange column names 
colnames (df2) <- c("year", "type", "emissions")
# total emissions in thousands of tons
df2$emissions <- df2$emissions/1000
# save as csv
write.csv(df2, file="PM25EmissionsBaltimore.csv", row.names = FALSE)
# test read csv
df3 <- read.csv("PM25EmissionsBaltimore.csv")
# plot graphic
g <- ggplot(df3, aes(year, emissions))
h <- g + geom_line(aes(color=type)) + 
  geom_point(aes(color=type)) + 
  geom_text(hjust=0, vjust= 1, size=3, angle=45, aes(label=emissions)) +   
  facet_grid(. ~ type) + 
  labs(title="Total Emissions per type and year in Baltimore") + 
  labs(x="Year") + labs(y="Total Emissions (thousands of tons)") + 
  theme_bw(base_family="Times")
h <- h + geom_line(stat = "hline", yintercept = "mean")
print(h)


