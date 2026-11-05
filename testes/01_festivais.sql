
-- ==================================================
-- 01 - TESTES DOS FESTIVAIS
-- ==================================================


-- Teste 1: PRIMARY KEY Festival
-- Erro esperado: duplicate key violates
-- unique constraint "pk_festival"
SET search_path TO yifei_schema;
INSERT INTO Festival (nome, ano_criacao)
VALUES ('NOS Alive', 2007);


-- Teste 2: CHECK Recinto
-- Erro esperado: violates check constraint
-- "ck_recinto_capacidade"

INSERT INTO Recinto (
    nome,
    capacidade_max
)
VALUES (
    'Recinto Teste',
    0
);


-- Teste 3: FOREIGN KEY Edicao -> Festival
-- Erro esperado: violates foreign key constraint
-- "fk_edicao_festival"

INSERT INTO Edicao (
    nome_festival,
    ano,
    preco_passe,
    nome_recinto
)
VALUES (
    'Festival Inexistente',
    2026,
    100.00,
    'Parque Tejo'
);


-- Teste 4: FOREIGN KEY Edicao -> Recinto
-- Erro esperado: violates foreign key constraint
-- "fk_edicao_recinto"

INSERT INTO Edicao (
    nome_festival,
    ano,
    preco_passe,
    nome_recinto
)
VALUES (
    'NOS Alive',
    2027,
    100.00,
    'Recinto Inexistente'
);


-- Teste 5: CHECK Edicao
-- Erro esperado: violates check constraint
-- "ck_edicao_preco"

INSERT INTO Edicao (
    nome_festival,
    ano,
    preco_passe,
    nome_recinto
)
VALUES (
    'NOS Alive',
    2027,
    0,
    'Passeio Maritimo de Alges'
);


-- Teste 6: FOREIGN KEY Dia -> Edicao
-- Erro esperado: violates foreign key constraint
-- "fk_dia_edicao"

INSERT INTO Dia (
    nome_festival,
    ano_edicao,
    data,
    preco_diario
)
VALUES (
    'Festival Inexistente',
    2026,
    '2026-07-12',
    50.00
);


-- Teste 7: CHECK Dia
-- Erro esperado: violates check constraint
-- "ck_dia_preco"

INSERT INTO Dia (
    nome_festival,
    ano_edicao,
    data,
    preco_diario
)
VALUES (
    'NOS Alive',
    2026,
    '2026-07-12',
    0
);
