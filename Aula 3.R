# Aula 3- Análise exploratória e visualização -----------------------------
#'Nesta aula, entenderemos um pouco melhor como podemos visualizar
#'e criar gráficos a partir dos dados que geramos. 


# Pacotes -----------------------------------------------------------------
library(tidyverse)

# Análise Descritiva ------------------------------------------------------
municipios <- read_excel("municipios.xlsx")

glimpse(municipios)
summary(municipios$id_municipio)

# Visualização de Dados ---------------------------------------------------
#'A primeira coisa que precisamos entender é o tipo de dado
#'que estamos tendo que lidar. Seja ele categórico, numérico, etc..
#'o tipo de gráfico que melhor pode representar o que buscamos varia.
#'
#'Outro ponto importante é entender como queremos mostrar o gráfico.
#'Uma das vantagens do R é a capacidade de customização dos gráficos.
#'Para isso, devemos entender a ordem de construção de um código 
#'a partir do ggplot2
#'
#'1. base, dados e mapeamentos estéticos (aes)
#'2. geom, tipo de gráfico
#'3. scales, eixos e legendas
#'4. coord, coordenadas
#'5. facet, facetas
#'6. theme, tema
#'7. labs, rótulos


#'Os gráficos gerados não necessariamente precisarão de cada uma
#'dessas funções. Mas entender a ordem de construção ajuda bastante.

options(scipen = 999) # desativa notação científica

#' Antigamente, os gráficos era rudimentares e simples de serem feitos
hist(municipios$pib_per_capita,
     main = "Histograma do PIB per capita dos municípios",
     xlab = "PIB per capita",
     ylab = "Frequência",
     col = "lightblue",
     border = "black")




# Tipos de gráficos -------------------------------------------------------
#' Com o ggplot2, podemos criar diversos tipos de gráficos e 
#' controlá-los melhor. 
#Gráfico de dispersão (x e y são numéricos)
install.packages("ggplot2")
library(ggplot2)
options(scipen = 999)

ggplot(municipios, aes(x = populacao, y = pib_per_capita)) +
  geom_point() +
  labs(x = "População",
       y = "PIB per capita",
       title = "Relação entre população e PIB per capita",
       subtitle = "Dados dos mape_municipios")



#municipios 2020
municipios_2020 <- municipios |> 
  filter(ano == "2020")

#Gráfico de barras (x é categórico, y é numérico ou contagem)
ggplot(municipios_2020, aes(x = nome_regiao)) +
  geom_bar() +
  labs(x = "Região",
       y = "Número de municípios",
       title = "Distribuição de municípios por região")

#Gráfico de linhas (x é numérico ou categórico ordenado, y é numérico)
municipios_resumo_ano <- municipios |> 
  group_by(ano) |> 
  summarise(populacao_total = sum(populacao, na.rm = TRUE))

municipios_resumo_ano |> 
  ggplot(aes(x = ano, y = populacao_total)) +
  geom_line(group = 1) + #group= 1 para garantir que a linha seja desenhada corretamente
  geom_point() +
  labs(x = "Ano",
       y = "População Total",
       title = "Evolução da população total ao longo dos anos")

#Gráfico de regressão (x e y são numéricos).
ggplot(municipios, aes(x = populacao, y = desmatado_total_municipio)) +
  geom_point(color = "red") +
  geom_smooth(method = "lm", se = FALSE) +  #se= FALSE remove a faixa de confiança
  labs(x = "x- VI- População",
       y = " y- VD-Área desmatada (município)",
       title = "População vs. Desmatamento com linha de regressão")

#histograma. x é numérico
ggplot(municipios_2020, aes(x = pib_per_capita)) +
  geom_histogram(binwidth = 1000, fill = "red", color = "darkred", alpha = 0.10) +
  labs(
    x = "PIB per capita",
    y = "Contagem de municípios",
    title = "Distribuição do PIB per capita dos municípios em 2020")

