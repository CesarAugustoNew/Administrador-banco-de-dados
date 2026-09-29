/* =====================================================================
   ATIVIDADE - FUNÇÕES DE AGREGAÇÃO, FILTROS E JOIN
   Banco: HamburgueriaBrasa   |   SGBD: SQL Server (SSMS)
   Hamburgueria Brasa & Pão - pedidos do 1º trimestre de 2026
   ===================================================================== */

IF DB_ID('HamburgueriaBrasa') IS NULL
    CREATE DATABASE HamburgueriaBrasa;
GO

USE HamburgueriaBrasa;
GO

-- Apaga as tabelas na ordem inversa das chaves estrangeiras
DROP TABLE IF EXISTS ItensPedido;
DROP TABLE IF EXISTS Pedidos;
DROP TABLE IF EXISTS Produtos;
DROP TABLE IF EXISTS Entregadores;
DROP TABLE IF EXISTS Clientes;
GO

/*