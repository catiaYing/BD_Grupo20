-- 8. Procedimento comprar_bilhete(p_comprador VARCHAR,
-- p_titular VARCHAR, p_festival VARCHAR, p_ano NUMERIC,
-- p_data DATE, p_data_compra DATE,
-- INOUT p_id_bilhete INTEGER DEFAULT NULL),
-- que regista a compra de um bilhete diário para o dia p_data.
-- Antes de inserir o bilhete, o procedimento deve verificar que:
-- a) A edição existe e o dia pertence a essa edição.
-- b) A data de compra não é posterior ao dia do bilhete (RIA-5).
-- c) Há lugar nesse dia, isto é, o número de bilhetes com
-- acesso ao dia (passes gerais da edição e bilhetes diários
-- desse dia) é inferior à capacidade máxima da edição (RIA-4).
-- Se alguma condição falhar, deve ser lançada uma exceção
-- com uma mensagem que a identifique; caso contrário,
-- o bilhete é inserido e o seu identificador é devolvido
-- em p_id_bilhete.f

CREATE OR REPLACE PROCEDURE comprar_bilhete(
    p_comprador VARCHAR,
    p_titular VARCHAR,
    p_festival VARCHAR,
    p_ano NUMERIC,
    p_data DATE,
    p_data_compra DATE,
    INOUT p_id_bilhete INTEGER DEFAULT NULL
)
AS $$
DECLARE
    v_capacidade INTEGER;
    v_num_bilhetes INTEGER;
BEGIN
    -- Verificar se a edição existe
    SELECT capacidade_max
    INTO v_capacidade
    FROM edicao
    WHERE festival = p_festival
      AND ano = p_ano
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'A edição não existe.';
    END IF;

    -- Verificar se o dia pertence à edição
    IF NOT EXISTS (
        SELECT 1
        FROM dia
        WHERE festival = p_festival
          AND ano = p_ano
          AND data = p_data
    ) THEN
        RAISE EXCEPTION 'O dia não pertence à edição.';
    END IF;

    -- Verificar a data de compra (RIA-5)
    IF p_data_compra IS NULL OR p_data_compra > p_data THEN
        RAISE EXCEPTION 'Data de compra inválida.';
    END IF;

    -- Contar os bilhetes com acesso ao dia (RIA-4)
    SELECT COUNT(*)
    INTO v_num_bilhetes
    FROM bilhete
    WHERE festival = p_festival
      AND ano = p_ano
      AND (tipo = 'geral'
           OR (tipo = 'diario' AND data = p_data));

    IF v_num_bilhetes >= v_capacidade THEN
        RAISE EXCEPTION 'Não há lugares disponíveis para este dia.';
    END IF;

    -- Inserir o bilhete diário e devolver o identificador
    INSERT INTO bilhete (
        comprador, titular, data_compra,
        tipo, festival, ano, data
    )
    VALUES (
        p_comprador, p_titular, p_data_compra,
        'diario', p_festival, p_ano, p_data
    )
    RETURNING id_bilhete INTO p_id_bilhete;
END;
$$ LANGUAGE plpgsql;


-- Exemplo de utilização do procedimento
-- Teste 1: Compra válida de um bilhete diário

CALL comprar_bilhete(
    'comprador@exemplo.pt',
    'titular@exemplo.pt',
    'Festival Atlântico',
    2024,
    DATE '2024-06-20',
    DATE '2024-06-01',
    NULL
);

-- Resultado obtido com os dados iniciais: p_id_bilhete = 1415.


-- Testes de validação
-- Os testes seguintes estão comentados porque geram exceções.

/*
-- Teste 2: Edição inexistente

CALL comprar_bilhete(
    'comprador@exemplo.pt',
    'titular@exemplo.pt',
    'Festival Atlântico',
    2099,
    DATE '2099-06-20',
    DATE '2099-06-01',
    NULL
);

-- Resultado esperado: A edição não existe.


-- Teste 3: Dia inexistente na edição

CALL comprar_bilhete(
    'comprador@exemplo.pt',
    'titular@exemplo.pt',
    'Festival Atlântico',
    2024,
    DATE '2024-01-01',
    DATE '2023-12-01',
    NULL
);

-- Resultado esperado: O dia não pertence à edição.


-- Teste 4: Data de compra inválida (RIA-5)

CALL comprar_bilhete(
    'comprador@exemplo.pt',
    'titular@exemplo.pt',
    'Festival Atlântico',
    2024,
    DATE '2024-06-20',
    DATE '2024-06-21',
    NULL
);

-- Resultado esperado: Data de compra inválida.


-- Teste 5: Dia sem lugares disponíveis (RIA-4)

CALL comprar_bilhete(
    'comprador@exemplo.pt',
    'titular@exemplo.pt',
    'Lua Cheia Fest',
    2026,
    DATE '2026-06-26',
    DATE '2026-06-01',
    NULL
);

-- Resultado esperado:
-- Não há lugares disponíveis para este dia.
*/