#bindwidth: largura das barras
#alpha: transparência das barras
#fill: cor de preenchimento
#color: cor da borda

#Exemplo de distribuição normal
set.seed(123)
dados_normal <- data.frame(valor = rnorm(1000, mean = 10, sd
                                         = 3))

ggplot(dados_normal, aes(x = valor)) +
  geom_histogram(binwidth = 2, fill = "lightblue", color = "black", alpha = 0.7) +
  labs(
    x = "Renda",
    y = "Frequência",
    title = "Distribuição de renda no Brasil")


#Distribuição enviesada



#Gráfico de barras com resumo. x é categórico, y é numérico
municipios |>
  group_by(nome_uf) |>
  summarise(media_desmatamento = mean(desmatado_total_municipio, na.rm = TRUE)) |>
  ggplot(aes(x = reorder(nome_uf, media_desmatamento), y = media_desmatamento)) +
  geom_col() +
  coord_flip() +
  labs(
    x = "UF",
    y = "Desmatamento médio",
    title = "Desmatamento médio por UF")

municipios_sem_na <- municipios |>
  filter(!is.na(nome_uf))

municipios_sem_na |>
  group_by(nome_uf) |>
  summarise(media_desmatamento = mean(desmatado_total_municipio, na.rm = TRUE)) |>
  ggplot(aes(x = reorder(nome_uf, media_desmatamento), y = media_desmatamento)) +
  geom_col(color= "red") +
  coord_flip() +
  labs(
    x = "UF",
    y = "Desmatamento médio",
    title = "Desmatamento médio por UF")

#boxplot. x é categórico, y é numérico. 
ggplot(municipios_2020, aes(x = nome_regiao, y = pib_per_capita)) +
  geom_boxplot() +
  labs(
    x = "Região",
    y = "PIB per capita",
    title = "Distribuição do PIB per capita por região")

options(scipen - 999)
quantile(municipios_2020$pib_per_capita, 
         probs = c(0.25, 0.5, 0.75), na.rm = TRUE)
# Exemplos de gráficos com todas as camadas  ------------------------------

ggplot(municipios_2020, aes(x = nome_regiao, y = pib_per_capita, fill = nome_regiao)) +
  geom_boxplot() +
  scale_y_continuous(labels = scales::dollar_format(prefix = "R$ ")) +
  coord_flip() +
  facet_wrap(~ ano) +
  theme_minimal() +
  labs(
    x = "Região",
    y = "PIB per capita",
    title = "Distribuição do PIB per capita por região em 2020",
    caption = "Fonte: mape_municipios") +
  theme(legend.position = "none")


# Salvando gráficos -------------------------------------------------------
p <- ggplot(municipios, aes(x = populacao, y = pib_per_capita)) +
  geom_point()
library(ggplot2)
ggsave("pop_pib_scatter.png", plot = p, width = 6, height = 4)


# geobr -------------------------------------------------------------------
install.packages("geobr")
install.packages("sf")

library(geobr)
library(sf)

# Carregar os dados geográficos dos municípios
municipios_geo <- read_municipality(year = 2020)

municipios_geo |> View()

library(ggplot2)
# Visualizar o mapa dos municípios
ggplot() +
  geom_sf(data = municipios_geo, fill = "lightblue", color = "white") +
  labs(title = "Mapa dos municípios do brasil em 2020")

#Outro pacote para gráficos.
intall.packages("esquisse")
library(esquisse)
#Duas formas de fazer o mesmo gráfico
#Criando objeto
municipios_2020 <- municipios |> 
  filter(ano == "2020")

ggplot(municipios_2020) +
  aes(x = nome_uf) +
  geom_bar(fill = "red") +
  coord_flip()+
  theme_minimal()

#Direto usando pipe
municipios |> 
  filter(ano == "2020") |> 
  ggplot() +
  aes(x = partido) +
  geom_bar(fill = "red") +
  coord_flip()+
  theme_minimal()
