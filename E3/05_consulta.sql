-- 5. Nome dos artistas que atuaram em todas as edições do Festival Atlântico.

SELECT a.nome
FROM artista a
WHERE NOT EXISTS (
    SELECT 1
    FROM edicao e
    WHERE e.festival = 'Festival Atlântico'
      AND NOT EXISTS (
          SELECT 1
          FROM concerto c
          WHERE c.festival = e.festival
            AND c.ano = e.ano
            AND c.artista = a.nome
      )
);


-- TESTE 5.1: Artistas esperados que não aparecem no resultado da consulta.

(
    VALUES
        ('Bruno Estrela'),
        ('Kalunga Beat'),
        ('Os Faroleiros')
)

EXCEPT

(
    SELECT a.nome
    FROM artista a
    WHERE NOT EXISTS (
        SELECT 1
        FROM edicao e
        WHERE e.festival = 'Festival Atlântico'
          AND NOT EXISTS (
              SELECT 1
              FROM concerto c
              WHERE c.artista = a.nome
                AND c.festival = e.festival
                AND c.ano = e.ano
          )
    )
);


-- TESTE 5.2: Artistas que aparecem no resultado mas não eram esperados.

(
    SELECT a.nome
    FROM artista a
    WHERE NOT EXISTS (
        SELECT 1
        FROM edicao e
        WHERE e.festival = 'Festival Atlântico'
          AND NOT EXISTS (
              SELECT 1
              FROM concerto c
              WHERE c.artista = a.nome
                AND c.festival = e.festival
                AND c.ano = e.ano
          )
    )
)

EXCEPT

(
    VALUES
        ('Bruno Estrela'),
        ('Kalunga Beat'),
        ('Os Faroleiros')
);
