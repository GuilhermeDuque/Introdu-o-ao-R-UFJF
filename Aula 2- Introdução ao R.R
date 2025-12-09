
# Aula 2- Estrutura e formatação de dados ---------------------------------
#' Nesta aula, vamos explorar um pouco sobre como importar bases, as importâncias 
#' de data frames, como ordenar e manipular dados no R utilizando não somente as 
#' funções vistas na aula 1, mas também outras. Para isso, precisaremos instalar 
#' alguns pacotes:

#' Na última aula faltou:
#' R é case sensitive: ele diferencia maiúsculo de minúsculo
#' Quando se atribua um valor a um objeto já existente, este será modificado 
#' no enviroment


# Carregando os pacotes ---------------------------------------------------
#'Lembrem-se que para instalar um pacote, devemos utilizar a função:
#'insall.packages("nome_do_pacote")

library(dplyr)
library(readxl)

install.packages("readxl")

install.packages("tidyverse")
library(tidyverse)

library(ggplot2)
library(tidyr)

# Carregando os dados -----------------------------------------------------
#'Com os pacotes carregados, podemos dar início à importação. No R, temos diversas
#'formas de importar arquivos. Muitos deles vem com formatações diferentes e advém 
#'de softwares diferentes; por isso, devemos nos atentar aos pacotes que devemos utilizar
#'e o código para importá-los.
#'Em síntese, temos duas formas de importar um arquivo.
#'A primeira e mais simples é usar a função "Import Dataset", localizada no Enviroment.
#'Nessa função, podemos selecionar diretamente o arquivo que estamos buscando e ajustá-lo para 
#'importar da maneira correta. 

municipios <- read_excel("municipios.xlsx")

rm(municipios)

#'Uma dica importante: sempre que importar algum arquivo pelo Import Dataset, copie o código
#'e cole no script. Dessa forma, você não somente explicita o arquivo que está sendo importado,
#'mas também auxilia na reprodutibilidade do seu código. 
#'
#'Além disso, também temos a função específica para cada tipo de arquivo. 
#'No exemplo abaixo, importamos um arquivo chamado "municipios.xlsx a partir do pacote
#'readxl, que é utilizado para ler arquivos do Excel.


#setwd
#getwd

getwd() #verificar onde está localizado o projeto
setwd() #para alterar a localização do projeto. 


# Bases para treinar ------------------------------------------------------
starwars

billboard |> View()

arrange(billboard, wk1) |> View()

data()

# Base que iremos usar  ---------------------------------------------------
library(dplyr)
library(read)
municipios <- read_excel("municipios.xlsx")

head(municipios) # primeiras linhas

summary(municipios)

str(municipios) # estrutura dos dados

#skip = pula linhas no início do arquivo


glimpse(municipios) # visão geral dos dados

#Mas também possuimos outros tipos de pacotes para importar, como 
#Haven, para SPSS
#readr, para arquivos .csv e .txt
#readxl, para arquivos do Excel
#DBI, para bancos de dados relacionais
#googlesheets4, para planilhas do Google Sheets

# Data frames -------------------------------------------------------------
#Criação e inspeção de data frames

# primeiras linhas
head(municipios)

# últimas linhas
tail(municipios)

#Sumário estatístico das variáveis
summary(municipios)

summary(municipios[, c("populacao", "pib_per_capita", "proporcao_desmatado")])

# estrutura dos dados
str(municipios) 

# nomes das colunas
colnames(municipios) 

# número de linhas
nrow(municipios) 

# Verificar valores únicos
unique(municipios$nome_uf)
unique(municipios$ano)

#contagem de municípios por estado
table(municipios$nome_uf)

#Filtragem e contagem
municipios |> 
  filter(ano == "2019") |>
  count(nome_uf)


# Criando novas bases  ---------------------------------------------------
library(dplyr)

municipios_selecionados <- municipios |> 
  filter(ano == "2019") |> 
  select("id_municipio", "nome_municipio", "nome_uf", "nome_regiao", "ano",
         "populacao", "proporcao_desmatado", "pib_per_capita", "dependencia_agro",
         "partido", "pct_votos_eleito", "alinhado_partido_governador")

municipios_sp <- municipios_selecionados |> 
  filter(nome_uf == "São Paulo")

municipios |> 
  filter(nome_municipio == "Jaboatão dos Guararapes",
         ano == 2020) |> View()

table(municipios$nome_uf)


#grandes municipios
grandes_municipios <- municipios_selecionados |> 
  filter(populacao > 500000)

grandes_municipios |> View()

#Municipios PT
municipios_pt <- municipios |> 
  filter(partido == "PT")

table(municipios_pt$ano)

#Também podemos combinar filtros
municipios_sp_pt <- municipios_selecionados |> 
  filter(nome_uf == "SP",
         partido == "PT")

# Manipulando bases -------------------------------------------------------
#Criando uma nova coluna com classificação da população
municipios <- municipios |> 
  mutate(classificacao_populacao = case_when(
    populacao < 20000 ~ "Pequeno",
    populacao >= 20000 & populacao < 100000 ~ "Médio",
    populacao >= 100000 ~ "Grande"))

municipios$

table(municipios$classificacao_populacao)



municipios |>
  filter(ano == "2020") |>
  count(classificacao_populacao)

