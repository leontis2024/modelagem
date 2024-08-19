CREATE TABLE usuario 
( 
 id VARCHAR(5) PRIMARY KEY,  
 nm_usuario VARCHAR(100) constraint nm_usuario_nulo not null,  
 sobrenome VARCHAR(100) constraint sobrenome_nulo not null,  
 email_usuario VARCHAR(100) constraint email_usuario_nulo not null,   
 nr_tel_usuario VARCHAR(20) constraint nr_tel_usuario_nulo not null,  
 dt_nasci_usuario DATE default current_date,  
 biografia VARCHAR(280) default 'Oi, eu estou usando o Leontis!',  
 sexo VARCHAR(20) constraint sexo_nulo not null,  
 apelido VARCHAR(100),  
 senha_usuario VARCHAR(100) constraint senha_usuario_nula not null  
); 

CREATE TABLE genero 
( 
 id VARCHAR(5) PRIMARY KEY,  
 nm_genero VARCHAR(100) constraint nm_genero_nulo not null,  
 introducao VARCHAR(500),  
 desc_genero TEXT constraint ds_genero_nulo not null
); 

CREATE TABLE obra 
( 
 id VARCHAR(5) PRIMARY KEY,  
 ano_inicio VARCHAR(4),  
 ano_final VARCHAR(4),  
 desc_obra TEXT default 'Que obra linda! Não é mesmo?',  
 nm_obra VARCHAR(100) constraint nm_obra_nulo not null,  
 id_genero VARCHAR(5),  
 id_artista VARCHAR(5),  
 id_museu VARCHAR(5)
); 

CREATE TABLE endereco_museu (
    id VARCHAR(5) PRIMARY KEY,
    rua VARCHAR(100) NOT NULL,
    cep VARCHAR(9) NOT NULL,
    num_museu VARCHAR(10) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    ponto_referencia VARCHAR(150)
);

CREATE TABLE museu (
    id VARCHAR(5) PRIMARY KEY,
    nm_museu VARCHAR(100) constraint nm_museu_nulo not null,
    desc_museu TEXT default 'Este museu passou por tanta coisa! Concorda?',
    id_endereco VARCHAR(5) REFERENCES endereco_museu(id),  -- Chave estrangeira para a tabela endereco_museu
    dt_inauguracao DATE default current_date,
    nr_tel_museu VARCHAR(20)
);

CREATE TABLE guia 
( 
 id VARCHAR(5) PRIMARY KEY,  
 titulo_guia VARCHAR(100) constraint titulo_guia_nulo not null,  
 desc_guia TEXT default 'Este guia irá te guiar por esta sala!',  
 id_museu VARCHAR(5)
); 


CREATE TABLE artista 
( 
 id VARCHAR(5) PRIMARY KEY,
 nm_artista VARCHAR(250),  
 dt_nasc_artista DATE,  
 dt_falecimento DATE,  
 local_nasc VARCHAR(150),  
 local_morte VARCHAR(150),  
 desc_artista TEXT  
); 

CREATE TABLE dia_funcionamento 
( 
 id VARCHAR(5) PRIMARY KEY,
 hr_inicio VARCHAR(20),  
 hr_termino VARCHAR(20),  
 pr_dia_funcionamento FLOAT,  
 dia_semana VARCHAR(30),  
 id_museu VARCHAR(5)
); 

CREATE TABLE usuario_museu 
(
 id VARCHAR(5) PRIMARY KEY,  
 id_museu VARCHAR(5),
 id_usuario VARCHAR(5)
); 

CREATE TABLE obra_guia 
( 
 id VARCHAR(5) PRIMARY KEY,  
 nr_ordem INT, 
 desc_localizacao VARCHAR(500),
 id_guia VARCHAR(5),  
 id_obra VARCHAR(5)  
); 

CREATE TABLE artista_genero 
(
 id VARCHAR(5) PRIMARY KEY,
 id_artista VARCHAR(5),  
 id_genero VARCHAR(5) 
); 

