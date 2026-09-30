-- Q1. A Dona Marta quer saber quantos clientes cadastrados moram no bairro Centro.

SELECT COUNT(*) AS QuantidadeClientes
FROM Clientes
WHERE Bairro = 'Centro';

-- Q2. Liste o nome e o preço dos produtos da categoria Hambúrguer que custam mais de R$ 30,00, do mais caro para o mais barato.

SELECT NomeProduto, Preco
FROM Produtos
WHERE Preco > 30
ORDER BY Preco DESC;


-- Q3. Quantos pedidos foram entregues e quantos foram cancelados no trimestre? Mostre as duas contagens numa consulta só.

SELECT Status, COUNT(*) AS Quantidade
FROM Pedidos
WHERE Status IN ('Entregue', 'Cancelado')
GROUP BY Status;

-- Q4. Considerando só os pedidos entregues: quantos foram, quantos receberam avaliação, quantos ficaram sem avaliação e qual a nota média (com casas decimais)?

SELECT
    COUNT(*) AS TotalPedidosEntregues,
    COUNT(Avaliacao) AS PedidosAvaliados,
    COUNT(*) - COUNT(Avaliacao) AS PedidosSemAvaliacao,
    AVG(CAST(Avaliacao AS DECIMAL(4,2))) AS NotaMedia
FROM Pedidos
WHERE Status = 'Entregue';


-- Q5. A Dona Marta acha que o delivery está crescendo. Mostre, mês a mês, quantos pedidos entregues foram de Delivery e quantos de Retirada.
SELECT
    MONTH(DataPedido) AS Mes,
    TipoEntrega,
    COUNT(*) AS QuantidadePedidos
FROM Pedidos
WHERE Status = 'Entregue'
GROUP BY
    MONTH(DataPedido),
    TipoEntrega
ORDER BY
    MONTH(DataPedido),
    TipoEntrega;


-- 🟡 Nível 2 — Cruzando tabelas (JOIN)

-- Q6. Liste todos os pedidos de janeiro de 2026 com número do pedido, data, nome do cliente, bairro e status, em ordem de data.

SELECT
    p.IdPedido,
    p.DataPedido,
    c.Nome,
    c.Bairro,
    p.Status
FROM dbo.Pedidos AS p
INNER JOIN dbo.Clientes AS c
    ON p.IdCliente = c.IdCliente
WHERE p.DataPedido BETWEEN '2026-01-01' AND '2026-01-31'
ORDER BY p.DataPedido ASC;


-- Q7. Para escolher o entregador do trimestre, a Dona Marta quer ver quantas entregas cada entregador fez (só pedidos entregues), de quem mais entregou para quem menos entregou.

SELECT
    IdEntregador,
    COUNT(*) AS QuantidadeEntregas
FROM dbo.Pedidos
WHERE Status = 'Entregue'
GROUP BY IdEntregador
ORDER BY QuantidadeEntregas DESC;


-- Q8. Quantas unidades de cada produto foram vendidas e quanto cada um faturou? Ordene pelas unidades. O campeão em unidades é também o campeão em faturamento?

SELECT
    IdProduto,
    SUM(Quantidade) AS UnidadeVendidas,
    SUM(Quantidade * PrecoUnitario) AS Faturamento
FROM dbo.ItensPedido
GROUP BY IdProduto
ORDER BY UnidadeVendidas DESC;


-- Q9. Qual o faturamento de produtos por categoria, da maior para a menor?

SELECT
    p.Categoria,
    SUM(ip.Quantidade * ip.PrecoUnitario) AS Faturamento
FROM dbo.ItensPedido AS ip
INNER JOIN dbo.Produtos AS p
    ON ip.IdProduto = p.IdProduto
GROUP BY p.Categoria
ORDER BY Faturamento DESC;

-- Q10. Em quais bairros houve pelo menos 7 pedidos entregues? Mostre o bairro e a quantidade.

SELECT
    c.Bairro,
    COUNT(*) AS QuantidadePedidos
FROM dbo.Pedidos AS p
INNER JOIN dbo.Clientes AS c
    ON p.IdCliente = c.IdCliente
WHERE p.Status = 'Entregue'
GROUP BY c.Bairro
HAVING COUNT(*) >= 7;


