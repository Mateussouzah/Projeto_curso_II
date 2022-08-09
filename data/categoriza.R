caregoriza_wt <- function(coluna, ponto_de_corte){
  ifelse(coluna > ponto_de_corte, "Pesado", "Leve")
}

categoriza <- function(coluna, ponto_de_corte){
  ifelse(coluna > ponto_de_corte, "Alto", "Baixo")
}
