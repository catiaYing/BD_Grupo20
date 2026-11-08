-- Dados da tabela Artista

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


-- Dados da tabela Concerto

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

-- Tianzi Festival - 09/07/2026
    (1, '16:00', '17:00', 'tianzi', 2026, '2026-07-09', 'Ana Moura'),
    (2, '17:30', '18:30', 'tianzi', 2026, '2026-07-09', 'Calema'),
    (3, '19:00', '20:00', 'tianzi', 2026, '2026-07-09', 'Dua Lipa'),
    (4, '21:00', '23:00', 'tianzi', 2026, '2026-07-09', 'Coldplay'),

-- Tianzi Festival - 10/07/2026
    (5, '16:00', '17:00', 'tianzi', 2026, '2026-07-10', 'Mariza'),
    (6, '17:30', '18:30', 'tianzi', 2026, '2026-07-10', 'Ed Sheeran'),
    (7, '19:00', '20:00', 'tianzi', 2026, '2026-07-10', 'Burna Boy'),
    (8, '21:00', '23:00', 'tianzi', 2026, '2026-07-10', 'The Weeknd'),

-- Tianzi Festival - 11/07/2026
    (9, '16:00', '17:00', 'tianzi', 2026, '2026-07-11', 'Carolina Deslandes'),
    (10, '17:30', '18:30', 'tianzi', 2026, '2026-07-11', 'Xutos & Pontapes'),
    (11, '19:00', '20:00', 'tianzi', 2026, '2026-07-11', 'Billie Eilish'),
    (12, '21:00', '23:00', 'tianzi', 2026, '2026-07-11', 'Imagine Dragons'),

-- Shanghai Festival - 20/06/2026
    (13, '16:00', '17:00', 'shanghai', 2026, '2026-06-20', 'Dua Lipa'),
    (14, '17:30', '18:30', 'shanghai', 2026, '2026-06-20', 'Calema'),
    (15, '19:00', '20:00', 'shanghai', 2026, '2026-06-20', 'The Weeknd'),
    (16, '21:00', '23:00', 'shanghai', 2026, '2026-06-20', 'Coldplay'),

-- Shanghai Festival - 21/06/2026
    (17, '16:00', '17:00', 'shanghai', 2026, '2026-06-21', 'Ana Moura'),
    (18, '17:30', '18:30', 'shanghai', 2026, '2026-06-21', 'Burna Boy'),
    (19, '19:00', '20:00', 'shanghai', 2026, '2026-06-21', 'Ed Sheeran'),
    (20, '21:00', '23:00', 'shanghai', 2026, '2026-06-21', 'Imagine Dragons'),

-- Shanghai Festival - 27/06/2026
    (21, '16:00', '17:00', 'shanghai', 2026, '2026-06-27', 'Mariza'),
    (22, '17:30', '18:30', 'shanghai', 2026, '2026-06-27', 'Carolina Deslandes'),
    (23, '19:00', '20:00', 'shanghai', 2026, '2026-06-27', 'Billie Eilish'),
    (24, '21:00', '23:00', 'shanghai', 2026, '2026-06-27', 'Xutos & Pontapes'),

-- Primavera Festival - 11/06/2026
    (25, '16:00', '17:00', 'Primavera', 2026, '2026-06-11', 'The Weeknd'),
    (26, '17:30', '18:30', 'Primavera', 2026, '2026-06-11', 'Ana Moura'),
    (27, '19:00', '20:00', 'Primavera', 2026, '2026-06-11', 'Imagine Dragons'),
    (28, '21:00', '23:00', 'Primavera', 2026, '2026-06-11', 'Dua Lipa'),

-- Primavera Festival - 12/06/2026
    (29, '16:00', '17:00', 'Primavera', 2026, '2026-06-12', 'Calema'),
    (30, '17:30', '18:30', 'Primavera', 2026, '2026-06-12', 'Mariza'),
    (31, '19:00', '20:00', 'Primavera', 2026, '2026-06-12', 'Burna Boy'),
    (32, '21:00', '23:00', 'Primavera', 2026, '2026-06-12', 'Coldplay'),

-- Primavera Festival - 13/06/2026
    (33, '16:00', '17:00', 'Primavera', 2026, '2026-06-13', 'Ed Sheeran'),
    (34, '17:30', '18:30', 'Primavera', 2026, '2026-06-13', 'Carolina Deslandes'),
    (35, '19:00', '20:00', 'Primavera', 2026, '2026-06-13', 'Billie Eilish'),
    (36, '21:00', '23:00', 'Primavera', 2026, '2026-06-13', 'Xutos & Pontapes');