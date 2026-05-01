## Atividade 1
Desafios para fazer em um aplicativo de filmes

# Desafio 1 
O projeto estava sendo desenvolvido com o ListView que cria todos os Widgets de uma vez, mesmo sem estar visíveis, como solução troquei por ListView.builder que vai criando os Widgets assim que aparecem na tela. <br>
Foram usados tambem os seguintes códigos para montar o `ListView.builder`:
`itemCount: filmes.lenght` - Para mostrar a quantidade de itens que tem na lista de filmes <br>
`itemBuilder: (context, index)` - Para construir os itens da lista onde o context são as informações e o index a posição do filme <br>
`final filme = filme[index]` - Vai pegando os filmes de acordo que vai montando a visualização

