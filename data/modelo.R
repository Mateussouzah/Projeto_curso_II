source("R/pacotes.R")

mtcars_modelo <- readRDS("data/mtcars_modelo.rds")

modelo <- lm(mpg ~ coluna_regressao, data = mtcars_modelo)

# Lendo dados trabalhadaços
