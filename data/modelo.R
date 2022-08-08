source("R/pacotes.R")

mtcars_modelo <- readRDS("data/mtcars_modelo.rds")

# Lemos o bruto

modelo <- lm(mpg ~ coluna_regressao, data = mtcars_modelo)

# Lendo dados trabalhadaços
