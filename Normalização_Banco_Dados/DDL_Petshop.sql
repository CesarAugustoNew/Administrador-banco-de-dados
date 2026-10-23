CREATE DATABASE Petshop;
GO
USE Petshop;
GO

CREATE TABLE Tutor (
    id_tutor        INT IDENTITY(1,1) NOT NULL,
    nome_tutor      VARCHAR(100) NOT NULL,
    telefone_tutor  VARCHAR(20),
    bairro_tutor    VARCHAR(100),
    CONSTRAINT PK_Tutor PRIMARY KEY (id_tutor)
);

CREATE TABLE Pet (
    id_pet    INT IDENTITY(1,1) NOT NULL,
    nome_pet  VARCHAR(100) NOT NULL,
    especie   VARCHAR(50)  NOT NULL,
    raca      VARCHAR(50)  NOT NULL,
    id_tutor  INT NOT NULL,
    CONSTRAINT PK_Pet PRIMARY KEY (id_pet),
    CONSTRAINT FK_Pet_Tutor FOREIGN KEY (id_tutor) REFERENCES Tutor(id_tutor)
);

CREATE TABLE Ficha_Saude (
    id_pet                   INT NOT NULL,
    alergias                 VARCHAR(200),
    observacoes_veterinario  VARCHAR(500),
    CONSTRAINT PK_Ficha_Saude PRIMARY KEY (id_pet),
    CONSTRAINT FK_Ficha_Saude_Pet FOREIGN KEY (id_pet) REFERENCES Pet(id_pet)
);

CREATE TABLE Servico (
    id_servico    INT IDENTITY(1,1) NOT NULL,
    nome          VARCHAR(60)  NOT NULL,
    preco_tabela  DECIMAL(8,2) NOT NULL,
    CONSTRAINT PK_Servico PRIMARY KEY (id_servico)
);

CREATE TABLE Atendimento (
    id_atendimento  INT IDENTITY(1,1) NOT NULL,
    data            DATE NOT NULL,
    id_pet          INT  NOT NULL,
    CONSTRAINT PK_Atendimento PRIMARY KEY (id_atendimento),
    CONSTRAINT FK_Atendimento_Pet FOREIGN KEY (id_pet) REFERENCES Pet(id_pet)
);

CREATE TABLE Atendimento_Servico (
    id_atendimento  INT NOT NULL,
    id_servico      INT NOT NULL,
    valor_cobrado   DECIMAL(8,2) NOT NULL,
    CONSTRAINT PK_Atendimento_Servico PRIMARY KEY (id_atendimento, id_servico),
    CONSTRAINT FK_AtendServ_Atendimento FOREIGN KEY (id_atendimento) REFERENCES Atendimento(id_atendimento),
    CONSTRAINT FK_AtendServ_Servico FOREIGN KEY (id_servico) REFERENCES Servico(id_servico)
);