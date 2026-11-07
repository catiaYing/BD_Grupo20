
SET search_path TO catia_schema;

-- ==================================================
-- Dados da tabela Artista
-- ==================================================

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


-- ==================================================
-- Dados da tabela Concerto
-- ==================================================

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

-- Sons do Tejo - Edicao 2026
(1, '16:00', '17:00', 'Sons do Tejo', 2026, '2026-06-19', 'Ana Moura'),
(2, '17:30', '18:30', 'Sons do Tejo', 2026, '2026-06-19', 'Calema'),
(3, '19:00', '20:00', 'Sons do Tejo', 2026, '2026-06-19', 'Dua Lipa'),

(4, '21:00', '23:00', 'Sons do Tejo', 2026, '2026-06-20', 'Coldplay'),
(5, '16:00', '17:00', 'Sons do Tejo', 2026, '2026-06-20', 'Mariza'),
(6, '17:30', '18:30', 'Sons do Tejo', 2026, '2026-06-20', 'Ed Sheeran'),

(7, '19:00', '20:00', 'Sons do Tejo', 2026, '2026-06-21', 'Burna Boy'),
(8, '21:00', '23:00', 'Sons do Tejo', 2026, '2026-06-21', 'The Weeknd'),
(9, '16:00', '17:00', 'Sons do Tejo', 2026, '2026-06-21', 'Carolina Deslandes'),

-- Sons do Tejo - Edicao 2027
(10, '17:30', '18:30', 'Sons do Tejo', 2027, '2027-06-18', 'Xutos & Pontapes'),
(11, '19:00', '20:00', 'Sons do Tejo', 2027, '2027-06-18', 'Billie Eilish'),
(12, '21:00', '23:00', 'Sons do Tejo', 2027, '2027-06-18', 'Imagine Dragons'),

(13, '16:00', '17:00', 'Sons do Tejo', 2027, '2027-06-19', 'Dua Lipa'),
(14, '17:30', '18:30', 'Sons do Tejo', 2027, '2027-06-19', 'Calema'),
(15, '19:00', '20:00', 'Sons do Tejo', 2027, '2027-06-19', 'The Weeknd'),

(16, '21:00', '23:00', 'Sons do Tejo', 2027, '2027-06-20', 'Coldplay'),
(17, '16:00', '17:00', 'Sons do Tejo', 2027, '2027-06-20', 'Ana Moura'),
(18, '17:30', '18:30', 'Sons do Tejo', 2027, '2027-06-20', 'Burna Boy'),

-- Luz do Atlantico - Edicao 2027
(19, '19:00', '20:00', 'Luz do Atlantico', 2027, '2027-07-02', 'Ed Sheeran'),
(20, '21:00', '23:00', 'Luz do Atlantico', 2027, '2027-07-02', 'Imagine Dragons'),
(21, '16:00', '17:00', 'Luz do Atlantico', 2027, '2027-07-03', 'Mariza'),

(22, '17:30', '18:30', 'Luz do Atlantico', 2027, '2027-07-03', 'Carolina Deslandes'),
(23, '19:00', '20:00', 'Luz do Atlantico', 2027, '2027-07-03', 'Billie Eilish'),
(24, '21:00', '23:00', 'Luz do Atlantico', 2027, '2027-07-03', 'Xutos & Pontapes'),

(25, '16:00', '17:00', 'Luz do Atlantico', 2027, '2027-07-04', 'The Weeknd'),
(26, '17:30', '18:30', 'Luz do Atlantico', 2027, '2027-07-04', 'Ana Moura'),
(27, '19:00', '20:00', 'Luz do Atlantico', 2027, '2027-07-04', 'Imagine Dragons'),

-- Ritmos da Serra - Edicao 2027
(28, '21:00', '23:00', 'Ritmos da Serra', 2027, '2027-08-06', 'Dua Lipa'),
(29, '16:00', '17:00', 'Ritmos da Serra', 2027, '2027-08-06', 'Calema'),
(30, '17:30', '18:30', 'Ritmos da Serra', 2027, '2027-08-06', 'Mariza'),

(31, '19:00', '20:00', 'Ritmos da Serra', 2027, '2027-08-07', 'Burna Boy'),
(32, '21:00', '23:00', 'Ritmos da Serra', 2027, '2027-08-07', 'Coldplay'),
(33, '16:00', '17:00', 'Ritmos da Serra', 2027, '2027-08-07', 'Ed Sheeran'),

(34, '17:30', '18:30', 'Ritmos da Serra', 2027, '2027-08-08', 'Carolina Deslandes'),
(35, '19:00', '20:00', 'Ritmos da Serra', 2027, '2027-08-08', 'Billie Eilish'),
(36, '21:00', '23:00', 'Ritmos da Serra', 2027, '2027-08-08', 'Xutos & Pontapes');
