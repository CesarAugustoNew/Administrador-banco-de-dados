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

-- ????? -> carros que estão na rua


SELECT idVeiculo FROM Locacoes WHERE STATUS = 'Em Andamento'
UNION 
SELECT idVeiculo FROM Manutencoes WHERE DataSaida IS NULL;
-- carros que estão na manutenção

SELECT IdVeiculo FROM Veiculos
EXCEPT
(
	SELECT idVeiculo FROM Locacoes WHERE STATUS = 'Em Andamento'
	UNION 
	SELECT idVeiculo FROM Manutencoes WHERE DataSaida IS NULL
);

-- quem alugou todo mês ???
SELECT C.IdCliente, 
	Nome as NomeCliente 
	FROM Locacoes L 
	JOIN Clientes C on  L.IdCliente = C.IdCliente 
	where MONTH(DataRetirada) = 7
INTERSECT 
SELECT C.IdCliente, 
	Nome as NomeCliente 
	FROM Locacoes L 
	JOIN Clientes C on  L.IdCliente = C.IdCliente 
	where MONTH(DataRetirada) = 8
INTERSECT 
SELECT C.IdCliente, 
	Nome as NomeCliente 
	FROM Locacoes L 
	JOIN Clientes C on  L.IdCliente = C.IdCliente 
	where MONTH(DataRetirada) = 9
INTERSECT 
SELECT C.IdCliente, 
	TRIM(Nome) as NomeCliente 
	FROM Locacoes L 
	JOIN Clientes C on  L.IdCliente = C.IdCliente 
	where MONTH(DataRetirada) = 10
	order by NomeCliente asc;


-- primeira maneira -> tabela temporaria
DROP TABLE IF EXISTS #Frota
SELECT IdVeiculo,
		Count(*) as Locacoes,
		Sum(DATEDIFF(Day, DataRetirada, DataDevolucao)) AS diasNaRua
INTO  #Frota
FROM Locacoes
group by IdVeiculo;

Select * from #Frota;

INSERT INTO Veiculos(AnoFabricacao, Cor, IdCategoria,Marca, Modelo, Placa, Quilometragem, Status)
VALUES 
(2021, 'branco', 2, 'FIAT', 'Punto', 'GGG9999', 1455, 'Disponível');

select * from Veiculos;



DROP TABLE IF EXISTS #Atrasadas;

CREATE TABLE #Atrasadas
	(IdLocacao INT, IdCliente INT, DiasAtraso INT)

INSERT INTO #Atrasadas
SELECT	
	IdLocacao,
	IdCliente,
	DATEDIFF(day, DataPrevistaDevolucao, DataDevolucao)
FROM
	Locacoes
Where DataDevolucao > DataPrevistaDevolucao;


SELECT * FROM #Atrasadas;




DROP TABLE IF EXISTS #infoClientesDaCasa;

CREATE TABLE #infoClientesDaCasa
	(IdCliente INT, Nome VARCHAR(50))

INSERT INTO #infoClientesDaCasa
SELECT C.IdCliente, 
	Nome as NomeCliente 
	FROM Locacoes L 
	JOIN Clientes C on  L.IdCliente = C.IdCliente 
	WHERE MONTH(DataRetirada) = 7
INTERSECT 
SELECT C.IdCliente, 
	Nome as NomeCliente 
	FROM Locacoes L 
	JOIN Clientes C on  L.IdCliente = C.IdCliente 
	WHERE MONTH(DataRetirada) = 8
INTERSECT 
SELECT C.IdCliente, 
	Nome as NomeCliente 
	FROM Locacoes L 
	JOIN Clientes C on  L.IdCliente = C.IdCliente 
	where MONTH(DataRetirada) = 9
INTERSECT 
SELECT C.IdCliente, 
	TRIM(Nome) as NomeCliente 
	FROM Locacoes L 
	JOIN Clientes C on  L.IdCliente = C.IdCliente 
	WHERE MONTH(DataRetirada) = 10
	ORDER BY NomeCliente ASC;

SELECT * FROM #infoClientesDaCasa;


DROP TABLE IF EXISTS #ClientesTodoMes;

SELECT 
	C.IdCliente,
	TRIM(C.Nome) as NomeCliente
INTO #ClientesTodoMes
FROM Locacoes L
JOIN Clientes C ON L.IdCliente = C.IdCliente
WHERE 
	L.DataRetirada >= '2026-07-01'
	AND L.DataRetirada < '2026-11-01'
GROUP BY C.IdCliente, C.Nome
HAVING COUNT(DISTINCT MONTH(L.DataRetirada)) = 4


SELECT * FROM #ClientesTodoMes