CREATE TABLE usuario_genero 
( 
 id VARCHAR(5) PRIMARY KEY,
 id_usuario VARCHAR(5),  
 id_genero VARCHAR(5)
); 


ALTER TABLE obra 
ADD FOREIGN KEY(id_genero) 
REFERENCES genero (id);

ALTER TABLE obra 
ADD FOREIGN KEY(id_artista) 
REFERENCES artista (id);

ALTER TABLE obra 
ADD FOREIGN KEY(id_museu) 
REFERENCES museu (id);

ALTER TABLE guia 
ADD FOREIGN KEY(id_museu) 
REFERENCES museu (id);

ALTER TABLE dia_funcionamento 
ADD FOREIGN KEY(id_museu) 
REFERENCES museu (id);

ALTER TABLE usuario_museu 
ADD FOREIGN KEY(id_museu) 
REFERENCES museu (id);

ALTER TABLE usuario_museu 
ADD FOREIGN KEY(id_usuario) 
REFERENCES usuario (id);

ALTER TABLE obra_guia
 ADD FOREIGN KEY(id_guia) 
 REFERENCES guia (id);
 
ALTER TABLE obra_guia
 ADD FOREIGN KEY(id_obra) 
 REFERENCES obra (id);

ALTER TABLE artista_genero 
ADD FOREIGN KEY(id_artista) 
REFERENCES artista (id);

ALTER TABLE artista_genero 
ADD FOREIGN KEY(id_genero) 
REFERENCES genero (id);

ALTER TABLE usuario_genero 
ADD FOREIGN KEY(id_usuario) 
REFERENCES usuario (id);

ALTER TABLE usuario_genero 
ADD FOREIGN KEY(id_genero) 
REFERENCES genero (id);


--------------------------------------------------------- Fazendo Inserções ---------------------------------------------------------
												-- Inserindo dados na tabela genero --
INSERT INTO genero (id, nm_genero, introducao, desc_genero)
values
    (1,
     'Neorrealismo',
     'O neorrealismo foi movimento artístico que surgiu no início de século XX que teve influências de movimento políticos como o socialismo, o comunismo e o marxismo.',
     'O neorrealismo foi uma corrente artística de meados do século XX, com um carácter ideológico marcadamente de esquerda marxista, que teve ramificações em várias formas de arte (literatura, pintura, música), mas atingiu o seu expoente máximo no Cinema neorrealista, sobretudo no realismo poético francês e no neorrealismo italiano. Com o mesmo nome, mas com distinção, pode ser observada uma Teoria das relações internacionais.'),
     
    (2,
     'Simbolismo',
     'A poesia simbolista apresenta teor metafísico, musicalidade, alienação social, rigor formal e caráter sinestésico.',
     'Simbolismo é um movimento literário da poesia e das outras artes que surgiu na França, no final do século XIX, como oposição ao realismo, ao naturalismo e ao positivismo da época. Como escola literária, teve suas origens na obra As Flores do Mal, do poeta Charles Baudelaire. Ademais, os trabalhos de Edgar Allan Poe, os quais Baudelaire admirava e traduziu para francês, foram de significativa influência, além de servirem como fontes de diversos tropos e imagens. Fundamentou-se principalmente na subjetividade, no irracional e na análise profunda da mensagem, a partir da sinestesia.');

												-- Inserindo dados na tabela artista --
INSERT INTO artista (id, nm_artista, desc_artista, local_nasc, local_morte, dt_nasc_artista, dt_falecimento)
VALUES
    (1,
     'Cândido Portinari',
     'Candido Portinari OMC foi um artista plástico brasileiro. Portinari pintou mais de cinco mil obras, de pequenos esboços e pinturas de proporções padrão, como O Lavrador de Café, até gigantescos murais, como os painéis Guerra e Paz, presenteados à sede da ONU em Nova Iorque em 1956, e que, em dezembro de 2010, graças aos esforços de seu filho, retornaram para exibição no Teatro Municipal do Rio de Janeiro.',
     'Brodowski, São Paulo',
     'Rio de Janeiro, Rio de Janeiro',
     '1903-12-29',
     '1962-02-06'),
     
    (2,
     'Rodolfo Amoedo',
     'Rodolfo Amoedo foi um pintor, desenhista, professor e decorador brasileiro. Era professor na Escola Nacional de Belas Artes do Rio de Janeiro e foi considerado um ótimo conhecedor das técnicas artísticas.',
     'Salvador, Bahia',
     'Rio de Janeiro, Rio de Janeiro',
     '1857-12-11',
     '1914-05-31');

												-- Inserindo dados na tabela artista_genero --
