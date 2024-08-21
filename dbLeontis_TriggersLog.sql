-- Criação do Banco/Normalização do Banco.
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

--------------------------------------------------------------------------
-- A tabela `genero` armazena informações sobre os diferentes gêneros artísticos. A normalização está detalhada abaixo:
-- 1NF: A tabela atende à 1NF porque cada coluna contém valores atômicos. Não há repetição de grupos de valores, e cada coluna armazena um único tipo de informação. Por exemplo, `nm_genero` armazena apenas o nome do gênero, sem listas ou valores combinados.
-- 2NF: A tabela está na 2NF porque todos os atributos dependem da chave primária `id`. Não há colunas que dependam de uma parte da chave primária, já que `id` é uma chave simples e todas as outras colunas são relacionadas diretamente a ela.
-- 3NF: A tabela está na 3NF porque não há dependências transitivas. Isso significa que cada coluna não-chave, como `desc_genero`, depende apenas da chave primária e não de outras colunas na tabela. Por exemplo, `desc_genero` não depende de `nm_genero`, mas sim diretamente de `id`.
-- Justificativa: A normalização desta tabela evita redundâncias e garante que cada gênero artístico seja representado de forma única e consistente. Isso facilita a manutenção dos dados e a realização de consultas eficientes e precisas.

CREATE TABLE genero 
( 
 id VARCHAR(5) PRIMARY KEY,  
 nm_genero VARCHAR(100) constraint nm_genero_nulo not null,  
 introducao VARCHAR(500),  
 desc_genero TEXT constraint ds_genero_nulo not null
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
 id VARCHAR(5) PRIMARY KEY,  
 ano_inicio VARCHAR(4),  
 ano_final VARCHAR(4),  
 desc_obra TEXT default 'Que obra linda! Não é mesmo?',  
 nm_obra VARCHAR(100) constraint nm_obra_nulo not null,  
 id_genero VARCHAR(5),  
 id_artista VARCHAR(5),  
 id_museu VARCHAR(5)
); 

--------------------------------------------------------------------------
-- A tabela `endereco_museu` armazena informações de endereço dos museus.
-- Normalização:
-- 1NF: Todos os valores são atômicos e específicos, como `rua`, `cep`, `num_museu`, `cidade`, etc. Não há agrupamento de informações em uma única coluna.
-- 2NF: Todos os atributos dependem exclusivamente da chave primária `id`, que identifica cada endereço de forma única. Por exemplo, `cep` e `rua` são específicos ao `id` do endereço.
-- 3NF: Não há dependências transitivas entre as colunas. Cada coluna fornece informações diretas sobre o endereço identificado pela chave primária `id`.
-- Justificativa: Ao separar o endereço do museu em uma tabela distinta, evitamos a duplicação de dados de endereço em outras tabelas, como `museu`. Isso melhora a integridade dos dados e facilita a manutenção, como atualizar um endereço sem afetar outras partes do banco de dados.

CREATE TABLE endereco_museu (
    id VARCHAR(5) PRIMARY KEY,
    rua VARCHAR(100) NOT NULL,
    cep VARCHAR(9) NOT NULL,
    num_museu VARCHAR(10) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    ponto_referencia VARCHAR(150)
);

--------------------------------------------------------------------------
-- A tabela `museu` armazena informações sobre museus e faz referência ao endereço do museu.
-- Normalização:
-- 1NF: Todos os valores são atômicos. Colunas como `nm_museu` e `desc_museu` contêm informações indivisíveis sobre cada museu.
-- 2NF: Todos os atributos dependem exclusivamente da chave primária `id`. A coluna `id_endereco` faz referência ao `id` da tabela `endereco_museu`, garantindo que cada museu esteja associado a um único endereço.
-- 3NF: Não há dependências transitivas. A tabela armazena dados exclusivos do museu, como seu nome, descrição e número de telefone, enquanto a informação de endereço é mantida separada para evitar redundância.
-- Justificativa: Ao utilizar uma chave estrangeira para o endereço (`id_endereco`), asseguramos que cada museu tenha um endereço único e correto, reduzindo a duplicação de dados e facilitando a integridade e consistência dos dados de endereço.


CREATE TABLE museu (
    id VARCHAR(5) PRIMARY KEY,
    nm_museu VARCHAR(100) constraint nm_museu_nulo not null,
    desc_museu TEXT default 'Este museu passou por tanta coisa! Concorda?',
    id_endereco VARCHAR(5) REFERENCES endereco_museu(id),  -- Chave estrangeira para a tabela endereco_museu
    dt_inauguracao DATE default current_date,
    nr_tel_museu VARCHAR(20)
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
 id VARCHAR(5) PRIMARY KEY,  
 titulo_guia VARCHAR(100) constraint titulo_guia_nulo not null,  
 desc_guia TEXT default 'Este guia irá te guiar por esta sala!',  
 id_museu VARCHAR(5)
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
 id VARCHAR(5) PRIMARY KEY,
 nm_artista VARCHAR(250),  
 dt_nasc_artista DATE,  
 dt_falecimento DATE,  
 local_nasc VARCHAR(150),  
 local_morte VARCHAR(150),  
 desc_artista TEXT  
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
 id VARCHAR(5) PRIMARY KEY,
 hr_inicio VARCHAR(20),  
 hr_termino VARCHAR(20),  
 pr_dia_funcionamento FLOAT,  
 dia_semana VARCHAR(30),  
 id_museu VARCHAR(5)
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
 id VARCHAR(5) PRIMARY KEY,  
 id_museu VARCHAR(5),
 id_usuario VARCHAR(5)
);
-- A tabela usuario_museu corresponde a tabela onde será armazenado os dados quando um usuário seguir um determinado museu dentro do aplicativo. Para ver mais obras de desse museu.

