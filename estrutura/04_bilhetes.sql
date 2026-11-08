CREATE TABLE Bilhete (
    id_bilhete SERIAL,
    data_compra DATE NOT NULL,
    preco_pago NUMERIC(10, 2) NOT NULL,
    comprador VARCHAR(255) NOT NULL,
    ns_serie VARCHAR(50) NULL, -- Compatível com o tamanho do numero_serie da tabela Dispositivo
    
    CONSTRAINT pk_bilhete 
        PRIMARY KEY (id_bilhete),
        
    CONSTRAINT fk_bilhete_comprador 
        FOREIGN KEY (comprador) 
        REFERENCES Utilizador(email) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
        
    CONSTRAINT fk_bilhete_dispositivo 
        FOREIGN KEY (ns_serie) 
        REFERENCES Dispositivo(numero_serie) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE,
        
    -- RIA-12: O preço pago tem de ser positivo
    CONSTRAINT ck_bilhete_preco_positivo 
        CHECK (preco_pago > 0)
);

CREATE TABLE PasseGeral (
    id_bilhete INTEGER,
    nome_festival VARCHAR(100) NOT NULL,
    ano_edicao INTEGER NOT NULL,
    
    CONSTRAINT pk_passe_geral 
        PRIMARY KEY (id_bilhete),
        
    CONSTRAINT fk_passe_geral_bilhete 
        FOREIGN KEY (id_bilhete) 
        REFERENCES Bilhete(id_bilhete) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
        
    -- Chave estrangeira composta para Edicao (nome_festival, ano)
    CONSTRAINT fk_passe_geral_edicao 
        FOREIGN KEY (nome_festival, ano_edicao) 
        REFERENCES Edicao(nome_festival, ano) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
);

CREATE TABLE BilheteDiario (
    id_bilhete INTEGER,
    nome_festival VARCHAR(100) NOT NULL,
    ano_edicao INTEGER NOT NULL,
    data_dia DATE NOT NULL,
    
    CONSTRAINT pk_bilhete_diario 
        PRIMARY KEY (id_bilhete),
        
    CONSTRAINT fk_bilhete_diario_bilhete 
        FOREIGN KEY (id_bilhete) 
        REFERENCES Bilhete(id_bilhete) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
        
    -- Chave estrangeira composta para Dia (nome_festival, ano_edicao, data)
    CONSTRAINT fk_bilhete_diario_dia 
        FOREIGN KEY (nome_festival, ano_edicao, data_dia) 
        REFERENCES Dia(nome_festival, ano_edicao, data) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
);
