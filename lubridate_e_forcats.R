
library(lubridate)

lubridate::now()

as.numeric(now())

dmy_hms("21/04/1995 22:35:00") # Transforma no padrão ISO 8601 dmy = dias, mês e ano e hms = hora, minutos e segundos

dmy("23/01/2002")


# Fusos

dmy_hms("15/04/2002 03:12:34", tz = "Europe/London") # Fuso especificado  pelo argumento tz

dif <- dmy("30/12/2002") - dmy("21/02/2002") # Diferença em dias

as.period(dif) / minutes(1) # convertendo diferença para minutos


format(now(), "%d/%m/%Y %H:%M:%S") # Formatando data para sistema português

with_tz(dmy_hms("15/05/2010 02:12:34"), tzone = "America/Sao_Paulo") #Passando para o fuso de sao paulo(horario de verão)

floor_date(today(), unit = "mouth")# Função chão
rollforward(today())              # Fim do mês

# Feriados(usar o pacote bizdays)

install.packages("bizdays")

bizdays::add.bizdays("2020-12-30", 5, "Brazil/ANBIMA")

bizdays::bizdays.options$set(default.calendar = "Brazil/ANBIMA")

bizdays::add.bizdays("2013-01-02", 5, "Brazil/ANBIMA")


# FORCATS-----------------------------------------------------------------------------------------------------------






