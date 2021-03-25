library(tidyverse)
library(here)

paste0(here(), "/data") %>% setwd()

data <- read_csv("economic-freedom-of-the-world-data-for-researchers.csv", skip = 4)
gdp <- read_csv("API_NY.GDP.PCAP.CD_DS2_en_csv_v2_10134337.csv", skip = 3)

data <- data[-1, -1]
data <- data[-(3499:3699), ]
data <- data[, -(80:129)]
data <- data[, -(73:79)]

gdp <- gdp[, -(5:14)]
gdp <- gdp[, -(51:53)]
gdp <- gdp[-1, -(2:4)]
gdp$`Country Name`[42] <- "Congo, Dem. R."
gdp$`Country Name`[95] <- "Hong Kong"
gdp$`Country Name`[111] <- "Iran"
gdp$`Country Name`[125] <- "Korea, South"
gdp$`Country Name`[226] <- "Syria"
gdp$`Country Name`[253] <- "Venezuela"

columns <- c(which(names(data)=="Year"), 
             which(names(data)=="Countries"), 
             which(names(data)=="Economic Freedom Summary Index"), 
             which(names(data)=="Rank"),
             which(names(data)=="Size of Government"),
             which(names(data)=="Legal System & Property Rights"),
             which(names(data)=="Sound Money"),
             which(names(data)=="Freedom to trade internationally"),
             which(names(data)=="Regulation"))

cleaning <- which(is.na(data$`Economic Freedom Summary Index`))
clean_data <- data[-cleaning, ]
country_remove <- names(which(table(clean_data$Countries) != 22))
data2 <- clean_data

for (i in 1:length(country_remove)) {
  data2 <- data2[-(which(data2$Countries == country_remove[i])), ]
}
table(data2$Countries)

data3 <- data2[, columns]
remove_taiwan <- which(data3$Countries == "Taiwan")
data3 <- data3[-remove_taiwan, ]

countries <- names(table(data3$Countries))

gdp_select <- c(1:length(countries))

for(i in 1:length(countries)) {
  gdp_select[i] <- which(gdp$`Country Name` == countries[i])
}

gdp <- gdp[gdp_select, ]

gdp_gather <- gather(gdp, Year, GDP, -'Country Name')

years <- c("1971", "1972", "1973", "1974", "1976", "1977", "1978", "1979",
           "1981", "1982", "1983", "1984", "1986", "1987", "1988", "1989",
           "1991", "1992", "1993", "1994", "1996", "1997", "1998", "1999")

for (i in 1:length(years)) {
  gdp_gather <- gdp_gather[-(which(gdp_gather$Year == years[i])), ]
}

gdp_gather <- gdp_gather %>%
  arrange(desc(Year))

gdp_data <- data3
gdp_data$'GDP per capita' <- gdp_gather$GDP

gdp_data$Year <- as.numeric(gdp_data$Year)
gdp_data$`Economic Freedom Summary Index` <- as.numeric(gdp_data$`Economic Freedom Summary Index`)
gdp_data$Rank <- as.numeric(gdp_data$Rank)

world_gdp <- read_csv("API_NY.GDP.MKTP.CD_DS2_en_csv_v2_10203569.csv", skip = 4)
world_gdp <- world_gdp[, -(1:4)]
world_gdp <- world_gdp[, (names(table(gdp_data$Year)))]

gdp_data$`World GDP` <- 1

for(i in seq_along((names(table(gdp_data$Year))))) {
  gdp_data[which(gdp_data$Year == (names(table(gdp_data$Year)))[i]), 11] <- world_gdp[(names(table(gdp_data$Year)))[i]]
}

dollar <- read_csv("TWEXBANL.csv")

dollar$DATE <- as.numeric(substring(dollar$DATE,1,4))
dollar$DATE[1] <- 1970
dollar <- dollar[-c(2, 4, 5, 6, 7, 9, 10, 11, 12, 14, 15, 16, 17, 19, 20, 21, 22, 24, 25, 26, 27, 44, 45), ]

gdp_data$`USD` <- 1

for(i in seq_along(dollar$DATE)) {
  gdp_data[which(gdp_data$Year == dollar$DATE[i]), 12] <- dollar$TWEXBANL_NBD20170101[i]
}

gdp_data$OECD <- c(0, 1, 1, 1, 0, 1, 1,
                   0, 0, 1, 0, 1, 1, 1,
                   1, 0, 0, 1, 0, 0, 0,
                   1, 1, 1, 1, 0, 1, 1,
                   0, 1, 0, 1, 1, 0, 1,
                   0, 0, 0, 1, 0, 0, 1,
                   1, 1, 0, 0, 0, 0, 1,
                   1, 1, 0)

gdp_data <- gdp_data[-which(gdp_data$Year == 2001),]
gdp_data <- gdp_data[-which(gdp_data$Year == 2002),]
gdp_data <- gdp_data[-which(gdp_data$Year == 2003),]
gdp_data <- gdp_data[-which(gdp_data$Year == 2004),]
gdp_data <- gdp_data[-which(gdp_data$Year == 2006),]
gdp_data <- gdp_data[-which(gdp_data$Year == 2007),]
gdp_data <- gdp_data[-which(gdp_data$Year == 2008),]
gdp_data <- gdp_data[-which(gdp_data$Year == 2009),]
gdp_data <- gdp_data[-which(gdp_data$Year == 2011),]
gdp_data <- gdp_data[-which(gdp_data$Year == 2012),]
gdp_data <- gdp_data[-which(gdp_data$Year == 2013),]
gdp_data <- gdp_data[-which(gdp_data$Year == 2014),]


rm(data, data2, data3, gdp, gdp_gather, cleaning,
   columns, countries, country_remove, gdp_select,
   i, remove_taiwan, select_years, years, clean_data,
   dollar, world_gdp)

View(gdp_data)


save(gdp_data, file = "GDP_Data.RData")
write.csv(file="GDP_Data.csv", x=gdp_data)