# Resumindo dados por grupo
municipios_resumo <- municipios |> 
  group_by(ano, nome_uf) |> 
  summarise(
    populacao_total = sum(populacao, na.rm = TRUE),
    pib_per_capita_medio = mean(pib_per_capita, na.rm = TRUE),
    proporcao_desmatado_medio = mean(proporcao_desmatado, na.rm = TRUE)
  ) |> 
  ungroup() |> View()


# Verificar NAs por coluna
na_por_coluna <- colSums(is.na(municipios))

na_por_coluna

#Percentual de NAs por coluna
percentual_na <- colSums(is.na(municipios_selecionados)) / nrow(municipios_selecionados) * 100


#PARAMOS AQUI
percentual_na


# Pivot wide e longer -----------------------------------------------------
# Transformando dados de longo para largo

municipios|> 
  select(id_municipio, nome_municipio, starts_with("populacao_"))

municipios_wide <- municipios_selecionados |> 
  pivot_wider(
    names_from = ano,
    values_from = c(populacao, proporcao_desmatado, pib_per_capita))

municipios_wide |> 
  select(id_municipio, nome_municipio, starts_with("populacao_")) |> 
  head()

#longer
municipios_long <- municipios_wide |> 
  pivot_longer(
    cols = starts_with(c("populacao_", "proporcao_desmatado_", "pib_per_capita_")),
    names_to = c(".value", "ano"),
    names_sep = "_")
municipios_long |> 
  select(id_municipio, nome_municipio, starts_with("populacao_")) |> 
  head()
# Exportando gráficos  ----------------------------------------------------

write.csv(municipios_selecionados, "municipios_selecionados.csv", row.names = FALSE)

colnames(municipios)

municipios |> view()

view(municipios)
# Utilizando joins --------------------------------------------------------

# Criando dois data frames de exemplo
df1 <- data.frame(
  id = 1:5, #1, 2, 3, 4, 5
  nome = c("Ana", "Bruno", "Carla", "Daniel", "Eva"))

df2 <- data.frame(
  id = c(3, 4, 5, 6, 7),
  idade = c(25, 30, 22, 28, 35))

df3 <- data.frame(
  id = c(3, 4, 12, 9, 7),
  idade = c(25, 40, 32, 28, 35))

# Inner Join
# Mantém apenas as linhas com correspondência em ambos os data frames
inner_join_df <- inner_join(df1, df2, by = "id") 
inner_join_df

inner_join_df_2 <- inner_join(df1, df3, by = c("id" = "oi")) 

inner_join_df_2

# Left Join
left_join_df <- left_join(df1, df2, by = "id") # Mantém todas as linhas do primeiro data frame e adiciona colunas do segundo quando há correspondência
left_join_df

# Right Join
# Mantém todas as linhas do segundo data frame e adiciona colunas do primeiro quando há correspondência
right_join_df <- right_join(df1, df2, by = "id") 
right_join_df

# Full Join
# Mantém todas as linhas de ambos os data frames, preenchendo com NA onde não há correspondência
full_join_df <- full_join(df1, df2, by = "id") 
full_join_df |> view()

# Como fazer gráficos  ----------------------------------------------------
install.packages("ggplot2")
library(ggplot2)

options(scipen = 999) # desativa notação científica
#Gráfico de dispersão
ggplot(municipios, aes(x = populacao, y = pib_per_capita)) +
  geom_point() +
  labs(x = "População",
       y = "PIB per capita",
       title = "Relação entre população e PIB per capita")

#municipios 2020
municipios_2020 <- municipios |> 
  filter(ano == "2020")

#Gráfico de barras
ggplot(municipios_2020, aes(x = nome_regiao)) +
  geom_bar() +
  col(or = "blue") +
  labs(
    x = "Região",
    y = "Número de municípios",
    title = "Distribuição de municípios por região")

#Gráfico de linhas

municipios_resumo_ano <- municipios |> 
  group_by(ano) |> 
  summarise(
    populacao_total = sum(populacao, na.rm = TRUE)) |> 
  ungroup()

municipios_resumo_ano |> 
  ggplot(aes(x = ano, y = populacao_total)) +
  geom_line(group = 1) +
  geom_point() +
  labs(
    x = "Ano",
    y = "População Total",
    title = "Evolução da população total ao longo dos anos")

#Gráfico de regressão
ggplot(municipios, aes(x = populacao, y = desmatado_total_municipio)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    x = "População",
    y = "Área desmatada (município)",
    title = "População vs. Desmatamento com linha de regressão")


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
  geom_col() +
  coord_flip() +
  labs(
    x = "UF",
    y = "Desmatamento médio",
    title = "Desmatamento médio por UF")
# Salvando gráficos -------------------------------------------------------
p <- ggplot(municipios, aes(x = populacao, y = pib_per_capita)) +
  geom_point()

ggsave("pop_pib_scatter.png", plot = p, width = 6, height = 4)

# Exercícios --------------------------------------------------------------
# 1. Importe uma base de dados de sua escolha (pode ser um arquivo .csv, .xlsx, etc.) e
#    explore sua estrutura utilizando funções como head(), str() e summary().

# 2. Filtre os dados para incluir apenas observações de um ano específico e selecione
#    colunas relevantes para sua análise.

#Faça alguns gráficos simples 


