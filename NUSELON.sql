-- cria tabela doador
CREATE TABLE IF NOT EXISTS Doador(
	doador_id SERIAL NOT NULL,
	nome VARCHAR (20),
	tipo_Doador VARCHAR (20)
);


-- cria tabela de contemplados
CREATE TABLE IF NOT EXISTS Contemplados(
	contem_id SERIAL NOT NULL,
	nome VARCHAR(20)
);

-- Cria tabela de entradas (recebimento de doações)
CREATE TABLE IF NOT EXISTS Entrada(
	doador_id SERIAL NOT NULL,
	prodNome VARCHAR(30),
	tipo VARCHAR(15),
	quantidade INT,
	nome_doador varchar(50),
	tipo_doador varchar(15),
	data_entrada DATE DEFAULT CURRENT_DATE
);

CREATE TABLE IF NOT EXISTS Saida(
	ordem SERIAL,
	prodNome VARCHAR(30),
	tipo VARCHAR(15),
	quantidade INT,
	data_saida DATE DEFAULT CURRENT_DATE,
	contem_id INTEGER
);

CREATE TABLE IF NOT EXISTS Estoque(
	prod_id SERIAL NOT NULL,
	prodNome VARCHAR(30),
	quantidade INT,
	tipo VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS Backup(
	prod_id int,
	prodNome VARCHAR (25),
	quantidade int,
	tipo varchar(15),
	data timestamp DEFAULT CURRENT_timestamp
);

ALTER TABLE Doador ADD PRIMARY KEY (doador_id);
ALTER TABLE Contemplados ADD PRIMARY KEY (contem_id);


ALTER TABLE Entrada ADD PRIMARY KEY (doador_id);
ALTER TABLE Entrada ADD FOREIGN KEY (doador_id)
	REFERENCES Doador(doador_id) 
		ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Saida ADD PRIMARY KEY (ordem);
ALTER TABLE Saida ADD FOREIGN KEY (contem_id)
	REFERENCES Contemplados(contem_id)
		ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Estoque ADD PRIMARY KEY (prod_id);

--TABELA doador -------------------------------------
INSERT INTO doador(nome,tipo_doador)
VALUES
	('Robersval','Pessoa Fisica'),
	('Pizzaria LaMassa','Pessoa Juridica'),
	('Alessandro','Pessoa Fisica'),
	('Farmacia DrogaMais','Pessoa Juridica'),
	('Marcelo Sucuri','Pessoa Fisica');


INSERT INTO Estoque(prodnome,quantidade,tipo) 
	VALUES
		('arroz','5','ALIMENTO'),
		('feijao','3','ALIMENTO'),
		('detergente','7','LIMPEZA'),
		('pasta de dente','10','HIGIENE'),
		('dorflex','3','MEDICAMENTO');
--TABELA ENTRADA -------------------------------------
INSERT INTO Entrada(doador_id,prodnome,tipo,quantidade,nome_doador,tipo_doador) 
VALUES
	(1,'macarrao','ALIMENTO',12,'Robersval','Pessoa Fisica'),
	(2,'pizza','ALIMENTO',3,'Pizzaria LaMassa','Pessoa Juridica'),
	(3,'pix','DINHEIRO',2000,'Alessandro','Pessoa Fisica'),
	(4,'xarope','MEDICAMENTO',10,'Farmacia DrogaMais','Pessoa Juridica'),
	(5,'amaciante','LIMPEZA',2,'Marcelo Sucuri','Pessoa Fisica');
--TABELA contemplados -------------------------------------
INSERT INTO contemplados(nome) 
VALUES	('Patricia'),
		('Carlos'),
		('Anderson'),
		('Priscila'),
		('Marcos');
--TABELA SAIDA -------------------------------------
INSERT INTO Saida(prodnome,tipo,quantidade, contem_id) 
VALUES
	('arroz','ALIMENTO',2,1),
	('feijao','ALIMENTO',2,2),
	('dorflex','MEDICAMENTO',1,3),
	('detergente','LIMPEZA',2,4),
	('macarrao','ALIMENTO',5,5);
	


/* triggers e funcao para o controle de backup */
CREATE OR REPLACE FUNCTION BACKUP_EST() RETURNS TRIGGER AS $$
begin
	insert into Backup(prod_id,prodNome,quantidade,tipo)
	values (old.prod_id,old.prodNome,old.quantidade,old.tipo);
	return old;
end; $$ LANGUAGE PLPGSQL;

CREATE TRIGGER BACKUP_ESTOQUE AFTER
DELETE ON estoque
FOR EACH ROW EXECUTE PROCEDURE BACKUP_EST();


--funcão para as inserções de saída
CREATE OR REPLACE FUNCTION controle_estoques() RETURNS TRIGGER AS $$
DECLARE
    quantidade_estoque INTEGER;
BEGIN
    IF EXISTS (SELECT 1 FROM Estoque WHERE prodNome = NEW.prodNome AND tipo = NEW.tipo) THEN
        SELECT quantidade INTO quantidade_estoque FROM Estoque WHERE prodNome = NEW.prodNome AND tipo = NEW.tipo;
        IF quantidade_estoque >= NEW.quantidade THEN
            UPDATE Estoque SET quantidade = quantidade - NEW.quantidade
            WHERE prodNome = NEW.prodNome AND tipo = NEW.tipo;
            RETURN NEW;
        ELSE
            RAISE EXCEPTION 'A quantidade retirada é maior do que a quantidade disponível no estoque.';
        END IF;
    ELSE
        RAISE EXCEPTION 'O produto não está presente no estoque.';
    END IF;
END;
$$ LANGUAGE plpgsql;

--função para as inserções de entrada
CREATE OR REPLACE FUNCTION controle_estoquee() RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Estoque WHERE prodNome = NEW.prodNome AND tipo = NEW.tipo) THEN
        UPDATE Estoque SET quantidade = quantidade + NEW.quantidade
        WHERE prodNome = NEW.prodNome AND tipo = NEW.tipo;
    ELSE
        INSERT INTO Estoque (prodNome, quantidade, tipo) VALUES (NEW.prodNome, NEW.quantidade, NEW.tipo);
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/* triggers e funcao para o controle do estoque */
CREATE TRIGGER controle_estoqueE AFTER
INSERT ON Entrada
FOR EACH ROW EXECUTE PROCEDURE controle_estoquee();

