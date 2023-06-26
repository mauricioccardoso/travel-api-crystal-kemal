# API de Gerenciamento de Planos de Viagens - Rick And Morty

API para armazenar e gerenciar planos de viagens, integrada à API do Rick and Morty para obter informações sobre locais por ID. A API oferece seis rotas principais: listar todos os planos, obter um plano por ID, criar um novo plano, atualizar um plano existente, excluir um plano e adicionar pontos de parada a planos existentes.

### Sumário

1. [Sobre o Projeto](#estrutura-do-projeto)
2. [Pré-requisitos](#pré-requisitos)
3. [Instalação(Sem Docker)](#instalação-se-você-utiliza-docker-clique-aqui)
   - [Instalação (Com Docker)](#docker)
4. [Uso](#uso)
5. [Rotas e Endpoints](#rotas-e-endpoints)
   - [GET_ALL](#listar-todos-os-planos-de-viagem)
   - [GET_BY_ID](#obter-um-plano-de-viagem-por-id)
   - [POST](#criar-um-novo-plano-de-viagem)
   - [PUT](#atualizar-um-plano-de-viagem-existente)
   - [DELETE](#excluir-um-plano-de-viagem-existente)
   - [PATCH](#adicionar-novas-paradas-a-um-plano-de-viagem-existente)
6. [Contributors](#contributors)

## Estrutura do Projeto

O projeto da API de planos de viagens foi desenvolvido utilizando conceitos de Programação Orientada a Objetos (POO) e Clean Code, com o objetivo de aplicar uma arquitetura de software organizada e de fácil manutenção. A estrutura adotada segue o padrão MVC (Model-View-Controller) junto com o uso de serviços, rotas, modelos e repositórios.

## Pré-requisitos

- [Crystal](https://crystal-lang.org/) (version 1.8.2) - A API é desenvolvida em Crystal, portanto, é necessário ter o Crystal instalado em sua máquina
- [Kemal](https://kemalcr.com/) (version 1.4.0) - A API utiliza o framework Kemal para lidar com as rotas e requisições HTTP.
- [Jennifer ORM](https://imdrasil.github.io/jennifer.cr/docs/) (version 0.13.0) - A API utiliza o Jennifer ORM para interagir com o banco de dados.
- [Sam](https://github.com/imdrasil/sam.cr) (0.4.2) - Sam é um gerenciador de serviços usado para facilitar a execução da API e de outros componentes necessários.
- [Docker e Docker Compose](https://www.docker.com/) - O Docker e Docker Compose é necessário para criar e orquestrar os contêineres da API e do banco de dados. Não é nescessário, mas é recomendado utilizar.
- [Postgres](https://www.postgresql.org/) - A API utiliza o banco de dados PostgreSQL para armazenar os planos de viagens. Pode usar outro banco, contudo deve se realizar auterações no arquivo de configuração do banco.
- [GraphQL](https://graphql.org/learn/) - A API utiliza o graphql para fazer requisição para API externa. (Obs.: Não se faz nescessário a instalação).

## Instalação (Se você utiliza docker clique [aqui](#docker))

1. Clone o repositório

```bash
  git clone <URL_DO_REPOSITÓRIO>
```

2. Acesse o diretório do projeto

```bash
  cd <NOME_DO_PROJETO>
```

3. Altere o arquivo de configuração do banco de dados. Em "config/database.yml". Se você utiliza outro banco de dados, será nescessário adicionar o drive do banco no arquivo "shard.yml".

4. Na raiz do projeto, intale as dependências do Crystal usando o Shards

```bash
  shards install
```

5. Crie o banco de dados. (Obs.: O comando 'crystal sam.cr db:setup' cria o banco e executa as migrations)

```bash
  crystal sam.cr db:create ou make sam db:create
```

6. Execute as migrations do banco de dados

```bash
 crystal sam.cr db:migrate ou make sam db:migrate
```

7. Inicie a API

```bash
 crystal  run src/main.cr
```

8. Inicie a API

```bash
 crystal  run src/main.cr
```

---

### Docker

1. Clone o repositório

```bash
  git clone <URL_DO_REPOSITÓRIO>
```

2. Acesse o diretório do projeto

```bash
  cd <NOME_DO_PROJETO>
```

3. Inicie o container

```bash
  docker compose up
```

---

- Após seguir esses passos, a API de Gerenciamento de Planos de Viagens estará instalada e pronta para uso.
- Certifique-se de fornecer as informações corretas para as variáveis de ambiente no arquivo de configuração do banco de dados (database.yml).
- Essas são apenas instruções resumidas e podem variar dependendo do seu ambiente e configurações específicas.
- A API estará disponível em [http://localhost:3000](http://localhost:3000).

## Uso

A API de Gerenciamento de Planos de Viagens oferece várias rotas para interagir com os planos de viagens. A seguir, estão detalhadas as informações sobre cada rota, sua estrutura e exemplos de uso.

1. Rota: **_GET_** /travel_plans

   - Parâmetros de consulta: `optimize` e `expand`
   - Descrição:
     - `optimize` (opcional): Reorganiza a lista de paradas para otimizar o número de viagens entre dimensões, reorganizando-as por popularidade.
     - `expand` (opcional): Modifica os dados retornados para incluir mais informações sobre os locais, além dos IDs.

2. Rota: **_GET_** /travel_plans/:id

   - Parâmetros de consulta: Nenhum

3. Rota: **_POST_** /travel_plans

   - Parâmetros de consulta: Nenhum

4. Rota: **_PUT_** /travel_plans/:id

   - Parâmetros de consulta: Nenhum

5. Rota: **_DELETE_** /travel_plans/:id

   - Parâmetros de consulta: Nenhum

6. Rota: **_PATCH_** /travel_plans/:id/append
   - Parâmetros de consulta: Nenhum

## Rotas e Endpoints

### Listar todos os planos de viagem

Endpoint: /travel_plans

Método HTTP: GET

Descrição: Retorna uma lista de todos os planos de viagem armazenados.

Exemplo de uso

```bash
GET /travel_plans
```

Resposta de sucesso

Em caso de sucesso, o endpoint retornará uma resposta com o status 200 (OK) e o corpo da resposta será um array de objetos JSON, onde cada objeto representa um plano de viagem. Cada objeto terá os seguintes campos:

```bash
[
  {
    "id": 1,
    "travel_stops": [1, 2]
  },
  {
    "id": 2,
    "travel_stops": [3, 4, 5]
  }
]
```

**_Listar todos os planos de viagem com opções de otimização e expansão_**

Descrição: Retorna uma lista de todos os planos de viagem armazenados, com opções de otimização e expansão.

Exemplo de uso

```bash
GET /travel_plans?optimize=false&expand=true
```

Resposta de sucesso
Em caso de sucesso, o endpoint retornará uma resposta com o status 200 (OK) e o corpo da resposta será um array de objetos JSON, onde cada objeto representa um plano de viagem. Cada objeto terá os seguintes campos:

```bash
[
  {
    "id": 1,
    "travel_stops": [
      {
        "id": 1,
        "name": "Earth (C-137)",
        "type": "Planet",
        "dimension": "Dimension C-137"
      },
      {
        "id": 2,
        "name": "Abadango",
        "type": "Cluster",
        "dimension": "unknown"
      }
    ]
  },
  {
    "id": 2,
    "travel_stops": [
      {
        "id": 3,
        "name": "Citadel of Ricks",
        "type": "Space station",
        "dimension": "unknown"
      },
      {...}
    ]
  }
]
```

### Obter um plano de viagem por ID

Endpoint: /travel_plans/:id

Método HTTP: GET

Descrição: Retorna um plano de viagem específico com base no ID fornecido.

Exemplo de uso

```bash
GET /travel_plans/1
```

Resposta de sucesso

Em caso de sucesso, o endpoint retornará uma resposta com o status 200 (OK) e o corpo da resposta será um objeto JSON com os seguintes campos:

```bash
{
  "id": 1,
  "travel_stops": [1, 2, 3]
}
```

Obter um plano de viagem por ID com opções de otimização e expansão

Descrição: Retorna um plano de viagem específico com base no ID fornecido, com opções de otimização e expansão.

Exemplo de uso

```bash
GET /travel_plans/1?optimize=false&expand=true
```

Resposta de sucesso

Em caso de sucesso, o endpoint retornará uma resposta com o status 200 (OK) e o corpo da resposta será um objeto JSON com os seguintes campos:

```bash
{
  "id": 1,
  "travel_stops": [
    {
      "id": 1,
      "name": "Earth (C-137)",
      "type": "Planet",
      "dimension": "Dimension C-137"
    },
    {
      "id": 2,
      "name": "Abadango",
      "type": "Cluster",
      "dimension": "unknown"
    }
  ]
}
```

### Criar um novo plano de viagem

Endpoint: /travel_plans

Método HTTP: POST

Descrição: Cria um novo plano de viagem com base nos dados fornecidos.

Corpo da solicitação

- O corpo da solicitação deve ser um objeto JSON com a seguinte estrutura:

```bash
  {
    "travel_stops": [1, 2]
  }
```

travel_stops (obrigatório): Um array contendo os IDs das paradas de viagem que você deseja adicionar ao plano.

Exemplo de solicitação

```bash
POST /travel_plans
Content-Type: application/json

{
"travel_stops": [1, 2]
}
```

Resposta de sucesso

Em caso de sucesso, o endpoint retornará uma resposta com o status 201 (Created) e o corpo da resposta será um objeto JSON com os seguintes campos:

```bash
{
  "id": 1,
  "travel_stops": [1, 2]
}
```

### Atualizar um plano de viagem existente

Endpoint: /travel_plans/{id}

Método HTTP: PUT

Descrição: Atualiza um plano de viagem existente com base no ID fornecido.

Parâmetros de URL

{id} (obrigatório): O identificador único do plano de viagem que deseja atualizar.

Exemplo de uso

```bash
PUT /travel_plans/1
```

Corpo da requisição

O corpo da requisição deve ser um objeto JSON com a seguinte estrutura:

```bash
{
  "travel_stops": [4, 5, 6]
}
```

travel_stops (obrigatório): Um array contendo os novos IDs das paradas de viagem para atualizar o plano.

Exemplo de solicitação

```bash
PUT /travel_plans/1
Content-Type: application/json

{
  "travel_stops": [4, 5, 6]
}
```

Resposta de sucesso

Em caso de sucesso, o endpoint retornará uma resposta com o status 200 (OK) e o corpo da resposta será um objeto JSON com os seguintes campos:

```bash
{
"id": 1,
"travel_stops": [4, 5, 6]
}
```

### Excluir um plano de viagem existente

Endpoint: /travel_plans/{id}

Método HTTP: DELETE

Descrição: Exclui um plano de viagem existente com base no ID fornecido.

Parâmetros de URL

{id} (obrigatório): O identificador único do plano de viagem que deseja excluir.

Exemplo de uso

```bash
DELETE /travel_plans/1
```

Resposta de sucesso

Em caso de sucesso, o endpoint retornará uma resposta com o status 204 (No Content). Não haverá corpo de resposta.

### Adicionar novas paradas a um plano de viagem existente

Endpoint: /travel_plans/{id}/append

Método HTTP: PATCH

Descrição: Adiciona novas paradas à lista de paradas de um plano de viagem existente com base no ID fornecido.

Parâmetros de URL

{id} (obrigatório): O identificador único do plano de viagem ao qual deseja adicionar novas paradas.

Exemplo de uso

```bash
PATCH /travel_plans/1/append
```

Corpo da requisição

O corpo da requisição deve ser um objeto JSON com a seguinte estrutura:

```bash
{
  "travel_stops": [4, 5, 6]
}
```

travel_stops (obrigatório): Um array contendo os IDs das novas paradas de viagem a serem adicionadas ao plano existente.

Exemplo de solicitação

```bash
PATCH /travel_plans/1/append
Content-Type: application/json

{
  "travel_stops": [4, 5, 6]
}
```

Resposta de sucesso

Em caso de sucesso, o endpoint retornará uma resposta com o status 200 (OK) e o corpo da resposta será um objeto JSON com os seguintes campos:

```bash
{
  "id": 1,
  "travel_stops": [1, 2, 3, 4, 5, 6]
}
```

## Contributors

- **_[Maurício Erick da Costa Cardoso](https://portfolio-mauricio-cardoso.vercel.app/home) - desenvolvedor_**
- **[github](https://github.com/mauricioccardoso)**
- **[LinkedIn](https://www.linkedin.com/in/mauricioccardoso/)**
- **mauricioerick17@gmail.com**