INSERT INTO artista_genero (id, id_artista, id_genero)
VALUES
    (1,1, 1),
    (2,2, 2);

												-- Inserindo os endereços na tabela endereco_museu --
INSERT INTO endereco_museu (id, rua, cep, num_museu, cidade, estado, ponto_referencia)
VALUES
    (1, 'Av. Paulista', '01310-200', '1578', 'Bela Vista, São Paulo', 'SP', ''),
    (2, 'Av. Rio Branco', '20040-008', '199', 'Centro, Rio de Janeiro', 'RJ', '');

												-- Inserindo os museus na tabela museu --
INSERT INTO museu (id, nm_museu, desc_museu, id_endereco, nr_tel_museu, dt_inauguracao)
VALUES
    (1,
     'Museu de Arte de São Paulo Assis Chateaubriand',
     'Museu de Arte de São Paulo Assis Chateaubriand é um centro cultural e museu de arte brasileiro fundado em 1947 pelo empresário e jornalista paraibano Assis Chateaubriand. Entre os anos de 1947 e 1990, o crítico e marchand italiano Pietro Bardi assumiu a direção do MASP a convite de Chateaubriand.',
     '1',
     '(11) 3149-5959',
     '1947-01-01'),

    (2,
     'Museu Nacional de Belas Artes',
     'O Museu Nacional de Belas Artes é um museu de arte localizado na cidade do Rio de Janeiro, no Brasil. Concentra o maior acervo de obras de arte do século XIX, sendo um dos mais importantes museus do gênero no país.',
     '2',
     '(21) 2219-8474',
     '1937-01-01');


												-- Inserindo dados na tabela dia_funcionamento --
INSERT INTO dia_funcionamento (id,id_museu, dia_semana, pr_dia_funcionamento, hr_inicio, hr_termino)
VALUES
    (1,1, 'Quarta', 50.00, '10:00', '18:00'),
    (2,1, 'Quinta', 70.00, '10:00', '18:00'),
    (3,1, 'Sexta', 70.00, '10:00', '18:00'),
    (4,1, 'Sábado', 70.00, '10:00', '18:00'),
    (5,1, 'Domingo', 70.00, '10:00', '18:00'),
    (6,1, 'Terça', 60.00, '10:00', '20:00'),
    (7,2, 'Terça', 0.00, '10:00', '18:00'),
    (8,2, 'Quarta', 0.00, '10:00', '18:00'),
    (9,2, 'Quinta', 0.00, '10:00', '18:00'),
    (10,2, 'Sexta', 0.00, '10:00', '18:00'),
    (11,2, 'Sábado', 0.00, '12:00', '17:00'),
    (12,2, 'Domingo', 0.00, '12:00', '17:00');

												-- Inserindo dados na tabela obra --
INSERT INTO obra (id,nm_obra, desc_obra, ano_inicio, ano_final, id_genero, id_artista, id_museu)
VALUES
    (1,
     'Más Notícias',
     'Más Notícias é uma obra de arte feita por Rodolfo Amoedo em 1895. Retrata uma mulher sentada em uma poltrona, com o olhar direcionado para a frente, encarando quem a observa.',
     NULL,
     '1895',
     2,
     2,
     2),
     
    (2,
     'Lavrador de Café',
     'O Lavrador de Café é uma obra de Cândido Portinari. Atualmente, pertence ao acervo do MASP. É uma pintura a óleo sobre tela, datada de 1934.',
     NULL,
     '1934',
     1,
     1,
     1),
     
    (3,
     'Obra 1',
     'Primeira obra do guia.',
     NULL,
     '1999',
     1,
     1,
     1),
     
    (4,
     'Obra 2',
     'Segunda obra do guia.',
     NULL,
     '1999',
     2,
     2,
     1),
     
    (5,
     'Obra 3',
     'Terceira obra do guia.',
     NULL,
     '1999',
     1,
     2,
     1),
     
    (6,
     'Obra 4',
     'Quarta obra do guia.',
     NULL,
     '1999',
     2,
     1,
     1);

												-- Inserindo dados na tabela guia --
