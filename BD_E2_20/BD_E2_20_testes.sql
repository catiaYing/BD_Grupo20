-- =====================================================
-- BD Projeto E2 - Grupo 20
-- Testes das Restricoes de Integridade
-- =====================================================

-- Executar apos BD_E2_20.sql.
-- Cada teste deve provocar o erro indicado no comentario.
-- Os testes devem ser executados individualmente.



-- =====================================================
-- BD Projeto E2 - Grupo 20
-- Modulo 01: Testes das Restricoes
-- Festivais
-- =====================================================

-- Teste 1: PRIMARY KEY Festival
-- Erro esperado: pk_festival.

INSERT INTO Festival (nome, ano_criacao)
VALUES ('Sons do Tejo', 2014);


-- Teste 2: CHECK Recinto - Capacidade invalida
-- Erro esperado: ck_recinto_capacidade.

INSERT INTO Recinto (
    nome,
    capacidade_max
)
VALUES (
    'Recinto Teste',
    0
);


-- Teste 3: FOREIGN KEY Edicao -> Festival
-- Erro esperado: fk_edicao_festival.

INSERT INTO Edicao (
    nome_festival,
    ano,
    preco_passe,
    nome_recinto
)
VALUES (
    'Festival Inexistente',
    2027,
    100.00,
    'Parque Ribeirinho'
);


-- Teste 4: FOREIGN KEY Edicao -> Recinto
-- Erro esperado: fk_edicao_recinto.

INSERT INTO Edicao (
    nome_festival,
    ano,
    preco_passe,
    nome_recinto
)
VALUES (
    'Sons do Tejo',
    2028,
    100.00,
    'Recinto Inexistente'
);


-- Teste 5: CHECK Edicao - Preco invalido
-- Erro esperado: ck_edicao_preco.

INSERT INTO Edicao (
    nome_festival,
    ano,
    preco_passe,
    nome_recinto
)
VALUES (
    'Sons do Tejo',
    2028,
    0,
    'Parque Ribeirinho'
);


-- Teste 6: FOREIGN KEY Dia -> Edicao
-- Erro esperado: fk_dia_edicao.

INSERT INTO Dia (
    nome_festival,
    ano_edicao,
    data,
    preco_diario
)
VALUES (
    'Festival Inexistente',
    2027,
    '2027-07-12',
    50.00
);


-- Teste 7: CHECK Dia - Preco invalido
-- Erro esperado: ck_dia_preco.

INSERT INTO Dia (
    nome_festival,
    ano_edicao,
    data,
    preco_diario
)
VALUES (
    'Sons do Tejo',
    2027,
    '2027-06-21',
    0
);


-- Teste 8: PRIMARY KEY Recinto
-- Erro esperado: pk_recinto.

INSERT INTO Recinto (
    nome,
    capacidade_max
)
VALUES (
    'Parque Ribeirinho',
    18000
);


-- Teste 9: PRIMARY KEY Edicao
-- Erro esperado: pk_edicao.

INSERT INTO Edicao (
    nome_festival,
    ano,
    preco_passe,
    nome_recinto
)
VALUES (
    'Sons do Tejo',
    2026,
    98.00,
    'Quinta das Fontes'
);


-- Teste 10: PRIMARY KEY Dia
-- Erro esperado: pk_dia.

INSERT INTO Dia (
    nome_festival,
    ano_edicao,
    data,
    preco_diario
)
VALUES (
    'Sons do Tejo',
    2026,
    '2026-06-19',
    36.00
);



-- =====================================================
-- BD Projeto E2 - Grupo 20
-- Modulo 02: Testes das Restricoes
-- Artistas e Concertos
-- =====================================================

-- Teste 1: RIA-2 - Horario invalido
-- Erro esperado: ck_concerto_horas.

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
    'Sons do Tejo',
    2026,
    '2026-06-19',
    'Ana Moura'
);


-- Teste 2: RIA-3 - Tipo de artista invalido
-- Erro esperado: ck_artista_tipo.

INSERT INTO Artista (
    nome,
    genero_musical,
    tipo
)
VALUES (
    'Artista Teste',
    'Pop',
    'banda'
);


-- Teste 3: PRIMARY KEY Artista
-- Erro esperado: pk_artista.

INSERT INTO Artista (
    nome,
    genero_musical,
    tipo
)
VALUES (
    'Ana Moura',
    'Fado',
    'artista'
);


-- Teste 4: PRIMARY KEY Concerto
-- Erro esperado: pk_concerto.

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
    1,
    '16:00',
    '17:00',
    'Sons do Tejo',
    2026,
    '2026-06-19',
    'Ana Moura'
);


