# Introdução ao R- Aula 1 -------------------------------------------------

#' Bem vindos ao curso de introdução ao R e RStudio para o curso de pós-graduação 
#' em Ciências Sociais da Universidade Federal de Juiz de Fora (PPGCSO/UFJF). 
#' Em primeiro lugar, vamos entender um pouco sobre como o R se estrutura.
#' Todos esses scripts estarão disponíveis no google classroom ou no link:
#' https://github.com/GuilhermeDuque/Introdu-o-ao-R-UFJF

# Como colocar comentários e seções ---------------------------------------
#' A primeira coisa que precisamos conhecer é a diferença entre código e comentários. 
#' No R, para escrever, relatar, descrever o que está ocorrendo no código, utilizamos
#' # para fazer esses comentários. Tudo o que estiver após esse #, será considerado 
#' um comentário e não será executado. Além disso, caso queira manter um texto corrido,
#' utilize #' para digitar sem precisar colocar # em cada uma das linhas de comentário


#' Outra funcionalidade útil, até mesmo para organização do código, é a criação de seções.
#' Para isso, basta utilizar o comando cntrl + shift + r (no Windows) ou cmd + shift + r
#' (no Mac) para criar esse título, seguido de uma linha. Além de ser útil para se localizar, 
#' podendo até mesmo ser encontrado no ícone com linhas no canto superior direito do source,
#' também pode ser utilizado para reduzir e navegar entre seções do código 

# A interface  ------------------------------------------------------------
#1. Source
#' O primeiro quadrante (cantos esquerdo superior), chamado de Source, será onde
#' a maior parte do código será executado. Aqui, seus códigos ficarão salvos para
#' um próximo uso.

#2. Enviroment
#'O segundo quadrante (canto superior direito), chamado de Enviroment, será onde
#'os objetos criados ao longo do seu código ficarão armazenados. Pense neste 
#'espaço como uma prateleira, onde você coloca objetos que serão utilizados na
#'resolução do seu problema. 

#3. Console
#' O terceiro quadrante (canto inferior esquerdo), chamado de Console, é onde será
#' retornado o que o código está executando. Sejam os resultados da sua ação ou 
#' os problemas que ocorrerão (não se assuste, eles ocorrerão com frequência), todos
#' estes serão retornados no console. Além disso, o console também pode servir para 
#' executar códigos; porém, os códigos utilizados não serão salvos no sistema para 
#' um próximo uso 

#4. Plots/Files/Packages/Help
#'O quarto e último quadrante (canto inferior direito), chamado de Plots/Files/Packages/Help,
#'é onde muito da mágica do R acontece. Aqui, os gráficos gerados a partir dos códigos
#'serão exibidos. Além disso, também utilizamos esse quadrante para verificar pacotes
#'ligados, arquivos e ajuda sobre funções do R. 

# Funções do R ------------------------------------------------------------
# R como calculadora ------------------------------------------------------
#' A parte mais básica do R está em sua capacidade de agir como uma calculadora. 
#' Apesar de simples, essa funcionalidade será extremamente útil para criar, manipular 
#' e lidar com todos os dados que utilizaremos. 

#Soma
2+2

sum(1,2)
#Subtração
4-3

#Multiplicação
2*3

#Divisão
9/3

5/3 #Também podemos utilizar números quebrados

23%%6 #Resto da divisão

23%/%6 #Divisão inteira

#Potenciação
2^4

#Raiz quadrada
sqrt(25)

#'Com isso, podemos extrapolar e realizar diversas operações
2+3*4-8/2

(2+3)*(4-8)/2

#'Caso já tenham uma noção maior de estatística, também podemos utilizar funções
#'mais complexas, como 

# Cálculo de logaritmos
log(10)

# Logaritmo na base 2
log2(16)

# Exponencial
exp(2)

#Arredondamento
round(3.14159, digits = 2)#Arredonda para 2 casas decimais

round(3.14159)

# Operações lógicas  ------------------------------------------------------
#' Além das funções do códigos matemáticos, no R também lidamos com operadores lógicos. 
#' assim como demais linguagens de programação, estes serão muito úteis para verificar
#' condições de suas bases. Em sua maioria, estes operadores retornam como: 
#' TRUE (verdadeiro) ou FALSE (falso).

