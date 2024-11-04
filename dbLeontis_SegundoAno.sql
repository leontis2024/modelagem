-- Criação do Banco/Normalização do Banco.

-- Vale ressaltar que as tabelas antigas sem a normalização, se encontram no script do banco do primeiro ano, também presente no github. 
--------------------------------------------------------------------------

-- A tabela `usuario` armazena informações pessoais dos usuários. Vamos analisar a normalização:
-- 1NF (Primeira Forma Normal): A tabela está na 1NF porque todas as colunas contêm valores atômicos, ou seja, cada coluna contém um único valor, sem listas ou grupos de valores. Por exemplo, o campo `nm_usuario` contém um único nome de usuário, sem qualquer repetição de dados ou divisão em múltiplas partes.
-- 2NF (Segunda Forma Normal): A tabela está na 2NF porque todos os atributos não-chave dependem da chave primária `id`. Não há dependências parciais, o que significa que não existe uma combinação de colunas que poderia ser usada como chave primária para parte dos dados. Todos os campos, como `email_usuario` e `nr_tel_usuario`, dependem exclusivamente do `id` do usuário.
-- 3NF (Terceira Forma Normal): A tabela está na 3NF porque não há dependências transitivas. Isso significa que cada atributo não-chave depende unicamente da chave primária e não de outros atributos não-chave. Por exemplo, o `email_usuario` depende diretamente do `id` e não de outra coluna, como `nm_usuario`. Essa estrutura minimiza a redundância e o risco de inconsistências nos dados.
-- Justificativa: Manter todas as informações do usuário em uma única tabela faz sentido aqui porque cada atributo é exclusivo para o usuário e não se repete em outras entidades. Isso simplifica o design do banco de dados, facilita as consultas e garante que os dados pessoais do usuário estejam centralizados em um único lugar.

-- Tendo em vista que os dados nessa tabela se tratam apenas sobre o usuário, dados que são totalmente dele, não há necessidade
-- de separar informações como (e-mail, telefone, etc) em tabelas distintas.

CREATE TABLE usuario 
( 
 id BIGINT PRIMARY KEY,  
 nm_usuario VARCHAR(100) constraint nm_usuario_nulo not null,  
 sobrenome VARCHAR(100) constraint sobrenome_nulo not null,  
 email_usuario VARCHAR(100) constraint email_usuario_nulo not null,   
 nr_tel_usuario VARCHAR(20) constraint nr_tel_usuario_nulo not null,  
 dt_nasci_usuario DATE default current_date,  
 biografia VARCHAR(280) default 'Oi, eu estou usando o Leontis!',  
 sexo VARCHAR(1) constraint sexo_nulo not null,  
 apelido VARCHAR(100),  
 senha_usuario VARCHAR(100) constraint senha_usuario_nula not null,
 url_imagem VARCHAR(500) 
); 

--------------------------------------------------------------------------
-- A tabela `genero` armazena informações sobre os diferentes gêneros artísticos. A normalização está detalhada abaixo:
-- 1NF: A tabela atende à 1NF porque cada coluna contém valores atômicos. Não há repetição de grupos de valores, e cada coluna armazena um único tipo de informação. Por exemplo, `nm_genero` armazena apenas o nome do gênero, sem listas ou valores combinados.
-- 2NF: A tabela está na 2NF porque todos os atributos dependem da chave primária `id`. Não há colunas que dependam de uma parte da chave primária, já que `id` é uma chave simples e todas as outras colunas são relacionadas diretamente a ela.
-- 3NF: A tabela está na 3NF porque não há dependências transitivas. Isso significa que cada coluna não-chave, como `desc_genero`, depende apenas da chave primária e não de outras colunas na tabela. Por exemplo, `desc_genero` não depende de `nm_genero`, mas sim diretamente de `id`.
-- Justificativa: A normalização desta tabela evita redundâncias e garante que cada gênero artístico seja representado de forma única e consistente. Isso facilita a manutenção dos dados e a realização de consultas eficientes e precisas.

CREATE TABLE genero 
( 
 id BIGINT PRIMARY KEY,  
 nm_genero VARCHAR(100) constraint nm_genero_nulo not null,  
 introducao VARCHAR(500),  
 desc_genero TEXT constraint ds_genero_nulo not null,
 url_imagem VARCHAR(500) 
); 

--------------------------------------------------------------------------
-- A tabela `obra` armazena informações sobre as obras de arte, incluindo suas associações com gêneros, artistas e museus.
-- Normalização:
-- 1NF: Todos os valores são atômicos e indivisíveis. As colunas como `nm_obra`, `ano_inicio`, e `ano_final` contêm informações únicas e específicas sobre cada obra.
-- 2NF: Todos os atributos nesta tabela dependem totalmente da chave primária `id`, o que significa que não há dependências parciais. A obra é identificada exclusivamente por `id`, e atributos como `nm_obra` e `desc_obra` são diretamente dependentes dessa chave primária.
-- 3NF: Não há dependências transitivas. Todas as colunas dependem diretamente da chave primária. As referências a `genero`, `artista` e `museu` são feitas por meio de chaves estrangeiras (`id_genero`, `id_artista`, `id_museu`), garantindo que essas associações sejam mantidas de forma clara e sem redundância.
-- Justificativa: A tabela `obra` está organizada de forma que qualquer dado relacionado a uma obra (como seu gênero, artista e museu) seja referenciado externamente, evitando duplicação e assegurando que cada obra tenha uma única representação clara e direta.

CREATE TABLE obra 
( 
 id BIGINT PRIMARY KEY,  
 ano_inicio VARCHAR(4),  
 ano_final VARCHAR(4),  
 desc_obra TEXT default 'Que obra linda! Não é mesmo?',  
 nm_obra VARCHAR(100) constraint nm_obra_nulo not null,  
 id_genero BIGINT,  
 id_artista BIGINT,  
 id_museu BIGINT,
 url_imagem VARCHAR(500) 
); 

--------------------------------------------------------------------------
-- A tabela `endereco_museu` armazena informações de endereço dos museus.
-- Normalização:
-- 1NF: Todos os valores são atômicos e específicos, como `rua`, `cep`, `num_museu`, `cidade`, etc. Não há agrupamento de informações em uma única coluna.
-- 2NF: Todos os atributos dependem exclusivamente da chave primária `id`, que identifica cada endereço de forma única. Por exemplo, `cep` e `rua` são específicos ao `id` do endereço.
-- 3NF: Não há dependências transitivas entre as colunas. Cada coluna fornece informações diretas sobre o endereço identificado pela chave primária `id`.
-- Justificativa: Ao separar o endereço do museu em uma tabela distinta, evitamos a duplicação de dados de endereço em outras tabelas, como `museu`. Isso melhora a integridade dos dados e facilita a manutenção, como atualizar um endereço sem afetar outras partes do banco de dados.

