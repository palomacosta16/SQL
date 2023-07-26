CREATE DATABASE LOJA; 
USE LOJA; 

CREATE TABLE CLIENTE_REL (
	CODCLI NUMERIC(15),
    RUA VARCHAR(100),
    CIDADE VARCHAR(100),
    ESTADO CHAR(2),
    CEP CHAR(10),
    FONE1 VARCHAR(20),
    FONE2 VARCHAR(20),
    FONE3 VARCHAR(20),
    PRIMARY KEY (CODCLI)
); 

CREATE TABLE CLIENTE_VIP_REL (
	CODCLI NUMERIC(15),
    PONTOS_BONIFICACAO INT,
    DESCONTO_PADRAO NUMERIC (5,2),
    PRIMARY KEY (CODCLI),
    FOREIGN KEY (CODCLI) REFERENCES CLIENTE_REL(CODCLI)
);

CREATE TABLE CLIENTE_ESPECIAL_REL (
	CODCLI NUMERIC(15),
    DESCONTO_PADRAO NUMERIC (5,2),
    PRIMARY KEY (CODCLI),
    FOREIGN KEY (CODCLI) REFERENCES CLIENTE_REL (CODCLI)
    );

CREATE TABLE PEDIDO_REL (
	CODPED NUMERIC (20),
    DATA_PEDIDO DATE,
    DATA_ENTREGA DATE,
    RUA VARCHAR (100),
    CIDADE VARCHAR (100),
    CEP CHAR (10),
    CODCLI NUMERIC (15),
    PRIMARY KEY (CODPED),
    FOREIGN KEY (CODCLI) REFERENCES CLIENTE_REL (CODCLI)
);

CREATE TABLE MERCADORIA_REL (
	CODMER NUMERIC(15),
    PRECO NUMERIC(15,2),
    ICMS NUMERIC(5,2),
    PRIMARY KEY (CODMER)
);

CREATE TABLE ITEM_PEDIDO_REL (
	NO_ITEM NUMERIC (5),
    CODPED NUMERIC (20),
    QUANTIDADE NUMERIC(15,2),
    DESCONTO NUMERIC (5,2),
    CODMER NUMERIC (15),
    PRIMARY KEY (NO_ITEM,CODPED), 
    FOREIGN KEY (CODPED) REFERENCES PEDIDO_REL(CODPED),
    FOREIGN KEY (CODMER) REFERENCES MERCADORIA_REL(CODMER)
);

INSERT INTO CLIENTE_REL
VALUES (1,'RUA A', 'BRASILIA','DF', '1223-030','111','222','333','JOAO');

INSERT INTO CLIENTE_REL
VALUES (2,'RUA A', 'BRASILIA','DF', '1223-030','111','222','333','JOSE');

INSERT INTO CLIENTE_REL
VALUES (3,'RUA A', 'BRASILIA','DF', NULL,'111','222','333','JOAQUIM');

INSERT INTO CLIENTE_REL
VALUES (4,'RUA D', 'BRASILIA','DF', NULL,'111','222','333','JUNIOR');

INSERT INTO CLIENTE_VIP_REL
VALUES  (3, 10,5);

INSERT INTO CLIENTE_ESPECIAL_REL
VALUES (4, 20);

INSERT INTO MERCADORIA_REL 
VALUES (1, 10.00, 5);
 
INSERT INTO MERCADORIA_REL 
VALUES (2, 20.00, 10);

INSERT INTO MERCADORIA_REL 
VALUES (3, 50.00, 15);

INSERT INTO PEDIDO_REL
VALUES (1,'2023-06-27', '2023-06-27', 'RUA X', 'BRASILIA','DF', '67890-030', 2);

INSERT INTO PEDIDO_REL
VALUES (2,'2023-06-20', '2023-06-27', 'RUA Y', 'BRASILIA','DF', '67890-030', 1);

INSERT INTO PEDIDO_REL
VALUES (3, '2023-05-20', '2023-05-27', 'RUA B', 'BRASILIA','DF','67890-038', 3)


DROP TABLE PEDIDO; #DELETA

ALTER TABLE CLIENTE_REL ADD COLUMN NOME VARCHAR(100); #ALTERA 

SELECT * FROM CLIENTE_REL
WHERE RUA = 'RUA A'; #FILTRA LINHAS 

SELECT * FROM CLIENTE_REL 
WHERE FONE1 IS NOT NULL #O NULL É UM ESTADO, USA-SE APENA O IS NULL OU NOT NULL
AND FONE2 IS NULL
AND FONE3 IS NOT NULL;

SELECT CODCLI FROM CLIENTE_REL #APENAS PARA COLUNAS, SUBSTITU APENAS O *
WHERE FONE1 IS NOT NULL 
AND FONE2 IS NULL
AND FONE3 IS NOT NULL;

SELECT * FROM MERCADORIA_REL 
WHERE ICMS >= 10 AND ICMS <= 50;

SELECT NOME, CODCLI, FONE1, FONE2, FONE3
FROM CLIENTE_REL
WHERE ESTADO = 'CE'
AND CIDADE = 'ICÓ';

#COMANDOS DE JUNÇÃO DE TABELAS, COMBINAR LINHAS E TABELAS. RECUPERAR DADOS. APENAS DE 2 EM 2.
SELECT CV.*, C.*
FROM CLIENTE_VIP_REL CV, PEDIDO_REL P, CLIENTE_REL C
WHERE CV.CODCLI = P.CODCLI
AND C.CODCLI = CV.CODCLI;

#ALIASE - RELACIONAMENTO 
SELECT M.CODMER, M.PRECO
FROM MERCADORIA_REL M, ITEM_PEDIDO_REL IP, PEDIDO_REL P
WHERE M.CODMER = IP.CODMER
AND IP.CODPED = P.CODPED 
AND P.CODCLI = CE.CODCLI
AND C.CODCLI = CE.CODCLI;