CREATE TABLE obra_guia 
( 
 id VARCHAR(5) PRIMARY KEY,  
 nr_ordem INT, 
 desc_localizacao VARCHAR(500),
 id_guia VARCHAR(5),  
 id_obra VARCHAR(5)  
); 
-- A tabela obra_guia estabelece a relação entre a tabela de obras e a de guia e possui novas informações para o guia. 
-- O guia será um passo a passo para o usuário andar e ver obras pelo museu, sabendo onde ela se encontra, e com o campo nr_ordem na tabela obra_guia, poderemos saber qual order o usuário deve seguir.

CREATE TABLE artista_genero 
(
 id VARCHAR(5) PRIMARY KEY,
 id_artista VARCHAR(5),  
 id_genero VARCHAR(5) 
); 

-- A tabela artista_genero corresponde a tabela onde será armazenado o genero da obra que determinado artista possui em suas obras.

CREATE TABLE usuario_genero 
( 
 id VARCHAR(5) PRIMARY KEY,
 id_usuario VARCHAR(5),  
 id_genero VARCHAR(5)
); 

-- -- A tabela usuario_genero corresponde a tabela onde será armazenado os dados de quando após o usuário se cadastrar, ele responde uma especie de pesquisa e escolhe os generos de arte que ele mais gosta. 
-- Para que veja mais informações sobre esse genero.


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
    id_usuario VARCHAR(5)
);

CREATE TABLE log_genero (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_genero VARCHAR(5)
);

CREATE TABLE log_obra (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_obra VARCHAR(5)
);

CREATE TABLE log_museu (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_museu VARCHAR(5)
);

CREATE TABLE log_endereco (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_endereco VARCHAR(5)
);

CREATE TABLE log_guia (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_guia VARCHAR(5)
);

CREATE TABLE log_artista (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_artista VARCHAR(5)
);

CREATE TABLE log_dia_funcionamento (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_dia_funcionamento VARCHAR(5)
);

CREATE TABLE log_usuario_museu (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario_museu VARCHAR(5)
);

CREATE TABLE log_obra_guia (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_obra_guia VARCHAR(5)
);

CREATE TABLE log_artista_genero (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_artista_genero VARCHAR(5)
);

CREATE TABLE log_usuario_genero (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(50),
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario_genero VARCHAR(5)
);


--------------------------------------------------- Criação de Triggers para Log das tabelas --------------------------------------------------- 

													-- Trigger para a tabela usuário --
												
CREATE OR REPLACE FUNCTION log_usuario_operation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_usuario (operacao, data_operacao, id_usuario)
        VALUES ('INSERT', NOW(), NEW.id);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_usuario (operacao, data_operacao, id_usuario)
        VALUES ('UPDATE', NOW(), NEW.id);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_usuario (operacao, data_operacao, id_usuario)
        VALUES ('DELETE', NOW(), OLD.id);
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
        INSERT INTO log_usuario_museu (operacao, data_operacao, id_usuario_museu)
        VALUES ('INSERT', NOW(), NEW.id);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_usuario_museu (operacao, data_operacao, id_usuario_museu)
        VALUES ('UPDATE', NOW(), NEW.id);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_usuario_museu (operacao, data_operacao, id_usuario_museu)
        VALUES ('DELETE', NOW(), OLD.id);
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

													-- Trigger para a tabela usuario_genero --

CREATE OR REPLACE FUNCTION log_usuario_genero_operation()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_usuario_genero (operacao, data_operacao, id_usuario_genero)
        VALUES ('INSERT', NOW(), NEW.id);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_usuario_genero (operacao, data_operacao, id_usuario_genero)
        VALUES ('UPDATE', NOW(), NEW.id);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_usuario_genero (operacao, data_operacao, id_usuario_genero)
        VALUES ('DELETE', NOW(), OLD.id);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_log_usuario_genero
AFTER INSERT OR UPDATE OR DELETE ON usuario_genero
FOR EACH ROW
EXECUTE FUNCTION log_usuario_genero_operation();

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- Drops Normais
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
-- Drops Tabelas de Log

drop table log_usuario cascade
drop table log_genero cascade
drop table log_obra cascade
drop table log_museu cascade
drop table log_endereco cascade
drop table log_guia cascade
drop table log_artista cascade
drop table log_dia_funcionamento cascade
drop table log_usuario_museu cascade
drop table log_obra_guia cascade
drop table log_artista_genero cascade
drop table log_usuario_genero cascade

--------------------------------------------------------------------------------------------------------------------------------------------------------

-- Selects Normais

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

--------------------------------------------------------------------------------------------------------------------------------------------------------

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

