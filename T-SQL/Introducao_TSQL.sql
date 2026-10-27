--Seu Ricardo vai começar a mandar mensagens para os clientes, e o balcão precisa 
--imprimir um comprovante a cada retirada. Só que os dados foram digitados às pressas: 
--tem nome com espaço sobrando, e-mail em maiúsculas, CPF e placa sem pontuação.
--Hoje você vai preparar esses textos com T-SQL, sem alterar nada na tabela: 
--só mudando a forma de mostrar.


-- Variáveis - funções para formatação de texto
DECLARE @NomeLoja VARCHAR(30) = 'Locadora Veloz'; -- já nascem com valores
DECLARE @DataAtual DATE = '2026-10-26'; -- já nascem com valores

DECLARE @DiariaBase DECIMAL(10,2); -- DIARIA BASE JÁ NASCE NULL

SET @DiariaBase = 120.00;

SELECT @NomeLoja as Loja, @DataAtual as Hoje, @DiariaBase as Diaria;

-----------------------------------------------------------
-- Atribuir consulta sql a uma variavel 
DECLARE @TotalClientes INT;

SET @TotalClientes = (select count(*) FROM Clientes);

PRINT 'Total de clientes cadastrados: ' + CAST(@TotalClientes as VARCHAR(10));

----------------------------------------------------------

DECLARE @Cidade VARCHAR(50) = 'Campinas';

SELECT Nome, Cidade
FROM
Clientes 
WHERE Cidade = @Cidade;


----------------------------------------------------------

-- Funções de texto e a funcionalidade de cada função


-- Upper/Lower -> conversão para maiúscula ou minúscula
print UPPER('locadora veloz');

print LOWER('LOCADORA VELOZ');

-- len -> contagem dos caracteres (ignora espaços no fim)
print len('guilherme ');

-- trim -> remove os espaços do inicio ao fim 
print trim (' Felipe ');

print Rtrim(' Ana ');
print Ltrim(' Ana ');

-- Left/Right -> pega os caracteres do começo ou do fim 
print left('RGB1B28', 3);
print right('RGB1B28', 4);

-- substring -> pega um trecho: texto, posição inicial, quantidade
print substring('36589678945', 1, 3);

-- charindex -> posição de um texto dentro de outro, 0 se não achar nada
print charindex('@', 'guilherme@gmail.com');

-- replace -> troca um trecho por outro
print replace('120.00', '.', ',');

-- concat -> juntar valores diferentes
print concat('ana', ' ', 'souza',  ' ','é',  ' ','top');

-------------------------------------------------
-- funções dentro de funções
SELECT 
	Nome, 
	UPPER(Trim(Nome))								as NomePadronizado,
	LEFT(TRIM(Nome), CHARINDEX(' ', TRIM(Nome)) -1) as PrimeiroNome
From Clientes;

SELECT 
	Nome,
	'E-mail: ' + Email  AS Email,
	CONCAT('E-mail: ', Email) AS EmailConcat
FROM CLientes;


------------------------------------------------
-- Funções de conversão = CAST e CONVERT

DECLARE @Total INT = 15;

--PRINT 'Temos' + @Total + 'Carros'; 

--corrigindo:
PRINT 'Temos ' + CAST(@Total AS VARCHAR(10)) + ' Carros'; 

-- também podemos utilizar o convert
PRINT 'Temos ' + CONVERT(VARCHAR(10), @Total) + ' Carros'; 

-- também podemos utilizar o concat
PRINT concat('temos ', @Total, ' carros');

-- convert para datas:
-- 103 -> 23/10/2026
-- 23  -> 2026-10-26
-- 113 -> 20261026

-- convert(VARCHAR(10), colunaData, tipoPadrao)

--formatação de valores monetários: 
SELECT	
	NomeCategoria,
	CONCAT('R$ ', REPLACE(ValorDiaria, '.', ',')) as Diaria
FROM Categorias; 

-- R$ 120,00