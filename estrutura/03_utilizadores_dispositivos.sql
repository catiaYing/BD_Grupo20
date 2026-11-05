-- Selecionar o schema pessoal para os testes
SET search_path TO luisa_schema;

-- =====================================================
-- BD Projeto E2 - Grupo 20
-- Modulo 03: Utilizadores e Dispositivos
-- =====================================================

-- TABELA 1: Utilizador
-- Guarda as informacoes pessoais dos utilizadores.

CREATE TABLE Utilizador (
    email VARCHAR(255) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    grupo_sanguineo VARCHAR(5),
    contacto_emergencia VARCHAR(20),

    CONSTRAINT pk_utilizador
        PRIMARY KEY (email)
);


-- TABELA 2: UtilizadorAlergia
-- Guarda as alergias associadas a cada utilizador.
-- Um utilizador pode ter varias alergias.

CREATE TABLE UtilizadorAlergia (

    -- Email do utilizador a quem pertence a alergia.
    email_utilizador VARCHAR(255) NOT NULL,

    -- Nome da alergia.
    alergia VARCHAR(100) NOT NULL,

    -- Chave primaria composta:
    -- Impede que a mesma alergia seja repetida
    -- para o mesmo utilizador.
    CONSTRAINT pk_utilizador_alergia
        PRIMARY KEY (email_utilizador, alergia),

    -- Chave estrangeira:
    -- Garante que o utilizador existe.
    CONSTRAINT fk_alergia_utilizador
        FOREIGN KEY (email_utilizador)
        REFERENCES Utilizador(email)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =====================================================
-- TABELA 3: Dispositivo
-- Guarda os dispositivos BANDy dos utilizadores.
-- =====================================================

CREATE TABLE Dispositivo (

    -- Numero de serie unico de cada dispositivo.
    numero_serie VARCHAR(50) NOT NULL,

    -- Saldo disponivel no dispositivo.
    saldo NUMERIC(10, 2) NOT NULL,

    -- Estado atual: ativo, bloqueado ou extraviado.
    estado VARCHAR(20) NOT NULL,

    -- Utilizador ao qual o dispositivo pertence.
    email_utilizador VARCHAR(255) NOT NULL,

    -- Chave primaria.
    CONSTRAINT pk_dispositivo
        PRIMARY KEY (numero_serie),

    -- Chave estrangeira: associacao ao utilizador.
    CONSTRAINT fk_dispositivo_utilizador
        FOREIGN KEY (email_utilizador)
        REFERENCES Utilizador(email)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    -- RIA-7: O saldo nao pode ser negativo.
    CONSTRAINT ck_dispositivo_saldo
        CHECK (saldo >= 0),

    -- RIA-7: Apenas tres estados sao permitidos.
    CONSTRAINT ck_dispositivo_estado
        CHECK (estado IN (
            'ativo',
            'bloqueado',
            'extraviado'
        ))
);


-- =====================================================
-- TABELA 4: Segue
-- Representa a relacao de seguimento entre utilizadores.
-- =====================================================

CREATE TABLE Segue (

    -- Utilizador que segue outra pessoa.
    email_seguidor VARCHAR(255) NOT NULL,

    -- Utilizador que e seguido.
    email_seguido VARCHAR(255) NOT NULL,

    -- Chave primaria composta:
    -- impede que o mesmo utilizador siga
    -- a mesma pessoa mais do que uma vez.
    CONSTRAINT pk_segue
        PRIMARY KEY (email_seguidor, email_seguido),

    -- O seguidor tem de existir na tabela Utilizador.
    CONSTRAINT fk_segue_seguidor
        FOREIGN KEY (email_seguidor)
        REFERENCES Utilizador(email)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    -- O utilizador seguido tambem tem de existir.
    CONSTRAINT fk_segue_seguido
        FOREIGN KEY (email_seguido)
        REFERENCES Utilizador(email)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    -- RIA-11: Um utilizador nao pode seguir-se a si proprio.
    CONSTRAINT ck_segue_diferentes
        CHECK (email_seguidor <> email_seguido)
);
