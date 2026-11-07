SET search_path TO luisa_schema;
-- =====================================================
-- BD Projeto E2 - Grupo 20
-- Modulo 03: Populacao de Dados
-- =====================================================

-- TABELA 1: Utilizador
-- Inserir quatro utilizadores na base de dados.
-- 中文：插入四个用户，方便后续测试设备和关注关系。

INSERT INTO Utilizador
    (email, nome, data_nascimento, grupo_sanguineo, contacto_emergencia)
VALUES
    ('ana@example.com', 'Ana Silva', '2002-05-14', 'A+', '912345678'),
    ('joao@example.com', 'Joao Costa', '2001-09-20', 'O+', '923456789'),
    ('maria@example.com', 'Maria Santos', '2003-02-08', 'B+', '934567890'),
    ('pedro@example.com', 'Pedro Almeida', '2000-11-30', 'AB+', '945678901');


-- TABELA 2: UtilizadorAlergia
-- 中文：为用户插入过敏信息。
-- 同一个用户可以有多种过敏信息。

INSERT INTO UtilizadorAlergia
    (email_utilizador, alergia)
VALUES
    ('ana@example.com', 'Polen'),
    ('ana@example.com', 'Amendoim'),
    ('joao@example.com', 'Marisco'),
    ('maria@example.com', 'Lactose');


-- TABELA 3: Dispositivo
-- Casos: dispositivos ativos, bloqueados e extraviados.
-- 中文：覆盖正常使用、锁定和丢失的设备。

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
-- Exemplos de seguimentos nao reciprocos.
-- 中文：插入单向关注和双向关注的情况。

INSERT INTO Segue
    (email_seguidor, email_seguido)
VALUES
    ('ana@example.com', 'joao@example.com'),
    ('ana@example.com', 'maria@example.com'),
    ('joao@example.com', 'maria@example.com'),
    ('maria@example.com', 'joao@example.com'),
    ('pedro@example.com', 'ana@example.com');
