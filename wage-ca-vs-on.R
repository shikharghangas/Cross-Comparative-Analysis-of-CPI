library(tidyverse)
library(dplyr)
library(ggplot2)
library(areaplot)


inflation_overal <- read.csv("CAvsON.csv")

inflation_overal$Reference.period <- lubridate::dmy(inflation_overal$Reference.period)

cols <- hcl.colors(2, palette = "viridis", alpha = 0.8)

inflation_overal %>% 
  na.omit() %>%
  gather(key = "Variable", value = "Value", in_ca, in_on) %>% # gather variables into long format
  ggplot(aes(x = Reference.period, y = Value, fill = Variable)) +
  geom_area() +
  labs(title = "Year-over-Year Inflation Rate Canda vs Ontario",
       x = "Year", y = "Percentage Change") 
  scale_fill_manual(values) = cols # customize colors of variables
ggsave("InflationComparison.png",last_plot(), width = 10, height = 7, dpi = 600)
  

inflation_overal %>% 
  na.omit() %>%
  gather(key = "Variable", value = "Value", wage_ca, wage_on) %>% # gather variables into long format
  ggplot(aes(x = Value, fill = Variable)) +
  geom_density(alpha = 0.5) +
  labs(title = "Year-over-Year Inflation Rate Canda vs Ontario",
       x = "Percentage Change", y = "Density") +
  scale_fill_manual(values = cols) # customize colors of variables
ggsave("WageComparison.png",last_plot(), width = 10, height = 7, dpi = 600)


