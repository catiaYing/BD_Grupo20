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