INSERT INTO guia (id,titulo_guia, desc_guia, id_museu)
VALUES
    (1,'Guia lindo', 'Obras legais e maravilhosas', 1);

												-- Inserindo dados na tabela obra_guia --
INSERT INTO obra_guia (id,id_guia, id_obra, nr_ordem, desc_localizacao)
VALUES
    (1,1, 3, 1,'Seguindo corredor principal, na sessão de obras do simbolismo'),
    (2,1, 4, 2,'Duas pinturas a esqueda de “A dama de vermelho'),
    (3,1, 5, 3,'Seguindo o corredor ao lado dos sanitários, é a terceira obra de arte'),
    (4,1, 6, 4,'A pintura esta na sessão central do meuseu, ela esta exposta em local aberto');

												-- Inserindo dados na tabela usuario --
INSERT INTO usuario (id,nm_usuario, sobrenome, apelido, sexo, email_usuario, nr_tel_usuario, senha_usuario, dt_nasci_usuario)
VALUES
    (1,'Ana Beatriz', 'Almeida', 'Ana Bea', 'Feminino', 'email@gmail.com', '(11) 98765-4321', 'senha1234@', '2007-09-12');

												-- Inserindo dados na tabela usuario_genero --
INSERT INTO usuario_genero (id,id_usuario, id_genero)
VALUES
    (1,1, 1),
    (2,1, 2);

												-- Inserindo dados na tabela usuario_museu --
INSERT INTO usuario_museu (id,id_museu, id_usuario)
VALUES
    (1,2, 1);

 
-------------------------------------------------------- Criando tabelas de log -------------------------------------------------------

													-- Criação de tabelas de log --
CREATE TABLE log_usuario (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario INT,
    nm_usuario VARCHAR(100),
    sobrenome VARCHAR(100),
    email_usuario VARCHAR(100),
    nr_tel_usuario VARCHAR(20),
    dt_nasci_usuario DATE,
    biografia VARCHAR(280),
    sexo VARCHAR(20),
    apelido VARCHAR(100),
    senha_usuario VARCHAR(100)
);


CREATE TABLE log_genero (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_genero INT,
    nm_genero VARCHAR(100),
    introducao VARCHAR(500),
    desc_genero TEXT
);

CREATE TABLE log_obra (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_obra INT,
    ano_inicio VARCHAR(4),
    ano_final VARCHAR(4),
    desc_obra TEXT,
    nm_obra VARCHAR(100),
    id_genero INT,
    id_artista INT,
    id_museu INT
);

CREATE TABLE log_museu (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_museu INT,
    nm_museu VARCHAR(100),
    desc_museu TEXT,
    id_endereco INT,
    dt_inauguracao DATE,
    nr_tel_museu VARCHAR(20)
);

CREATE TABLE log_endereco (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_endereco INT,
    rua VARCHAR(100),
    cep VARCHAR(9),
    num_museu VARCHAR(10),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    ponto_referencia VARCHAR(150)
);

CREATE TABLE log_guia (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_guia INT,
    titulo_guia VARCHAR(100),
    desc_guia TEXT,
    id_museu INT
);

CREATE TABLE log_artista (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_artista INT,
    nm_artista VARCHAR(250),
    dt_nasc_artista DATE,
    dt_falecimento DATE,
    local_nasc VARCHAR(150),
    local_morte VARCHAR(150),
    desc_artista TEXT
);

