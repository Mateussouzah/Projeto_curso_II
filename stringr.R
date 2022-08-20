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

regex_email_final <- str_c(regex_email, "|", regex_email_2, "|", regex_email_3)

str_view(vetor_de_email, regex_email_final)


