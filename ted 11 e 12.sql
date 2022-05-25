--criando o banco de dados 
Create Database bdi221;
go

-- Definri qual banco de dados vamos usar 
use bdi221
go

--Criando tabela prontuário
create table prontuario(
	id int identity(1,1),
	discricao varchar(50),
	temperatura decimal(4,1),
	peso decimal(3,2)
); 
go

alter table prontuario
add constraint pk_prontuario primary key(id);

--Tabela Produtos
DROP TABLE DBO.PRODUTOS;
GO

CREATE TABLE PRODUTOS(
	ID INT IDENTITY(1,1) NOT NULL,
	NOME VARCHAR(50),
	DESCRICAO VARCHAR(255),
	TIPO CHAR(1),
	VALOR DECIMAL(5,2),
	CONSTRAINT PK_PRODUTOS PRIMARY KEY(ID)
);
GO

--TABELA FORMA DE PAGAMENTO
DROP TABLE FORMA_PAGAMENTO;
GO

CREATE TABLE FORMA_PAGAMENTO(
	ID INT IDENTITY(1,1) NOT NULL,
	DESCRICAO  VARCHAR(50) NOT NULL,
	CONSTRAINT PK_FORMA_PAGAMENTO PRIMARY KEY(ID)
);
GO

--TABELA FUNCIONARIO
DROP TABLE FUNCIONARIO;
GO

CREATE TABLE FUNCIONARIO(
	ID INT IDENTITY(1,1) NOT NULL,
	NOME VARCHAR(255) NOT NULL,
	CPF VARCHAR(11) NOT NULL,
	SALARIO DECIMAL(6,2) NOT NULL,
	--CDD ENDERECO
	TIPO CHAR(1) NULL,
	N_CONSELHO INT NULL,
	ESPECIALIDADE VARCHAR(20) NULL,
	COMISSAO DECIMAL(4,2),
	CONSTRAINT PK_FUNCIONARIO PRIMARY KEY(ID)
);
GO

SELECT * FROM FUNCIONARIO;

ALTER TABLE FUNCIONARIO
ADD ID_ENDERECO INT;
GO

ALTER TABLE FUNCIONARIO
ADD CONSTRAINT FK_FUNCIONARIO_ENDERECO FOREIGN KEY(ID_ENDERECO)
REFERENCES DBO.ENDERECO(ID);
GO

--TABELA CLIENTE
DROP TABLE CLIENTE;
GO

CREATE TABLE CLIENTE(
	ID INT IDENTITY(1,1) NOT NULL,
	NOME VARCHAR(255) NOT NULL,
	--COD_ENDERECO
	--TELEFONE
	EMAIL VARCHAR(50) NOT NULL,
	CONSTRAINT PK_CLIENTE PRIMARY KEY(ID)
);
GO

SELECT * FROM CLIENTE;

ALTER TABLE CLIENTE
ADD ID_ENDERECO INT;
GO

ALTER TABLE CLIENTE
ADD TELEFONE_TELEFONE VARCHAR(50);
GO


ALTER TABLE CLIENTE
ADD CONSTRAINT FK_CLIENTE_ENDERECO FOREIGN KEY(ID_ENDERECO)
REFERENCES DBO.ENDERECO(ID);
GO

--Tabela pet
DROP TABLE PET;
GO

CREATE TABLE PET(
	ID INT IDENTITY(1,1),
	NOME VARCHAR(50),
	ESPECIE VARCHAR(50),
	PORTE VARCHAR(50),
	DT_NASC DATE,
	ID_PRONTUARIO INT NULL,
	CONSTRAINT PK_PET PRIMARY KEY(ID),
	CONSTRAINT FK_PET_PRONTUARIO FOREIGN KEY(ID_PRONTUARIO)
	REFERENCES DBO.PRONTUARIO(ID)
);
GO

SELECT * FROM PET;

--Tabela cliente-pet
DROP TABLE CLIENTE_PET;
GO

