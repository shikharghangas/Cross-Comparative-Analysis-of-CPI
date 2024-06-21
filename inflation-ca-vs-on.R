library(tidyverse)
library(dplyr)
library(ggplot2)
library(areaplot)

inflation_ca <- read.csv("inflationCanada.csv")


inflation_ca$Reference.period <- lubridate::dmy(inflation_ca$Reference.period)


inflation_ca %>% 
  mutate(inflation_ca_yoy = round(((CPI - lag(CPI,12)) / lag(CPI,12)) * 100, 2),
         Wage_ca_yoy = round(((Wage - lag(Wage,12)) / lag(Wage,12)) * 100, 2)) %>%
  na.omit() %>%
  ggplot(., aes(x = Reference.period, y = inflation_ca_yoy, color = "Inflation Rate Canada"))+
  geom_line() + 
  geom_line(aes(y = Wage_ca_yoy, color = "Hourly Wages Canada")) +
  labs(title = "Year-over-Year Inflation Rate vs. Wage Growth in Canada",
       x = "Year", y = "Percentage Change") +
ggsave("InflationCanada.png",last_plot(), width = 10, height = 7, dpi = 600)




