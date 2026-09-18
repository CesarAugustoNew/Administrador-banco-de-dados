CREATE DATABASE SENAI

USE SENAI

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


INSERT INTO Alunos
(Nome_Aluno, Email_Aluno)








