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
SELECT MAX(Produtos.PrecoUniProduto) AS produto_mais_caro, MIN(Produtos.PrecoUniProduto) AS produto_mais_barato FROM Produtos;

-- soma do estoque total apenas numa categoria especifica
SELECT SUM(Produtos.QtdProduto) AS estoque_fixacao FROM Produtos 
WHERE CategoriaProduto = 'Hidráulica'

-- quantidade de fornecedores cadastrados apenas em São Paulo
SELECT COUNT(Fornecedores.IdFornecedor) AS fornedores_saopaulo FROM Fornecedores 
WHERE Cidade = 'São Paulo'

USE MetalurgicaVitoria


-- Agrupar valores: Agrupar as linhas que tem o mesmo valor em uma coluna
-- Quantidade de produtos(Count) e estoque total(Sum), por categoria(group by)

SELECT Produtos.CategoriaProduto, COUNT(*) AS qtd_produto, SUM(Produtos.QtdProduto) AS estoque_total FROM Produtos GROUP BY Produtos.CategoriaProduto


-- Quantos fornecedores existem em cada cidade - group by

SELECT Fornecedores.Cidade, COUNT(*) AS total_fornecedores FROM Fornecedores GROUP BY Fornecedores.Cidade


SELECT * FROM Fornecedores

-- HAVING -- OPÇÃO DE FILTRAGEM LOGO APOS O USO DO GROUP BY
-- QUAIS CATEGORIAS TEM MAIS DE 200 UNIDADES EM ESTOQUE TOTAL ?

SELECT 
Produtos.CategoriaProduto, 
SUM(Produtos.QtdProduto) AS estoque_total 
FROM Produtos 
GROUP BY Produtos.CategoriaProduto
HAVING SUM(Produtos.QtdProduto) > 200

-- cidades com mais de 1 fornecedor cadastrado
SELECT
Fornecedores.Cidade,
COUNT(*) AS qtd_fornecedor
FROM Fornecedores
GROUP BY Fornecedores.Cidade
HAVING COUNT(*) > 1;

-- ORDER BY --> FUNÇÕES DE ORDENAÇÕES
-- produtos do mais caro para o mais barato
SELECT 
Produtos.NomeProduto,
Produtos.PrecoUniProduto
FROM Produtos
ORDER BY PrecoUniProduto DESC;  -- ASC

-- fornecedores em ordem alfabetica por cidade
SELECT
Fornecedores.NomeFornecedor,
Fornecedores.Cidade
FROM Fornecedores
ORDER BY NomeFornecedor ASC;


-- agrupando os produtos que custam mais de 1 por categoria,
-- quantos produtos e quanto estoque cada categoria tem,
-- mostrando primeiro a categoria com mais estoque

SELECT
Produtos.CategoriaProduto,
Produtos.NomeProduto,
COUNT(*) AS qtd_total_produtos,
SUM(Produtos.QtdProduto) AS qtd_total_estoque_categoria
FROM Produtos
WHERE Produtos.PrecoUniProduto > 1
GROUP BY Produtos.CategoriaProduto, Produtos.NomeProduto
ORDER BY qtd_total_estoque_categoria DESC;








































