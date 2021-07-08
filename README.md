# Carrinho de Compras
<a href="https://github.com/brunomendesdecarvalho/shop-cart/issues"><img alt="GitHub issues" src="https://img.shields.io/github/issues/brunomendesdecarvalho/shop-cart"></a>
<a href="https://github.com/brunomendesdecarvalho/shop-cart/network"><img alt="GitHub forks" src="https://img.shields.io/github/forks/brunomendesdecarvalho/shop-cart"></a>
<a href="https://github.com/brunomendesdecarvalho/shop-cart/stargazers"><img alt="GitHub stars" src="https://img.shields.io/github/stars/brunomendesdecarvalho/shop-cart"></a>
[![Linkedin Badge](https://img.shields.io/badge/-brunomendesccb-blue?style=flat&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/brunomendesccb/)](https://www.linkedin.com/in/brunomendesccb/)

## Sumário

- [Carrinho de Compras](#carrinho-de-compras)
    - [Descrição do Projeto](#descrição-do-projeto)
    - [Descrição do Fluxo](#descrição-do-fluxo)
    - [Descrição da Organização do Projeto](#descrição-da-organização-do-projeto)
    - [Endpoints da API](#endpoints-da-api)
    - [Pacotes utilizados](#pacotes-utilizados)
    - [Bugs Conhecidos](#bugs-conhecidos)
    - [O que Faltou Fazer](#o-que-faltou-fazer)
    - [Como Rodar o Projeto](#como-rodar-o-projeto)
      - [Clonando o Projeto no Computador](#clonando-o-projeto-no-computador)
      - [Antes de Rodar o Projeto](#antes-de-rodar-o-projeto)
      - [Rodando o Projeto](#rodando-o-projeto)
    - [Vídeo](#vídeo)
    - [Agradecimentos](#agradecimentos)

### Descrição do Projeto
O seguinte projeto foi feito como trabalho final para a aprovação na disciplina de Programação para Dispositivos Móveis do Instituto Federal do Piauí.

O aplicativo visa simular um histórico de compras de uma loja qualquer. Constam duas abas, com as telas de listagem, detalhes e adicionar, tanto produtos, quanto carrinhos. As telas do aplicativo não atualizam automaticamente, necessitando mudar de aba e voltar, para que as listas sejam atualizadas.

Os testes foram feitos na build para Android, via emulador do Android Studio.

### Descrição do Fluxo
O usuário inicia na página inicial, que é a página de listagem de carrinhos. No topo ta tela, constam duas abas:
- Carrinhos, onde mostra uma lista de cards com os detalhes dos carrinhos salvos da API;
- Produtos, onde mostra uma lista de cards com os detalhes dos produtos salvos na API.

Se o usuário desejar, ele pode clicar em um dos cards, tanto na aba "Carrinhos" quanto na aba "Produtos", que ele será redirecionado para uma página com os detalhes do card em quem clicou. Na mesma página, consta um botão flutuante onde, caso pressionado, um alerta surge pedindo para confirmar se o usuário deseja excluir o card. Caso aperte em "Cancelar", o alerta é fechado e nada acontece. Caso contrário, o produto ou o carrinho é deletado, porém o usuário não é redirecionado automaticamente - é preciso que ele atualize a página trocando as abas de forma manual (ver seção [Bugs Conhecidos](#bugs-conhecidos))

Na página de listagem, ainda, há um botão flutuante que, caso apertado, o usuário é levado para uma página de formulário, onde devem ser preenchidos os dados para a criação. O usuário, ao enviar o formulário, cria um registro na API, porém o mesmo processo feito ao deletar um registro - mudar de abas na página de listagem - deve, também, ser feito aqui, para poder atualizar a página.

Para a realização do formulário, foi utilizada o pacote [Reactive Forms](https://pub.dev/packages/reactive_forms).


### Descrição da Organização do Projeto
Até a data da escrita desse Readme.md, o projeto basicamente consiste em algumas pastas dentro da lib. Na pasta "utils", encontra-se uma variável que converte uma variável double para o formato da moeda brasileira. Na pasta "screens", temos:
- A pasta "get", onde se encontram os widgets de consumo da API e listagem dos carrinhos e dos produtos;
- A pasta "post", onde se encontram os widgets relacionados à requisição HTTP de mesmo nome;
- A pasta "details", onde estão as páginas de detalhes de cada produto ou carrinho, bem como a requisição DELETE. 

Não foi utilizado um padrão específico de projeto, tal como MVC ou BloC.

### Endpoints da API
- Listagem de carrinhos (GET): https://api-fluttter.herokuapp.com/api/v1/carrinho/
- Listagem de produtos (GET): https://api-fluttter.herokuapp.com/api/v1/produto/
- Detalhes de um carrinho cujo id é {id} (GET): https://api-fluttter.herokuapp.com/api/v1/carrinho/{id}
- Detalhes de um produto cujo id é {id} (GET): https://api-fluttter.herokuapp.com/api/v1/produto/{id}
- Adicionar um carrinho (POST): https://api-fluttter.herokuapp.com/api/v1/carrinho/
- Adicionar um produto (POST): https://api-fluttter.herokuapp.com/api/v1/produto/
- Deletar um carrinho cujo id é {id} (DELETE): https://api-fluttter.herokuapp.com/api/v1/carrinho/{id}
- Deletar um produto cujo id é {id} (DELETE): https://api-fluttter.herokuapp.com/api/v1/produto/{id}

### Pacotes utilizados
As dependências que se encontram no arquivo pubspect.yaml, são as seguintes:
- http: ^0.13.3
- sqflite: ^2.0.0+3
- path: ^1.8.0
- reactive_forms: ^10.4.1

### Bugs Conhecidos
- As páginas não atualizam automaticamente após uma requisição HTTP;

### O que Faltou Fazer
- Adicionar mecanismos de persistência em banco de dados local, sincronizando com a API;
- Atualizar páginas automaticamente;
- Programar a página "Novo Carrinho".

### Como Rodar o Projeto

#### Clonando o Projeto no Computador
Antes de mais nada, é preciso copiar esse repositório para o computador. Para isso, de posse do Git instalado e configurado no computador, abra um terminal de preferência, na pasta desejada, e digite a seguinte linha de comando:
```
git clone https://github.com/brunomendesdecarvalho/shop-cart.git
```
O repositório será todo copiado para a pasta onde o terminal está aberto.

#### Antes de Rodar o Projeto
Um primeiro passo interessante a se fazer, antes de iniciar o projeto propriamente dito, é rodar o flutter doctor, para averiguar se todos os requisitos para iniciar a aplicação estão satisfeitos:
```
flutter doctor
```
Caso haja algum problema, acesse este [link](https://flutter.dev/docs/get-started/install) para realizar a instalação das dependências necessárias.

Para verificar se há dispositivos disponíveis para rodar a aplicação:
```
flutter devices
```
Para entrar na pasta da aplicação, no mesmo terminal:
```
cd pasta_da_aplicacao
```
Caso seja necessário instalar as dependências, no terminal, digite:
```
flutter pub get
```

#### Rodando o Projeto
Por fim, para executá-la:
```
flutter run
```
Uma lista com os dispositivos disponíveis aparecerá. Basta escolher o desejado e esperar o aplicativo iniciar.

#### Vídeo
O vídeo de apresentação do trabalho está disponível neste [link](https://www.youtube.com/watch?v=Cq7g2jPdqmE).

### Agradecimentos
- Agradeço ao Artur Oliveira, por aceitar ser minha dupla e ter feito uma API muito boa para esse projeto, além de tê-la hospedado e de aceitar meus feedbacks e, por fim, de ter me ajudado com algumas partes no Flutter;
- Agradeço ao professor Ely Miranda por nos acompanhar durante 4 dos 5 semestres que cursamos até esse ponto, e por ter me apresentado ao Flutter, linguagem esta que está, hoje, dentro dos meus planos profissionais. Considere esta documentação uma demonstração da minha gratidão, bem como uma forma de compensar o que não completamos desse trabalho, hehehe. :)

Atenciosamente,

Bruno Mendes de Carvalho Castelo Branco.
