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
