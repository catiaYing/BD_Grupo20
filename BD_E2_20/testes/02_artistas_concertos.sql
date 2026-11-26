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
