-- 1. Tabela Festival
-- Selecionar o schema correto
SET search_path TO yifei_schema;
CREATE TABLE Festival (
    nome VARCHAR(100) NOT NULL,
    ano_criacao INTEGER NOT NULL,

    CONSTRAINT pk_festival
        PRIMARY KEY (nome)
);


-- 2. Tabela Recinto

CREATE TABLE Recinto (
    nome VARCHAR(100) NOT NULL,
    morada VARCHAR(150),
    rua VARCHAR(100),
    codigo_postal VARCHAR(10),
    localidade VARCHAR(100),
    cidade VARCHAR(100),
    capacidade_max INTEGER NOT NULL,

    CONSTRAINT pk_recinto
        PRIMARY KEY (nome),

    -- RIA-12
    CONSTRAINT ck_recinto_capacidade
        CHECK (capacidade_max > 0)
);


-- 3. Tabela Edicao

CREATE TABLE Edicao (
    nome_festival VARCHAR(100) NOT NULL,
    ano INTEGER NOT NULL,
    preco_passe NUMERIC(10,2) NOT NULL,
    nome_recinto VARCHAR(100) NOT NULL,

    CONSTRAINT pk_edicao
        PRIMARY KEY (nome_festival, ano),

    CONSTRAINT fk_edicao_festival
        FOREIGN KEY (nome_festival)
        REFERENCES Festival (nome)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_edicao_recinto
        FOREIGN KEY (nome_recinto)
        REFERENCES Recinto (nome)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    -- RIA-12
    CONSTRAINT ck_edicao_preco
        CHECK (preco_passe > 0)
);


-- 4. Tabela Dia

CREATE TABLE Dia (
    nome_festival VARCHAR(100) NOT NULL,
    ano_edicao INTEGER NOT NULL,
    data DATE NOT NULL,
    preco_diario NUMERIC(10,2) NOT NULL,

    CONSTRAINT pk_dia
        PRIMARY KEY (nome_festival, ano_edicao, data),

    CONSTRAINT fk_dia_edicao
        FOREIGN KEY (nome_festival, ano_edicao)
        REFERENCES Edicao (nome_festival, ano)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    -- RIA-12
    CONSTRAINT ck_dia_preco
        CHECK (preco_diario > 0)
);