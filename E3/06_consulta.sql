-- 6. Para cada dia das edições de 2026,
-- o festival, a data, o número de bilhetes com acesso a esse dia e o número de lugares ainda disponíveis.

SELECT
    d.festival,
    d.data,
    COUNT(b.id_bilhete) AS numero_bilhetes,
    e.capacidade_max - COUNT(b.id_bilhete) AS lugares_disponiveis

FROM dia d

JOIN edicao e
    ON d.festival = e.festival
    AND d.ano = e.ano

LEFT JOIN bilhete b
    ON b.festival = d.festival
    AND b.ano = d.ano
    AND (
        b.tipo = 'geral'
        OR (b.tipo = 'diario' AND b.data = d.data)
    )

WHERE d.ano = 2026

GROUP BY
    d.festival,
    d.data,
    e.capacidade_max

ORDER BY
    d.festival,
    d.data;


-- TESTE 6.1
-- Verificar se existem 15 dias nas edições de 2026.

SELECT
    CASE
        WHEN COUNT(*) = 15 THEN 'OK'
        ELSE 'ERRO'
    END AS teste_numero_dias
FROM dia
WHERE ano = 2026;

-- TESTE 6.2
-- Verificar se o dia sem bilhetes vendidos (Jazz na Quinta, 19/09/2026) é identificado.

SELECT
    CASE
        WHEN COUNT(b.id_bilhete) = 0 THEN 'OK'
        ELSE 'ERRO'
    END AS teste_dia_sem_bilhetes
FROM dia d
LEFT JOIN bilhete b
    ON b.festival = d.festival
    AND b.ano = d.ano
    AND (
        b.tipo = 'geral'
        OR (b.tipo = 'diario' AND b.data = d.data)
    )
WHERE d.festival = 'Jazz na Quinta'
  AND d.ano = 2026
  AND d.data = '2026-09-19';