-- 1. Criação do banco de dados
-- 2. Script de Criação/Definição - DDL (Data Definition Language)

CREATE DATABASE MetalurgicaVitoria;

USE MetalurgicaVitoria;

-- Criação das tebelas de banco de dados
-- NomeTabela -> Atributos -> Campos -> Colunas -> Tipagem de dados
CREATE TABLE Produtos (
	IdProduto INT IDENTITY(1, 1) PRIMARY KEY,
	NomeProduto VARCHAR(100) NOT NULL,
	CategoriaProduto VARCHAR(100),
	QtdProduto INT NOT NULL,
	-- DECIMAL(10, 2) -> 1000000000,00
	PrecoUniProduto FLOAT NOT NULL, -- 19.5,  52.2
	DataCadastroProduto DATETIME DEFAULT GETDATE()

);

-- DML -> DATA MANIPULATION LANGUAGE

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

-- DQL -> DATA QUERY LANGUAGE
-- SELECIONE TUDO DA TABELA Produtos
SELECT * FROM Produtos;


-- DML -> DATA MANIPULATION LANGUAGE
UPDATE dbo.Produtos
SET QtdProduto = 100
WHERE NomeProduto = 'Torneira Plástica'

DELETE FROM Produtos
WHERE IdProduto = 20

--## Revisão rápida

--**DDL — Data Definition Language** (define tabelas e estruturas)

--- `CREATE` → cria tabelas, bancos de dados, índices etc.
--- `ALTER` → modifica uma tabela ou estrutura já existente (ex.: adicionar uma coluna nova).
--- `DROP` → exclui uma tabela ou outro objeto do banco por completo (estrutura e dados juntos).
--- `TRUNCATE` → apaga todos os registros de uma tabela de uma vez, mas mantém a estrutura da tabela intacta.


--**DML — Data Manipulation Language** (mexe nos dados que já existem)

--- `INSERT` → insere novos registros na tabela.
--- `UPDATE` → modifica registros existentes.
--- `DELETE` → remove registros específicos de uma tabela (linha por linha, conforme o `WHERE`).

--**DQL — Data Query Language** (só consulta, não altera nada)

--- `SELECT` → busca e filtra dados dentro do banco.
--> `DELETE` x `TRUNCATE` x `DROP`, qual a diferença? `DELETE` remove linhas específicas (e pode ter `WHERE`); `TRUNCATE` esvazia a tabela inteira de uma vez (sem `WHERE`), mas a tabela continua existindo; `DROP` apaga a tabela inteira, estrutura e tudo — ela deixa de existir no banco.
-->



-- EXERCICIO

CREATE TABLE Fornecedores (
	IdFornecedor INT IDENTITY(1, 1) PRIMARY KEY,
	NomeFornecedor VARCHAR(100) NOT NULL,
	CNPJ VARCHAR(18),
	Telefone VARCHAR(20),
	Cidade VARCHAR(50)
);


ALTER TABLE Produtos
ADD IdFornecedor INT;

INSERT INTO Fornecedores 
(NomeFornecedor, CNPJ, Telefone, Cidade)
VALUES
('Eletrica Clara', '00.0000003-01', '11981231214', 'São Paulo'),
('Martelo Forte', '30.0003-01', '12221231214', 'São Paulo'),
('Phillips One', '02.0000003-01', '11981236664', 'São Paulo');


SELECT * FROM Fornecedores


UPDATE Produtos
SET IdFornecedor = 1
WHERE NomeProduto = 'Cabo Elétrico';