CREATE TABLE endereco_museu (
    id INT PRIMARY KEY,
    rua VARCHAR(100) NOT NULL,
    cep VARCHAR(20) NOT NULL,
    num_museu VARCHAR(10) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    ponto_referencia VARCHAR(150)
);

select * from endereco_museu

drop table endereco_museu cascade

--------------------------------------------------------------------------
-- A tabela `museu` armazena informações sobre museus e faz referência ao endereço do museu.
-- Normalização:
-- 1NF: Todos os valores são atômicos. Colunas como `nm_museu` e `desc_museu` contêm informações indivisíveis sobre cada museu.
-- 2NF: Todos os atributos dependem exclusivamente da chave primária `id`. A coluna `id_endereco` faz referência ao `id` da tabela `endereco_museu`, garantindo que cada museu esteja associado a um único endereço.
-- 3NF: Não há dependências transitivas. A tabela armazena dados exclusivos do museu, como seu nome, descrição e número de telefone, enquanto a informação de endereço é mantida separada para evitar redundância.
-- Justificativa: Ao utilizar uma chave estrangeira para o endereço (`id_endereco`), asseguramos que cada museu tenha um endereço único e correto, reduzindo a duplicação de dados e facilitando a integridade e consistência dos dados de endereço.


CREATE TABLE museu 
( 
    id SERIAL PRIMARY KEY,  
    id_museu_adm INT NOT NULL, 
    nm_museu VARCHAR(100) NOT NULL,  
    desc_museu TEXT DEFAULT 'Este museu passou por tanta coisa! Concorda?',  
    dt_inauguracao DATE DEFAULT current_date NOT NULL, 
    nr_tel_museu VARCHAR(20) DEFAULT 'Sem telefone!',
    url_imagem VARCHAR(500) DEFAULT 'https://images2.imgbox.com/2d/47/iwT9Tl4Q_o.png',
    cnpj VARCHAR(18) NOT NULL, -- CNPJ com formato padrão
    id_endereco INT,
    CONSTRAINT fk_endereco_museu FOREIGN KEY (id_endereco) REFERENCES endereco_museu(id_endereco),
    CONSTRAINT fk_museu_adm FOREIGN KEY (id_museu_adm) REFERENCES museu_adm(id)
);


--------------------------------------------------------------------------
-- A tabela `guia` armazena informações sobre guias de museus e suas associações com os museus.
-- Normalização:
-- 1NF: Todos os valores são atômicos. A tabela contém informações específicas sobre cada guia, como `titulo_guia` e `desc_guia`.
-- 2NF: Todos os atributos dependem completamente da chave primária `id`. A coluna `id_museu` indica a associação do guia com um museu específico.
-- 3NF: Não há dependências transitivas. Cada coluna depende diretamente da chave primária `id`, e não há redundâncias de dados.
-- Justificativa: A tabela está organizada de maneira que cada guia seja identificado de forma única e tenha uma associação clara e direta com um museu específico, facilitando a gestão e evitando duplicação de dados em outros contextos.

CREATE TABLE guia 
( 
 id BIGINT PRIMARY KEY,  
 titulo_guia VARCHAR(100) constraint titulo_guia_nulo not null,  
 desc_guia TEXT default 'Este guia irá te guiar por esta sala!',  
 id_museu BIGINT,
 url_imagem VARCHAR(500) 
); 

--------------------------------------------------------------------------
-- A tabela `artista` armazena informações sobre os artistas, incluindo detalhes sobre suas datas e locais de nascimento e morte.
-- Normalização:
-- 1NF: Cada valor na tabela é atômico, com colunas distintas para nome, datas e locais.
-- 2NF: Todos os atributos dependem completamente da chave primária `id`, garantindo que não haja dependências parciais.
-- 3NF: Não há dependências transitivas. Cada atributo depende diretamente da chave primária `id`, o que elimina redundâncias e mantém a integridade dos dados.
-- Justificativa: A tabela `artista` é estruturada para armazenar informações específicas e únicas de cada artista, sem redundância e com uma clara distinção entre dados de identificação e detalhes adicionais, como biografia.

CREATE TABLE artista 
( 
 id BIGINT PRIMARY KEY,
 nm_artista VARCHAR(250),  
 dt_nasc_artista DATE,  
 dt_falecimento DATE,  
 local_nasc VARCHAR(150),  
 local_morte VARCHAR(150),  
 desc_artista TEXT,
 url_imagem VARCHAR(500) 
); 

--------------------------------------------------------------------------
-- A tabela `dia_funcionamento` armazena informações sobre os dias e horários de funcionamento dos museus.
-- Normalização:
-- 1NF: Todos os valores são atômicos e específicos para cada dia de funcionamento.
-- 2NF: Cada atributo, como `hr_inicio` e `dia_semana`, depende completamente da chave primária `id`.
-- 3NF: Não há dependências transitivas. Cada coluna na tabela fornece informações diretamente relacionadas ao dia de funcionamento identificado pela chave primária.
-- Justificativa: A tabela está estruturada para armazenar informações claras e únicas sobre os horários de funcionamento, associados a um museu específico por meio de `id_museu`. Isso evita duplicação de informações de horários e garante que cada dia de funcionamento esteja corretamente relacionado a um museu.

CREATE TABLE dia_funcionamento 
( 
 id BIGINT PRIMARY KEY,
 hr_inicio VARCHAR(20),  
 hr_termino VARCHAR(20),  
 pr_dia_funcionamento FLOAT,  
 dia_semana VARCHAR(30),  
 id_museu BIGINT
); 

--------------------------------------------------------------------------
-- Estas tabelas relacionais são utilizadas para modelar associações entre entidades (usuários, museus, guias, obras, artistas e gêneros).
-- Normalização:
-- 1NF: Todas as tabelas possuem valores atômicos e cada linha representa uma associação única entre duas entidades.
-- 2NF: As colunas em cada tabela dependem totalmente das chaves primárias compostas, garantindo que cada relação seja única e bem definida.
-- 3NF: Não há dependências transitivas, pois as tabelas não possuem atributos além das chaves estrangeiras. Cada chave estrangeira aponta para uma entidade específica, eliminando qualquer redundância.
-- Justificativa: Ao usar tabelas de associação, como `usuario_museu` e `obra_guia`, garantimos que as relações entre diferentes entidades sejam gerenciadas de forma eficiente, sem duplicar dados em outras tabelas. Isso também facilita a expansão futura do banco de dados, caso novas associações precisem ser feitas.

CREATE TABLE usuario_museu 
(
 id BIGINT PRIMARY KEY,  
 id_museu BIGINT,
 id_usuario BIGINT
);
-- A tabela usuario_museu corresponde a tabela onde será armazenado os dados quando um usuário seguir um determinado museu dentro do aplicativo. Para ver mais obras de desse museu.

