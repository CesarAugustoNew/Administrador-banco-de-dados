CREATE DATABASE SENAI

USE SENAI

-- DDL
CREATE TABLE Instrutores (
	Id_Instruto INT IDENTITY (1,1) PRIMARY KEY,
	Nome_Instrutor VARCHAR(50) NOT NULL,
	Especialidade VARCHAR(50) NOT NULL
);

CREATE TABLE Alunos (

	Id_Aluno INT IDENTITY (1,1) PRIMARY KEY,
	Nome_Aluno VARCHAR(50) NOT NULL,
	Email_Aluno VARCHAR(100) NOT NULL
);


CREATE TABLE Cursos (
	Id_Curso INT IDENTITY (1,1) PRIMARY KEY,
	Nome_Curso VARCHAR(100) NOT NULL,
	Descricao VARCHAR(100), 
	Id_Instrutor INT,

	CONSTRAINT FK_Instrutor
	FOREIGN KEY (Id_Instrutor)
	REFERENCES Instrutores (Id_Instruto)
);


CREATE TABLE Matricula (

	Id_Matricula INT IDENTITY (1,1) PRIMARY KEY,
	DataMatricula DATETIME DEFAULT GETDATE(),
	Id_Aluno INT,
	Id_Curso INT,

	CONSTRAINT FK_Aluno
	FOREIGN KEY (Id_Aluno)
	REFERENCES Alunos (Id_Aluno),

	CONSTRAINT FK_Curso
	FOREIGN KEY (Id_Curso)
	REFERENCES Cursos (Id_Curso)

);


-- DML 
INSERT INTO Alunos
(Nome_Aluno, Email_Aluno)
VALUES
	('Cesar Augusto', 'cesar@email.com'),
	('Jose Silva', 'Jose@email.com'),
	('Carol Fofa', 'Carolzinha@email.com'),
	('Pedro Henrique', 'pedrinho@email.com'),
	('Katarina', 'Katarina@email.com'),
	('Diana', 'Diana@email.com');

SELECT * FROM Alunos


INSERT INTO Instrutores
(Nome_Instrutor, Especialidade)
VALUES
	('Jose', 'Desenvolvimento de Software'),
	('Rengar', 'Ciência e Análise de Dados'),
	('Darius', 'Segurança da Informação'),
	('Lux', 'Inteligência Artificial'),
	('Gustavo', 'Gerente de TI'),
	('Carlos', 'Computação em Nuvem');

SELECT * FROM Instrutores


INSERT INTO Cursos
(Nome_Curso, Descricao, Id_Instrutor)
VALUES
	('Python Avançado', 'Técnicas sofísticadas de Python e arquiterura de código', 1 ),
	('Desenvolvedor Full Stack', ' desenvolvimento completo de aplicações web construindo desde a interface visual até a lógica do servidor e bancos de dados', 1),
	('Programação com IA', 'Aprenda as melhores técnicas de desenvolvimento com inteligencia artificial', 4),
	('Programação em Nuvem AWS', 'Aprenda como otimizar suas aplicações utilizando AWS', 6),
	('Teck Lead', 'Desenvolva Soft skills para ser teck lead', 5),
	('Segurança em TI', 'Aprenda a como se proteger na internet e evitar hacks e golpes', 3),
	('Programação em C++', 'Aprenda a programar em C++', 1),
	('Administrador de banco de dados', 'Aprenda a ser um Administrador de banco de dados', 2);


SELECT * FROM Cursos
SELECT * FROM Alunos
SELECT * FROM Matricula


INSERT INTO Matricula
(Id_Curso, Id_Aluno)
VALUES
	(8, 1),
	(12, 4),
	(10, 5),
	(10, 4),
	(14, 1),
	(12, 5),
	(8, 3),
	(9, 6);


-- Desafio - Funções de agregação e filtragem (adicional):

-- DQL

-- 1. Contem quantos alunos estão matriculados em cada curso

SELECT 
    Cursos.Nome_Curso,
    COUNT(Matricula.Id_Aluno) AS Quantidade_Alunos