CREATE TABLE log_dia_funcionamento (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_dia_funcionamento INT,
    hr_inicio VARCHAR(20),
    hr_termino VARCHAR(20),
    pr_dia_funcionamento FLOAT,
    dia_semana VARCHAR(30),
    id_museu INT
);

CREATE TABLE log_usuario_museu (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario_museu INT,
    id_museu INT,
    id_usuario INT
);

CREATE TABLE log_obra_guia (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_obra_guia INT,
    nr_ordem INT,
    desc_localizacao VARCHAR(500),
    id_guia INT,
    id_obra INT
);

CREATE TABLE log_artista_genero (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_artista_genero INT,
    id_artista INT,
    id_genero INT
);

CREATE TABLE log_usuario_genero (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario_genero INT,
    id_usuario INT,
    id_genero INT
);


--------------------------------------------------- Criação de Triggers para Log das tabelas --------------------------------------------------- 

													-- Trigger para a tabela usuário --
												
CREATE OR REPLACE FUNCTION log_usuario_operation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_usuario (operacao, data_operacao, id_usuario, nm_usuario, sobrenome, email_usuario, nr_tel_usuario, dt_nasci_usuario, biografia, sexo, apelido, senha_usuario)
        VALUES ('INSERT', NOW(), NEW.id, NEW.nm_usuario, NEW.sobrenome, NEW.email_usuario, NEW.nr_tel_usuario, NEW.dt_nasci_usuario, NEW.biografia, NEW.sexo, NEW.apelido, NEW.senha_usuario);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_usuario (operacao, data_operacao, id_usuario, nm_usuario, sobrenome, email_usuario, nr_tel_usuario, dt_nasci_usuario, biografia, sexo, apelido, senha_usuario)
        VALUES ('UPDATE', NOW(), NEW.id, NEW.nm_usuario, NEW.sobrenome, NEW.email_usuario, NEW.nr_tel_usuario, NEW.dt_nasci_usuario, NEW.biografia, NEW.sexo, NEW.apelido, NEW.senha_usuario);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_usuario (operacao, data_operacao, id_usuario, nm_usuario, sobrenome, email_usuario, nr_tel_usuario, dt_nasci_usuario, biografia, sexo, apelido, senha_usuario)
        VALUES ('DELETE', NOW(), OLD.id, OLD.nm_usuario, OLD.sobrenome, OLD.email_usuario, OLD.nr_tel_usuario, OLD.dt_nasci_usuario, OLD.biografia, OLD.sexo, OLD.apelido, OLD.senha_usuario);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_log_usuario
AFTER INSERT OR UPDATE OR DELETE ON usuario
FOR EACH ROW
EXECUTE FUNCTION log_usuario_operation();

													-- Trigger para a tabela genero --
												
CREATE OR REPLACE FUNCTION log_genero_operation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_genero (operacao, data_operacao, id_genero, nm_genero, introducao, desc_genero)
        VALUES ('INSERT', NOW(), NEW.id, NEW.nm_genero, NEW.introducao, NEW.desc_genero);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_genero (operacao, data_operacao, id_genero, nm_genero, introducao, desc_genero)
        VALUES ('UPDATE', NOW(), NEW.id, NEW.nm_genero, NEW.introducao, NEW.desc_genero);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_genero (operacao, data_operacao, id_genero, nm_genero, introducao, desc_genero)
        VALUES ('DELETE', NOW(), OLD.id, OLD.nm_genero, OLD.introducao, OLD.desc_genero);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_log_genero
AFTER INSERT OR UPDATE OR DELETE ON genero
FOR EACH ROW
EXECUTE FUNCTION log_genero_operation();

													-- Trigger para a tabela obra --
												