CREATE TABLE obra_guia 
( 
 id BIGINT PRIMARY KEY,  
 nr_ordem INT, 
 desc_localizacao VARCHAR(500),
 id_guia BIGINT,  
 id_obra BIGINT  
); 
-- A tabela obra_guia estabelece a relação entre a tabela de obras e a de guia e possui novas informações para o guia. 
-- O guia será um passo a passo para o usuário andar e ver obras pelo museu, sabendo onde ela se encontra, e com o campo nr_ordem na tabela obra_guia, poderemos saber qual order o usuário deve seguir.

CREATE TABLE artista_genero 
(
 id BIGINT PRIMARY KEY,
 id_artista BIGINT,  
 id_genero BIGINT 
); 

-- A tabela artista_genero corresponde a tabela onde será armazenado o genero da obra que determinado artista possui em suas obras.

CREATE TABLE usuario_genero 
( 
 id BIGINT PRIMARY KEY,
 id_usuario BIGINT,  
 id_genero BIGINT
); 

-- -- A tabela usuario_genero corresponde a tabela onde será armazenado os dados de quando após o usuário se cadastrar, ele responde uma especie de pesquisa e escolhe os generos de arte que ele mais gosta. 
-- Para que veja mais informações sobre esse genero.

-- Criando a tabela museu_adm para gerenciar as informações de login do museu (requisito do primeiro ano)

CREATE TABLE museu_adm
(
    id SERIAL PRIMARY KEY,
    email_adm VARCHAR(100) UNIQUE constraint email_adm_nulo not null, 
    senha_usuario VARCHAR(100) constraint senha_adm_nula not null
);



--------------------------------------------------------------------------
-- Estabelecendo relações
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

-- Inserções para teste de conexão.
-- Vale ressaltar que nem todas as inserçõe estão aqui, pois estão sendo realizadas no banco do primeiro ano e transportadas através do RPA.

--INSERTS Usuário
INSERT INTO usuario ( id
					,  nm_usuario
					, sobrenome
					, email_usuario
					, nr_tel_usuario
					, dt_nasci_usuario
					, biografia
					, sexo
					, apelido
					, senha_usuario
					, url_imagem
					) 
			 VALUES ( 1
			 		,  'Alice'
					, 'Silva'
					, 'alice.silva@gmail.com'
					, '(15) 92275-7124'
					, '1990-01-01'
					, DEFAULT
					, 'F'
					, 'Lice'
					, 'senha123'
					, DEFAULT
					)
					,
				    ( 2
					, 'Bob'
					, 'Santos'
					, 'bob.santos@outlook.com'
					, '(13) 92023-9285'
					, '1988-02-02'
					, DEFAULT
					, 'M'
					, 'Bobster'
					, 'senha456'
					, DEFAULT
					)
					,
					( 3
					, 'Carlos'
					, 'Oliveira'
					, 'carlos.oliveira@gmail.com'
					, '(11) 93111-2687'
					, '1992-03-03'
					, DEFAULT
					, 'M'
					, 'Carlito'
					, 'senha789'
					, DEFAULT
					)
					,
					( 4
					, 'Daniela'
					, 'Costa'
					, 'daniela.costa@hotmail.com'
					, '(17) 92173-2652'
					, '1985-04-04'
					, DEFAULT
					, 'F'
					, 'Dani'
					, 'senha012'
					, DEFAULT
					)
					,
					( 5
					, 'Eduardo'
					, 'Ferreira'
					, 'eduardo.ferreira@gmail.com'
					, '(15) 92729-4416'
					, '1993-05-05'
					, DEFAULT
					, 'M'
					, 'Dudu'
					, 'senha345'
					, DEFAULT
					)
					,
					( 6
					, 'Fernanda'
					, 'Gomes'
					, 'fernanda.gomes@hotmail.com'
					, '(12) 92470-3258'
					, '1991-06-06'
					, DEFAULT
					, 'F'
					, 'Fê'
					, 'senha678'
					, DEFAULT
					)
					,
					( 7
					, 'Gustavo'
					, 'Martins'
					, 'gustavo.martins@gmail.com'
					, '(17) 93051-5556'
					, '1987-07-07'
					, DEFAULT
					, 'M'
					, 'Gu'
					, 'senha901'
					, DEFAULT
					)
					,
					( 8
					, 'Helena'
					, 'Ribeiro'
					, 'helena.ribeiro@gmail.com'
					, '(12) 92541-6391'
					, '1994-08-08'
					, DEFAULT
					, 'F'
					, 'Leninha'
					, 'senha234'
					, DEFAULT
					)
					,
					( 9
					, 'Igor'
					, 'Almeida'
					, 'igor.almeida@outlook.com'
					, '(19) 93451-9214'
					, '1995-09-09'
					, DEFAULT
					, 'M'
					, 'Igão'
					, 'senha567'
					, DEFAULT
					)
					,
					( 10
					, 'Julia'
					, 'Mendes'
					, 'julia.mendes@gmail.com'
					, '(14) 92132-5744'
					, '1986-10-10'
					, DEFAULT
					, 'F'
					, 'Juju'
					, 'senha890'
					, DEFAULT
					)
					,
					( 11
					, 'Kleber'
					, 'Cardoso'
					, 'kleber.cardoso@gmail.com'
					, '(13) 93650-8338'
					, '1989-11-11'
					, DEFAULT
					, 'M'
					, 'CardoKleb'
					, 'senha1234'
					, DEFAULT
					)
					,
					( 12
					, 'Larissa'
					, 'Rocha'
					, 'larissa.rocha@outlook.com'
					, '(16) 92743-1295'
					, '1990-12-12'
					, DEFAULT
					, 'F'
					, 'Lari'
					, 'senha5678'
					, DEFAULT)
					,
					( 13
					, 'Marcelo'
					, 'Sousa'
					, 'marcelo.sousa@outlook.com'
					, '(11) 92743-1295'
					, '1988-01-13'
					, DEFAULT
					, 'M'
					, 'Marcel'
					, 'senha9012'
					, DEFAULT
					)
					,
					( 14
					, 'Natalia'
					, 'Araujo'
					, 'natalia.araujo@gmail.com'
					, '(11) 93821-0779'
					, '1992-02-14'
					, DEFAULT
					, 'F'
					, 'Nati'
					, 'senha3456'
					, DEFAULT
					)
					,
					( 15
					, 'Otávio'
					, 'Barros'
					, 'otavio.barros@outlook.com'
					, '(11) 93983-4524'
					, '1985-03-15'
					, DEFAULT
					, 'M'
					, 'Tavin'
					, 'senha7890'
					, DEFAULT
					)
					,
					( 16
					, 'Paula'
					, 'Monteiro'
					, 'paula.monteiro@outlook.com'
					, '(11) 93628-2512'
					, '1991-04-16'
					, DEFAULT
					, 'F'
					, 'Paulinha'
					, 'senha1235'
					, DEFAULT
					)
					,
					( 17
					, 'Quintino'
					, 'Vasconcelos'
					, 'quintino.vasconcelos@gmail.com'
					, '(11) 93120-1714'
					, '1989-05-17'
					, DEFAULT
					, 'M'
					, 'Quinto'
					, 'senha4567'
					, DEFAULT
					)
					,
					( 18
					, 'Renata'
					, 'Dias'
					, 'renata.dias@outlook.com'
					, '(15) 92662-4750'
					, '1993-06-18'
					, DEFAULT
					, 'F'
					, 'Rê'
					, 'senha7891'
					, DEFAULT
					)
					,
					( 19
					, 'Sérgio'
					, 'Pereira'
					, 'sergio.pereira@gmail.com'
					, '(11) 93533-3484'
					, '1987-07-19'
					, DEFAULT
					, 'M'
					, 'Serginho'
					, 'senha0123'
					, DEFAULT
					)
					,
					( 20
					, 'Tatiana'
					, 'Ramos'
					, 'tatiana.ramos@gmail.com'
					, '(12) 93767-9329'
					, '1995-08-20'
					, DEFAULT
					, 'F'
					, 'Tati'
					, 'senha4568'
					, DEFAULT
					)
					,
					( 21
					, 'Ulisses'
					, 'Moura Junior'
					, 'ulisses.junior@hotmail.com'
					, '(11) 92479-0381'
					, '1986-09-21'
					, DEFAULT
					, 'M'
					, 'Junior'
					, 'senha7892'
					, DEFAULT
					)
					,
					( 22
					, 'Vanessa'
					, 'Freitas'
					, 'vanessa.freitas@gmail.com'
					, '(12) 92178-6244'
					, '1991-10-22'
					, DEFAULT
					, 'F'
					, 'Nessa'
					, 'senha0124'
					, DEFAULT
					)
					,
					( 23
					, 'Wagner'
					, 'Carvalho'
					, 'wagner.carvalho@outlook.com'
					, '(13) 92466-3718'
					, '1988-11-23'
					, DEFAULT
					, 'M'
					, 'Wag'
					, 'senha3457'
					, DEFAULT
					)
					,
					( 24
					, 'Milena'
					, 'Silveira'
					, 'milena.silveira@hotmail.com'
					, '(13) 93818-6926'
					, '1990-12-24'
					, DEFAULT
					, 'F'
					, 'Lena'
					, 'senha6789'
					, DEFAULT
					)
					,
					( 25
					, 'Yuri'
					, 'Teixeira'
					, 'yuri.teixeira@gmail.com'
					, '(11) 93287-2109'
					, '1987-01-25'
					, DEFAULT
					, 'M'
					, 'Yuri'
					, 'senha9013'
					, DEFAULT
					)
					,
					( 26
					, 'Zuleica'
					, 'Moreira'
					, 'zuleica.moreira@outlook.com'
					, '(11) 92388-9782'
					, '1992-02-26'
					, DEFAULT
					, 'F'
					, 'Zul'
					, 'senha2345'
					, DEFAULT
					);


