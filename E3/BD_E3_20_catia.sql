
-- 3. Para cada festival, o género musical com mais concertos,
-- considerando todas as edições, e o respetivo número de concertos.
-- Em caso de empate, devem ser apresentados todos os géneros empatados.

SELECT c.festival AS festival,
       a.genero_musical,
       COUNT(*) AS numero_concertos
FROM luisa_e3.concerto c
JOIN luisa_e3.artista a
     ON c.artista = a.nome
GROUP BY c.festival, a.genero_musical
HAVING COUNT(*) >= ALL (
    SELECT COUNT(*)
    FROM luisa_e3.concerto c2
    JOIN luisa_e3.artista a2
         ON c2.artista = a2.nome
    WHERE c2.festival = c.festival
    GROUP BY a2.genero_musical
)
ORDER BY c.festival, a.genero_musical;



-- 4. Email dos compradores que compraram mais bilhetes
-- para outras pessoas (titular diferente do comprador)
-- do que para si próprios, indicando o número de bilhetes
-- comprados para outras pessoas.

SELECT comprador,
       COUNT(*) FILTER (
           WHERE titular <> comprador
       ) AS bilhetes_para_outros
FROM luisa_e3.bilhete
GROUP BY comprador
HAVING COUNT(*) FILTER (
           WHERE titular <> comprador
       ) > COUNT(*) FILTER (
           WHERE titular = comprador
       )
ORDER BY comprador;
