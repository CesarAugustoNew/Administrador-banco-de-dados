 /* ---------------------------------------------------------------------
   1. CRIAÇÃO DAS TABELAS (DDL)
   --------------------------------------------------------------------- */

CREATE TABLE Clientes (
    IdCliente     INT          PRIMARY KEY,
    Nome          VARCHAR(100) NOT NULL,
    Bairro        VARCHAR(50)  NOT NULL,
    Telefone      VARCHAR(20)  NULL,          -- alguns clientes não informaram
    DataCadastro  DATE         NOT NULL
);

CREATE TABLE Entregadores (
    IdEntregador     INT          PRIMARY KEY,
    Nome             VARCHAR(100) NOT NULL,
    Veiculo          VARCHAR(20)  NOT NULL,   -- 'Moto' ou 'Bicicleta'
    DataContratacao  DATE         NOT NULL
);

CREATE TABLE Produtos (
    IdProduto    INT           PRIMARY KEY,
    NomeProduto  VARCHAR(100)  NOT NULL,
    Categoria    VARCHAR(30)   NOT NULL,      -- Hambúrguer, Acompanhamento, Bebida, Sobremesa
    Preco        DECIMAL(10,2) NOT NULL       -- preço ATUAL do cardápio
);

CREATE TABLE Pedidos (
    IdPedido      INT           PRIMARY KEY,
    IdCliente     INT           NOT NULL REFERENCES Clientes (IdCliente),
    IdEntregador  INT           NULL     REFERENCES Entregadores (IdEntregador), -- NULL = retirada no balcão
    DataPedido    DATE          NOT NULL,
    TipoEntrega   VARCHAR(20)   NOT NULL,     -- 'Delivery' ou 'Retirada'
    Status        VARCHAR(20)   NOT NULL,     -- 'Entregue' ou 'Cancelado'
    TaxaEntrega   DECIMAL(10,2) NOT NULL,     -- 0.00 quando é retirada
    Avaliacao     TINYINT       NULL          -- nota de 1 a 5; NULL = cliente não avaliou
);

CREATE TABLE ItensPedido (
    IdPedido       INT           NOT NULL REFERENCES Pedidos (IdPedido),
    IdProduto      INT           NOT NULL REFERENCES Produtos (IdProduto),
    Quantidade     INT           NOT NULL,
    PrecoUnitario  DECIMAL(10,2) NOT NULL,    -- preço cobrado NO DIA do pedido
    PRIMARY KEY (IdPedido, IdProduto)
);