FROM Cursos
LEFT JOIN Matricula
    ON Cursos.Id_Curso = Matricula.Id_Curso
GROUP BY Cursos.Nome_Curso;


-- 2. Calculem o total de matrículas registradas

SELECT COUNT(*) AS Total_Matriculas
FROM Matricula;


-- 3. Encontrem o instrutor responsável pelo maior número de cursos

SELECT TOP 1
    Instrutores.Nome_Instrutor,
    COUNT(Cursos.Id_Curso) AS Quantidade_Cursos
FROM Instrutores
JOIN Cursos
    ON Instrutores.Id_Instruto = Cursos.Id_Instrutor
GROUP BY Instrutores.Nome_Instrutor
ORDER BY Quantidade_Cursos DESC;

-- 4. Listem os cursos que ainda não possuem nenhum aluno

SELECT 
    Cursos.Nome_Curso
FROM Cursos
LEFT JOIN Matricula
    ON Cursos.Id_Curso = Matricula.Id_Curso
GROUP BY Cursos.Nome_Curso
HAVING COUNT(Matricula.Id_Aluno) = 0;

-- 5. Quantidade de alunos matriculados por instrutor

SELECT
    Instrutores.Nome_Instrutor,
    COUNT(Matricula.Id_Aluno) AS Quantidade_Alunos
FROM Instrutores
JOIN Cursos
    ON Instrutores.Id_Instruto = Cursos.Id_Instrutor
LEFT JOIN Matricula
    ON Cursos.Id_Curso = Matricula.Id_Curso
GROUP BY Instrutores.Nome_Instrutor;

-- 6. Identifiquem o curso com maior número de matrículas

SELECT TOP 1
    Cursos.Nome_Curso,
    COUNT(Matricula.Id_Aluno) AS Quantidade_Alunos
FROM Cursos
LEFT JOIN Matricula
    ON Cursos.Id_Curso = Matricula.Id_Curso
GROUP BY Cursos.Nome_Curso
ORDER BY Quantidade_Alunos DESC;

-- 7. Listem os alunos matriculados em mais de um curso

SELECT
    Alunos.Nome_Aluno,
    COUNT(Matricula.Id_Curso) AS Quantidade_Cursos
FROM Alunos
JOIN Matricula
    ON Alunos.Id_Aluno = Matricula.Id_Aluno
GROUP BY Alunos.Nome_Aluno
HAVING COUNT(Matricula.Id_Curso) > 1;

-- 8. Contem quantos instrutores existem para cada especialidade

SELECT
    Especialidade,
    COUNT(*) AS Quantidade_Instrutores
FROM Instrutores
GROUP BY Especialidade;

-- 9. Mostrem os 3 cursos com mais alunos

SELECT TOP 3
    Cursos.Nome_Curso,
    COUNT(Matricula.Id_Aluno) AS Quantidade_Alunos
FROM Cursos
LEFT JOIN Matricula
    ON Cursos.Id_Curso = Matricula.Id_Curso
GROUP BY Cursos.Nome_Curso
ORDER BY Quantidade_Alunos DESC;

-- 10. Listem os cursos cujo nome contém "Python"

SELECT
    Nome_Curso
FROM Cursos
WHERE Nome_Curso LIKE '%Python%';

-- 11. Calculem a média de alunos matriculados por curso

SELECT
    CAST(COUNT(*) AS DECIMAL(10,2)) /
    (SELECT COUNT(*) FROM Cursos) AS Media_Alunos_Por_Curso
FROM Matricula;

-- 12. Listem apenas os instrutores que lecionam mais de um curso

SELECT
    Instrutores.Nome_Instrutor,
    COUNT(Cursos.Id_Curso) AS Quantidade_Cursos
FROM Instrutores
JOIN Cursos
    ON Instrutores.Id_Instruto = Cursos.Id_Instrutor
GROUP BY Instrutores.Nome_Instrutor
HAVING COUNT(Cursos.Id_Curso) > 1;


