
-- ==================================================
-- 01 - DADOS DOS FESTIVAIS
-- ==================================================


-- 1. Festival

INSERT INTO Festival (nome, ano_criacao)
VALUES
    ('NOS Alive', 2007),
    ('Rock in Rio', 1985),
    ('Primavera Sound', 2001);


-- 2. Recinto

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
        'Passeio Maritimo de Alges',
        'Alges',
        'Passeio Maritimo de Alges',
        '1495-718',
        'Alges',
        'Oeiras',
        55000
    ),
    (
        'Parque Tejo',
        'Parque Tejo',
        'Parque Tejo',
        '1990-231',
        'Lisboa',
        'Lisboa',
        80000
    ),
    (
        'Parque da Cidade',
        'Parque da Cidade',
        'Estrada Interior da Circunvalacao',
        '4100-083',
        'Porto',
        'Porto',
        50000
    );


-- 3. Edicao

INSERT INTO Edicao (
    nome_festival,
    ano,
    preco_passe,
    nome_recinto
)
VALUES
    ('NOS Alive', 2026, 180.00, 'Passeio Maritimo de Alges'),
    ('Rock in Rio', 2026, 150.00, 'Parque Tejo'),
    ('Primavera Sound', 2026, 120.00, 'Parque da Cidade');


-- 4. Dia

INSERT INTO Dia (
    nome_festival,
    ano_edicao,
    data,
    preco_diario
)
VALUES
    ('NOS Alive', 2026, '2026-07-09', 75.00),
    ('NOS Alive', 2026, '2026-07-10', 75.00),
    ('NOS Alive', 2026, '2026-07-11', 75.00),

    ('Rock in Rio', 2026, '2026-06-20', 80.00),
    ('Rock in Rio', 2026, '2026-06-21', 80.00),
    ('Rock in Rio', 2026, '2026-06-27', 80.00),

    ('Primavera Sound', 2026, '2026-06-11', 60.00),
    ('Primavera Sound', 2026, '2026-06-12', 60.00),
    ('Primavera Sound', 2026, '2026-06-13', 60.00);
