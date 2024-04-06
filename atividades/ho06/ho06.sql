CREATE SCHEMA SAM;

CREATE TABLE SAM.AREA (
    Sigla CHAR(5) NOT NULL,
    Nome VARCHAR(45) NOT NULL,
    Area CHAR(5),
    PRIMARY KEY (Sigla),
    UNIQUE (Nome) 
);

ALTER TABLE SAM.AREA 
ADD FOREIGN KEY (Area) 
REFERENCES SAM.AREA (Sigla)
ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE SAM.CURSO (
    Sigla CHAR(5) NOT NULL,
    Nome VARCHAR(45) NOT NULL,
    Custo DOUBLE PRECISION NOT NULL,
    Horas INTEGER DEFAULT 0,
    Area CHAR(5) NOT NULL,
    PRIMARY KEY (Sigla),
    UNIQUE (Nome),
    FOREIGN KEY (Area)
    REFERENCES SAM.AREA (Sigla)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SAM.PROFESSOR (
    Curso CHAR(5) NOT NULL,
    CPF CHAR(11) NOT NULL,
    Nome VARCHAR(45) NOT NULL,
    PRIMARY KEY (Curso, CPF),
    FOREIGN KEY (Curso)
    REFERENCES SAM.CURSO (Sigla)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SAM.ALUNO (
    CPF CHAR(11) NOT NULL,
    Nome VARCHAR(45) NOT NULL,
    Sobrenome VARCHAR(45) NOT NULL,
    Sexo CHAR NOT NULL CHECK(Sexo = 'F' OR Sexo = 'M'),
    DataNasc DATE NOT NULL,
    PRIMARY KEY (CPF)
);

CREATE TABLE SAM.MATRICULA (
    Curso CHAR(5) NOT NULL,
    Aluno CHAR(11) NOT NULL,
    Data  DATE NOT NULL,
    PagamentoStatus BOOLEAN NOT NULL,
    PRIMARY KEY (Curso, Aluno),
    FOREIGN KEY (Curso)
    REFERENCES SAM.CURSO (Sigla)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Aluno)
    REFERENCES SAM.ALUNO (CPF)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SAM.MODULO (
    Sigla CHAR(5) NOT NULL,
    Nome VARCHAR(45) NOT NULL,
    Curso CHAR(5) NOT NULL,
    PRIMARY KEY (Sigla),
    UNIQUE (Nome),
    FOREIGN KEY (Curso)
    REFERENCES SAM.CURSO (Sigla)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SAM.TOPICO (
    Modulo CHAR(5) NOT NULL,
    Sigla CHAR(5) NOT NULL,
    Nome VARCHAR(45) NOT NULL,
    Horas INTEGER NOT NULL,
    PRIMARY KEY (Modulo, Sigla),
    UNIQUE (Nome),
    FOREIGN KEY (Modulo)
    REFERENCES SAM.MODULO (Sigla)
    ON DELETE CASCADE ON UPDATE CASCADE
);