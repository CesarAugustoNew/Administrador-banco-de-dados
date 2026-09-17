-- =========================================================
-- 1. CRIAÇÃO DO BANCO DE DADOS
-- =========================================================

CREATE DATABASE MetalurgicaVitoria;

USE MetalurgicaVitoria;


-- =========================================================
-- 2. DDL - DATA DEFINITION LANGUAGE
-- Criação das tabelas e estruturas do banco
-- =========================================================

-- Nome da Tabela -> Atributos -> Campos -> Colunas -> Tipos de Dados

CREATE TABLE Produtos (
    IdProduto INT IDENTITY(1,1) PRIMARY KEY,
    NomeProduto VARCHAR(100) NOT NULL,
    CategoriaProduto VARCHAR(100),
    QtdProduto INT NOT NULL,
    -- DECIMAL(10,2) permite valores com até 10 dígitos,
    -- sendo 2 casas decimais.
    PrecoUniProduto DECIMAL(10,2) NOT NULL,
    DataCadastroProduto DATETIME DEFAULT GETDATE()
);


-- =========================================================
-- 3. DML - DATA MANIPULATION LANGUAGE
-- Inserção de dados
-- =========================================================

INSERT INTO Produtos
    (NomeProduto, CategoriaProduto, QtdProduto, PrecoUniProduto)
VALUES
    ('Porca M8', 'Fixação', 3000, 0.35),
    ('Arruela M8', 'Fixação', 4000, 0.20),
    ('Parafuso M10', 'Fixação', 2500, 0.95),
    ('Porca M10', 'Fixação', 2000, 0.45),
    ('Arruela M10', 'Fixação', 3000, 0.25),
    ('Parafuso M6', 'Fixação', 4500, 0.55),
    ('Porca M6', 'Fixação', 3500, 0.25),
    ('Arruela M6', 'Fixação', 4000, 0.15),
    ('Chave de Fenda', 'Ferramentas', 150, 12.50),
    ('Chave Phillips', 'Ferramentas', 150, 13.90),
    ('Alicate Universal', 'Ferramentas', 100, 24.90),
    ('Martelo de Unha', 'Ferramentas', 80, 32.50),
    ('Fita Isolante', 'Elétrica', 500, 4.75),
    ('Fio Elétrico 2,5mm', 'Elétrica', 1000, 2.80),
    ('Tomada 10A', 'Elétrica', 300, 8.50),
    ('Interruptor Simples', 'Elétrica', 250, 7.90),
    ('Cano PVC 25mm', 'Hidráulica', 400, 18.50),
    ('Joelho PVC 25mm', 'Hidráulica', 600, 2.50),
    ('Registro de Gaveta', 'Hidráulica', 100, 45.90),
    ('Torneira Plástica', 'Hidráulica', 120, 22.90);


-- =========================================================
-- 4. DQL - DATA QUERY LANGUAGE
-- Consulta dos dados
-- =========================================================

SELECT *
FROM dbo.Produtos;


-- =========================================================
-- 5. UPDATE - ALTERAÇÃO DE DADOS
-- =========================================================

UPDATE dbo.Produtos
SET QtdProduto = 100
WHERE NomeProduto = 'Torneira Plástica';


-- =========================================================
-- 6. DELETE - EXCLUSÃO DE DADOS
-- =========================================================

DELETE FROM dbo.Produtos
WHERE IdProduto = 20;


-- =========================================================
-- REVISÃO RÁPIDA
-- =========================================================

-- DDL — Data Definition Language
-- Define tabelas e estruturas do banco.

-- CREATE    -> Cria bancos, tabelas, índices etc.
-- ALTER     -> Modifica uma estrutura existente.
-- DROP      -> Exclui completamente um objeto.
-- TRUNCATE  -> Remove todos os registros de uma tabela,
--              mantendo sua estrutura.


-- DML — Data Manipulation Language
-- Manipula os dados existentes.

-- INSERT -> Insere novos registros.
-- UPDATE -> Altera registros existentes.
-- DELETE -> Remove registros.


-- DQL — Data Query Language
-- Realiza consultas sem alterar os dados.

-- SELECT -> Consulta e retorna dados.


-- =========================================================
-- DELETE x TRUNCATE x DROP
-- =========================================================

-- DELETE
-- Remove registros específicos.
-- Pode utilizar WHERE.

-- TRUNCATE
-- Remove TODOS os registros da tabela.
-- Mantém a estrutura da tabela.

-- DROP
-- Remove a tabela inteira, incluindo sua estrutura.


-- =========================================================
-- 7. EXERCÍCIO - TABELA DE FORNECEDORES
-- =========================================================

CREATE TABLE Fornecedores (
    IdFornecedor INT IDENTITY(1,1) PRIMARY KEY,
    NomeFornecedor VARCHAR(100) NOT NULL,
    CNPJ VARCHAR(18),
    Telefone VARCHAR(20),
    Cidade VARCHAR(50)
);


-- =========================================================
-- 8. ADICIONANDO FORNECEDOR À TABELA DE PRODUTOS
-- =========================================================

ALTER TABLE Produtos
ADD IdFornecedor INT;


-- =========================================================
-- 9. CRIAÇÃO DA CHAVE ESTRANGEIRA
-- =========================================================

ALTER TABLE Produtos
ADD CONSTRAINT FK_Produto_Fornecedor
FOREIGN KEY (IdFornecedor)
REFERENCES Fornecedores (IdFornecedor);


-- =========================================================
-- 10. INSERÇÃO DOS FORNECEDORES
-- =========================================================

INSERT INTO Fornecedores
    (NomeFornecedor, CNPJ, Telefone, Cidade)
VALUES
    ('Metal Forte', '15.234.567/0001-89', '11987654321', 'São Paulo'),
    ('Fixar Parafusos', '27.345.678/0001-90', '11345678901', 'Campinas'),
    ('Ferragens Brasil', '39.456.789/0001-12', '11456789012', 'Santos');


SELECT *
FROM dbo.Fornecedores;


-- =========================================================
-- 11. ATUALIZAÇÃO DO FORNECEDOR DE UM PRODUTO
-- =========================================================

UPDATE dbo.Produtos
SET IdFornecedor = 1
WHERE NomeProduto = 'Porca M10';


SELECT * FROM dbo.Produtos;
SELECT * FROM dbo.Fornecedores;


SELECT *
FROM dbo.Fornecedores
WHERE Cidade = 'São Paulo';


-- =========================================================
-- 12. EXEMPLO COM TRUNCATE
-- =========================================================

CREATE TABLE Rascunho (
    Teste VARCHAR(50)
);


INSERT INTO Rascunho (Teste)
VALUES
    ('Entendendo TRUNCATE'),
    ('Qualquer coisa'),
    ('Apenas um teste');


SELECT *
FROM dbo.Rascunho;


TRUNCATE TABLE dbo.Rascunho;


SELECT *
FROM dbo.Rascunho;

SELECT p.NomeProduto, f.NomeFornecedor
FROM Produtos p 
JOIN Fornecedores f on p.IdFornecedor = f.IdFornecedor




