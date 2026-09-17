-- Funções de agregações
-- Filtros e funções de agregação - WHERE, COUNT, SUM, AVG...

-- WHERE -- filtragem de linhas/dados

SELECT * FROM Produtos
WHERE CategoriaProduto = 'Ferramentas';

SELECT * FROM Fornecedores
WHERE Cidade = 'São Paulo';


-- OPERADORES DE COMPARAÇÃO
-- > < >= <= <> =

SELECT * FROM Produtos
WHERE QtdProduto <= 200;

-- OPERADORES LÓGICOS
-- AND, OR, NOT

SELECT * FROM Produtos
WHERE NomeProduto = 'Martelo de Unha' AND QtdProduto >= 80;

SELECT * FROM Produtos
WHERE CategoriaProduto = 'Fixação' OR CategoriaProduto = 'Elétrica';


-- IN -> Testa varia valores de uma vez

SELECT * FROM Produtos
WHERE CategoriaProduto IN('Fixação');

-- BETWEEN (VALORES ENTRE) 
SELECT * FROM Produtos
WHERE PrecoUniProduto BETWEEN 10 AND 100;

-- LIKE -> Busca um padrão textual
SELECT * FROM Fornecedores
WHERE NomeFornecedor LIKE '%forte%'


-- IS NULL/NOT NULL -> Testar se um campo esta vazio ou não
SELECT * FROM Produtos
WHERE IdFornecedor IS NOT NULL

--FUNÇÕES DE AGREGAÇÃO
-- COUNT() -> CONTA QUANTAS LINHAS EXISTEM
-- SUM() -> SOMA OS VALORES DE UMA COLUNA NUMÉRICA
-- AVG() -> MÉDIA
-- MAX() -> RETORNA O MAIOR NUMERO
-- MIN() -> RETORNA O MENOR NUMERO

-- quantos produtos temos cadastrados
SELECT COUNT(*) AS total_produtos FROM Produtos;

SELECT COUNT(*) AS total_fornecedores FROM Fornecedores;

-- qual a soma de tudo que existe em estoque
SELECT SUM(Produtos.QtdProduto) AS total_estoque FROM Produtos;

-- preçõ médio dos produtos
SELECT AVG(Produtos.PrecoUniProduto) AS preco_medio FROM Produtos;


-- produto mais caro e o produto mais barato (vem valores, não nomes)
SELECT MAX(Produtos.PrecoUniProduto) AS produto_mais_caro FROM Produtos;

-- soma do estoque total apenas numa categoria especifica
SELECT SUM(Produtos.QtdProduto) AS estoque_fixacao FROM Produtos 
WHERE CategoriaProduto = 'Hidráulica'

-- quantidade de fornecedores cadastrados apenas em São Paulo
SELECT COUNT(Fornecedores.IdFornecedor) AS fornedores_saopaulo FROM Fornecedores 
WHERE Cidade = 'São Paulo'




