# Igualdade
2==2

# Desigualdade
2==3

# Maior que
3>2

3>3

# Menor que
2<7

2<2

# Maior ou igual
6>=5

6>=6

# Menor ou igual
4<=9

4<=4

# Diferente
5!=3

5!=5
# Combinações lógicas -----------------------------------------------------
#' Além dos operadores lógicos básicos, também podemos combinar diversas condições
#' utilizando os operadores lógicos E (AND), OU (OR) e NÃO (NOT). Estes operadores
#' são extremamente úteis para verificar múltiplas condições em seus dados.

# Operador E (AND) - &
(3>2) & (5<10)

(3>2) & (5>10)

# Operador OU (OR) - |
(3>2) | (5>10)

(3<2) | (5>10)

# Operador NÃO (NOT) - !
!(3>2)

!(3<2)


# Criação de objetos  -----------------------------------------------------
#' No R, uma das maiores funcionalidades que iremos utilizar é a criação de objetos.
#' Com isso, conseguimos armazenar dados, bases, funções e muito mais. 
# Você pode digitar <- ou utilizar o atalho alt + - 
x <- 2
y <- 3

x+y

z <- x*y

z

#Também podemos criar objetos com vários dados

a <- c(1,2,3,4,5)

a

#Ou 
b <- c(1:10) #a função : cria uma sequência de números

b

#Verificando o tamanho
length(a) 
length(b)

# Podemos criar objetos com textos também
nome <- "Guilherme" #Sempre que criarmos objetos com texto, devemos deixá-los entre aspas

sobrenome <- "Duque"

nome_completo <- c(nome, sobrenome)

nome_completo

toupper(nome_completo) #Deixa as letras maiúsculas 

nchar(nome_completo) #número de letras 

paste("oi","tudo bem?")

# Tipos de objetos --------------------------------------------------------
#' No R, temos diversos tipos de classificação de objetos. Até o momento, trabalhamos com 
#' objetos numéricos (números) e caracteres (textos). Além desses, temos também os objetos lógicos
#' (TRUE/FALSE), vetores, listas, data frames e muitos outros. Cada tipo de objeto possui suas 
#' próprias características e funcionalidades

# Objeto numérico
num <- 32
class(num) #função utilizada para verificar o tipo de dado do objeto

# Objeto caractere
texto <- "Gil do Vigor usando R"
class(texto)

# Objeto lógico
logico <- TRUE
class(logico)

# Objeto vetor
vetor <- c(1,2,3,4,5)
class(vetor)

vetor2 <- c(1, 2, 3, 4, 5, "oi")
class(vetor2)

# Objeto lista
lista <- list(nome="Guilherme", idade=26, notas=c(8,9,10))
class(lista)

# Objeto data frame
df <- data.frame(nome=c("Ana","Bruno","Carla"), idade=c(23,30,27))

class(df)

colnames(df) #Nomes das colunas do data frame

View(df)

# Funções matemáticas  ----------------------------------------------------

#' O R possui diversas funções matemáticas que facilitam a realização de cálculos
#' estatísticos e matemáticos. Abaixo, listamos algumas das funções mais comuns:

# Média
media <- mean(c(1,2,3,4,5))
media

# Mediana
mediana <- median(c(1,2,3,4,5))
mediana

# Moda
a <- c(1,2,2,3,4,5)
table(a) #Função muito útil para verificar frequências 

#Desvio padrão
desvio_padrao <- sd(c(1,2,3,4,5))
desvio_padrao

# Variância
variancia <- var(c(1,2,3,4,5))
variancia

#Acessando dados específicos 
c <- c(10, 20, 30, 40, 50, 110, 220)
c[1] #Primeiro elemento
c[4] #Quarto elemento
c[c > 50] #Elementos maiores que 50

#Também podemos ordenar qualitativamente
categorias <- factor(c("alto", "baixo", "médio", "alto"))
print(categorias)

levels(categorias) #toma pelo alfabeto

