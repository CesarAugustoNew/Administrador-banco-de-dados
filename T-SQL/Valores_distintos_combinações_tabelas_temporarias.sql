SELECT FormaPagamento
From Pagamentos;

-- selecionar valores únicos e formas 
--de pagamento
select distinct FormaPagamento
from pagamentos;

SELECT Cidade
from Clientes;

SELECT COUNT(DISTINCT Cidade) as QTD_Cidades
FROM Clientes;

-- Outra possibilidade
SELECT Email
from Clientes; -- 20

Select count(Email) 
from clientes -- 17

SELECT DISTINCT(Email)
FROM Clientes; -- 18

-- Combinando valores de resultados de query (UNION)
-- Carros que estão alugados (na rua)
SELECT idVeiculo FROM Locacoes WHERE Status = 'Em Andamento'
--union -- Carros que estão na rua ou já foram para oficina ?
--union all -- carros que estão na rua e carros que estão na oficina ou que já foram para oficina
--intersect -- Carros na rua e já foram na oficina 
except -- somente os carros que estão na rua que nunca foram pra oficina
SELECT idVeiculo FROM Manutencoes; -- carros que já passaram por manutenção

-- exemplo 1. extrato do caixa de agosto
SELECT 
	DataPagamento as Data,
	FormaPagamento as Descricao,
	'Entrada' as TipoMovimentacao,
	Valor
FROM Pagamentos
WHERE DataPagamento >= '2026-08-01' AND DataPagamento < '2026-09-01'
UNION ALL
SELECT 
	DataSaida,
	Descricao,
	'Saida' as TipoMovimentacao,
	Custo
FROM Manutencoes
WHERE Custo IS NOT NULL AND DataSaida >= '2026-08-01' AND DataSaida < '2026-09-01'


-- Quais carros estão no pátio de locação ??
-- combinações (union, union all, intersect, except)

-- carros que estao na rua
SELECT idVeiculo FROM Locacoes WHERE STATUS = 'Em Andamento'
UNION
SELECT idVeiculo FROM Manutencoes WHERE DataSaida IS NULL;
-- carros que estao na manutencao

SELECT  IdVeiculo FROM Veiculos
EXCEPT
(
	SELECT idVeiculo FROM Locacoes WHERE STATUS = 'Em Andamento'
	UNION
	SELECT idVeiculo FROM Manutencoes WHERE DataSaida IS NULL
);

--quem alugou todo mês ?
SELECT idCliente FROM Locacoes WHERE MONTH(DataRetirada) = 7
INTERSECT
SELECT idCliente FROM Locacoes WHERE MONTH(DataRetirada) = 8
INTERSECT
SELECT idCliente FROM Locacoes WHERE MONTH(DataRetirada) = 9
INTERSECT
SELECT idCliente FROM Locacoes WHERE MONTH(DataRetirada) = 10;






