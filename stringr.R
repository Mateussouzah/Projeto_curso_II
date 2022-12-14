library(tidyverse)

string_qualqier <- 'Veja agora"control"como ficou'

cat(string_qualqier)


# jeito chato de concatenar uma string
c("a", "b", "c")
paste0("a", "b","c", collapse = "")


# jeito fácil de concatenar uma string
str_c("a", "b", "c")


str_c("meu", "texto") %>%
  str_length()
imdb <- read_csv("https://raw.githubusercontent.com/curso-r/main-r4ds-1/master/dados/imdb.csv")


imdb %>%
  mutate(label_para_grafico = str_c("Ano de lançamento: ", ano)) %>%
  select(label_para_grafico)

# str_detect()-------------------------------------------------------------------

str_detect(c("Angelina Jolie,  Brad Pitt", "Angelina Jolie, Michael Caine"),# Da TRUE se achar a regex
           pattern = "Angelina")

str_view_all(sentences, "the|The") # Usando | como 'ou' para achar regex The ou the


vetor_exemplo <- c("baaaaaac", "bc", "baac", "baaaaac", "bac")

str_view_all(vetor_exemplo, "ba*c") # Usando * para achar regex onde a aparece de 0 a n vezes entre b e c
str_view_all(vetor_exemplo, "ba+c")# Usando + no lugar  para aparecer pelo menos uma vez
str_view_all(vetor_exemplo, "ba{2,6}c") #Usando para buscar onde a se repete de 2 á 6 vezes entre b e c

regex_de_conjunto <- "b(a|d){2,5}c" # Procurando se tem a ou d 2 a 5 vezes entre b e c
regex_de_conjunto_2 <- "b[a-d]{2,5}c" # se quiser de 'a' a 'd' pode se usar -

regex_cep <- "[0-9]{5}-[0-9]{3}" #mascara de CEP, se tiver um no meio do texto pode encontrar



# regex serve para representar qualquer texto por uma 'máscara' ou versão genérica------------------------------------
# Idéias Principais:
# caracteres com posições fixas
# quantificadores
# classes


vetor_de_email <- c("meu email é fulano@bol.com.br", "nosso email é contato@bla.org.zip. VALEU")

regex_email <- "[a-zA-Z0-9_.-]{1,100}@[a-zA-Z0-9]{1,100}\\.com\\.br"
regex_email_2 <- "[a-zA-Z0-9_.-]{1,100}@[a-zA-Z0-9]{1,100}\\.org"
regex_email_3 <- "[a-zA-Z0-9_.-]{1,100}@[a-zA-Z0-9]{1,100}\\.com"

regex_email_final <- str_c(regex_email, regex_email_2, regex_email_3, sep = "|")

str_view(vetor_de_email, regex_email_final)

#str_extract--------------------------------------------------------------------------------------------------
# extrai os dados


# primeira tentativa
regex_email_lucas <- "[a-zA-Z0-9._-]{0,100}@[^ ]+"

str_extract(vetor_de_email, regex_email_lucas)

#segunda tentativa

regex_email_lucas <- "[a-zA-Z0-9._-]+@[^ ]+[a-zA-Z0-9]"

# telefone

regex_tel <- "(\\+[0-9]{2}\\([0-9]{2}\\) )?[0-9]{4,5}-[0-9]{4}"# \\ para interpretar literalmente o que vem depois

tel <- c("Meu telefone é: 98161-6517, eo telefone da lili é 3243-4559 ",
         "O telefone gringo é: +78(34) 3442-7765 ",
         "his tel is: +55(51) 97342-9588")

str_extract_all(tel, regex_tel)

# str_replace-----------------------------------------------------------------------------------------------

str_replace_all(tel, regex_tel, "TELEFONE")# Substituir,  util para fazer limpeza

texto_zoado <- c("texto com      espaços  a mais",
                 "      texto que começa com espaços",
                 "COMEÇO INUTIL: conteudo")
str_view_all(texto_zoado, "  +")

texto_limpo <- texto_zoado %>%
  str_replace("  +", " ") %>%
  #esse poderia ser str_squish

   str_replace("^ +", "") %>%
   #esse poderia ser str_remove
  # str_remove("^ +")
  #    ou
  #str_trim

  str_replace("COMEÇO INUTIL: ", "")

