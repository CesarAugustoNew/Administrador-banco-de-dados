/* ---------------------------------------------------------------------
   3. CONFERÊNCIA - se tudo deu certo, o resultado deve ser:
      Clientes 16 | Entregadores 5 | Produtos 14 | Pedidos 40 | ItensPedido 91
   --------------------------------------------------------------------- */
SELECT 'Clientes' AS Tabela, COUNT(*) AS Linhas FROM Clientes
UNION ALL SELECT 'Entregadores', COUNT(*) FROM Entregadores
UNION ALL SELECT 'Produtos', COUNT(*) FROM Produtos
UNION ALL SELECT 'Pedidos', COUNT(*) FROM Pedidos
UNION ALL SELECT 'ItensPedido', COUNT(*) FROM ItensPedido;