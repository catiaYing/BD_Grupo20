-- Teste 1.1: Violação da restrição CHECK de preço positivo (RIA-12 / ck_bilhete_preco_positivo)
-- ERRO ESPERADO: new row for relation "bilhete" violates check constraint "ck_bilhete_preco_positivo"
INSERT INTO Bilhete (data_compra, preco_pago, comprador, numero_serie)
VALUES ('2026-03-15', -15.00, 'ana@example.com', NULL);


-- Teste 1.2: Violação de Chave Estrangeira (Comprador inexistente na tabela Utilizador)
-- ERRO ESPERADO: insert or update on table "bilhete" violates foreign key constraint "fk_bilhete_comprador"
INSERT INTO Bilhete (data_compra, preco_pago, comprador, numero_serie)
VALUES ('2026-03-15', 50.00, 'nao.existe@example.com', NULL);


-- =====================================================
-- 2. Testes na tabela Concerto (Horários)
-- =====================================================

-- Teste 2.1: Violação da restrição RIA-2 em Concerto (hora_inicio >= hora_fim)
-- ERRO ESPERADO: new row for relation "concerto" violates check constraint "ck_concerto_horario" (ou equivalente)
INSERT INTO Concerto (id_concerto, hora_inicio, hora_fim, nome_festival, ano_edicao, data, nome_artista)
VALUES (99, '22:00', '21:00', 'Sons do Tejo', 2026, '2026-06-19', 'Ana Moura');


-- =====================================================
-- 3. Testes na tabela Dispositivo e Utilizador
-- =====================================================

-- Teste 3.1: Violação de Chave Primária Duplicada em Dispositivo
-- ERRO ESPERADO: duplicate key value violates unique constraint "dispositivo_pkey" (ou pk_dispositivo)
INSERT INTO Dispositivo (numero_serie, saldo, estado, email_utilizador)
VALUES ('BANDY001', 10.00, 'ativo', 'joao@example.com');


-- Teste 3.2: Violação de Chave Estrangeira ao inserir dispositivo para utilizador inexistente
-- ERRO ESPERADO: insert or update on table "dispositivo" violates foreign key constraint ...
INSERT INTO Dispositivo (numero_serie, saldo, estado, email_utilizador)
VALUES ('BANDY999', 10.00, 'ativo', 'fantasma@example.com');


-- =====================================================
-- 4. Testes de Ações Referenciais (ON DELETE / ON UPDATE)
-- =====================================================

-- Teste 4.1: Violação de Integridade Referencial (Apagar Utilizador com bilhetes/dispositivos associados com ON DELETE RESTRICT)
-- ERRO ESPERADO: update or delete on table "utilizador" violates foreign key constraint ... on table "bilhete"
DELETE FROM Utilizador WHERE email = 'ana@example.com';