-- Teste 5: FOREIGN KEY Concerto -> Dia
-- Erro esperado: fk_concerto_dia.

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
    101,
    '16:00',
    '17:00',
    'Sons do Tejo',
    2026,
    '2099-01-01',
    'Ana Moura'
);


-- Teste 6: FOREIGN KEY Concerto -> Artista
-- Erro esperado: fk_concerto_artista.

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
    102,
    '16:00',
    '17:00',
    'Sons do Tejo',
    2026,
    '2026-06-19',
    'Artista Inexistente'
);


-- Teste 7: NOT NULL - Tipo obrigatorio
-- Erro esperado: valor nulo na coluna tipo.

INSERT INTO Artista (
    nome,
    genero_musical,
    tipo
)
VALUES (
    'Artista Sem Tipo',
    'Pop',
    NULL
);


-- Teste 8: NOT NULL - Hora de inicio obrigatoria
-- Erro esperado: valor nulo na coluna hora_inicio.

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
    103,
    NULL,
    '18:00',
    'Sons do Tejo',
    2026,
    '2026-06-19',
    'Ana Moura'
);


-- =====================================================
-- BD Projeto E2 - Grupo 20
-- Modulo 03: Testes das Restricoes
-- Utilizadores e Dispositivos
-- =====================================================

-- TESTE 1: RIA-7 - Saldo negativo
-- Erro esperado: violacao de ck_dispositivo_saldo.
INSERT INTO Dispositivo
    (numero_serie, saldo, estado, email_utilizador)
VALUES
    ('TESTE001', -10.00, 'ativo', 'ana@example.com');


-- TESTE 2: RIA-7 - Estado invalido
-- Erro esperado: violacao de ck_dispositivo_estado.
INSERT INTO Dispositivo
    (numero_serie, saldo, estado, email_utilizador)
VALUES
    ('TESTE002', 20.00, 'desativado', 'ana@example.com');


-- TESTE 3: RIA-11 - Utilizador segue-se a si proprio
-- Erro esperado: violacao de ck_segue_diferentes.
INSERT INTO Segue
    (email_seguidor, email_seguido)
VALUES
    ('ana@example.com', 'ana@example.com');


-- TESTE 4: PK - Email duplicado
-- Erro esperado: violacao de pk_utilizador.
INSERT INTO Utilizador
    (email, nome)
VALUES
    ('ana@example.com', 'Outra Ana');


-- TESTE 5: FK - Dispositivo com utilizador inexistente
-- Erro esperado: violacao de fk_dispositivo_utilizador.
INSERT INTO Dispositivo
    (numero_serie, saldo, estado, email_utilizador)
VALUES
    ('TESTE003', 10.00, 'ativo', 'inexistente@example.com');


-- TESTE 6: PK - Seguimento duplicado
-- Erro esperado: violacao de pk_segue.
INSERT INTO Segue
    (email_seguidor, email_seguido)
VALUES
    ('ana@example.com', 'joao@example.com');


-- TESTE 7: NOT NULL - Estado obrigatorio
-- Erro esperado: valor nulo na coluna estado.
INSERT INTO Dispositivo
    (numero_serie, saldo, estado, email_utilizador)
VALUES
    ('TESTE004', 10.00, NULL, 'ana@example.com');


-- TESTE 8: NOT NULL - Nome obrigatorio
-- Erro esperado: valor nulo na coluna nome.
INSERT INTO Utilizador
    (email, nome)
VALUES
    ('teste8@example.com', NULL);


-- TESTE 9: PK - Alergia duplicada
-- Erro esperado: violacao de pk_utilizador_alergia.
INSERT INTO UtilizadorAlergia
    (email_utilizador, alergia)
VALUES
    ('ana@example.com', 'Polen');


-- TESTE 10: FK - Alergia de utilizador inexistente
-- Erro esperado: violacao de fk_alergia_utilizador.
INSERT INTO UtilizadorAlergia
    (email_utilizador, alergia)
VALUES
    ('inexistente@example.com', 'Polen');


-- TESTE 11: PK - Numero de serie duplicado
-- Erro esperado: violacao de pk_dispositivo.
INSERT INTO Dispositivo
    (numero_serie, saldo, estado, email_utilizador)
VALUES
    ('BANDY001', 10.00, 'bloqueado', 'ana@example.com');


-- TESTE 12: FK - Seguidor inexistente
-- Erro esperado: violacao de fk_segue_seguidor.
INSERT INTO Segue
    (email_seguidor, email_seguido)
VALUES
    ('inexistente@example.com', 'ana@example.com');


-- TESTE 13: FK - Seguido inexistente
-- Erro esperado: violacao de fk_segue_seguido.
INSERT INTO Segue
    (email_seguidor, email_seguido)
VALUES
    ('ana@example.com', 'inexistente@example.com');


