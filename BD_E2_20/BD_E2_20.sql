-- =====================================================
-- BD Projeto E2 - Grupo 20
-- Criacao e Populacao da Base de Dados
-- =====================================================

-- Remocao das tabelas existentes

DROP TABLE IF EXISTS
    BilheteDiario,
    PasseGeral,
    Bilhete,
    Segue,
    Dispositivo,
    UtilizadorAlergia,
    Utilizador,
    Concerto,
    Artista,
    Dia,
    Edicao,
    Recinto,
    Festival
CASCADE;


-- 1. Tabela Festival

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


-- =====================================================
-- BD Projeto E2 - Grupo 20
-- Modulo 03: Utilizadores e Dispositivos
-- =====================================================

-- TABELA 1: Utilizador
-- Informacoes pessoais dos utilizadores.

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
-- Atributo multivalorado: um utilizador pode ter varias alergias.

CREATE TABLE UtilizadorAlergia (
    email_utilizador VARCHAR(255) NOT NULL,
    alergia VARCHAR(100) NOT NULL,

    CONSTRAINT pk_utilizador_alergia
        PRIMARY KEY (email_utilizador, alergia),

    CONSTRAINT fk_alergia_utilizador
        FOREIGN KEY (email_utilizador)
        REFERENCES Utilizador(email)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- TABELA 3: Dispositivo
-- Dispositivos associados aos utilizadores.

CREATE TABLE Dispositivo (
    numero_serie VARCHAR(50) NOT NULL,
    saldo NUMERIC(10, 2) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    email_utilizador VARCHAR(255) NOT NULL,

    CONSTRAINT pk_dispositivo
        PRIMARY KEY (numero_serie),

    CONSTRAINT fk_dispositivo_utilizador
        FOREIGN KEY (email_utilizador)
        REFERENCES Utilizador(email)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    -- RIA-7: O saldo deve ser maior ou igual a zero.
    CONSTRAINT ck_dispositivo_saldo
        CHECK (saldo >= 0),

    -- RIA-7: Estados permitidos.
    CONSTRAINT ck_dispositivo_estado
        CHECK (estado IN ('ativo', 'bloqueado', 'extraviado'))
);


-- TABELA 4: Segue
-- Relacao de seguimento entre utilizadores.

CREATE TABLE Segue (
    email_seguidor VARCHAR(255) NOT NULL,
    email_seguido VARCHAR(255) NOT NULL,

    CONSTRAINT pk_segue
        PRIMARY KEY (email_seguidor, email_seguido),

    CONSTRAINT fk_segue_seguidor
        FOREIGN KEY (email_seguidor)
        REFERENCES Utilizador(email)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_segue_seguido
        FOREIGN KEY (email_seguido)
        REFERENCES Utilizador(email)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    -- RIA-11: Um utilizador nao pode seguir-se a si proprio.
    CONSTRAINT ck_segue_diferentes
        CHECK (email_seguidor <> email_seguido)
);



-- =====================================================
-- BD Projeto E2 - Grupo 20
-- Modulo 04: Bilhetes
-- =====================================================

-- TABELA 1: Bilhete
-- Informacoes gerais dos bilhetes comprados.

CREATE TABLE Bilhete (
    id_bilhete SERIAL,
    data_compra DATE NOT NULL,
    preco_pago NUMERIC(10, 2) NOT NULL,
    comprador VARCHAR(255) NOT NULL,
    numero_serie VARCHAR(50),

    CONSTRAINT pk_bilhete
        PRIMARY KEY (id_bilhete),

    CONSTRAINT fk_bilhete_comprador
        FOREIGN KEY (comprador)
        REFERENCES Utilizador(email)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_bilhete_dispositivo
        FOREIGN KEY (numero_serie)
        REFERENCES Dispositivo(numero_serie)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    -- Restricao adicional: preco pago positivo.
    CONSTRAINT ck_bilhete_preco_positivo
        CHECK (preco_pago > 0)
);


-- TABELA 2: PasseGeral
-- Passe que permite acesso a todos os dias de uma edicao.

CREATE TABLE PasseGeral (
    id_bilhete INTEGER,
    nome_festival VARCHAR(100) NOT NULL,
    ano_edicao INTEGER NOT NULL,

    CONSTRAINT pk_passe_geral
        PRIMARY KEY (id_bilhete),

    CONSTRAINT fk_passe_geral_bilhete
        FOREIGN KEY (id_bilhete)
        REFERENCES Bilhete(id_bilhete)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_passe_geral_edicao
        FOREIGN KEY (nome_festival, ano_edicao)
        REFERENCES Edicao(nome_festival, ano)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


-- TABELA 3: BilheteDiario
-- Bilhete que permite acesso a um dia especifico.

CREATE TABLE BilheteDiario (
    id_bilhete INTEGER,
    nome_festival VARCHAR(100) NOT NULL,
    ano_edicao INTEGER NOT NULL,
    data_dia DATE NOT NULL,

    CONSTRAINT pk_bilhete_diario
        PRIMARY KEY (id_bilhete),

    CONSTRAINT fk_bilhete_diario_bilhete
        FOREIGN KEY (id_bilhete)
        REFERENCES Bilhete(id_bilhete)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_bilhete_diario_dia
        FOREIGN KEY (nome_festival, ano_edicao, data_dia)
        REFERENCES Dia(nome_festival, ano_edicao, data)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);



-- 01 - DADOS DOS FESTIVAIS
-- Projeto E2 - Bases de Dados 2026/2027
-- ==================================================



-- ==================================================
-- 1. Festival
-- ==================================================

INSERT INTO Festival (nome, ano_criacao) 
VALUES
    ('Sons do Tejo', 2014),
    ('Luz do Atlantico', 2018), 
    ('Ritmos da Serra', 2022);


-- ==================================================
-- 2. Recinto
-- ==================================================

INSERT INTO Recinto (
    nome,
    morada,
    rua,
    codigo_postal,
    localidade,
    cidade,
    capacidade_max
)
VALUES
    (
        'Parque Ribeirinho',
        'Zona Ribeirinha',
        'Avenida do Rio',
        '2670-421',
        'Loures',
        'Loures',
        18000
    ),
    (
        'Quinta das Fontes',
        'Zona Verde',
        'Rua das Fontes',
        '2780-215',
        'Oeiras',
        'Oeiras',
        25000
    ),
    (
        'Parque da Serra',
        'Zona da Serra',
        'Estrada da Serra',
        '3000-125',
        'Coimbra',
        'Coimbra',
        12000
    );


-- ==================================================
-- 3. Edicao
-- ==================================================

INSERT INTO Edicao (
    nome_festival,
    ano,
    preco_passe,
    nome_recinto
)
VALUES
    ('Sons do Tejo', 2026, 98.00, 'Quinta das Fontes'),
    ('Sons do Tejo', 2027, 105.00, 'Parque Ribeirinho'),
    ('Luz do Atlantico', 2027, 138.00, 'Quinta das Fontes'),
    ('Ritmos da Serra', 2027, 89.00, 'Parque da Serra');

-- ==================================================
-- 4. Dia
-- ==================================================

INSERT INTO Dia (
    nome_festival,
    ano_edicao,
    data, 
    preco_diario
)
VALUES

    -- Sons do Tejo - Edicao 2026
    ('Sons do Tejo', 2026, '2026-06-19', 36.00),
    ('Sons do Tejo', 2026, '2026-06-20', 40.00),
    ('Sons do Tejo', 2026, '2026-06-21', 43.00),

    -- Sons do Tejo - Edicao 2027
    ('Sons do Tejo', 2027, '2027-06-18', 39.00),
    ('Sons do Tejo', 2027, '2027-06-19', 42.00),
    ('Sons do Tejo', 2027, '2027-06-20', 45.00),

    -- Luz do Atlantico - Edicao 2027
    ('Luz do Atlantico', 2027, '2027-07-02', 48.00),
    ('Luz do Atlantico', 2027, '2027-07-03', 52.00),
    ('Luz do Atlantico', 2027, '2027-07-04', 55.00),

    -- Ritmos da Serra - Edicao 2027
    ('Ritmos da Serra', 2027, '2027-08-06', 32.00),
    ('Ritmos da Serra', 2027, '2027-08-07', 35.00),
    ('Ritmos da Serra', 2027, '2027-08-08', 38.00);


-- =====================================================
-- BD Projeto E2 - Grupo 20
-- Modulo 02: Populacao de Dados
-- Artistas e Concertos
-- =====================================================

-- TABELA 1: Artista

INSERT INTO Artista (nome, genero_musical, tipo)
VALUES
    ('Ana Moura', 'Fado', 'artista'),
    ('The Weeknd', 'Pop', 'artista'),
    ('Coldplay', 'Rock', 'grupo'),
    ('Dua Lipa', 'Pop', 'artista'),
    ('Ed Sheeran', 'Pop', 'artista'),
    ('Imagine Dragons', 'Rock', 'grupo'),
    ('Billie Eilish', 'Pop', 'artista'),
    ('Calema', 'Pop', 'grupo'),
    ('Mariza', 'Fado', 'artista'),
    ('Xutos & Pontapes', 'Rock', 'grupo'),
    ('Carolina Deslandes', 'Pop', 'artista'),
    ('Burna Boy', 'Afrobeats', 'artista');


-- TABELA 2: Concerto
-- Quatro concertos por dia, com horarios distintos.

INSERT INTO Concerto (
    id_concerto,
    hora_inicio,
    hora_fim,
    nome_festival,
    ano_edicao,
    data,
    nome_artista
)
VALUES

    -- Sons do Tejo - 19/06/2026
    (1, '16:00', '17:00', 'Sons do Tejo', 2026, '2026-06-19', 'Ana Moura'),
    (2, '17:30', '18:30', 'Sons do Tejo', 2026, '2026-06-19', 'Calema'),
    (3, '19:00', '20:00', 'Sons do Tejo', 2026, '2026-06-19', 'Dua Lipa'),
    (4, '21:00', '23:00', 'Sons do Tejo', 2026, '2026-06-19', 'Coldplay'),

    -- Sons do Tejo - 20/06/2026
    (5, '16:00', '17:00', 'Sons do Tejo', 2026, '2026-06-20', 'Mariza'),
    (6, '17:30', '18:30', 'Sons do Tejo', 2026, '2026-06-20', 'Ed Sheeran'),
    (7, '19:00', '20:00', 'Sons do Tejo', 2026, '2026-06-20', 'Burna Boy'),
    (8, '21:00', '23:00', 'Sons do Tejo', 2026, '2026-06-20', 'The Weeknd'),

    -- Sons do Tejo - 21/06/2026
    (9, '16:00', '17:00', 'Sons do Tejo', 2026, '2026-06-21', 'Carolina Deslandes'),
    (10, '17:30', '18:30', 'Sons do Tejo', 2026, '2026-06-21', 'Xutos & Pontapes'),
    (11, '19:00', '20:00', 'Sons do Tejo', 2026, '2026-06-21', 'Billie Eilish'),
    (12, '21:00', '23:00', 'Sons do Tejo', 2026, '2026-06-21', 'Imagine Dragons'),

    -- Sons do Tejo - 18/06/2027
    (13, '16:00', '17:00', 'Sons do Tejo', 2027, '2027-06-18', 'Dua Lipa'),
    (14, '17:30', '18:30', 'Sons do Tejo', 2027, '2027-06-18', 'Calema'),
    (15, '19:00', '20:00', 'Sons do Tejo', 2027, '2027-06-18', 'The Weeknd'),
    (16, '21:00', '23:00', 'Sons do Tejo', 2027, '2027-06-18', 'Coldplay'),

    -- Sons do Tejo - 19/06/2027
    (17, '16:00', '17:00', 'Sons do Tejo', 2027, '2027-06-19', 'Ana Moura'),
    (18, '17:30', '18:30', 'Sons do Tejo', 2027, '2027-06-19', 'Burna Boy'),
    (19, '19:00', '20:00', 'Sons do Tejo', 2027, '2027-06-19', 'Ed Sheeran'),
    (20, '21:00', '23:00', 'Sons do Tejo', 2027, '2027-06-19', 'Imagine Dragons'),

    -- Sons do Tejo - 20/06/2027
    (21, '16:00', '17:00', 'Sons do Tejo', 2027, '2027-06-20', 'Mariza'),
    (22, '17:30', '18:30', 'Sons do Tejo', 2027, '2027-06-20', 'Carolina Deslandes'),
    (23, '19:00', '20:00', 'Sons do Tejo', 2027, '2027-06-20', 'Billie Eilish'),
    (24, '21:00', '23:00', 'Sons do Tejo', 2027, '2027-06-20', 'Xutos & Pontapes'),

    -- Luz do Atlantico - 02/07/20INSERT INTO Festival27
    (25, '16:00', '17:00', 'Luz do Atlantico', 2027, '2027-07-02', 'The Weeknd'),
    (26, '17:30', '18:30', 'Luz do Atlantico', 2027, '2027-07-02', 'Ana Moura'),
    (27, '19:00', '20:00', 'Luz do Atlantico', 2027, '2027-07-02', 'Imagine Dragons'),
    (28, '21:00', '23:00', 'Luz do Atlantico', 2027, '2027-07-02', 'Dua Lipa'),

    -- Luz do Atlantico - 03/07/2027
    (29, '16:00', '17:00', 'Luz do Atlantico', 2027, '2027-07-03', 'Calema'),
    (30, '17:30', '18:30', 'Luz do Atlantico', 2027, '2027-07-03', 'Mariza'),
    (31, '19:00', '20:00', 'Luz do Atlantico', 2027, '2027-07-03', 'Burna Boy'),
    (32, '21:00', '23:00', 'Luz do Atlantico', 2027, '2027-07-03', 'Coldplay'),

    -- Luz do Atlantico - 04/07/2027
    (33, '16:00', '17:00', 'Luz do Atlantico', 2027, '2027-07-04', 'Ed Sheeran'),
    (34, '17:30', '18:30', 'Luz do Atlantico', 2027, '2027-07-04', 'Carolina Deslandes'),
    (35, '19:00', '20:00', 'Luz do Atlantico', 2027, '2027-07-04', 'Billie Eilish'),
    (36, '21:00', '23:00', 'Luz do Atlantico', 2027, '2027-07-04', 'Xutos & Pontapes');



-- =====================================================
-- BD Projeto E2 - Grupo 20
-- Modulo 03: Populacao de Dados
-- Utilizadores e Dispositivos
-- =====================================================

-- TABELA 1: Utilizador
-- Quatro utilizadores com dados pessoais distintos.

INSERT INTO Utilizador
    (email, nome, data_nascimento, grupo_sanguineo, contacto_emergencia)
VALUES
    ('ana@example.com', 'Ana Silva', '2002-05-14', 'A+', '912345678'),
    ('joao@example.com', 'Joao Costa', '2001-09-20', 'O+', '923456789'),
    ('maria@example.com', 'Maria Santos', '2003-02-08', 'B+', '934567890'),
    ('pedro@example.com', 'Pedro Almeida', '2000-11-30', 'AB+', '945678901');


-- TABELA 2: UtilizadorAlergia
-- Exemplo de atributo multivalorado:
-- um utilizador pode ter varias alergias.

INSERT INTO UtilizadorAlergia
    (email_utilizador, alergia)
VALUES
    ('ana@example.com', 'Polen'),
    ('ana@example.com', 'Amendoim'),
    ('joao@example.com', 'Marisco'),
    ('maria@example.com', 'Lactose');


-- TABELA 3: Dispositivo
-- Casos limite: dispositivos extraviados ou bloqueados
-- e respetivos utilizadores com um novo dispositivo ativo.
-- Inclui ainda um utilizador sem dispositivo ativo.

INSERT INTO Dispositivo
    (numero_serie, saldo, estado, email_utilizador)
VALUES
    ('BANDY001', 25.50, 'ativo', 'ana@example.com'),
    ('BANDY002', 0.00, 'extraviado', 'ana@example.com'),
    ('BANDY003', 10.00, 'bloqueado', 'joao@example.com'),
    ('BANDY004', 15.00, 'ativo', 'joao@example.com'),
    ('BANDY005', 30.00, 'ativo', 'maria@example.com'),
    ('BANDY006', 0.00, 'bloqueado', 'pedro@example.com');


-- TABELA 4: Segue
-- Casos de seguimento reciproco e nao reciproco.
-- Ana segue Joao, mas Joao nao segue Ana.
-- Joao e Maria seguem-se mutuamente.

INSERT INTO Segue
    (email_seguidor, email_seguido)
VALUES
    ('ana@example.com', 'joao@example.com'),
    ('ana@example.com', 'maria@example.com'),
    ('joao@example.com', 'maria@example.com'),
    ('maria@example.com', 'joao@example.com'),
    ('pedro@example.com', 'ana@example.com');


-- =====================================================
-- BD Projeto E2 - Grupo 20
-- Modulo 04: Populacao de Dados
-- Bilhetes
-- =====================================================

-- TABELA 1: Bilhete
-- Compras com e sem dispositivos associados.

INSERT INTO Bilhete (
    data_compra,
    preco_pago,
    comprador,
    numero_serie
)
VALUES
    ('2026-03-10', 98.00, 'ana@example.com', 'BANDY001'),
    ('2026-04-15', 36.00, 'joao@example.com', NULL),
    ('2026-05-01', 48.00, 'maria@example.com', 'BANDY005'),
    ('2026-05-20', 105.00, 'pedro@example.com', NULL),
    ('2027-01-15', 138.00, 'ana@example.com', NULL),
    ('2027-02-01', 32.00, 'pedro@example.com', NULL);


-- TABELA 2: PasseGeral
-- Passes gerais para diferentes edicoes.

INSERT INTO PasseGeral (
    id_bilhete,
    nome_festival,
    ano_edicao
)
VALUES
    (1, 'Sons do Tejo', 2026),
    (4, 'Sons do Tejo', 2027),
    (5, 'Luz do Atlantico', 2027);


-- TABELA 3: BilheteDiario
-- Bilhetes diarios para diferentes festivais.

INSERT INTO BilheteDiario (
    id_bilhete,
    nome_festival,
    ano_edicao,
    data_dia
)
VALUES
    (2, 'Sons do Tejo', 2026, '2026-06-19'),
    (3, 'Luz do Atlantico', 2027, '2027-07-02'),
    (6, 'Ritmos da Serra', 2027, '2027-08-06');


-- RIA-2: hora_inicio deve ser anterior a hora_fim
-- Resultado esperado: ERRO

INSERT INTO Concerto (
    id_concerto,
    hora_inicio,
    hora_fim,
    nome_festival,
    ano_edicao,
    data,
    nome_artista
)
VALUES (
    100,
    '22:00',
    '20:00',
    'tianzi',
    2026,
    '2026-07-09',
    'Ana Moura'
);


-- RIA-3: tipo deve ser 'artista' ou 'grupo'
-- Resultado esperado: ERRO

INSERT INTO Artista (nome, genero_musical, tipo)
VALUES (
    'Artista Teste',
    'Pop',
    'banda'
);