CREATE TRIGGER controle_estoqueS AFTER
INSERT ON Saida
FOR EACH ROW EXECUTE PROCEDURE controle_estoques();




-- Criacão Índices 

create index I_Entrada on Entrada(doador_id);
create index I_Saida on Saida(ordem);
create index I_Estoque on Estoque(prod_id);
create index I_Doador on Doador(doador_id);

-- Criação de usuario 

CREATE ROLE funcionario;

GRANT SELECT
ON Estoque,Entrada,Saida,doador,contemplados
TO funcionario;


-- View de Quantidade de doaçoes realizadas
CREATE VIEW DoacoesPorDoador AS
SELECT d.doador_id, d.nome, sum(quantidade) AS Quantidade
FROM Doador d, Entrada e
WHERE d.doador_id = e.doador_id
GROUP BY d.doador_id;

-- FUNCTION DA TRIGGER de inserção na view
CREATE OR REPLACE FUNCTION InsereDoacoesPorDoador() RETURNS TRIGGER
AS $$ DECLARE ultimaOrdem INTEGER;  ultimoId INTEGER;
BEGIN
	ultimaOrdem := (select MAX(ordem) FROM Entrada)+1;
	ultimoId := (select MAX(doador_id) FROM Doador)+1;
	
	if ultimaOrdem IS null THEN
		ultimaOrdem := 1;
	END IF;
	
	if ultimoId IS null THEN
		ultimoId := 1;
	END IF;
	
	INSERT INTO Doador VALUES
		(ultimoId, NEW.nome, 'Desconhecido');
	
	INSERT INTO Entrada VALUES
		(ultimaOrdem, null, NEW.quantidade, CURRENT_DATE, NEW.doador_id);
RETURN NEW;
END; $$ LANGUAGE PLPGSQL;

-- Trigger de inserção na view
CREATE OR REPLACE TRIGGER InsereDoacoesPorDoador INSTEAD OF 
INSERT ON DoacoesPorDoador FOR EACH ROW EXECUTE
PROCEDURE InsereDoacoesPorDoador();

-- garantia de inserção e select para o Funcionario
GRANT SELECT,INSERT
ON doacoespordoador
TO funcionario;