-- Q11. O X-Bacon teve reajuste de preço durante o trimestre. Por quais preços ele foi vendido, quantas unidades saíram a cada preço e quanto isso faturou?

SELECT
    ip.PrecoUnitario,
    SUM(ip.Quantidade) AS UnidadesVendidas,
    SUM(ip.Quantidade * ip.PrecoUnitario) AS Faturamento
FROM dbo.ItensPedido AS ip
INNER JOIN dbo.Produtos AS p
    ON ip.IdProduto = p.IdProduto
WHERE p.NomeProduto = 'X-Bacon'
GROUP BY ip.PrecoUnitario;


-- Q12. A Dona Marta vai criar um programa de fidelidade para os 3 clientes que mais gastaram em produtos. Mostre o nome, quantos pedidos cada um fez e o total gasto.

SELECT TOP 3
    c.Nome,
    COUNT(DISTINCT p.IdPedido) AS QuantidadePedidos,
    SUM(ip.Quantidade * ip.PrecoUnitario) AS TotalGasto
FROM dbo.Clientes AS c
INNER JOIN dbo.Pedidos AS p
    ON c.IdCliente = p.IdCliente
INNER JOIN dbo.ItensPedido AS ip
    ON p.IdPedido = ip.IdPedido
GROUP BY c.Nome
ORDER BY TotalGasto DESC;


-- Q13. O faturamento de produtos cresceu ou caiu ao longo do trimestre? Mostre, para cada mês, a quantidade de pedidos entregues e o faturamento de produtos.

SELECT
    MONTH(p.DataPedido) AS Mes,
    COUNT(DISTINCT p.IdPedido) AS QuantidadePedidos,
    SUM(ip.Quantidade * ip.PrecoUnitario) AS Faturamento
FROM dbo.Pedidos AS p
INNER JOIN dbo.ItensPedido AS ip
    ON p.IdPedido = ip.IdPedido
WHERE p.Status = 'Entregue'
GROUP BY MONTH(p.DataPedido)
ORDER BY Mes;


-- Q14. Entregadores com pelo menos 4 entregas e nota média de pelo menos 4.Quem se qualifica? Mostre as entregas e a nota média (com decimais)

SELECT
    IdEntregador,
    COUNT(*) AS Entregas,
    AVG(CAST(Avaliacao AS DECIMAL(4,2))) AS NotaMedia
FROM dbo.Pedidos
WHERE Status = 'Entregue'
GROUP BY IdEntregador
HAVING COUNT(*) >= 4
   AND AVG(CAST(Avaliacao AS DECIMAL(4,2))) >= 4;



-- Q15. Valor dos pedidos entregues em março produtos + taxa de entrega, com o nome do cliente, do maior para o menor.

SELECT
    p.IdPedido,
    c.Nome,
    SUM(ip.Quantidade * ip.PrecoUnitario) + p.TaxaEntrega AS ValorTotal
FROM dbo.Pedidos AS p
INNER JOIN dbo.Clientes AS c
    ON p.IdCliente = c.IdCliente
INNER JOIN dbo.ItensPedido AS ip
    ON p.IdPedido = ip.IdPedido
WHERE p.Status = 'Entregue'
  AND MONTH(p.DataPedido) = 3
GROUP BY
    p.IdPedido,
    c.Nome,
    p.TaxaEntrega
ORDER BY ValorTotal DESC;


-- Q16. Há clientes que se cadastraram e nunca fizeram nenhum pedido. Quem são e em que bairro moram? O que isso sugere para a Dona Marta?

SELECT
    c.Nome,
    c.Bairro
FROM dbo.Clientes AS c
LEFT JOIN dbo.Pedidos AS p
    ON c.IdCliente = p.IdCliente
WHERE p.IdPedido IS NULL;


-- Q17. Existe algum produto do cardápio que nunca apareceu em nenhum pedido, nem cancelado? Ele é candidato a sair do cardápio.

SELECT
    p.NomeProduto
FROM dbo.Produtos AS p
LEFT JOIN dbo.ItensPedido AS ip
    ON p.IdProduto = ip.IdProduto
WHERE ip.IdProduto IS NULL;




