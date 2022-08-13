library(tidyverse)
imdb <- read_csv("https://raw.githubusercontent.com/curso-r/main-r4ds-1/master/dados/imdb.csv")

#  separate--------------------------------------------------------------

imdb %>%
  separate(idioma, sep = ", ", into = paste0("idioma", 1:10),
           remove = TRUE  #Remove a coluna que está sendo usada, por padrão é TRUE
          ) %>%  # merge, se tiver mais que o indicado mantem junto na ultima coluna
 View()

# Como descobrir o maior número possivel de quebras ?

imdb %>%
  summarise(
    max(str_count(idioma, ", "), na.rm = TRUE)
  )


#  unite-----------------------------------------------------------------

imdb_com_genero <- imdb %>%
  separate(generos, sep = ", ", into = c("genero1", "genero2", "genero3"),
           remove = TRUE)
imdb_com_genero %>%
  unite("genero", starts_with("genero"), sep = ", ", na.rm = TRUE ) %>% #Start_with função que pega o começo da str, ou poderia especificar genero1, genero2, genero3 no lugar
  select(genero)

# pivot_longer----------------------------------------------------------------

imdb_atores <- imdb %>%
  select(id_filme, titulo, elenco, pais) %>%
  separate(elenco, sep = ", ", into = c("elenco1", "elenco2", "elenco3"),
           extra = "drop")

imdb_atores_long <- imdb_atores %>%
  pivot_longer(cols = starts_with("elenco"), names_to = "posicao_titulacao",
               values_to = "nome_pessoa")


# pivot_wider---------------------------------------------------------------------


imdb_atores_long %>%
  pivot_wider(names_from = c("posicao_titulacao", "pais"),
              values_from = "nome_pessoa")

# fill---------------------------------------------------------------------------
#preenchendo o idioma NA com a ultima informação disponivel ou seja mesmos diretores ano anterior

imdb %>%
  arrange(direcao, ano) %>%
  mutate(idioma2 = idioma ) %>%
  group_by(direcao) %>%
  fill(idioma2) %>%
  select(titulo, direcao, ano, idioma, idioma2) %>%
  filter(is.na(idioma)) %>%
  View()

#across------------------------------------------------------------------------------------
# Ideal para usar a mesma função em varias colunas


# as vezer queremos pegar uma variavel qualitativa e sumarizar varivéis quantitativas
casas <- dados::casas
casas %>%
  group_by(geral_qualidade) %>%
  summarise(media_prime = median(primeiro_andar_area),
            media_seg = median(segundo_andar_area)) %>%
  View()


# mas para todas as colunas...

casas %>%
  group_by(geral_qualidade) %>%
  summarise(
    across(
      .cols = ends_with("area"),
      .fns = mean, na.rm = TRUE
    )
  ) %>% View()

#função para trocar NA pela média da coluna

troca_coluna <- function(coluna){
  if_else(is.na(coluna), mean(coluna, na.rm = TRUE), as.numeric(coluna))
}


# usando funçaõ com o across


casas %>%
  mutate(
    across(
      .cols = c(lote_fachada, ends_with("area")),
      .fns = troca_coluna
    )
  ) %>% View()

casas %>%
  filter(
    across(
      .cols = lote_fachada,
      .fns = ~!is.na(.x)
      # Isso é uma abreviação para function(x){!is.na(x)}
    )
  )


# Prática----------------------------------------------------------------------------

star_wars <- dados::dados_starwars


# Substituir NA por Sem Infromação

star_wars %>%
  mutate(
    across(
      .cols = where(is.character),
      .fns = replace_na, replace = "Sem Informação"
    )
  ) %>% View()


# Quais colunas possuem mais NAs

star_wars %>%
  summarise(
    across(
      .cols = everything(),
      .fns = ~sum(is.na(.x))
    )
  ) %>%

  #Transformando no formato longo

  pivot_longer(
        cols = everything(),
        names_to = "Valores",
        values_to = "Num_NAs"
  )

# Ver o número de categorias distintas em cada variavel categorica

star_wars %>%
  select(where(is.character)) %>%
  summarise(
    across(
      .fns = n_distinct
      )
    ) %>%
pivot_longer(
  cols = everything(),
  names_to = "Variaveis",
  values_to = "Quantidade"

) %>% View



