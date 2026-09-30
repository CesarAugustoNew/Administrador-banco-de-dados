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
    SUM(CASE 
        WHEN Avaliacao IS NULL THEN 1 
        ELSE 0 
    END) AS PedidosSemAvaliacao,
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