CREATE OR REPLACE FUNCTION log_obra_operation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_obra (operacao, data_operacao, id_obra, ano_inicio, ano_final, desc_obra, nm_obra, id_genero, id_artista, id_museu)
        VALUES ('INSERT', NOW(), NEW.id, NEW.ano_inicio, NEW.ano_final, NEW.desc_obra, NEW.nm_obra, NEW.id_genero, NEW.id_artista, NEW.id_museu);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_obra (operacao, data_operacao, id_obra, ano_inicio, ano_final, desc_obra, nm_obra, id_genero, id_artista, id_museu)
        VALUES ('UPDATE', NOW(), NEW.id, NEW.ano_inicio, NEW.ano_final, NEW.desc_obra, NEW.nm_obra, NEW.id_genero, NEW.id_artista, NEW.id_museu);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_obra (operacao, data_operacao, id_obra, ano_inicio, ano_final, desc_obra, nm_obra, id_genero, id_artista, id_museu)
        VALUES ('DELETE', NOW(), OLD.id, OLD.ano_inicio, OLD.ano_final, OLD.desc_obra, OLD.nm_obra, OLD.id_genero, OLD.id_artista, OLD.id_museu);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_log_obra
AFTER INSERT OR UPDATE OR DELETE ON obra
FOR EACH ROW
EXECUTE FUNCTION log_obra_operation();

													-- Trigger para a tabela museu --
												
CREATE OR REPLACE FUNCTION log_museu_operation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_museu (operacao, data_operacao, id_museu, nm_museu, desc_museu, id_endereco, dt_inauguracao, nr_tel_museu)
        VALUES ('INSERT', NOW(), NEW.id, NEW.nm_museu, NEW.desc_museu, NEW.id_endereco, NEW.dt_inauguracao, NEW.nr_tel_museu);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_museu (operacao, data_operacao, id_museu, nm_museu, desc_museu, id_endereco, dt_inauguracao, nr_tel_museu)
        VALUES ('UPDATE', NOW(), NEW.id, NEW.nm_museu, NEW.desc_museu, NEW.id_endereco, NEW.dt_inauguracao, NEW.nr_tel_museu);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_museu (operacao, data_operacao, id_museu, nm_museu, desc_museu, id_endereco, dt_inauguracao, nr_tel_museu)
        VALUES ('DELETE', NOW(), OLD.id, OLD.nm_museu, OLD.desc_museu, OLD.id_endereco, OLD.dt_inauguracao, OLD.nr_tel_museu);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_log_museu
AFTER INSERT OR UPDATE OR DELETE ON museu
FOR EACH ROW
EXECUTE FUNCTION log_museu_operation();

													-- Trigger para a tabela endereco_museu --
												
CREATE OR REPLACE FUNCTION log_endereco_operation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_endereco (operacao, data_operacao, id_endereco, rua, cep, num_museu, cidade, estado, ponto_referencia)
        VALUES ('INSERT', NOW(), NEW.id, NEW.rua, NEW.cep, NEW.num_museu, NEW.cidade, NEW.estado, NEW.ponto_referencia);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_endereco (operacao, data_operacao, id_endereco, rua, cep, num_museu, cidade, estado, ponto_referencia)
        VALUES ('UPDATE', NOW(), NEW.id, NEW.rua, NEW.cep, NEW.num_museu, NEW.cidade, NEW.estado, NEW.ponto_referencia);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_endereco (operacao, data_operacao, id_endereco, rua, cep, num_museu, cidade, estado, ponto_referencia)
        VALUES ('DELETE', NOW(), OLD.id, OLD.rua, OLD.cep, OLD.num_museu, OLD.cidade, OLD.estado, OLD.ponto_referencia);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_log_endereco
AFTER INSERT OR UPDATE OR DELETE ON endereco_museu
FOR EACH ROW
EXECUTE FUNCTION log_endereco_operation();

													-- Trigger para a tabela guia --
												
CREATE OR REPLACE FUNCTION log_guia_operation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_guia (operacao, data_operacao, id_guia, titulo_guia, desc_guia, id_museu)
        VALUES ('INSERT', NOW(), NEW.id, NEW.titulo_guia, NEW.desc_guia, NEW.id_museu);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_guia (operacao, data_operacao, id_guia, titulo_guia, desc_guia, id_museu)
        VALUES ('UPDATE', NOW(), NEW.id, NEW.titulo_guia, NEW.desc_guia, NEW.id_museu);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_guia (operacao, data_operacao, id_guia, titulo_guia, desc_guia, id_museu)
        VALUES ('DELETE', NOW(), OLD.id, OLD.titulo_guia, OLD.desc_guia, OLD.id_museu);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_log_guia
