# Aula 4 ------------------------------------------------------------------
## Terminar a aula 3. Pedir exercícios 
## esquisse

# Carregando dados de municípios ------------------------------------------

municipios <- read_excel("municipios.xlsx")

# Ensinando loop ----------------------------------------------------------
#' Criando um loop para gerar um gráfico de linhas 
#' do número de prefeituras que cada 
#' partido teve ao longo dos anos, gerando um gráfico para cada partido e
#' salvando os gráficos 
library(dplyr)
library(ggplot2)
library(tidyr)   

# If/Else -----------------------------------------------------------------
#' Muitas vezes, queremos verificar várias coisas ao mesmo tempo na tabela,
#' delimitando uma coisa para outra. Por exemplo, se o partido é o PSDB, 
#' então o número de prefeituras é maior que 100, senão, é menor que 100.
#' Para isso, usamos o if/else.

#' O código funciona como:
#' if (condição) {
#'   # código a ser executado se a condição for verdadeira
#' } else {
#'   # código a ser executado se a condição for falsa
#' }
#Exemplo

if (municipios$partido[1] == "PT") {
  print("O partido é PT")} else {
  print("O partido não é PT")
}   

#' Podemos também usar o ifelse, que é uma função que verifica uma condição e retorna
#' um valor se a condição for verdadeira e outro valor se a condição for falsa.

#' O código funciona como
#' ifelse(condição, valor_se_verdadeiro, valor_se_falso)
#Exemplo

municipios$partido <- ifelse(municipios$partido == "PSDB", "PSDB", "Outro partido")

municipios |> View()


# Loop --------------------------------------------------------------------
#' No loop, nós repetimos uma ação várias vezes, visando verificar, gerar ou até
#' treinar algo (em machine learning, isso é super importante!). Para isso, utilizamos
#' a função for. 

for (i in 1:5) {
  print(i)
}

#' Ao colocar em grande escala, o loop serve para salvar gráficos, processar
#' dados e muito mais.
library(readxl)
municipios <- read_excel("municipios.xlsx")

#loop para gerar gráficos do número de municipios que cada partido teve ao longo dos anos
library(dplyr)
library(ggplot2)

# conta número de prefeituras por partido em cada ano
pref_por_ano <- municipios  |>  
  group_by(ano, partido) |>  
    summarise(n_prefeituras = n(), .groups = "drop")


partidos <- unique(pref_por_ano$partido)

for (p in partidos) {
  
  # filtra dados do partido
  dados_p <- pref_por_ano |>  filter(partido == p)
  
  # cria o gráfico
  g <- ggplot(dados_p, aes(x = ano, y = n_prefeituras)) +
    geom_line() +
    geom_point() +
    labs(title = paste("Número de prefeituras do partido", p),
         x = "Ano",
         y = "Número de prefeituras")
  
  # salva o gráfico
  ggsave(filename = paste0("prefeituras_", p, ".png"),
    plot = g,
    width = 7,
    height = 5
  )
}

table(municipios$partido,municipios$ano)


# R Markdown  -------------------------------------------------------------
# No R markdown, podemos gerar documentos, apresentações e até sites.

# # para título
# ## para subtítulo e assim por diante...
# - item 1
# - item 2
# - subitem

#1. item A
# 2. item B
# 3. item C



data()