-- TESTE 14: NOT NULL - Saldo obrigatorio
-- Erro esperado: valor nulo na coluna saldo.
INSERT INTO Dispositivo
    (numero_serie, saldo, estado, email_utilizador)
VALUES
    ('TESTE014', NULL, 'ativo', 'ana@example.com');


-- TESTE 15: NOT NULL - Utilizador do dispositivo
-- Erro esperado: valor nulo na coluna email_utilizador.
INSERT INTO Dispositivo
    (numero_serie, saldo, estado, email_utilizador)
VALUES
    ('TESTE015', 10.00, 'ativo', NULL);



-- =====================================================
-- BD Projeto E2 - Grupo 20
-- Modulo 04: Testes das Restricoes
-- Bilhetes
-- =====================================================

-- Teste 1.1: Violacao do CHECK de preco positivo.
-- Erro esperado: ck_bilhete_preco_positivo.

INSERT INTO Bilhete
    (data_compra, preco_pago, comprador, numero_serie)
VALUES
    ('2026-03-15', -15.00, 'ana@example.com', NULL);


-- Teste 1.2: Comprador inexistente.
-- Erro esperado: fk_bilhete_comprador.

INSERT INTO Bilhete
    (data_compra, preco_pago, comprador, numero_serie)
VALUES
    ('2026-03-15', 50.00, 'nao.existe@example.com', NULL);


-- Teste 1.3: Dispositivo inexistente.
-- Erro esperado: fk_bilhete_dispositivo.

INSERT INTO Bilhete
    (data_compra, preco_pago, comprador, numero_serie)
VALUES
    ('2026-03-15', 50.00, 'ana@example.com', 'INEXISTENTE');


-- Teste 1.4: Data de compra nula.
-- Erro esperado: violacao de NOT NULL em data_compra.

INSERT INTO Bilhete
    (data_compra, preco_pago, comprador, numero_serie)
VALUES
    (NULL, 50.00, 'ana@example.com', NULL);


-- Teste 1.5: Preco pago nulo.
-- Erro esperado: violacao de NOT NULL em preco_pago.

INSERT INTO Bilhete
    (data_compra, preco_pago, comprador, numero_serie)
VALUES
    ('2026-03-15', NULL, 'ana@example.com', NULL);


-- Teste 1.6: Comprador nulo.
-- Erro esperado: violacao de NOT NULL em comprador.

INSERT INTO Bilhete
    (data_compra, preco_pago, comprador, numero_serie)
VALUES
    ('2026-03-15', 50.00, NULL, NULL);


-- Teste 1.7: Chave primaria duplicada em Bilhete.
-- Erro esperado: pk_bilhete.

INSERT INTO Bilhete
    (id_bilhete, data_compra, preco_pago, comprador, numero_serie)
VALUES
    (1, '2026-03-15', 50.00, 'ana@example.com', NULL);


-- =====================================================
-- 2. Testes na tabela PasseGeral
-- =====================================================

-- Teste 2.1: Chave primaria duplicada.
-- Erro esperado: pk_passe_geral.

INSERT INTO PasseGeral
    (id_bilhete, nome_festival, ano_edicao)
VALUES
    (1, 'Sons do Tejo', 2026);


-- Teste 2.2: Bilhete inexistente.
-- Erro esperado: fk_passe_geral_bilhete.

INSERT INTO PasseGeral
    (id_bilhete, nome_festival, ano_edicao)
VALUES
    (9999, 'Sons do Tejo', 2026);


-- Teste 2.3: Edicao inexistente.
-- Erro esperado: fk_passe_geral_edicao.

INSERT INTO PasseGeral
    (id_bilhete, nome_festival, ano_edicao)
VALUES
    (2, 'Sons do Tejo', 9999);


-- =====================================================
-- 3. Testes na tabela BilheteDiario
-- =====================================================

-- Teste 3.1: Chave primaria duplicada.
-- Erro esperado: pk_bilhete_diario.

INSERT INTO BilheteDiario
    (id_bilhete, nome_festival, ano_edicao, data_dia)
VALUES
    (2, 'Sons do Tejo', 2026, '2026-06-19');


-- Teste 3.2: Bilhete inexistente.
-- Erro esperado: fk_bilhete_diario_bilhete.

INSERT INTO BilheteDiario
    (id_bilhete, nome_festival, ano_edicao, data_dia)
VALUES
    (9999, 'Sons do Tejo', 2026, '2026-06-19');


-- Teste 3.3: Dia inexistente.
-- Erro esperado: fk_bilhete_diario_dia.

INSERT INTO BilheteDiario
    (id_bilhete, nome_festival, ano_edicao, data_dia)
VALUES
    (3, 'Luz do Atlantico', 2027, '2099-01-01');