AFTER INSERT OR UPDATE OR DELETE ON guia
FOR EACH ROW
EXECUTE FUNCTION log_guia_operation();

													-- Trigger para a tabela artista --
												
CREATE OR REPLACE FUNCTION log_artista_operation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_artista (operacao, data_operacao, id_artista, nm_artista, dt_nasc_artista, dt_falecimento, local_nasc, local_morte, desc_artista)
        VALUES ('INSERT', NOW(), NEW.id, NEW.nm_artista, NEW.dt_nasc_artista, NEW.dt_falecimento, NEW.local_nasc, NEW.local_morte, NEW.desc_artista);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_artista (operacao, data_operacao, id_artista, nm_artista, dt_nasc_artista, dt_falecimento, local_nasc, local_morte, desc_artista)
        VALUES ('UPDATE', NOW(), NEW.id, NEW.nm_artista, NEW.dt_nasc_artista, NEW.dt_falecimento, NEW.local_nasc, NEW.local_morte, NEW.desc_artista);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_artista (operacao, data_operacao, id_artista, nm_artista, dt_nasc_artista, dt_falecimento, local_nasc, local_morte, desc_artista)
        VALUES ('DELETE', NOW(), OLD.id, OLD.nm_artista, OLD.dt_nasc_artista, OLD.dt_falecimento, OLD.local_nasc, OLD.local_morte, OLD.desc_artista);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_log_artista
AFTER INSERT OR UPDATE OR DELETE ON artista
FOR EACH ROW
EXECUTE FUNCTION log_artista_operation();

													-- Trigger para a tabela dia_funcionamento --
												
CREATE OR REPLACE FUNCTION log_dia_funcionamento_operation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_dia_funcionamento (operacao, data_operacao, id_dia_funcionamento, hr_inicio, hr_termino, pr_dia_funcionamento, dia_semana, id_museu)
        VALUES ('INSERT', NOW(), NEW.id, NEW.hr_inicio, NEW.hr_termino, NEW.pr_dia_funcionamento, NEW.dia_semana, NEW.id_museu);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_dia_funcionamento (operacao, data_operacao, id_dia_funcionamento, hr_inicio, hr_termino, pr_dia_funcionamento, dia_semana, id_museu)
        VALUES ('UPDATE', NOW(), NEW.id, NEW.hr_inicio, NEW.hr_termino, NEW.pr_dia_funcionamento, NEW.dia_semana, NEW.id_museu);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_dia_funcionamento (operacao, data_operacao, id_dia_funcionamento, hr_inicio, hr_termino, pr_dia_funcionamento, dia_semana, id_museu)
        VALUES ('DELETE', NOW(), OLD.id, OLD.hr_inicio, OLD.hr_termino, OLD.pr_dia_funcionamento, OLD.dia_semana, OLD.id_museu);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_log_dia_funcionamento
AFTER INSERT OR UPDATE OR DELETE ON dia_funcionamento
FOR EACH ROW
EXECUTE FUNCTION log_dia_funcionamento_operation();

													-- Trigger para a tabela usuario_museu --
												
CREATE OR REPLACE FUNCTION log_usuario_museu_operation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_usuario_museu (operacao, data_operacao, id_usuario_museu, id_museu, id_usuario)
        VALUES ('INSERT', NOW(), NEW.id, NEW.id_museu, NEW.id_usuario);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_usuario_museu (operacao, data_operacao, id_usuario_museu, id_museu, id_usuario)
        VALUES ('UPDATE', NOW(), NEW.id, NEW.id_museu, NEW.id_usuario);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_usuario_museu (operacao, data_operacao, id_usuario_museu, id_museu, id_usuario)
        VALUES ('DELETE', NOW(), OLD.id, OLD.id_museu, OLD.id_usuario);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_log_usuario_museu
