CREATE DATABASE Petshop

use Petshop


CREATE TABLE Tutor(
	
	id_tutor INT PRIMARY KEY IDENTITY (1,1),
	nome_tutor VARCHAR(100) NOT NULL,
	telefone_tutor VARCHAR(100),
	bairro_tutor VARCHAR(100),
);


CREATE TABLE Pet (

	id_pet INT PRIMARY KEY IDENTITY (1,1),
	nome_pet VARCHAR(100) NOT NULL,
	especie VARCHAR(50) NOT NULL,
	raca VARCHAR(50) NOT NULL,
	alergia VARCHAR(50),

	id_tutor INT NOT NULL,
	CONSTRAINT FK_id_tutor
	FOREIGN KEY (id_tutor) 
	REFERENCES Tutor (id_tutor)
);


CREATE TABLE FICHA_SAUDE (
    id_pet                   INT PRIMARY KEY,
    alergias                 VARCHAR(200),
    observacoes_veterinario  VARCHAR(500),
    FOREIGN KEY (id_pet) REFERENCES Pet(id_pet)
);


CREATE TABLE SERVICO (
    id_servico    INT IDENTITY(1,1) PRIMARY KEY,
    nome          VARCHAR(60) NOT NULL,
    preco_tabela  DECIMAL(8,2) NOT NULL
);

CREATE TABLE Atendimento(

id_atendimento INT PRIMARY KEY IDENTITY(1,1),
data DATE,

id_pet INT NOT NULL,
FOREIGN KEY (id_pet)
REFERENCES Pet(id_pet) 
);

CREATE TABLE Atendimento_Servico (

	id_atendimento  INT NOT NULL,
    id_servico      INT NOT NULL,
    valor_cobrado   DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (id_atendimento, id_servico),
    FOREIGN KEY (id_atendimento) REFERENCES Atendimento(id_atendimento),
    FOREIGN KEY (id_servico)     REFERENCES Servico(id_servico)
);
	







