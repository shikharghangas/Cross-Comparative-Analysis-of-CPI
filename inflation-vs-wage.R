library(tidyverse)
library(dplyr)
library(ggplot2)
theme_set(theme_bw())

inflation_on <- read.csv("inflationOntario.csv")

inflation_on$Reference.period <- lubridate::dmy(inflation_on$Reference.period)

inflation_on %>% 
  mutate(inflation_on_yoy = round(((CPI - lag(CPI,12)) / lag(CPI,12)) * 100, 2),
         AvgHrRate_yoy = round(((AvgHrRate - lag(AvgHrRate,12)) / lag(AvgHrRate,12)) * 100, 2)) %>%
  na.omit() %>%
  ggplot(., aes(x = Reference.period, y = inflation_on_yoy, color = "Inflation Rate Ontario"))+
  geom_line() + 
  geom_line(aes(y = AvgHrRate_yoy, color = "Hourly Wages Ontario")) +
  labs(title = "Year-over-Year Inflation Rate vs. Wage Growth in Ontario",
       x = "Year", y = "Percentage Change")
ggsave("InflationOntario.png",last_plot(), width = 10, height = 7, dpi = 600)