--INSERTS usuario_museu
INSERT INTO usuario_museu (id, id_museu, id_usuario) VALUES 
( 1, 1, 1),
( 2, 1, 2),
( 3, 1, 3),
( 4, 1, 4),
( 5, 1, 5),

( 6, 2, 6),
( 7, 2, 7),
( 8, 2, 8),
( 9, 2, 9),
( 10, 2, 1), 

( 11, 3, 10),
( 12, 3, 11),
( 13, 3, 12),
( 14, 3, 13),
( 15, 3, 14),

( 16, 4, 15),
( 17, 4, 16),
( 18, 4, 17),
( 19, 4, 18),
( 20, 4, 2),

( 21, 5, 19),
( 22, 5, 20),
( 23, 5, 21),
( 24, 5, 22),
( 25, 5, 3); 


--INSERTS usuario_genero
INSERT INTO usuario_genero (id, id_usuario, id_genero) VALUES
( 1, 3, 7), 
( 2, 13, 7), 
( 3, 22, 7), 
( 4, 7, 10), 
( 5, 11, 10), 
( 6, 16, 10),
( 7, 20, 10),
( 8, 25, 10), 
( 9, 10, 6), 
( 10, 17, 6), 
( 11, 24, 6), 
( 12, 2, 5), 
( 13, 12, 5), 
( 14, 19, 5), 
( 15, 21, 9), 
( 16, 23, 9), 
( 17, 5, 2), 
( 18, 26, 2), 
( 19, 6, 3),
( 20, 21, 3), 
( 21, 4, 8), 
( 22, 14, 8), 
( 23, 20, 8), 
( 24, 23, 8), 
( 25, 1, 1), 
( 26, 15, 1), 
( 27, 25, 1), 
( 28, 9, 4), 
( 29, 18, 4); 


INSERT INTO museu_adm ( id
					  , email_adm
					  , senha_adm 
					  )
			   VALUES ( 1
			   		  , 'adm_pinacoteca@gmail.com'
					  , 'Mus@Senha'
			          )
					  , 
					  ( 2
					  , 'adm_ims@outlook.com'
					  , 'Mus@Senha'
					  )
					  ,
					  ( 3
					  , 'adm_ipiranga@hotmail.com'
					  , 'Mus@Senha'
					  )
					  ,
					  ( 4
					  , 'adm_mam@gmail.com'
					  , 'Mus@Senha'
					  )
					  ,
					  ( 5
					  , 'adm_mnba@hotmail.com'
					  , 'Mus@Senha'
					  )
					  ;
 
-------------------------------------------------------- Criando tabelas de log -------------------------------------------------------

													-- Criação de tabelas de log --
CREATE TABLE log_usuario (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario BIGINT
);

CREATE TABLE log_genero (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_genero BIGINT
);

CREATE TABLE log_obra (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_obra BIGINT
);

CREATE TABLE log_museu (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_museu BIGINT
);

CREATE TABLE log_endereco (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_endereco BIGINT
);

CREATE TABLE log_guia (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_guia BIGINT
);

CREATE TABLE log_artista (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_artista BIGINT
);

CREATE TABLE log_dia_funcionamento (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_dia_funcionamento BIGINT
);

CREATE TABLE log_usuario_museu (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario_museu BIGINT
);

CREATE TABLE log_obra_guia (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_obra_guia BIGINT
);

CREATE TABLE log_artista_genero (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_artista_genero BIGINT
);

CREATE TABLE log_usuario_genero (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario_genero BIGINT
);