CREATE TABLE CLIENTE_PET(
	ID INT IDENTITY(1,1) NOT NULL,
	ID_PET INT NOT NULL,
	ID_CLIENTE INT NOT NULL,
	CONSTRAINT PK_CLIENTE_PET PRIMARY KEY(ID),
	CONSTRAINT FK_CLIENTE_PET_CLIENTE FOREIGN KEY (ID_CLIENTE)
	REFERENCES DBO.CLIENTE (ID),
	CONSTRAINT FK_CLIENTE_PET_PET FOREIGN KEY (ID_PET)
	REFERENCES DBO.PET (ID)
);
GO

--Tabela telefone
DROP TABLE TELEFONE;
GO

CREATE TABLE TELEFONE(
	ID INT IDENTITY(1,1) NOT NULL,
	ID_FUNCIONARIO INT NOT NULL,
	ID_CLIENTE INT NOT NULL,
	TELEFONE VARCHAR(50),
	CONSTRAINT PK_TELEFONE PRIMARY KEY(ID),
	CONSTRAINT FK_TELEFONE_FUNCIONARIO FOREIGN KEY (ID_FUNCIONARIO)
	REFERENCES DBO.FUNCIONARIO (ID),
	CONSTRAINT FK_TELEFONE_CLIENTE FOREIGN KEY (ID_CLIENTE)
	REFERENCES DBO.CLIENTE (ID)
);
GO

--Tabela venda
DROP TABLE VENDA;
GO

CREATE TABLE VENDA(
	ID INT IDENTITY(1,1) NOT NULL,
	ID_FORMA_PAGAMENTO INT NOT NULL,
	ID_CLIENTE INT NOT NULL,
	ID_FUNCIONARIO INT NOT NULL,
	CONSTRAINT PK_VENDA PRIMARY KEY(ID),
	CONSTRAINT FK_VENDA_FORMA_PAGAMENTO FOREIGN KEY (ID_FORMA_PAGAMENTO)
	REFERENCES DBO.FORMA_PAGAMENTO (ID),
	CONSTRAINT FK_VENDA_CLIENTE FOREIGN KEY (ID_CLIENTE)
	REFERENCES DBO.CLIENTE (ID),
	CONSTRAINT FK_VENDA_FUNCIONARIO FOREIGN KEY (ID_FUNCIONARIO)
	REFERENCES DBO.FUNCIONARIO (ID)
);
GO

--Tabela produtos-venda
DROP TABLE PRODUTOS_VENDA;
GO

CREATE TABLE PRODUTOS_VENDA(
	ID INT IDENTITY(1,1) NOT NULL,
	ID_PRODUTOS INT NOT NULL,
	ID_VENDA INT NOT NULL,
	CONSTRAINT PK_PRODUTOS_VENDA PRIMARY KEY(ID),
	CONSTRAINT FK_PRODUTOS_VENDA_PRODUTOS FOREIGN KEY(ID_PRODUTOS)
	REFERENCES DBO.PRODUTOS (ID),
	CONSTRAINT FK_PRODUTOS_VENDA_VENDA FOREIGN KEY(ID_VENDA)
	REFERENCES DBO.VENDA(ID)
);
GO

--Tabela residencia
DROP TABLE RESIDENCIA;
GO

CREATE TABLE RESIDENCIA(
	ID INT IDENTITY(1,1) NOT NULL,
	DESCRICAO VARCHAR(50),
	CONSTRAINT PK_RESIDENCIA PRIMARY KEY(ID)
);
GO

--Tabela endereço
DROP TABLE ENDERECO;
GO

CREATE TABLE ENDERECO(
	ID INT IDENTITY(1,1) NOT NULL,
	NUMERO INT,
	CEP INT,
	BAIRRO VARCHAR(50),
	CIDADE VARCHAR(50),
	ESTADO VARCHAR(50),
	PAIS VARCHAR(255),
	ID_TIPO_RESIDENCIA INT NOT NULL,
	COMPLEMENTO VARCHAR(255),
	CONSTRAINT PK_ENDERECO PRIMARY KEY(ID),
	CONSTRAINT FK_ENDERECO_RESIDENCIA FOREIGN KEY (ID_TIPO_RESIDENCIA)
	REFERENCES DBO.RESIDENCIA (ID),
);
GO
