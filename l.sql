SELECT 'Festival' AS tabela, COUNT(*) AS total FROM Festival
UNION ALL
SELECT 'Recinto', COUNT(*) FROM Recinto
UNION ALL
SELECT 'Edicao', COUNT(*) FROM Edicao
UNION ALL
SELECT 'Dia', COUNT(*) FROM Dia
UNION ALL
SELECT 'Artista', COUNT(*) FROM Artista
UNION ALL
SELECT 'Concerto', COUNT(*) FROM Concerto
UNION ALL
SELECT 'Utilizador', COUNT(*) FROM Utilizador
UNION ALL
SELECT 'UtilizadorAlergia', COUNT(*) FROM UtilizadorAlergia
UNION ALL
SELECT 'Dispositivo', COUNT(*) FROM Dispositivo
UNION ALL
SELECT 'Segue', COUNT(*) FROM Segue
UNION ALL
SELECT 'Bilhete', COUNT(*) FROM Bilhete
UNION ALL
SELECT 'PasseGeral', COUNT(*) FROM PasseGeral
UNION ALL
SELECT 'BilheteDiario', COUNT(*) FROM BilheteDiario;
