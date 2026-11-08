INSERT INTO Bilhete (
    data_compra,
    preco_pago,
    comprador,
    numero_serie 
)
VALUES
    ('2026-03-10', 98.00, 'ana@example.com', 'BANDY001'),   
    ('2026-04-15', 36.00, 'joao@example.com', NULL),         
    ('2026-05-01', 48.00, 'maria@example.com', 'BANDY005'),  
    ('2026-05-20', 105.00, 'pedro@example.com', NULL);       


INSERT INTO PasseGeral (
    id_bilhete,
    nome_festival,
    ano_edicao
)
VALUES
    (1, 'Sons do Tejo', 2026),
    (4, 'Sons do Tejo', 2027);

INSERT INTO BilheteDiario (
    id_bilhete,
    data_dia
)
VALUES
    (2, '2026-06-19'),
    (3, '2027-07-02');