str_split(texto_limpo, pattern = "[._@]+")#quebrando o texto

#----------------------------------------------------------------------------------

texto_bruto <- "Autor: \n\n\n\n\t\t\t Justiça Pública"

str_count(texto_limpo, "o") #quanta vezes apareceu "o"

regex_autor <- "Autor: +([:space:]|\n)+"

str_remove_all(texto_bruto, regex_autor)

str_to_lower("eU TI Amo")

str_to_upper("oLa mUNdo!")

str_to_title("nivel de emergencia 4")



stringi::stri_trans_general("VáriÔs àcêntôs", "Latin-ASCII")# Tirar acentos


#Aula Prática----------------------------------------------------------------------------------------------------

library(tidyverse)

imdb <- read_csv("https://raw.githubusercontent.com/curso-r/main-r4ds-1/master/dados/imdb.csv")


# Motivação: Descobrir a quantos gêneros cada filme pertence


imdb %>%
  mutate(num_generos = str_count(generos, pattern = ",")+ 1

  ) %>%
  select(generos, num_generos) %>%
  View()

# Motivação: Extrair o subtítulo dos filmes

imdb %>%
  mutate(subtitulo = str_extract(titulo, ": .*")) %>%
  drop_na(subtitulo) %>%
  mutate(subtitulo = str_remove(subtitulo, ": ")) %>%
  select(titulo, subtitulo) %>%
  View()

# Motivação: Criar uma tebela cujo o título começe apenas com números

imdb %>%
  mutate(titulo_num = str_extract(titulo, "^[0-9]{0,100} .*")) %>%
  drop_na(titulo_num) %>%
  select(titulo, titulo_num) %>%
  View()

# Se quizesse só filtrar

imdb %>%
  filter(str_detect(titulo, "^[0-9]")) %>% # ^ Esta pedindo para começar com números
  View()



# Motivação: Criar uma tabela onde apenas Josh Hutcherson faz parte do elenco

imdb %>%
  filter(
    str_detect(elenco, pattern = "Josh Hutcherson")
  ) %>%
  select(titulo, elenco) %>%
  View()



# Motivação: Criar uma tabela onde  Josh Hutcherson ou Jennifer Lawrence fazem parte do elenco

imdb %>%
  filter(
    str_detect(elenco, pattern = "Josh Hutcherson |Jennifer Lawrence")
  ) %>%
  select(titulo, elenco) %>%
  View()

# Motivação: Criar uma tabela onde  Josh Hutcherson e Jennifer Lawrence fazem parte do elenco

imdb %>%
  filter(
    str_detect(elenco, "Josh Hutcherson"),
    str_detect(elenco, "Jennifer Lawrence")
  ) %>%
  select(titulo, elenco) %>%
  View()

# Motivação: Criar uma tabela onde  Josh Hutcherson e Jennifer Lawrence não estajam junto nos filmes

imdb %>%
  mutate(
    josh =  str_detect(elenco, "Josh Hutcherson"),
    jennifer = str_detect(elenco, "Jennifer Lawrence")
  ) %>%
  filter((josh == FALSE & jennifer == TRUE) | (josh & !jennifer) ) %>%
  select(titulo, josh, jennifer) %>%
  view()
#--------------------------------------------------------------------------------------------

# Motivação: Baixando e Limpando dados de Rick and Morty


# ## scrape ##-----------------------------------------------------------------------------------

install.packages("httr")

url <- "https://en.wikipedia.org/wiki/List_Of_Rick_and_Morty_episodes"

res <- httr::GET(url)

wiki_page <- httr::content(res)


lista_tab <- wiki_page %>%
  xml2::xml_find_all(".//table") %>%
  magrittr::extract(2:6) %>%
  rvest::html_table(fill = TRUE) %>%
  purrr::map(janitor::clean_names) %>%
  purrr::map(~dplyr::rename_with(.x,~stringr::str_remove(.x, "_37|_3")))

num_temporadas <- 1:length(lista_tab)

tab <- lista_tab %>%
  purrr::map2(num_temporadas, ~dplyr::mutate(.x, no_season = .y)) %>%
  dplyr::blind_rows()