AFTER INSERT OR UPDATE OR DELETE ON usuario_museu
FOR EACH ROW
EXECUTE FUNCTION log_usuario_museu_operation();

													-- Trigger para a tabela obra_guia --
												
CREATE OR REPLACE FUNCTION log_obra_guia_operation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_obra_guia (operacao, data_operacao, id_obra_guia, nr_ordem, desc_localizacao, id_guia, id_obra)
        VALUES ('INSERT', NOW(), NEW.id, NEW.nr_ordem, NEW.desc_localizacao, NEW.id_guia, NEW.id_obra);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_obra_guia (operacao, data_operacao, id_obra_guia, nr_ordem, desc_localizacao, id_guia, id_obra)
        VALUES ('UPDATE', NOW(), NEW.id, NEW.nr_ordem, NEW.desc_localizacao, NEW.id_guia, NEW.id_obra);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_obra_guia (operacao, data_operacao, id_obra_guia, nr_ordem, desc_localizacao, id_guia, id_obra)
        VALUES ('DELETE', NOW(), OLD.id, OLD.nr_ordem, OLD.desc_localizacao, OLD.id_guia, OLD.id_obra);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_log_obra_guia
AFTER INSERT OR UPDATE OR DELETE ON obra_guia
FOR EACH ROW
EXECUTE FUNCTION log_obra_guia_operation();

													-- Trigger para a tabela artista_genero --
												
CREATE OR REPLACE FUNCTION log_artista_genero_operation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_artista_genero (operacao, data_operacao, id_artista_genero, id_artista, id_genero)
        VALUES ('INSERT', NOW(), NEW.id, NEW.id_artista, NEW.id_genero);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_artista_genero (operacao, data_operacao, id_artista_genero, id_artista, id_genero)
        VALUES ('UPDATE', NOW(), NEW.id, NEW.id_artista, NEW.id_genero);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_artista_genero (operacao, data_operacao, id_artista_genero, id_artista, id_genero)
        VALUES ('DELETE', NOW(), OLD.id, OLD.id_artista, OLD.id_genero);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_log_artista_genero
AFTER INSERT OR UPDATE OR DELETE ON artista_genero
FOR EACH ROW
EXECUTE FUNCTION log_artista_genero_operation();

													-- Trigger para a tabela usuario_genero --

CREATE OR REPLACE FUNCTION log_usuario_genero_operation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_usuario_genero (operacao, data_operacao, id_usuario_genero, id_usuario, id_genero)
        VALUES ('INSERT', NOW(), NEW.id, NEW.id_usuario, NEW.id_genero);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_usuario_genero (operacao, data_operacao, id_usuario_genero, id_usuario, id_genero)
        VALUES ('UPDATE', NOW(), NEW.id, NEW.id_usuario, NEW.id_genero);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_usuario_genero (operacao, data_operacao, id_usuario_genero, id_usuario, id_genero)
        VALUES ('DELETE', NOW(), OLD.id, OLD.id_usuario, OLD.id_genero);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_log_usuario_genero
AFTER INSERT OR UPDATE OR DELETE ON usuario_genero
FOR EACH ROW
EXECUTE FUNCTION log_usuario_genero_operation();

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- Drops
drop table artista cascade
drop table artista_genero cascade
drop table dia_funcionamento cascade
drop table genero cascade
drop table guia cascade
drop table endereco_museu cascade
drop table museu cascade
drop table obra cascade
drop table obra_guia cascade
drop table usuario cascade
drop table usuario_genero cascade
drop table usuario_museu cascade

--------------------------------------------------------------------------------------------------------------------------------------------------------

-- Selects

select * from artista
select * from artista_genero
select * from dia_funcionamento
select * from genero
select * from guia
select * from endereco_museu
select * from museu
select * from obra
select * from obra_guia
select * from usuario
select * from usuario_genero
select * from usuario_museu



