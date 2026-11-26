-- 7. Função preco_pago(p_id_bilhete INTEGER) RETURNS NUMERIC,
-- que devolve o preço pago por um bilhete (RIA-6):
-- o preço do passe da edição, se for um passe geral, ou o
-- preço diário do dia, se for um bilhete diário.
-- Se o bilhete não existir, deve ser lançada uma exceção.
-- Usar a função numa consulta que apresente, para cada edição,
-- o festival, o ano, o número de bilhetes vendidos e a receita total.

CREATE OR REPLACE FUNCTION preco_pago(p_id_bilhete INTEGER)
RETURNS NUMERIC
AS $$
DECLARE
    v_bilhete bilhete%ROWTYPE;
    v_preco NUMERIC;
BEGIN
    SELECT *
    INTO v_bilhete
    FROM bilhete
    WHERE id_bilhete = p_id_bilhete;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'O bilhete % não existe.', p_id_bilhete;
    END IF;

    -- Obter o preço de acordo com o tipo de bilhete
    IF v_bilhete.tipo = 'geral' THEN
        SELECT preco_passe
        INTO v_preco
        FROM edicao
        WHERE festival = v_bilhete.festival
          AND ano = v_bilhete.ano;
    ELSE
        SELECT preco_diario
        INTO v_preco
        FROM dia
        WHERE festival = v_bilhete.festival
          AND ano = v_bilhete.ano
          AND data = v_bilhete.data;
    END IF;

    RETURN v_preco;
END;
$$ LANGUAGE plpgsql;


-- Exemplos de utilização da função

SELECT preco_pago(1);
-- Resultado: 59.00 (bilhete diário)

SELECT preco_pago(2);
-- Resultado: 129.00 (passe geral)

-- Teste de um bilhete inexistente
-- SELECT preco_pago(-1);
-- Resultado: O bilhete -1 não existe.


-- Número de bilhetes vendidos e receita total por edição

SELECT e.festival, e.ano,
       COUNT(b.id_bilhete) AS numero_bilhetes,
       COALESCE(SUM(preco_pago(b.id_bilhete))
           FILTER (WHERE b.id_bilhete IS NOT NULL), 0) AS receita_total
FROM edicao e
LEFT JOIN bilhete b
    ON e.festival = b.festival
    AND e.ano = b.ano
GROUP BY e.festival, e.ano
ORDER BY e.festival, e.ano;