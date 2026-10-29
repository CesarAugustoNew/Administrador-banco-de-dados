--Nível 1 — Aquecimento

--Q1. Declare `@NomeLoja` com o valor `'Locadora Veloz'` e `@Hoje` com a data 23/10/2026. Mostre as duas num `SELECT`, com a data no formato brasileiro.


DECLARE @NomeLoja VARCHAR(50) = 'Locadora Veloz';
DECLARE @Hoje DATE = '2026-10-23';

SELECT 
    @NomeLoja AS NomeLoja,
    CONVERT(VARCHAR(10), @Hoje, 103) AS Hoje;


--Q2. Liste o nome de todos os clientes padronizado: sem espaços sobrando e em maiúsculas.

SELECT UPPER(LTRIM(RTRIM(Nome))) AS NomePadronizado
FROM Clientes;


--Q3. O balcão quer as placas com hífen, no formato RVA-1B23. Liste a placa formatada, a marca e o modelo de todos os veículos.

SELECT 
    LEFT(Placa, 3) + '-' + RIGHT(Placa, 4) AS PlacaFormatada,
    Marca,
    Modelo
FROM Veiculos;


--Q4. Crie a variável @Cidade e liste o nome e o telefone dos clientes dessa cidade. Teste com 'Valinhos' e depois com 'Campinas'.

DECLARE @Cidade VARCHAR(50);

SET @Cidade = 'Valinhos';
SELECT Nome, Telefone
FROM Clientes
WHERE Cidade = @Cidade;


DECLARE @Cidade VARCHAR(50);

SET @Cidade = 'Campinas';
SELECT Nome, Telefone
FROM Clientes
WHERE Cidade = @Cidade;


--Nível 2 — Formatando

--Q5. Mostre o nome e o CPF formatado de todos os clientes, no padrão `529.982.247-25`.

SELECT 
    Nome,
    SUBSTRING(Cpf, 1, 3) + '.' +
    SUBSTRING(Cpf, 4, 3) + '.' +
    SUBSTRING(Cpf, 7, 3) + '-' +
    SUBSTRING(Cpf, 10, 2) AS CpfFormatado
FROM Clientes;


--Q6. Monte a frase de contato Nome - e-mail de duas formas, lado a lado: com + e com CONCAT. Quantas linhas ficam NULL na versão com +? Por quê?

SELECT
    Nome,
    TRIM(Nome) + ' - ' + Email        AS ComMais,
    CONCAT(TRIM(Nome), ' - ', Email)  AS ComConcat
FROM Clientes;


--Q7. Guarde numa variável quantos veículos estão disponíveis e escreva na aba Messages a frase: Temos 8 carros disponíveis hoje.

DECLARE @Disponiveis INT;

SELECT @Disponiveis = COUNT(*)
FROM Veiculos
WHERE Status = 'Disponível';

PRINT 'Temos ' + CAST(@Disponiveis AS VARCHAR(10)) + ' carros disponíveis hoje.';

-- Nível 3 — Desafio

--Q8. Seu Ricardo quer saber quais provedores de e-mail os clientes usam. Mostre o domínio (o que vem depois do `@`), em minúsculas, e quantos clientes usam cada um, do mais usado para o menos usado.

SELECT
    LOWER(SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email))) AS Dominio,
    COUNT(*) AS Clientes
FROM Clientes
WHERE Email IS NOT NULL
GROUP BY LOWER(SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email)))
ORDER BY Clientes DESC;


--Q9. Encontre os clientes com espaços sobrando no começo ou no fim do nome.

SELECT IdCliente, Nome, DATALENGTH(Nome) AS Bytes
FROM Clientes
WHERE DATALENGTH(Nome) <> DATALENGTH(TRIM(Nome));


--Q10. Crie a variável @IdLocacao com o valor 144 e gere uma única coluna Comprovante com o texto:
--Locação 144 | Cliente: BRUNO CARVALHO | Veículo: Jeep Renegade (RST-8M56) | Retirada: 20/10/2026 | Diária: R$ 240,00

DECLARE @IdLocacao INT = 144;

SELECT CONCAT(
    'Locação ', L.IdLocacao,
    ' | Cliente: ', UPPER(C.Nome),
    ' | Veículo: ', V.Marca, ' ', V.Modelo,
    ' (', LEFT(V.Placa, 3), '-', RIGHT(V.Placa, 4), ')',
    ' | Retirada: ', CONVERT(VARCHAR(10), L.DataRetirada, 103),
    ' | Diária: R$ ', REPLACE(CAST(L.ValorDiaria AS VARCHAR(20)), '.', ',')
) AS Comprovante
FROM Locacoes L
JOIN Clientes C ON C.IdCliente = L.IdCliente
JOIN Veiculos V ON V.IdVeiculo = L.IdVeiculo
WHERE L.IdLocacao = @IdLocacao;

















