
-- =====================================================
-- BD Projeto E2 - Grupo 20
-- Modulo 03: Testes das Restricoes
-- Utilizadores e Dispositivos
-- =====================================================

-- TESTE 1: RIA-7 - Saldo negativo
-- Erro esperado: violacao de ck_dispositivo_saldo.

SET search_path TO luisa_schema;

INSERT INTO Dispositivo
    (numero_serie, saldo, estado, email_utilizador)
VALUES
    ('TESTE001', -10.00, 'ativo', 'ana@example.com');


-- TESTE 2: RIA-7 - Estado invalido
-- Erro esperado: violacao de ck_dispositivo_estado.

SET search_path TO luisa_schema;

INSERT INTO Dispositivo
    (numero_serie, saldo, estado, email_utilizador)
VALUES
    ('TESTE002', 20.00, 'desativado', 'ana@example.com');


-- TESTE 3: RIA-11 - Utilizador segue-se a si proprio
-- Erro esperado: violacao de ck_segue_diferentes.

SET search_path TO luisa_schema;

INSERT INTO Segue
    (email_seguidor, email_seguido)
VALUES
    ('ana@example.com', 'ana@example.com');


-- TESTE 4: PK - Email duplicado
-- Erro esperado: violacao de pk_utilizador.

SET search_path TO luisa_schema;

INSERT INTO Utilizador
    (email, nome)
VALUES
    ('ana@example.com', 'Outra Ana');


-- TESTE 5: FK - Dispositivo com utilizador inexistente
-- Erro esperado: violacao de fk_dispositivo_utilizador.

SET search_path TO luisa_schema;

INSERT INTO Dispositivo
    (numero_serie, saldo, estado, email_utilizador)
VALUES
    ('TESTE003', 10.00, 'ativo', 'inexistente@example.com');


-- TESTE 6: PK - Seguimento duplicado
-- Erro esperado: violacao de pk_segue.

SET search_path TO luisa_schema;

INSERT INTO Segue
    (email_seguidor, email_seguido)
VALUES
    ('ana@example.com', 'joao@example.com');


-- TESTE 7: NOT NULL - Estado obrigatorio
-- Erro esperado: valor nulo na coluna estado.

SET search_path TO luisa_schema;

INSERT INTO Dispositivo
    (numero_serie, saldo, estado, email_utilizador)
VALUES
    ('TESTE004', 10.00, NULL, 'ana@example.com');


-- TESTE 8: NOT NULL - Nome obrigatorio
-- Erro esperado: valor nulo na coluna nome.

SET search_path TO luisa_schema;

INSERT INTO Utilizador
    (email, nome)
VALUES
    ('teste8@example.com', NULL);


-- TESTE 9: PK - Alergia duplicada
-- Erro esperado: violacao de pk_utilizador_alergia.

SET search_path TO luisa_schema;

INSERT INTO UtilizadorAlergia
    (email_utilizador, alergia)
VALUES
    ('ana@example.com', 'Polen');


-- TESTE 10: FK - Alergia de utilizador inexistente
-- Erro esperado: violacao de fk_alergia_utilizador.

SET search_path TO luisa_schema;

INSERT INTO UtilizadorAlergia
    (email_utilizador, alergia)
VALUES
    ('inexistente@example.com', 'Polen');


-- TESTE 11: PK - Numero de serie duplicado
-- Erro esperado: violacao de pk_dispositivo.

SET search_path TO luisa_schema;

INSERT INTO Dispositivo
    (numero_serie, saldo, estado, email_utilizador)
VALUES
    ('BANDY001', 10.00, 'bloqueado', 'ana@example.com');


-- TESTE 12: FK - Seguidor inexistente
-- Erro esperado: violacao de fk_segue_seguidor.

SET search_path TO luisa_schema;

INSERT INTO Segue
    (email_seguidor, email_seguido)
VALUES
    ('inexistente@example.com', 'ana@example.com');


-- TESTE 13: FK - Seguido inexistente
-- Erro esperado: violacao de fk_segue_seguido.

SET search_path TO luisa_schema;

INSERT INTO Segue
    (email_seguidor, email_seguido)
VALUES
    ('ana@example.com', 'inexistente@example.com');


-- TESTE 14: NOT NULL - Saldo obrigatorio
-- Erro esperado: valor nulo na coluna saldo.

SET search_path TO luisa_schema;

INSERT INTO Dispositivo
    (numero_serie, saldo, estado, email_utilizador)
VALUES
    ('TESTE014', NULL, 'ativo', 'ana@example.com');


-- TESTE 15: NOT NULL - Utilizador do dispositivo
-- Erro esperado: valor nulo na coluna email_utilizador.

SET search_path TO luisa_schema;

INSERT INTO Dispositivo
    (numero_serie, saldo, estado, email_utilizador)
VALUES
    ('TESTE015', 10.00, 'ativo', NULL);


-- TESTE 16: PK - Email nulo
-- Erro esperado: valor nulo na chave primaria email.

SET search_path TO luisa_schema;

INSERT INTO Utilizador
    (email, nome)
VALUES
    (NULL, 'Utilizador Teste');


-- TESTE 17: PK - Numero de serie nulo
-- Erro esperado: valor nulo na chave primaria numero_serie.

SET search_path TO luisa_schema;

INSERT INTO Dispositivo
    (numero_serie, saldo, estado, email_utilizador)
VALUES
    (NULL, 10.00, 'ativo', 'ana@example.com');


-- TESTE 18: PK composta - Email da alergia nulo
-- Erro esperado: valor nulo em email_utilizador.

SET search_path TO luisa_schema;

INSERT INTO UtilizadorAlergia
    (email_utilizador, alergia)
VALUES
    (NULL, 'Polen');


-- TESTE 19: PK composta - Alergia nula
-- Erro esperado: valor nulo na coluna alergia.

SET search_path TO luisa_schema;

INSERT INTO UtilizadorAlergia
    (email_utilizador, alergia)
VALUES
    ('ana@example.com', NULL);


-- TESTE 20: PK composta - Seguidor nulo
-- Erro esperado: valor nulo em email_seguidor.

SET search_path TO luisa_schema;

INSERT INTO Segue
    (email_seguidor, email_seguido)
VALUES
    (NULL, 'ana@example.com');


-- TESTE 21: PK composta - Seguido nulo
-- Erro esperado: valor nulo em email_seguido.

SET search_path TO luisa_schema;

INSERT INTO Segue
    (email_seguidor, email_seguido)
VALUES
    ('ana@example.com', NULL);
