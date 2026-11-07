CREATE TABLE Bilhete (
    id_bilhete SERIAL,
    data_compra DATE NOT NULL,
    preco_pago NUMERIC(10, 2) NOT NULL,
    comprador VARCHAR(255) NOT NULL,
    ns_serie VARCHAR(100) NULL, 
    
    CONSTRAINT pk_bilhete PRIMARY KEY (id_bilhete),
    CONSTRAINT fk_bilhete_comprador 
        FOREIGN KEY (comprador) 
        REFERENCES Utilizador(email) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    CONSTRAINT fk_bilhete_dispositivo 
        FOREIGN KEY (ns_serie) 
        REFERENCES Dispositivo(ns_serie) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE,
    CONSTRAINT ck_bilhete_preco_positivo 
        CHECK (preco_pago > 0) -- RIA-12
);

CREATE TABLE PasseGeral (
    id_bilhete INTEGER,
    ano_edicao INTEGER NOT NULL,
    
    CONSTRAINT pk_passe_geral PRIMARY KEY (id_bilhete),
    CONSTRAINT fk_passe_geral_bilhete 
        FOREIGN KEY (id_bilhete) 
        REFERENCES Bilhete(id_bilhete) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT fk_passe_geral_edicao 
        FOREIGN KEY (ano_edicao) 
        REFERENCES Edicao(ano) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
);

CREATE TABLE BilheteDiario (
    id_bilhete INTEGER,
    data_dia DATE NOT NULL,
    
    CONSTRAINT pk_bilhete_diario PRIMARY KEY (id_bilhete),
    CONSTRAINT fk_bilhete_diario_bilhete 
        FOREIGN KEY (id_bilhete) 
        REFERENCES Bilhete(id_bilhete) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT fk_bilhete_diario_dia 
        FOREIGN KEY (data_dia) 
        REFERENCES Dia(data) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE