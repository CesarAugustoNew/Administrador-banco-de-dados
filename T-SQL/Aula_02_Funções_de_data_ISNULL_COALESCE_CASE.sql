
DECLARE @Hoje DATE = '2026-10-23';



 
  -- Q1. Quantas locações tiveram retirada em cada mês? Mostre o número do mês e a quantidade, em ordem de mês.
   
SELECT
    MONTH(DataRetirada) AS Mes,
    COUNT(*)            AS Qtde
FROM Locacoes
GROUP BY MONTH(DataRetirada)
ORDER BY MONTH(DataRetirada);


   --Q2. Liste o nome e o telefone de todos os clientes, mostrando
   --    'não informado' quando não houver telefone. Faça com ISNULL e com
   --    COALESCE, lado a lado. O que aconteceu com o ISNULL?

SELECT
    Nome,
    ISNULL(Telefone, 'não informado')   AS TelefoneIsnull,
    COALESCE(Telefone, 'não informado') AS TelefoneCoalesce
FROM Clientes;


   --Q3. Para as locações finalizadas, mostre o número da locação, a retirada, a devolução e quantos dias o carro ficou fora.

SELECT
    NumeroLocacao,
    DataRetirada,
    DataDevolucao,
    DATEDIFF(DAY, DataRetirada, DataDevolucao) AS DiasFora
FROM Locacoes
WHERE Situacao = 'Finalizada';


   --Q4. Classifique as categorias pela diária atual: até R$ 150 é Básica, até R$ 250 é Conforto, acima disso é Premium.

SELECT
    Nome,
    DiariaAtual,
    CASE
        WHEN DiariaAtual <= 150 THEN 'Básica'
        WHEN DiariaAtual <= 250 THEN 'Conforto'
        ELSE 'Premium'
    END AS Classificacao
FROM Categorias;



   --Q5. Para as locações em andamento, mostre o número da locação, o nome
   --    do cliente, a data prevista de devolução, a situação (Atrasada,
   --    Vence hoje ou No prazo) e os dias de atraso (0 para quem não está
   --    atrasado). Ordene do mais atrasado para o menos.

SELECT
    L.NumeroLocacao,
    C.Nome AS Cliente,
    L.DataPrevistaDevolucao,
    CASE
        WHEN L.DataPrevistaDevolucao < @Hoje THEN 'Atrasada'
        WHEN L.DataPrevistaDevolucao = @Hoje THEN 'Vence hoje'
        ELSE 'No prazo'
    END AS Situacao,
    CASE
        WHEN L.DataPrevistaDevolucao < @Hoje
            THEN DATEDIFF(DAY, L.DataPrevistaDevolucao, @Hoje)
        ELSE 0
    END AS DiasAtraso
FROM Locacoes L
INNER JOIN Clientes C ON C.IdCliente = L.IdCliente
WHERE L.Situacao = 'EmAndamento'
ORDER BY DiasAtraso DESC;



   --Q6. Calcule o valor de cada locação finalizada: dias cobrados × diária
   --    do dia. Pela regra da locadora, cobra-se no mínimo 1 dia.

SELECT
    NumeroLocacao,
    CASE
        WHEN DATEDIFF(DAY, DataRetirada, DataDevolucao) = 0 THEN 1
        ELSE DATEDIFF(DAY, DataRetirada, DataDevolucao)
    END AS DiasCobrados,
    ValorDiaria,
    CASE
        WHEN DATEDIFF(DAY, DataRetirada, DataDevolucao) = 0 THEN 1
        ELSE DATEDIFF(DAY, DataRetirada, DataDevolucao)
    END * ValorDiaria AS ValorLocacao
FROM Locacoes
WHERE Situacao = 'Finalizada'
ORDER BY ValorLocacao DESC;



   --Q7. Em uma única linha, mostre quantas locações estão finalizadas,
   --    quantas em andamento e quantas canceladas, cada uma numa coluna.

SELECT
    SUM(CASE WHEN Situacao = 'Finalizada'  THEN 1 ELSE 0 END) AS Finalizadas,
    SUM(CASE WHEN Situacao = 'EmAndamento' THEN 1 ELSE 0 END) AS EmAndamento,
    SUM(CASE WHEN Situacao = 'Cancelada'   THEN 1 ELSE 0 END) AS Canceladas
FROM Locacoes;





   --Q8. Calcule a idade de cada cliente em @Hoje. Primeiro só com
   --    DATEDIFF(YEAR, ...); depois, a idade certa. Para quais clientes a
   --    primeira forma erra?

SELECT
    Nome,
    DataNascimento,
    DATEDIFF(YEAR, DataNascimento, @Hoje) AS IdadeErrada,
    DATEDIFF(YEAR, DataNascimento, @Hoje)
      - CASE
            WHEN DATEADD(YEAR, DATEDIFF(YEAR, DataNascimento, @Hoje), DataNascimento) > @Hoje
                THEN 1
            ELSE 0
        END AS IdadeCerta
FROM Clientes;

SELECT Nome, DataNascimento, IdadeErrada, IdadeCerta
FROM (
    SELECT
        Nome,
        DataNascimento,
        DATEDIFF(YEAR, DataNascimento, @Hoje) AS IdadeErrada,
        DATEDIFF(YEAR, DataNascimento, @Hoje)
          - CASE
                WHEN DATEADD(YEAR, DATEDIFF(YEAR, DataNascimento, @Hoje), DataNascimento) > @Hoje
                    THEN 1
                ELSE 0
            END AS IdadeCerta
    FROM Clientes
) AS T
WHERE IdadeErrada <> IdadeCerta;


   --Q9. Seu Ricardo está pensando em cobrar multa de 1 diária por dia de
   --    atraso. Nas locações finalizadas que voltaram depois do prazo,
   --    quantas foram, quantos dias de atraso somaram e quanto a multa
   --    teria rendido?

SELECT
    COUNT(*) AS QtdeLocacoesAtrasadas,
    SUM(DATEDIFF(DAY, DataPrevistaDevolucao, DataDevolucao))               AS TotalDiasAtraso,
    SUM(DATEDIFF(DAY, DataPrevistaDevolucao, DataDevolucao) * ValorDiaria) AS MultaTotal
FROM Locacoes
WHERE Situacao = 'Finalizada'
  AND DataDevolucao > DataPrevistaDevolucao;


   --Q10. Liste os clientes que fazem aniversário nos próximos 30 dias a
   --     partir de @Hoje: nome, data do aniversário deste ano no formato
   --     dd/mm/aaaa e quantos dias faltam, do mais próximo ao mais distante.

SELECT
    Nome,
    CONVERT(VARCHAR(10), AniversarioEsteAno, 103) AS Aniversario,
    DATEDIFF(DAY, @Hoje, AniversarioEsteAno)      AS DiasFaltando
FROM (
    SELECT
        Nome,
        DATEFROMPARTS(YEAR(@Hoje), MONTH(DataNascimento), DAY(DataNascimento)) AS AniversarioEsteAno
    FROM Clientes
) AS T
WHERE AniversarioEsteAno BETWEEN @Hoje AND DATEADD(DAY, 30, @Hoje)
ORDER BY AniversarioEsteAno;