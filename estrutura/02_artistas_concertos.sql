
CREATE TABLE Artista (
    nome VARCHAR(100) NOT NULL,
    genero_musical VARCHAR(100),
    tipo VARCHAR(20) NOT NULL,

    CONSTRAINT pk_artista
        PRIMARY KEY (nome),

    CONSTRAINT ck_artista_tipo
        CHECK (tipo IN ('artista', 'grupo'))
);


-- =========================================
-- 2. Tabela Concerto
-- RIA-2: A hora de início deve ser anterior
-- à hora de fim
-- =========================================

CREATE TABLE Concerto (
    id_concerto INTEGER NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,

    nome_festival VARCHAR(100) NOT NULL,
    ano_edicao INTEGER NOT NULL,
    data DATE NOT NULL,

    nome_artista VARCHAR(100) NOT NULL,

    CONSTRAINT pk_concerto
        PRIMARY KEY (id_concerto),

    CONSTRAINT fk_concerto_dia
        FOREIGN KEY (nome_festival, ano_edicao, data)
        REFERENCES Dia (nome_festival, ano_edicao, data)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_concerto_artista
        FOREIGN KEY (nome_artista)
        REFERENCES Artista (nome)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT ck_concerto_horas
        CHECK (hora_inicio < hora_fim)
);