-- Tabela de log para ações (seguir e deixar de seguir) na tabela usuario_museu
CREATE TABLE log_usuario_museu_acoes (
    id SERIAL PRIMARY KEY,
    id_usuario BIGINT,
    id_museu BIGINT,
    acao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de log para ações (acompanhar e deixar de acompanhar) na tabela usuario_genero
CREATE TABLE log_usuario_genero_acoes (
    id SERIAL PRIMARY KEY,
    id_usuario BIGINT,
    id_genero BIGINT,
    acao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para registrar todas as atividades no banco, independente da tabela, para auxiliar no RPA de sincronização
CREATE TABLE log_geral (
    id SERIAL PRIMARY KEY,
    tabela VARCHAR(50) NOT NULL,
    id_registro BIGINT NOT NULL,
    operacao VARCHAR(50) NOT NULL,
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


----------------------------------------------------------------------- Criando Procedures --------------------------------------------------------------------------------
													-- Procedure para inserção e verificação de informações de usuário --

CREATE OR REPLACE PROCEDURE inserir_usuario(
    p_id BIGINT,
    p_nm_usuario VARCHAR(100),
    p_sobrenome VARCHAR(100),
    p_email_usuario VARCHAR(100),
    p_nr_tel_usuario VARCHAR(20),
    p_dt_nasci_usuario DATE,
    p_biografia VARCHAR(280),
    p_sexo VARCHAR(20),
    p_apelido VARCHAR(100),
    p_senha_usuario VARCHAR(100),
	p_url_imagem VARCHAR(500)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar se o e-mail já existe
    IF EXISTS (SELECT 1 FROM usuario WHERE email_usuario = p_email_usuario) THEN
        RAISE EXCEPTION 'O e-mail % já está em uso.', p_email_usuario;
    
    -- Verificar se o número de telefone já existe
    ELSIF EXISTS (SELECT 1 FROM usuario WHERE nr_tel_usuario = p_nr_tel_usuario) THEN
        RAISE EXCEPTION 'O número de telefone % já está em uso.', p_nr_tel_usuario;
    
    ELSE
        -- Inserir o novo usuário
        INSERT INTO usuario (id, nm_usuario, sobrenome, email_usuario, nr_tel_usuario, dt_nasci_usuario, biografia, sexo, apelido, senha_usuario, url_imagem)
        VALUES (p_id, p_nm_usuario, p_sobrenome, p_email_usuario, p_nr_tel_usuario, p_dt_nasci_usuario, p_biografia, p_sexo, p_apelido, p_senha_usuario, p_url_imagem);
    END IF;
END;
$$;

-- Teste para provar que a Procedure funciona e não deixa repetir nem e-mail e nem número de telefone.

CALL inserir_usuario(
    '27', 
    'Neife Lourivaldo', 
    'Oliveira', 
    'neifel@gmail.com', 
    '(11) 99572-0660', 
    '2007-10-23', 
    'Oi, eu estou usando o Leontis!', 
    'M', 
    'Neife Junior', 
    'senha1234@',
    'url'
);

															-- Procedure para atualização de informação de usuário --
															
-- A procedure abaixo serve para a atualização de usuário seguindo os requisitos solicitados pela equipe de DEV. Eles querem atualizar quantas informações forem necessárias, mantendo o ID que será gerado
-- por eles mesmos, eles saberão esse ID e informarão automaticamente, não será um ID informado pelo usuário, porque ele não terá acesso a esse informação.
-- Eles informarão o ID, juntamente as solicitações de atualização que o usuário desejar e manterão o restante. 
-- A procedure irá verificar se caso o usuário queira atualizar o e-mail e/ou telefone, ele já não pertence a outra pessoa. Caso a pessoa mantenha o mesmo, a verificação garante que não de erro caso o 
-- e-mail e/ou telefone sejam dele mesmo (verificando se os ids são diferentes.).

CREATE OR REPLACE PROCEDURE atualizar_usuario(
    p_id BIGINT,
    p_nm_usuario VARCHAR(100),
    p_sobrenome VARCHAR(100),
    p_email_usuario VARCHAR(100),
    p_nr_tel_usuario VARCHAR(20),
    p_dt_nasci_usuario DATE,
    p_biografia VARCHAR(280),
    p_sexo VARCHAR(20),
    p_apelido VARCHAR(100),
    p_senha_usuario VARCHAR(100),
	p_url_imagem VARCHAR(500)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar se o usuário existe
    IF NOT EXISTS (SELECT 1 FROM usuario WHERE id = p_id) THEN
        RAISE EXCEPTION 'Usuário com ID % não encontrado.', p_id;
    
    -- Verificar se o e-mail já está em uso por outro usuário
    ELSIF EXISTS (SELECT 1 FROM usuario WHERE email_usuario = p_email_usuario AND id != p_id) THEN
        RAISE EXCEPTION 'O e-mail % já está em uso por outro usuário.', p_email_usuario;
    
    -- Verificar se o número de telefone já está em uso por outro usuário
    ELSIF EXISTS (SELECT 1 FROM usuario WHERE nr_tel_usuario = p_nr_tel_usuario AND id != p_id) THEN
        RAISE EXCEPTION 'O número de telefone % já está em uso por outro usuário.', p_nr_tel_usuario;
    
    ELSE
        -- Atualizar as informações do usuário
        UPDATE usuario
        SET nm_usuario = p_nm_usuario,
            sobrenome = p_sobrenome,
            email_usuario = p_email_usuario,
            nr_tel_usuario = p_nr_tel_usuario,
            dt_nasci_usuario = p_dt_nasci_usuario,
            biografia = p_biografia,
            sexo = p_sexo,
            apelido = p_apelido,
            senha_usuario = p_senha_usuario,
			url_imagem = p_url_imagem
        WHERE id = p_id;
    END IF;
END;
$$;

-- Teste da procedure

CALL atualizar_usuario(
    '27', 
    'Neife', 
    'Oliveira', 
    'neife@gmail.com', 
    '(11) 99572-0660', 
    '2007-10-23', 
    'Oi, eu estou usando o Leontis!', 
    'M', 
    'Neife Junior', 
    'senha1234@',
	'abcdefgh'
);


													-- Procedure para deleção de usuário de todas as tabelas relacionadas a ele --
													
CREATE OR REPLACE PROCEDURE deletar_usuario(p_id BIGINT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar se o usuário existe
    IF NOT EXISTS (SELECT 1 FROM usuario WHERE id = p_id) THEN
        RAISE EXCEPTION 'Usuário com ID % não encontrado.', p_id;
    ELSE
        -- Deletar relacionamentos nas tabelas usuario_genero
        DELETE FROM usuario_genero WHERE id_usuario = p_id;

        -- Deletar relacionamentos nas tabelas usuario_museu
        DELETE FROM usuario_museu WHERE id_usuario = p_id;

        -- Deletar o usuário da tabela usuario
        DELETE FROM usuario WHERE id = p_id;
    END IF;
END;
$$;

-- Testando Procedure

CALL deletar_usuario('27');

									-- Procedure que verifica se a relação entre o usuário e o museu já existe e, com base nisso, adiciona ou remove a relação. --
									
CREATE OR REPLACE PROCEDURE gerenciar_seguidores_museu(
	p_id BIGINT,
    p_id_usuario BIGINT,
    p_id_museu BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar se a relação entre o usuário e o museu já existe
    IF EXISTS (SELECT 1 FROM usuario_museu WHERE id_usuario = p_id_usuario AND id_museu = p_id_museu) THEN
        -- Se existir, remover a relação (parar de seguir)
        DELETE FROM usuario_museu WHERE id_usuario = p_id_usuario AND id_museu = p_id_museu;
        RAISE NOTICE 'Usuário % parou de seguir o museu %.', p_id_usuario, p_id_museu;
    ELSE
        -- Se não existir, adicionar a relação (começar a seguir)
        INSERT INTO usuario_museu (id, id_usuario, id_museu)
        VALUES (p_id, p_id_usuario, p_id_museu);
        RAISE NOTICE 'Usuário % começou a seguir o museu %.', p_id_usuario, p_id_museu;
    END IF;
END;
$$;

-- Testando a Procedure 
CALL gerenciar_seguidores_museu('1', '729', '3');

									-- Procedure que verifica se a relação entre o usuário e o genero já existe e, com base nisso, adiciona ou remove a relação. --

CREATE OR REPLACE PROCEDURE gerenciar_generos_usuario(
    p_id BIGINT,
    p_id_usuario BIGINT,
    p_id_genero BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar se a relação entre o usuário e o gênero já existe
    IF EXISTS (SELECT 1 FROM usuario_genero WHERE id_usuario = p_id_usuario AND id_genero = p_id_genero) THEN
        -- Se existir, remover a relação (parar de acompanhar o gênero)
        DELETE FROM usuario_genero WHERE id_usuario = p_id_usuario AND id_genero = p_id_genero;
        RAISE NOTICE 'Usuário % parou de acompanhar o gênero %.', p_id_usuario, p_id_genero;
    ELSE
        -- Se não existir, adicionar a relação (começar a acompanhar o gênero)
        INSERT INTO usuario_genero (id, id_usuario, id_genero)
        VALUES (p_id, p_id_usuario, p_id_genero);
        RAISE NOTICE 'Usuário % começou a acompanhar o gênero %.', p_id_usuario, p_id_genero;
    END IF;
END;
$$;

-- Testando a Procedure
CALL gerenciar_generos_usuario('2', '729', '3');

--------------------------------------------------- Criação de Triggers para Log das tabelas --------------------------------------------------- 

													-- Trigger para a tabela usuário --
								
CREATE OR REPLACE FUNCTION log_usuario_operation()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN		
	
		INSERT INTO log_usuario (operacao, data_operacao, id_usuario)
        VALUES ('INSERT', NOW(), NEW.id);
		
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('usuario', NEW.id, 'INSERT');
		
    ELSIF TG_OP = 'UPDATE' THEN
		INSERT INTO log_usuario (operacao, data_operacao, id_usuario)
        VALUES ('UPDATE', NOW(), NEW.id);
		
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('usuario', NEW.id, 'UPDATE');
		
    ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO log_usuario (operacao, data_operacao, id_usuario)
        VALUES ('DELETE', NOW(), OLD.id);
		
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('usuario', OLD.id, 'DELETE');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criando a trigger para a tabela usuario
CREATE TRIGGER trigger_log_usuario
AFTER INSERT OR UPDATE OR DELETE ON usuario
FOR EACH ROW
EXECUTE FUNCTION log_usuario_operation();


															-- Trigger para a tabela usuario_genero
CREATE OR REPLACE FUNCTION log_usuario_genero_operation()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
		INSERT INTO log_usuario_genero (operacao, data_operacao, id_usuario_genero)
        VALUES ('INSERT', NOW(), NEW.id);
		
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('usuario_genero', NEW.id, 'INSERT');
		
    ELSIF TG_OP = 'UPDATE' THEN
		INSERT INTO log_usuario_genero (operacao, data_operacao, id_usuario_genero)
        VALUES ('UPDATE', NOW(), NEW.id);
		
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('usuario_genero', NEW.id, 'UPDATE');
		
    ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO log_usuario_genero (operacao, data_operacao, id_usuario_genero)
        VALUES ('DELETE', NOW(), OLD.id);
		
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('usuario_genero', OLD.id, 'DELETE');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criando a trigger para a tabela usuario_genero
CREATE TRIGGER trigger_log_usuario_genero
AFTER INSERT OR UPDATE OR DELETE ON usuario_genero
FOR EACH ROW
EXECUTE FUNCTION log_usuario_genero_operation();

															-- Trigger para a tabela usuario_museu
CREATE OR REPLACE FUNCTION log_usuario_museu_operation()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
		INSERT INTO log_usuario_museu (operacao, data_operacao, id_usuario_museu)
        VALUES ('INSERT', NOW(), NEW.id);
	
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('usuario_museu', NEW.id, 'INSERT');
		
    ELSIF TG_OP = 'UPDATE' THEN
		INSERT INTO log_usuario_museu (operacao, data_operacao, id_usuario_museu)
        VALUES ('UPDATE', NOW(), NEW.id);
	
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('usuario_museu', NEW.id, 'UPDATE');
		
    ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO log_usuario_museu (operacao, data_operacao, id_usuario_museu)
        VALUES ('DELETE', NOW(), OLD.id);
		
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('usuario_museu', OLD.id, 'DELETE');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criando a trigger para a tabela usuario_museu
CREATE TRIGGER trigger_log_usuario_museu
AFTER INSERT OR UPDATE OR DELETE ON usuario_museu
FOR EACH ROW
EXECUTE FUNCTION log_usuario_museu_operation();


													-- Trigger para a tabela genero --

CREATE OR REPLACE FUNCTION log_genero_operation()
RETURNS TRIGGER AS $$
BEGIN
    -- Inserir na tabela de log específica da tabela genero
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_genero (operacao, data_operacao, id_genero)
        VALUES ('INSERT', NOW(), NEW.id);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_genero (operacao, data_operacao, id_genero)
        VALUES ('UPDATE', NOW(), NEW.id);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_genero (operacao, data_operacao, id_genero)
        VALUES ('DELETE', NOW(), OLD.id);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_genero
AFTER INSERT OR UPDATE OR DELETE ON genero
FOR EACH ROW
EXECUTE FUNCTION log_genero_operation();

													-- Trigger para a tabela obra --

CREATE OR REPLACE FUNCTION log_obra_operation()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_obra (operacao, data_operacao, id_obra)
        VALUES ('INSERT', NOW(), NEW.id);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_obra (operacao, data_operacao, id_obra)
        VALUES ('UPDATE', NOW(), NEW.id);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_obra (operacao, data_operacao, id_obra)
        VALUES ('DELETE', NOW(), OLD.id);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_obra
AFTER INSERT OR UPDATE OR DELETE ON obra
FOR EACH ROW
EXECUTE FUNCTION log_obra_operation();

													-- Trigger para a tabela museu --				
													
CREATE OR REPLACE FUNCTION log_museu_operation()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_museu (operacao, data_operacao, id_museu)
        VALUES ('INSERT', NOW(), NEW.id);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_museu (operacao, data_operacao, id_museu)
        VALUES ('UPDATE', NOW(), NEW.id);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_museu (operacao, data_operacao, id_museu)
        VALUES ('DELETE', NOW(), OLD.id);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_museu
AFTER INSERT OR UPDATE OR DELETE ON museu
FOR EACH ROW
EXECUTE FUNCTION log_museu_operation();

													-- Trigger para a tabela endereco_museu --
select * from log_endereco
													
CREATE OR REPLACE FUNCTION log_endereco_museu_operation()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_endereco (operacao, data_operacao, id_endereco)
        VALUES ('INSERT', NOW(), NEW.id);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_endereco (operacao, data_operacao, id_endereco)
        VALUES ('UPDATE', NOW(), NEW.id);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_endereco (operacao, data_operacao, id_endereco)
        VALUES ('DELETE', NOW(), OLD.id);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_endereco
AFTER INSERT OR UPDATE OR DELETE ON endereco_museu
FOR EACH ROW
EXECUTE FUNCTION log_endereco_operation();

													-- Trigger para a tabela guia --
												
CREATE OR REPLACE FUNCTION log_guia_operation()
RETURNS TRIGGER AS $$
BEGIN
    -- Inserir na tabela de log específica da tabela guia
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_guia (operacao, data_operacao, id_guia)
        VALUES ('INSERT', NOW(), NEW.id);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_guia (operacao, data_operacao, id_guia)
        VALUES ('UPDATE', NOW(), NEW.id);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_guia (operacao, data_operacao, id_guia)
        VALUES ('DELETE', NOW(), OLD.id);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_guia
AFTER INSERT OR UPDATE OR DELETE ON guia
FOR EACH ROW
EXECUTE FUNCTION log_guia_operation();

													-- Trigger para a tabela artista --
													
CREATE OR REPLACE FUNCTION log_artista_operation()
RETURNS TRIGGER AS $$
BEGIN
    -- Inserir na tabela de log específica da tabela artista
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_artista (operacao, data_operacao, id_artista)
        VALUES ('INSERT', NOW(), NEW.id);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_artista (operacao, data_operacao, id_artista)
        VALUES ('UPDATE', NOW(), NEW.id);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_artista (operacao, data_operacao, id_artista)
        VALUES ('DELETE', NOW(), OLD.id);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_log_artista
AFTER INSERT OR UPDATE OR DELETE ON artista
FOR EACH ROW
EXECUTE FUNCTION log_artista_operation();

													-- Trigger para a tabela dia_funcionamento --
												
CREATE OR REPLACE FUNCTION log_dia_funcionamento_operation()
RETURNS TRIGGER AS $$
BEGIN
    -- Inserir na tabela de log específica da tabela dia_funcionamento
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_dia_funcionamento (operacao, data_operacao, id_dia_funcionamento)
        VALUES ('INSERT', NOW(), NEW.id);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_dia_funcionamento (operacao, data_operacao, id_dia_funcionamento)
        VALUES ('UPDATE', NOW(), NEW.id);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_dia_funcionamento (operacao, data_operacao, id_dia_funcionamento)
        VALUES ('DELETE', NOW(), OLD.id);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_dia_funcionamento
AFTER INSERT OR UPDATE OR DELETE ON dia_funcionamento
FOR EACH ROW
EXECUTE FUNCTION log_dia_funcionamento_operation();


													-- Trigger para a tabela obra_guia --

CREATE OR REPLACE FUNCTION log_obra_guia_operation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- Inserir na tabela de log específica da tabela obra_guia
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_obra_guia (operacao, data_operacao, id_obra_guia)
        VALUES ('INSERT', NOW(), NEW.id);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_obra_guia (operacao, data_operacao, id_obra_guia)
        VALUES ('UPDATE', NOW(), NEW.id);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_obra_guia (operacao, data_operacao, id_obra_guia)
        VALUES ('DELETE', NOW(), OLD.id);
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
    -- Inserir na tabela de log específica da tabela artista_genero
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_artista_genero (operacao, data_operacao, id_artista_genero)
        VALUES ('INSERT', NOW(), NEW.id);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_artista_genero (operacao, data_operacao, id_artista_genero)
        VALUES ('UPDATE', NOW(), NEW.id);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_artista_genero (operacao, data_operacao, id_artista_genero)
        VALUES ('DELETE', NOW(), OLD.id);
    END IF;

    RETURN NEW;
END;
$$;


CREATE TRIGGER trigger_log_artista_genero
AFTER INSERT OR UPDATE OR DELETE ON artista_genero
FOR EACH ROW
EXECUTE FUNCTION log_artista_genero_operation();



													-- Trigger para a tabela museu_adm --

CREATE OR REPLACE FUNCTION log_museu_adm_operation()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('museu_adm', NEW.id, 'INSERT');
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('museu_adm', NEW.id, 'UPDATE');
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('museu_adm', OLD.id, 'DELETE');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_museu_adm
AFTER INSERT OR UPDATE OR DELETE ON museu_adm
FOR EACH ROW
EXECUTE FUNCTION log_museu_adm_operation();


																						
-- As triggers abaixo são para complementarmos as ações necessárias.

-- Essa trigger será para registrarmos o histórico de quando o usuário seguir e deixar de seguir um museu.
CREATE OR REPLACE FUNCTION log_acoes_usuario_museu()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_usuario_museu_acoes (id_usuario, id_museu, acao)
        VALUES (NEW.id_usuario, NEW.id_museu, 'SEGUIR');
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_usuario_museu_acoes (id_usuario, id_museu, acao)
        VALUES (OLD.id_usuario, OLD.id_museu, 'DEIXAR DE SEGUIR');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_acoes_usuario_museu
AFTER INSERT OR DELETE ON usuario_museu
FOR EACH ROW
EXECUTE FUNCTION log_acoes_usuario_museu();


-- Essa trigger será para registrarmos ações (acompanhar e deixar de acompanhar) na tabela usuario_genero
CREATE OR REPLACE FUNCTION log_acoes_usuario_genero()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_usuario_genero_acoes (id_usuario, id_genero, acao)
        VALUES (NEW.id_usuario, NEW.id_genero, 'ACOMPANHAR');
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_usuario_genero_acoes (id_usuario, id_genero, acao)
        VALUES (OLD.id_usuario, OLD.id_genero, 'DEIXAR DE ACOMPANHAR');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_acoes_usuario_genero
AFTER INSERT OR DELETE ON usuario_genero
FOR EACH ROW
EXECUTE FUNCTION log_acoes_usuario_genero();


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- Criando indíces

-- Índices na tabela usuario
CREATE INDEX idx_email_usuario ON usuario (email_usuario);
CREATE INDEX idx_nr_tel_usuario ON usuario (nr_tel_usuario);
CREATE INDEX idx_apelido ON usuario (apelido);

-- Índices na tabela museu
CREATE INDEX idx_cnpj_museu ON museu (cnpj);
CREATE INDEX idx_museu_endereco ON museu (id_endereco);

-- Índice na tabela genero
CREATE INDEX idx_nm_genero ON genero (nm_genero);

-- Índices na tabela obra
CREATE INDEX idx_obra_genero ON obra (id_genero);
CREATE INDEX idx_obra_artista ON obra (id_artista);
CREATE INDEX idx_obra_museu ON obra (id_museu);

-- Índice composto na tabela usuario_museu
CREATE INDEX idx_usuario_museu ON usuario_museu (id_usuario, id_museu);

-- Índice composto na tabela usuario_genero
CREATE INDEX idx_usuario_genero ON usuario_genero (id_usuario, id_genero);


									-------------------------------- Testando os indíces --------------------------------

-- Testando o Índice em email_usuario e nr_tel_usuario na Tabela usuario

-- Consultas antes de criar os índices
EXPLAIN ANALYZE SELECT * FROM usuario WHERE email_usuario = 'alice.silva@gmail.com';
EXPLAIN ANALYZE SELECT * FROM usuario WHERE nr_tel_usuario = '(15) 92275-7124';

-- Após criar os índices
-- Devemos ver o índice sendo usado no plano de execução
EXPLAIN ANALYZE SELECT * FROM usuario WHERE email_usuario = 'alice.silva@gmail.com';
EXPLAIN ANALYZE SELECT * FROM usuario WHERE nr_tel_usuario = '(15) 92275-7124';



-- Testando o Índice em id_endereco e cnpj na Tabela museu

-- Consultas antes dos índices
EXPLAIN ANALYZE SELECT * FROM museu WHERE id_endereco = 1;
EXPLAIN ANALYZE SELECT * FROM museu WHERE cnpj = '00.000.000/0001-91';

-- Consultas após criação dos índices
EXPLAIN ANALYZE SELECT * FROM museu WHERE id_endereco = 1;
EXPLAIN ANALYZE SELECT * FROM museu WHERE cnpj = '00.000.000/0001-91';

-- Testando o Índice em nm_genero na Tabela genero

-- Antes do índice
EXPLAIN ANALYZE SELECT * FROM genero WHERE nm_genero = 'Arte Moderna';

-- Após criação do índice
EXPLAIN ANALYZE SELECT * FROM genero WHERE nm_genero = 'Arte Moderna';


-- Testando Índices de Chaves Estrangeiras nas Tabelas obra, usuario_museu e usuario_genero

-- Consultas antes dos índices nas tabelas com chaves estrangeiras
EXPLAIN ANALYZE SELECT * FROM obra WHERE id_genero = 1;
EXPLAIN ANALYZE SELECT * FROM obra WHERE id_artista = 2;
EXPLAIN ANALYZE SELECT * FROM obra WHERE id_museu = 3;

EXPLAIN ANALYZE SELECT * FROM usuario_museu WHERE id_usuario = 5;
EXPLAIN ANALYZE SELECT * FROM usuario_genero WHERE id_usuario = 6;

-- Após a criação dos índices
EXPLAIN ANALYZE SELECT * FROM obra WHERE id_genero = 1;
EXPLAIN ANALYZE SELECT * FROM obra WHERE id_artista = 2;
EXPLAIN ANALYZE SELECT * FROM obra WHERE id_museu = 3;

EXPLAIN ANALYZE SELECT * FROM usuario_museu WHERE id_usuario = 5;
EXPLAIN ANALYZE SELECT * FROM usuario_genero WHERE id_usuario = 6;



-- Drops Normais
-- drop table artista cascade
-- drop table artista_genero cascade
-- drop table dia_funcionamento cascade
-- drop table genero cascade
-- drop table guia cascade
-- drop table endereco_museu cascade
-- drop table museu cascade
-- drop table museu_adm cascade
-- drop table obra cascade
-- drop table obra_guia cascade
-- drop table usuario cascade
-- drop table usuario_genero cascade
-- drop table usuario_museu cascade


-- Drops Tabelas de Log
-- drop table log_usuario cascade
-- drop table log_genero cascade
-- drop table log_obra cascade
-- drop table log_museu cascade
-- drop table log_endereco cascade
-- drop table log_guia cascade
-- drop table log_artista cascade
-- drop table log_dia_funcionamento cascade
-- drop table log_usuario_museu cascade
-- drop table log_obra_guia cascade
-- drop table log_artista_genero cascade
-- drop table log_usuario_genero cascade

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- Excluir todas as informações das tabelas

truncate table artista cascade;
truncate table artista_genero cascade;
truncate table dia_funcionamento cascade;
truncate table genero cascade;
truncate table guia cascade;
truncate table endereco_museu cascade;
truncate table museu cascade;
truncate table museu_adm cascade;
truncate table obra cascade;
truncate table obra_guia cascade;
truncate table usuario cascade;
truncate table usuario_genero cascade;
truncate table usuario_museu cascade;


-- Excluir todas as informações das tabelas de log

truncate log_usuario cascade;
truncate log_genero cascade;
truncate log_obra cascade;
truncate log_museu cascade;
truncate log_endereco cascade;
truncate log_guia cascade;
truncate log_artista cascade;
truncate log_dia_funcionamento cascade;
truncate log_usuario_museu cascade;
truncate log_obra_guia cascade;
truncate log_artista_genero cascade;
truncate log_usuario_genero cascade;
truncate table log_geral cascade;

-- Selects Normais

select * from artista 
select * from artista_genero 
select * from dia_funcionamento
select * from genero 
select * from guia
select * from endereco_museu 
select * from museu 
select * from museu_adm
select * from obra 
select * from obra_guia
select * from usuario
select * from usuario_genero
select * from usuario_museu

-- Selects Tabelas de Log
												
select * from log_usuario
select * from log_genero
select * from log_obra
select * from log_museu
select * from log_endereco
select * from log_guia 
select * from log_artista
select * from log_dia_funcionamento
select * from log_usuario_museu
select * from log_obra_guia
select * from log_artista_genero
select * from log_usuario_genero
select * from log_usuario_museu_acoes;
select * from log_usuario_genero_acoes;
select * from log_geral

