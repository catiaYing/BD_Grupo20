
-- ==================================================
-- 01 - DADOS DOS FESTIVAIS
-- Projeto E2 - Bases de Dados 2026/2027
-- ==================================================

SET search_path TO yifei_schema;


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