#mas podemos modificar os níveis
categorias <- factor(categorias, 
                     levels = c("baixo", "médio", "alto"))
levels(categorias)

# Verificando os níveis
levels(categorias)


# Pipe --------------------------------------------------------------------
#'No R, temos uma funcionalidade maravilhosa, que ajuda imensamente a economizar tempo 
#'e será muito útil em códigos futuros: o pipe.
#'Com o pipe, podemos elencar funções em nosso código, sem precisar criar vários objetos 
#'para realizar uma determinada tarefa. 
#'O pipe pode ser executado e aparecer de duas formas. 
#'A primeira forma e mais antiga é dada por %>%. 
#'A segunda, por sua vez, é dada por |>. 
#'Não existe nenhuma diferença entre nenhuma das duas. Porém, a segunda é escrita 
#'a partir do atalho cntrl + shift + m (Windows) ou cmd + shift + m (Mac).
#'Exemplo de uso do pipe

df$idade |>
  mean()

#Ao invés de 
print(round(mean(df$idade), 2))

#Podemos escrever
df$idade |>
  mean() |>
  round(2) |>
  print()

df$idade |>
  sqrt() |>         # transforma as idades (exemplo)
  mean() |>         # calcula a média do resultado transformado
  print()


# Pacotes -----------------------------------------------------------------
#No R, temos os chamados "pacotes", que funcionam como extensões da linguagem.
#Estes criam mais funcionalidades ao R, permitindo uma infinidade de ações.

#Instalando um pacote
install.packages("dplyr")

#Após a instalação de um pacote, precisaremos carregá-lo para utilizá-lo todas as 
#vezes que ligarmos o R. Por isso, é sempre bom colocar os códigos utilizados 
#no início do código. 
library(dplyr)

#Funcionalidades do dplyr
#Selecionando colunas
select(df, nome)

#Filtrando linhas
filter(df, idade > 25)

# Arranjando linhas
arrange(df, idade)

# Resumindo dados
summarise(df, media_idade = mean(idade))

#Adicionando colunas
mutate(df, idade_mais_5 = idade + 5)

#Renomeando colunas
rename(df, nome_completo = nome)

#Agrupando dados
group_by(df, idade) |>
    summarise(contagem = n())

#Count
count(df, idade)

#'Na aula de amanhã, veremos mais pacotes e funcionalidade do R. Também veremos 
#'Mais funcionalidade do dplyr, especialmente na manipulação de bases de dados.

# Boas prátidade# Boas práticas no código -------------------------------------------------
#' Aprender uma linhagem sempre é difícil. Mas algumas práticas são importantes não 
#' somente para que você aprenda e tenha seu código organizado, mas também para que 
#' este seja compreensível e reprodutível por outras pessoas. 

# Exercícios --------------------------------------------------------------
#Crie um data frame, no qual há uma lista de 5 pessoas, idade e notas. 
#Depois, execute um comando para visualizar a lista. 
# Criando o data frame ----------------------------------------------

pessoas <- c("Ana", "Bruno", "Carla", "Diego", "Elisa")
idades  <- c(23, 30, 27, 35, 22)
notas   <- c(8.5, 7.0, 9.2, 6.8, 8.0)

df <- data.frame(pessoas, idades, notas)

# Criando um gráfico simples ----------------------------------------

barplot(df$notas,
        names.arg = df$pessoas,
        col = "lightblue",
        main = "Notas por Pessoa",
        xlab = "Pessoa",
        ylab = "Nota")

#ou 

barplot(df$notas,
        names.arg = df$pessoas,
        col = c("red", "blue", "green", "orange", "purple"),
        main = "Notas por Pessoa",
        xlab = "Pessoa",
        ylab = "Nota")

#Paleta automática
barplot(df$notas,
        names.arg = df$pessoas,
        col = rainbow(5),
        main = "Notas por Pessoa",
        xlab = "Pessoa",
        ylab = "Nota")

#de calor
barplot(df$notas,
        names.arg = df$pessoas,
        col = heat.colors(5),
        main = "Notas por Pessoa",
        xlab = "Pessoa",
        ylab = "Nota")


