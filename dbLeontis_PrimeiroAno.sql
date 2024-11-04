--Scripts SQL/Criação das tabelas
CREATE TABLE genero 
( 
  id          SERIAL       PRIMARY KEY
, intro       VARCHAR(300) DEFAULT 'Que pena! Estamos sem essa introdução no momento.'
, nm_genero   VARCHAR(100) CONSTRAINT CT_Genero_nm_genero_nulo   NOT NULL  
                           CONSTRAINT CT_Genero_nm_genero_unico  UNIQUE
, desc_genero TEXT         CONSTRAINT CT_Genero_desc_genero_nulo NOT NULL
, url_imagem  VARCHAR(500) DEFAULT 'https://images2.imgbox.com/81/e0/sebxSny9_o.png'
); 


CREATE TABLE museu 
( 
  id               SERIAL       PRIMARY KEY
, id_museu_adm     INT          CONSTRAINT CT_Museu_id_museu_adm_nulo NOT NULL 
, cnpj             VARCHAR(14)  CONSTRAINT CT_Museu_cnpj_nulo	      NOT NULL
, cep              VARCHAR(8)   CONSTRAINT CT_Museu_cep_nulo	      NOT NULL
, nm_museu         VARCHAR(100) CONSTRAINT CT_Museu_nm_museu_nulo     NOT NULL  
                                CONSTRAINT CT_Museu_nm_museu_unico    UNIQUE
, desc_museu       TEXT         DEFAULT 'Este museu passou por tanta coisa! Concorda?' 
, dt_inauguracao   DATE         DEFAULT CURRENT_DATE 
	                            CONSTRAINT CT_dt_inauguracao_nulo 	  NOT NULL 
, rua              VARCHAR(150) CONSTRAINT CT_rua_nulo	              NOT NULL
, estado           VARCHAR(150) CONSTRAINT CT_estado_nulo             NOT NULL
, cidade           VARCHAR(150) CONSTRAINT CT_cidade_nulo             NOT NULL
, ponto_referencia VARCHAR(150) DEFAULT 'Não temos o ponto de referência desse museu! :/'                                         
, nr_tel_museu     VARCHAR(20)  DEFAULT 'Sem telefone!'
, url_imagem       VARCHAR(500) DEFAULT 'https://images2.imgbox.com/2d/47/iwT9Tl4Q_o.png'
); 



CREATE TABLE guia 
( 
  id          SERIAL       PRIMARY KEY
, id_museu    INT          CONSTRAINT CT_Guia_id_museu_nulo    NOT NULL 
, titulo_guia VARCHAR(100) CONSTRAINT CT_Guia_titulo_guia_nulo NOT NULL  
, desc_guia   TEXT         DEFAULT 'Este guia irá te guiar por esta sala!'  
, url_imagem  VARCHAR(500) DEFAULT 'https://images2.imgbox.com/81/e0/sebxSny9_o.png'
); 


CREATE TABLE artista 
( 
  id		 	  SERIAL       PRIMARY KEY
, nm_artista 	  VARCHAR(100) CONSTRAINT CT_Artista_nm_artista_nulo      NOT NULL
, desc_artista    TEXT         DEFAULT 'Poxa! Esse artista está sem descrição no momento. :/'
, dt_nasc_artista DATE         CONSTRAINT CT_Artista_dt_nasc_artista_nulo NOT NULL  
, dt_falecimento  DATE         CONSTRAINT CK_Artista_dt_falecimento_invalida 
							   CHECK (dt_falecimento>dt_nasc_artista)
, local_nasc 	  VARCHAR(100) CONSTRAINT CT_Artista_local_nasc_nulo      NOT NULL  
				  DEFAULT 'Não sabemos onde esse artista nasceu! D:'
, local_morte     VARCHAR(100)  
, url_imagem 	  VARCHAR(500) DEFAULT 'https://images2.imgbox.com/53/cc/zbWjH7OF_o.png'
); 


CREATE TABLE dia_funcionamento
( 
  id 				   SERIAL      PRIMARY KEY
, id_museu             INT         CONSTRAINT CT_DiaFuncionamento_id_museu_dia_nulo NOT NULL
, hr_inicio 		   CHAR(5) 	   CONSTRAINT CT_DiaFuncionamento_hr_inicio_nulo    NOT NULL  
, hr_termino           CHAR(5)     CONSTRAINT CT_DiaFuncionamento_hr_termino_nulo   NOT NULL  
								   CONSTRAINT CK_DiaFuncionamento_hr_inicio_termino_invalida 
								   CHECK (
									       (REPLACE(hr_inicio,':',''))::INT <
									       (REPLACE(hr_termino,':',''))::INT
									     )
, pr_dia_funcionamento DECIMAL     DEFAULT 0
	                               CONSTRAINT CK_DiaFuncionamento_preco_negativo 
								   CHECK(pr_dia_funcionamento>=0) 
, dia_semana           VARCHAR(20) CONSTRAINT CT_DiaFuncionamento_dia_semana_nulo   NOT NULL
	                               CONSTRAINT CK_DiaFuncionamento_dia_semana_invalido
	                               CHECK(dia_semana IN ('seg', 'ter', 'qua', 'qui', 'sex', 'sab', 'dom'))
); 



CREATE TABLE usuario_museu 
(
  id         SERIAL PRIMARY KEY  
, id_museu   INT    CONSTRAINT CT_UsuarioMuseu_id_museu_nulo   NOT NULL  
, id_usuario INT    CONSTRAINT CT_UsuarioMuseu_id_usuario_nulo NOT NULL
); 



CREATE TABLE obra_guia 
( 
  id 	           SERIAL       PRIMARY KEY
, id_guia          INT          CONSTRAINT CT_ObraGuia_id_guia_nulo NOT NULL  
, id_obra          INT          CONSTRAINT CT_ObraGuia_id_obra_nulo NOT NULL
, nr_ordem         INT          CONSTRAINT CK_ObraGuia_nr_ordem_negativo 
	                            CHECK(nr_ordem>0)
, desc_localizacao VARCHAR(500) DEFAULT 'Não sabemos a localização dessa obra, será que é um mistério?'
); 


CREATE TABLE artista_genero 
(
  id 		 SERIAL PRIMARY KEY
, id_artista INT    CONSTRAINT CT_ArtistaGenero_id_artista_nulo NOT NULL  
, id_genero  INT    CONSTRAINT CT_ArtistaGenero_id_genero_nulo  NOT NULL
);  

CREATE TABLE usuario_genero 
( 
  id 		 SERIAL PRIMARY KEY
, id_usuario INT    CONSTRAINT CT_UsuarioGenero_id_usuario_nulo NOT NULL  
, id_genero  INT    CONSTRAINT CT_UsuarioGenero_id_genero_nulo  NOT NULL
); 



CREATE TABLE obra
( 
  id 		 SERIAL 	  PRIMARY KEY
, id_genero  INT            
, id_artista INT          
, id_museu   INT 		  CONSTRAINT CT_Obra_id_museu_nulo   NOT NULL
, ano_inicio INT 		  CONSTRAINT CT_Obra_ano_inicio_nulo NOT NULL
						  CONSTRAINT CK_Obra_ano_inicio_negativo
	                      CHECK (ano_inicio>=0)
, ano_final  INT 		  CONSTRAINT CT_Obra_ano_final_nulo  NOT NULL
						  CONSTRAINT CK_Obra_ano_final_invalido
	                      CHECK (ano_final>=ano_inicio)  
, desc_obra  TEXT         DEFAULT 'Que obra linda! Não é mesmo?' 
, nm_obra    VARCHAR(100) CONSTRAINT CT_Obra_nm_obra_nulo    NOT NULL  
, url_imagem VARCHAR(500) DEFAULT 'https://images2.imgbox.com/a7/0b/g4U2zcSy_o.png'
); 



CREATE TABLE usuario
( 
  id 			   SERIAL 	    PRIMARY KEY
, nm_usuario	   VARCHAR(100) CONSTRAINT CT_Usuario_nm_usuario_nulo     	NOT NULL 
, sobrenome        VARCHAR(100) CONSTRAINT CT_Usuario_sobrenome_nulo      	NOT NULL
, email_usuario    VARCHAR(100) CONSTRAINT CT_Usuario_email_usuario_nulo  	NOT NULL   
, nr_tel_usuario   VARCHAR(20)  CONSTRAINT CT_Usuario_nr_tel_usuario_nulo   NOT NULL  
, dt_nasci_usuario DATE 		CONSTRAINT CT_Usuario_dt_nasci_usuario_nulo NOT NULL
, biografia		   VARCHAR(280) DEFAULT 'Oi, eu estou usando o Leontis!'  
, sexo 			   CHAR(1)      CONSTRAINT CT_Usuario_sexo_nulo           	NOT NULL 
								CONSTRAINT CK_Usuario_sexo_invalido 
                                CHECK(sexo IN ('M','F','O'))
, apelido		   VARCHAR(100)  
, senha_usuario    VARCHAR(100) CONSTRAINT CT_Usuario_senha_usuario_nulo  	NOT NULL
, url_imagem 	   VARCHAR(500) DEFAULT 'https://images2.imgbox.com/53/cc/zbWjH7OF_o.png'
); 



CREATE TABLE museu_adm
(
  id 			SERIAL       PRIMARY KEY
, email_adm     VARCHAR(100) UNIQUE 
	                         CONSTRAINT CT_MuseuAdm_email_adm_nulo NOT NULL 
, senha_adm 	VARCHAR(100) CONSTRAINT CT_MuseuAdm_senha_adm_nula NOT NULL
	                         DEFAULT 'Mus@Senha'
);

-- Relações de Chaves Estrangeiras

ALTER TABLE obra 		      ADD FOREIGN KEY(id_genero)  	REFERENCES genero    (id);
ALTER TABLE obra 			  ADD FOREIGN KEY(id_artista) 	REFERENCES artista   (id);
ALTER TABLE obra 			  ADD FOREIGN KEY(id_museu)   	REFERENCES museu     (id);
ALTER TABLE guia 			  ADD FOREIGN KEY(id_museu)   	REFERENCES museu     (id);
ALTER TABLE dia_funcionamento ADD FOREIGN KEY(id_museu) 	REFERENCES museu     (id);
ALTER TABLE usuario_museu     ADD FOREIGN KEY(id_museu) 	REFERENCES museu     (id);
ALTER TABLE usuario_museu     ADD FOREIGN KEY(id_usuario)   REFERENCES usuario   (id);
ALTER TABLE obra_guia 		  ADD FOREIGN KEY(id_guia) 		REFERENCES guia      (id);
ALTER TABLE obra_guia         ADD FOREIGN KEY(id_obra)      REFERENCES obra      (id);
ALTER TABLE artista_genero    ADD FOREIGN KEY(id_artista)   REFERENCES artista   (id);
ALTER TABLE artista_genero    ADD FOREIGN KEY(id_genero)    REFERENCES genero    (id);
ALTER TABLE usuario_genero    ADD FOREIGN KEY(id_usuario)   REFERENCES usuario   (id);
ALTER TABLE usuario_genero    ADD FOREIGN KEY(id_genero) 	REFERENCES genero    (id);
ALTER TABLE museu 			  ADD FOREIGN KEY(id_museu_adm) REFERENCES museu_adm (id);

-- Criação da Tabela de Log
CREATE TABLE log_geral (
    id SERIAL PRIMARY KEY,
    tabela VARCHAR(50) NOT NULL,
    id_registro BIGINT NOT NULL,
    operacao VARCHAR(50) NOT NULL,
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Triggers 

CREATE OR REPLACE FUNCTION log_artista_operation()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('artista', NEW.id, 'INSERT');
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('artista', NEW.id, 'UPDATE');
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('artista', OLD.id, 'DELETE');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_artista
AFTER INSERT OR UPDATE OR DELETE ON artista
FOR EACH ROW
EXECUTE FUNCTION log_artista_operation();

--

CREATE OR REPLACE FUNCTION log_artista_genero_operation()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('artista_genero', NEW.id, 'INSERT');
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('artista_genero', NEW.id, 'UPDATE');
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('artista_genero', OLD.id, 'DELETE');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_artista_genero
AFTER INSERT OR UPDATE OR DELETE ON artista_genero
FOR EACH ROW
EXECUTE FUNCTION log_artista_genero_operation();

--

CREATE OR REPLACE FUNCTION log_dia_funcionamento_operation()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('dia_funcionamento', NEW.id, 'INSERT');
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('dia_funcionamento', NEW.id, 'UPDATE');
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('dia_funcionamento', OLD.id, 'DELETE');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_dia_funcionamento
AFTER INSERT OR UPDATE OR DELETE ON dia_funcionamento
FOR EACH ROW
EXECUTE FUNCTION log_dia_funcionamento_operation();

--

CREATE OR REPLACE FUNCTION log_genero_operation()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('genero', NEW.id, 'INSERT');
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('genero', NEW.id, 'UPDATE');
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('genero', OLD.id, 'DELETE');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_genero
AFTER INSERT OR UPDATE OR DELETE ON genero
FOR EACH ROW
EXECUTE FUNCTION log_genero_operation();

--

CREATE OR REPLACE FUNCTION log_guia_operation()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('guia', NEW.id, 'INSERT');
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('guia', NEW.id, 'UPDATE');
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('guia', OLD.id, 'DELETE');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_guia
AFTER INSERT OR UPDATE OR DELETE ON guia
FOR EACH ROW
EXECUTE FUNCTION log_guia_operation();

--

CREATE OR REPLACE FUNCTION log_museu_operation()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('museu', NEW.id, 'INSERT');
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('museu', NEW.id, 'UPDATE');
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('museu', OLD.id, 'DELETE');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_museu
AFTER INSERT OR UPDATE OR DELETE ON museu
FOR EACH ROW
EXECUTE FUNCTION log_museu_operation();

--

CREATE OR REPLACE FUNCTION log_obra_operation()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('obra', NEW.id, 'INSERT');
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('obra', NEW.id, 'UPDATE');
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('obra', OLD.id, 'DELETE');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_obra
AFTER INSERT OR UPDATE OR DELETE ON obra
FOR EACH ROW
EXECUTE FUNCTION log_obra_operation();

--

CREATE OR REPLACE FUNCTION log_obra_guia_operation()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('obra_guia', NEW.id, 'INSERT');
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('obra_guia', NEW.id, 'UPDATE');
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES ('obra_guia', OLD.id, 'DELETE');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_obra_guia
AFTER INSERT OR UPDATE OR DELETE ON obra_guia
FOR EACH ROW
EXECUTE FUNCTION log_obra_guia_operation();


-- Inserções para Teste

TRUNCATE TABLE artista           RESTART IDENTITY CASCADE;
TRUNCATE TABLE artista_genero    RESTART IDENTITY CASCADE;
TRUNCATE TABLE genero            RESTART IDENTITY CASCADE;
TRUNCATE TABLE dia_funcionamento RESTART IDENTITY CASCADE;
TRUNCATE TABLE guia              RESTART IDENTITY CASCADE;
TRUNCATE TABLE obra  			 RESTART IDENTITY CASCADE;
TRUNCATE TABLE obra_guia		 RESTART IDENTITY CASCADE;
TRUNCATE TABLE museu 			 RESTART IDENTITY CASCADE;
TRUNCATE TABLE museu_adm 		 RESTART IDENTITY CASCADE;
TRUNCATE TABLE usuario 			 RESTART IDENTITY CASCADE;
TRUNCATE TABLE usuario_genero 	 RESTART IDENTITY CASCADE;
TRUNCATE TABLE usuario_museu 	 RESTART IDENTITY CASCADE;

--DATALOAD Primeiro Ano
					
--Inserções Gênero

INSERT INTO genero ( nm_genero
				   , intro
				   , desc_genero
				   , url_imagem
				   ) 
		    VALUES ( 'Simbolismo'
				   , 'A poesia simbolista apresenta teor metafísico, musicalidade, alienação social, rigor formal e caráter sinestésico.'
				   , 'O Simbolismo é um movimento literário da poesia e das outras artes que surgiu na França, no final do século XIX, como oposição ao realismo, ao naturalismo e ao positivismo da época.' 
				   , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/generos%2Fgenero1.jpg?alt=media&token=fec1120b-fed6-4a5a-b529-1a839a22e1f8'
				   )
				   ,
				   ( 'Natureza-morta'
				   , 'Esse tipo de pintura surgiu no século XVI e o objetivo era representar objetos inanimados como flores, frutas, jarros de metal, taças de cristal, vidros, porcelanas e muitas outras coisas.'
				   , 'O termo “Natureza-morta” deriva do holandês stilleven, em inglês, still-life, que significa uma composição de objetos ou seres inanimados, silenciosos, discretos, incapazes de movimento, com a vida em suspenso.'
				   , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/generos%2Fgenero2.jpg?alt=media&token=56843782-c93f-4987-b5a8-bf319d7ee96a'
				   )
				   ,
				   ( 'Paisagem'
				   , 'A arte paisagem se caracteriza pela representação de cenários naturais, com foco na composição espacial, uso da luz e cor e detalhamento dos elementos.'
				   , 'A arte paisagem se concentra na representação de cenários naturais, como montanhas e rios, e utiliza a perspectiva para criar profundidade e uma composição equilibrada. Os artistas exploram a luz e a cor para evocar diferentes atmosferas e emoções, variando de representações detalhadas a estilos mais impressionistas ou abstratos. A arte paisagem também pode incluir figuras ou estruturas humanas para mostrar a interação entre o homem e a natureza, refletindo sentimentos como tranquilidade ou grandiosidade, e oferecendo uma visão diversa dependendo do estilo artístico adotado.'
				   , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/generos%2Fgenero3.jpg?alt=media&token=681e2ccb-837a-478a-ad7a-cb2043152089'
				   )
				   ,
				   ( 'Surrealista'
				   , 'Os artistas surrealistas tinham como objetivo usar o potencial do subconsciente e dos sonhos como fonte para a criação de imagens fantásticas.'
				   , ' O surrealismo é um dos movimentos europeus de vanguarda do início do século XX. Ele é caracterizado, principalmente, pela construção de imagens oníricas (tudo aquilo que se refere ou faz parte do que é sonhado ou parte de um lugar fantasioso)'
				   , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/generos%2Fgenero4.jpg?alt=media&token=ed796aae-b9de-4d95-bfa4-f693f86846d7'
				   )
				   ,
				   ( 'Impressionista'
				   , 'A proposta central do movimento impressionista consistia em representar, por meio das artes visuais, sobretudo na pintura, os efeitos luminosos no ambiente.'
				   , 'Além disso, buscava expressar as impressões pessoais dos artistas em relação ao que observavam, utilizando para isso cores primárias, também conhecidas como cores puras.'
				   , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/generos%2Fgenero5.jpg?alt=media&token=f409edde-d157-401c-8fb2-07e17ad855f7'
				   )
				   ,
				   ( 'Cubista'
				   , 'O cubismo é marcado pela representação de figuras da natureza a partir do uso de formas geométricas, promovendo a fragmentação e decomposição dos planos e perspectivas. '
				   , 'O cubismo teve como principal característica a representação das figuras em vários planos, buscando chegar a uma "tridimensionalidade" na pintura, exibindo as formas em planos irregulares. O artista cubista abdica do compromisso de utilizar a aparência real das coisas, como acontecia durante o Renascimento.'
				   , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/generos%2Fgenero6.jpg?alt=media&token=acedc81a-83df-49cf-a628-4956dd31d9e1'
				   )
				   ,
				   ( 'Abstrata'
				   , 'A arte abstrata, como seu próprio nome indica, trata-se de um estilo artístico que foca nas abstrações, e não na realidade. Em outras palavras: a arte abstrata não tenta reproduzir o mundo a partir de imagens conhecidas ou de formas definidas da realidade.'
				   ,'Definição. Em sentido amplo, abstracionismo refere-se às formas de arte não regidas pela figuração e pela imitação do mundo.'
				   , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/generos%2Fgenero7.jpg?alt=media&token=a404dd6c-ba41-42a6-bd88-5bae40fb7318'
				   )
				   ,
				   ( 'Retrato'
				   , 'O retrato é um gênero na pintura, ou na fotografia onde a intenção é descrever um sujeito humano.'
				   , 'O retrato é um gênero artístico que representa pessoas, focando em capturar suas características físicas e emoções. Desde a Antiguidade, evoluiu para incorporar maior realismo e profundidade psicológica'
				   , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/generos%2Fgenero8.jpg?alt=media&token=bf0b1044-3dbe-4dfe-b7a2-75c61cb99efb'
				   )
				   ,
				   ( 'Modernista'
				   , 'O modernismo na pintura, que emergiu no final do século XIX e início do XX, é um movimento que rompeu com tradições artísticas, explorando novas formas de expressão através da abstração, fragmentação e experimentação com cores e formas. '
				   , 'Com estilos variados como Impressionismo, Cubismo, Expressionismo e Surrealismo, os modernistas buscaram capturar experiências subjetivas e desafiavam normas estéticas, influenciando profundamente a arte e a cultura e abrindo caminho para a arte contemporânea.'
				   , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/generos%2Fgenero9.jpg?alt=media&token=d1230c06-5c4b-4c04-be6d-f075d005d80b'
				   )
				   ,
				   ( 'Contemporânea'
				   , 'Arte contemporânea é uma tendência artística que se construiu a partir do pós-modernismo, apresentando expressões e técnicas artísticas inovadoras, que incentivam a reflexão subjetiva sobre a obra.'
				   , 'É um estilo artístico que surgiu a partir da segunda metade do século XX, após o término da Segunda Guerra Mundial. Por conta disso, também é chamada de Arte do Pós-guerra, apesar de não ser possível definir um momento exato da sua origem.'
				   , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/generos%2Fgenero10.jpg?alt=media&token=1e7df4ce-cc2f-4c09-9b76-7f6f9ee34836'
				   );


INSERT INTO genero ( nm_genero
				   , intro
				   , desc_genero
				   , url_imagem
				   )
			VALUES ( 'Realismo'
				   , 'O Realismo é um estilo artístico que busca representar a realidade de forma objetiva, sem idealizações, focando em cenas do cotidiano e em pessoas comuns.'
				   , 'O Realismo é um movimento artístico que emergiu na França na segunda metade do século XIX como uma reação ao Romantismo e ao Idealismo. Seus principais objetivos eram representar a vida cotidiana e as experiências das classes sociais menos favorecidas, retratando a realidade sem idealizações. Os artistas realistas buscavam a verossimilhança, utilizando detalhes minuciosos e uma paleta de cores naturalista. Obras emblemáticas incluem "O enterro em Ornans" de Gustave Courbet e "A pedra quebrada" de Jean-François Millet. O Realismo influenciou não apenas a pintura, mas também a literatura e o teatro, promovendo uma visão crítica da sociedade da época.'
				   , 'imagem realismo'	
				   );

INSERT INTO genero ( nm_genero
				   , intro
				   , desc_genero
				   , url_imagem
				   )
			VALUES ( 'Academicismo'
				   , 'O Academicismo é um estilo artístico que seguia rígidas normas acadêmicas, valorizando a técnica perfeita, temas históricos e mitológicos, e a representação idealizada da realidade.'
				   , 'O Academicismo é um movimento artístico que se desenvolveu na Europa entre os séculos XVII e XIX, caracterizado pela adesão rigorosa a normas e técnicas estabelecidas pelas academias de arte. Esse estilo valoriza a técnica, a proporção e a perspectiva, baseando-se em modelos clássicos da Antiguidade e do Renascimento. Os acadêmicos acreditavam na importância da formação técnica e no estudo das obras dos mestres. Temas frequentemente abordados incluem mitologia, história e retratos, com uma ênfase na idealização da figura humana. Embora tenha promovido a excelência técnica, o Academicismo foi criticado por sua rigidez e falta de inovação, sendo eventualmente desafiado por movimentos como o Impressionismo e o Realismo.'
				   , 'imagem academicismo'
				   );

INSERT INTO genero ( nm_genero
				   , intro
				   , desc_genero
				   , url_imagem
				   )
			VALUES ( 'Barroco'
				   , 'O Barroco é um estilo artístico que floresceu entre os séculos XVI e XVIII, caracterizado pelo exagero, contraste, dramaticidade e pela exploração de temas religiosos e existenciais.'
				   , 'O Barroco é um movimento artístico que floresceu na Europa entre os séculos XVII e XVIII, caracterizado por seu estilo exuberante e dramático. Surgido como uma resposta às tensões sociais, políticas e religiosas da época, o Barroco busca evocar emoção e grandiosidade através de formas complexas, contrastes de luz e sombra (chiaroscuro) e ornamentação elaborada. Nas artes plásticas, os artistas barrocados, como Caravaggio e Rembrandt, exploraram temas religiosos, mitológicos e cotidianos, enquanto a arquitetura barroca se destacou por suas linhas curvas e fachadas ricamente decoradas. O Barroco também influenciou a música e a literatura, refletindo a complexidade da experiência humana.'
				   , 'imagem Barroco'
				   );
				   
INSERT INTO genero ( nm_genero
				   , intro
				   , desc_genero
				   , url_imagem
				   )
			VALUES ( 'Naturalismo'
				   , 'O Naturalismo é uma corrente artística que busca representar a realidade de forma objetiva e detalhada, explorando as influências do meio ambiente e da hereditariedade sobre o comportamento humano.'
				   , 'O Naturalismo é um movimento artístico e literário que surgiu no final do século XIX como uma extensão do Realismo, buscando representar a vida e a natureza de forma ainda mais precisa e científica. Influenciado pelas teorias de Charles Darwin e pelo avanço das ciências, o Naturalismo enfatiza a observação minuciosa e a representação fiel do mundo ao redor, focando em temas como a hereditariedade, o meio ambiente e a condição humana. Na pintura, artistas como Gustave Courbet e Émile Zola retrataram a vida cotidiana, enquanto na literatura, autores como Émile Zola e Guy de Maupassant exploraram as motivações e influências sociais que moldam os personagens, buscando um retrato mais cru e realista da existência.'
				   , 'imagem Naturalismo'
				   );
				   
INSERT INTO genero ( nm_genero
				   , intro
				   , desc_genero
				   , url_imagem
				   )
			VALUES ( 'Fotografia'
				   , 'A fotografia é a arte e técnica de capturar imagens por meio de uma câmera, utilizando a luz para registrar momentos, cenas ou objetos. Ela pode ser usada de forma artística, documental ou comercial, e é uma das principais formas de expressão visual.'
				   , 'A fotografia, arte e comunicação, começou a se desenvolver no início do século XIX. O conceito de capturar imagens remonta a práticas como a câmara escura. A primeira fotografia permanente foi criada em 1826 por Joseph Nicéphore Niépce, mas o daguerreótipo, apresentado por Louis Daguerre em 1839, popularizou a técnica. Ao longo do século XIX, inovações como negativos de vidro facilitaram a reprodução de imagens. No século XX, a fotografia se tornou essencial para documentar eventos históricos e movimentos sociais. Com a chegada da fotografia digital, no final do século XX, a prática se expandiu, tornando-se parte da cultura global.'
				   , 'imagem Fotografia'
				   );
				   
INSERT INTO genero ( nm_genero
				   , intro
				   , desc_genero
				   , url_imagem
				   )
			VALUES ( 'Historicismo'
				   , 'O historicismo é um estilo artístico que se caracteriza pela imitação ou recriação de estilos artísticos históricos ou do trabalho de artesãos e artistas históricos.'
				   , 'O historicismo é um movimento artístico e arquitetônico que emergiu no século XIX, caracterizado pela revitalização de estilos do passado, como o gótico, o renascentista e o barroco. Esse gênero busca a recriação de formas e elementos históricos, refletindo um interesse profundo pela história e pela cultura. O historicismo é frequentemente associado à busca de identidade nacional e à construção de monumentos que celebram eventos significativos. Embora tenha promovido a diversidade estética, também foi criticado por sua falta de originalidade, tornando-se um reflexo das tensões entre tradição e modernidade na arte e na arquitetura.'
				   , 'imagem historicismo'
				   );				   


-- MUSEU ADM

INSERT INTO museu_adm ( email_adm
					  , senha_adm 
					  )
			   VALUES ( 'adm_pinacoteca@gmail.com'
					  , 'Mus@Senha'
			          )
					  , 
					  ( 'adm_ims@outlook.com'
					  , 'Mus@Senha'
					  )
					  ,
					  ( 'adm_ipiranga@hotmail.com'
					  , 'Mus@Senha'
					  )
					  ,
					  ( 'adm_mam@gmail.com'
					  , 'Mus@Senha'
					  )
					  ,
					  ( 'adm_mnba@hotmail.com'
					  , 'Mus@Senha'
					  )
					  ;
 


--------------------------
--INSERTS Museu
--------------------------

INSERT INTO museu ( nm_museu
				  , desc_museu
				  , dt_inauguracao
				  , nr_tel_museu
				  , cidade
				  , estado
				  , rua
				  , ponto_referencia
				  , cep
				  , id_museu_adm
				  , cnpj
				  , url_imagem
				  ) 
		   VALUES ( 'Museu Nacional de Belas Artes (MNBA)'
				  , 'Dedicada à conservação, divulgação e aquisição de obras representativas da produção artística brasileira - séculos XIX e XX - em seu diálogo com as obras e a tradição artística das escolas estrangeiras.'
				  , '1938-08-19'
				  , '2122626067'
				  , 'Rio de Janeiro'
				  , 'RJ'
				  , 'Av. Rio Branco, 199'
				  , DEFAULT
				  , '20040008'
				  , ( SELECT id
					    FROM museu_adm
					   WHERE email_adm LIKE '%mnba%'
					)
				  , '24400445000127'
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/museus%2Fmuseu1.jpg?alt=media&token=105ffb24-f656-4e4a-896b-553d74225ea7'
				  );


INSERT INTO museu ( cnpj
				  , cep
				  , nm_museu
				  , desc_museu
				  , dt_inauguracao
				  , rua
				  , estado
				  , cidade
				  , ponto_referencia
				  , nr_tel_museu
				  , url_imagem
				  , id_museu_adm
				  )
		   VALUES ( '67444132000183'
				  , '01120010'
				  , 'Pinacoteca de São Paulo'
				  , 'A Pinacoteca do Estado de São Paulo é um dos mais importantes museus de arte do Brasil. Ocupa um edifício construído em 1900, no Jardim da Luz, centro de São Paulo, projetado por Ramos de Azevedo e Domiziano Rossi para ser a sede do Liceu de Artes e Ofícios. '
				  , '1905-12-25'
				  , 'Praça da Luz, 2'
				  , 'SP'
				  , 'São Paulo'
				  , 'Perto da Estação da Luz'
				  , '1133241000'
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/museus%2Fmuseu60.jpg?alt=media&token=7a28620b-823c-4839-b19c-662bcf897694'
				  , (SELECT ma.id 
					   FROM museu_adm ma
					  WHERE ma.email_adm LIKE '%pinacoteca%'
					)
				  )
				  , 
				  ( '48113965000117'
				  , '01310300'
				  , 'Instituto Moreira Salles (IMS Paulista)'
				  , 'Inaugurado em 20 de setembro de 2017, o IMS Paulista abriga toda a programação organizada pelo instituto na cidade, substituindo o IMS Higienópolis (1996-2016). São nove andares, todos com pé-direito duplo, em um prédio realizado a partir de conceitos sustentáveis. Além das áreas para exposições, com mais de 1200 metros quadrados, o IMS Paulista conta também com um cineteatro – onde acontecem mostras de filmes, eventos musicais, seminários e debates –, uma Biblioteca de Fotografia, salas de aula, a loja-livraria IMS por Travessa e o café-restaurante Balaio.'
				  , '2017-09-26'
				  , 'Av. Paulista, 2424'
				  , 'SP'
				  , 'São Paulo'
				  , DEFAULT
				  , '1128429120'
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/museus%2Fmuseu61.jpg?alt=media&token=e0601bc9-eeaf-4353-9a97-c88fe0f8a85f'
				  , (SELECT ma.id 
					   FROM museu_adm ma
					  WHERE ma.email_adm LIKE '%ims%'
					)
				  )
				  ,
				  ( '94106120000111'
				  , '04263000'
				  , 'Museu do Ipiranga'
				  , 'Museu Paulista da Universidade de São Paulo, também conhecido como Museu do Ipiranga ou Museu Paulista, é o museu público mais antigo da cidade de São Paulo, cuja sede é um monumento-edifício que faz parte do conjunto arquitetônico do Parque da Independência.'
				  , '1895-09-07'
				  , 'Parque da Independência'
				  , 'SP'
				  , 'São Paulo'
				  , DEFAULT
				  , '1120658000'
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/museus%2Fmuseu62.jpg?alt=media&token=12ef2e11-210c-4c9a-980c-6df88ae38e84'
				  , (SELECT ma.id
					   FROM museu_adm ma
					  WHERE ma.email_adm LIKE '%ipiranga%'
					)
				  )
				  , 
				  ( '85299024000146'
				  , '04094000'
				  , 'Museu de Arte Moderna de São Paulo (MAM)'
				  , 'O Museu de Arte Moderna de São Paulo é uma das mais importantes instituições culturais do Brasil. Localiza-se sob a marquise do Parque Ibirapuera, em São Paulo, em um edifício inserido no conjunto arquitetônico projetado por Oscar Niemeyer em 1954 e reformado por Lina Bo Bardi em 1982 para abrigar o museu.'
				  , '06-10-1948'
				  , 'Av. Pedro Álvares Cabral'
				  , 'SP'
				  , 'São Paulo'
				  , DEFAULT
				  , '1150851300'
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/museus%2Fmuseu62.jpg?alt=media&token=12ef2e11-210c-4c9a-980c-6df88ae38e84'
				  , (SELECT ma.id
					   FROM museu_adm ma
					  WHERE ma.email_adm LIKE '%mam%'
					)
				  );
				  
--------------------------
--INSERTS dia_funcionamento
--------------------------
INSERT INTO dia_funcionamento ( hr_inicio
							  , hr_termino
							  , pr_dia_funcionamento
							  , dia_semana
							  , id_museu
							  )
							  --Horários da Pinacoteca
					   VALUES ( '10:00'
							  , '18:00'
							  , 30
							  , 'dom'
							  , (SELECT id 
								   FROM museu
								  WHERE nm_museu LIKE '%Pinacoteca%'
								)
							  )
							  ,
							  ( '10:00'
							  , '18:00'
							  , 30
							  , 'seg'
							  , (SELECT id 
								   FROM museu
								  WHERE nm_museu LIKE '%Pinacoteca%'
								)
							  )
							  ,
							  ( '10:00'
							  , '18:00'
							  , 30
							  , 'qua'
							  , (SELECT id 
								   FROM museu
								  WHERE nm_museu LIKE '%Pinacoteca%'
								)
							  )
							  ,
							  ( '10:00'
							  , '18:00'
							  , 30
							  , 'qui'
							  , (SELECT id 
								   FROM museu
								  WHERE nm_museu LIKE '%Pinacoteca%'
								)
							  )
							  ,
							  ( '10:00'
							  , '20:00'
							  , 30
							  , 'sex'
							  , (SELECT id 
								   FROM museu
								  WHERE nm_museu LIKE '%Pinacoteca%'
								)
							  )
							  , 
							  ( '10:00'
							  , '18:00'
							  , 30
							  , 'sab'
							  , (SELECT id 
								   FROM museu
								  WHERE nm_museu LIKE '%Pinacoteca%'
								)
							  )
							  , 
							  --Horários do IMS
							  ( '10:00'
							  , '20:00'
							  , 0
							  , 'dom'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%IMS%'
								)
							  )
							  ,
							  ( '10:00'
							  , '20:00'
							  , 0
							  , 'ter'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%IMS%'
								)
							  )
							  ,
							  ( '10:00'
							  , '20:00'
							  , 0
							  , 'qua'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%IMS%'
								)
							  )
							  ,
							  ( '10:00'
							  , '20:00'
							  , 0
							  , 'qui'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%IMS%'
								) 
							  ) 
							  ,
							  ( '10:00'
							  , '20:00'
							  , 0
							  , 'sex'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%IMS%'
								)
							  )
							  ,
							  ( '10:00'
							  , '20:00'
							  , 0
							  , 'sab'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%IMS%'
								)
							  )
							  ,
							  --Horários Museu do Ipiranga
							  ( '10:00'
							  , '17:00'
							  , 30
							  , 'dom'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%Ipiranga%'
								)
							  )
							  ,
							  ( '10:00'
							  , '17:00'
							  , 30
							  , 'ter'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%Ipiranga%'
								)
							  )
							  ,
							  ( '10:00'
							  , '17:00'
							  , 0
							  , 'qua'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%Ipiranga%'
								)
							  )
							  ,
							  ( '10:00'
							  , '17:00'
							  , 30
							  , 'qui'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%Ipiranga%'
								)
							  )
							  ,
							  ( '10:00'
							  , '17:00'
							  , 30
							  , 'sex'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%Ipiranga%'
								)
							  )
							  ,
							  ( '10:00'
							  , '17:00'
							  , 30
							  , 'sab'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%Ipiranga%'
								)
							  )
							  , 
							  ( '10:00'
							  , '17:00'
							  , 30
							  , 'dom'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%Ipiranga%'
								)
							  )
							  --Horários MAM
							  ,
							  ( '10:00'
							  , '18:00'
							  , 30
							  , 'dom'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%MAM%'
								)
							  )
							  ,
							  ( '10:00'
							  , '18:00'
							  , 30
							  , 'ter'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%MAM%'
								)
							  )
							  ,
							  ( '10:00'
							  , '18:00'
							  , 30
							  , 'qua'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%MAM%'
								)
							  )
							  ,
							  ( '10:00'
							  , '18:00'
							  , 30
							  , 'qui'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%MAM%'
								)
							  )
							  ,
							  ( '10:00'
							  , '18:00'
							  , 30
							  , 'sex'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%MAM%'
								)
							  )
							  ,
							  ( '10:00'
							  , '18:00'
							  , 30
							  , 'sab'
							  , (SELECT id
								   FROM museu
								  WHERE nm_museu LIKE '%MAM%'
								)
							  )
							  ,
							  ( '10:00'
							  , '18:00'
							  , 8
							  , 'ter'
							  , ( SELECT id
								    FROM museu
							       WHERE nm_museu LIKE '%MNBA%'
								)
							  )
							  ,
							  ( '10:00'
							  , '18:00'
							  , 8
							  , 'qua'
							  , ( SELECT id
								    FROM museu
							       WHERE nm_museu LIKE '%MNBA%'
								)
							  )
							  ,
							  ( '10:00'
							  , '18:00'
							  , 8
							  , 'qui'
							  , ( SELECT id
								    FROM museu
							       WHERE nm_museu LIKE '%MNBA%'
								)
							  )
							  ,
							  ( '10:00'
							  , '18:00'
							  , 8
							  , 'sex'
							  , ( SELECT id
								    FROM museu
							       WHERE nm_museu LIKE '%MNBA%'
								)
							  )
							  ,
							  ( '12:00'
							  , '17:00'
							  , 8
							  , 'sab'
							  , ( SELECT id
								    FROM museu
							       WHERE nm_museu LIKE '%MNBA%'
								)
							  )
							  ,
							  ( '12:00'
							  , '17:00'
							  , 8
							  , 'dom'
							  , ( SELECT id
								    FROM museu
							       WHERE nm_museu LIKE '%MNBA%'
								)
							  )
							  ;
							  
--------------------------
--INSERTS Artista
--------------------------
INSERT INTO artista ( nm_artista
					, dt_nasc_artista
					, dt_falecimento
					, local_nasc
					, local_morte
					, desc_artista
					, url_imagem
					)
					
					--Artistas MAM				
			 VALUES ( 'Dudi Maia Rosa'
					, '1946-12-26'
					, DEFAULT 
					, 'São Paulo, Brasil'
					, DEFAULT
					, 'Dudi é um artista plástico brasileiro inaugurou em exposições individuais na Cooperativa dos Artistas Plásticos de São Paulo (1980) e na Galeria São Paulo (1982), procedimentos pioneiros de questionamento da pintura a partir da utilização de suportes e materiais diferenciados que permanecem como marcas de seu trabalho até hoje.'
					, 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/artistas%2Fartista20.jpg?alt=media&token=c74f187d-cbf0-4e9c-a4f3-4bfe4543c838'
					)
					,
					( 'Almeida Júnior'
					, '1850-05-08'
					, '1899-11-13'
					, 'São Paulo, Brasil'
					, 'São Paulo, Brasil'
					, 'Almeida Júnior foi um importante pintor brasileiro do realismo. Nascido em Itu, São Paulo, estudou na Academia Imperial de Belas Artes e em Paris. Ele retratou cenas da vida cotidiana e paisagens rurais, destacando o homem do campo e temas regionais, rompendo com a tradição de retratar apenas a elite. Obras como "Caipira Picando Fumo" e "Leitura" são exemplos de sua técnica detalhista e sensibilidade social. Sua arte influenciou o desenvolvimento de uma identidade visual genuinamente brasileira, tornando-o um pioneiro do realismo no Brasil.'
					, 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/artistas%2Fartista21.jpg?alt=media&token=b06db604-98a3-400b-88c5-8b3e6b5475bb'
					)
					,
					--Artistas Pinacoteca 
					( 'Oscar Pereira da Silva'
					, '1867-08-29'
					, '1939-01-17'
					, 'Rio de Janeiro, Brasil'
					, 'São Paulo, Brasil'
					, 'Oscar Pereira da Silva foi um renomado pintor, desenhista e professor brasileiro. Estudou na Academia Imperial de Belas Artes no Rio de Janeiro e aperfeiçoou-se em Paris. Suas obras incluem retratos, paisagens e cenas históricas, como "Desembarque de Pedro Álvares Cabral em Porto Seguro", destacando seu detalhismo e habilidade técnica. Pereira da Silva também foi professor na Escola de Belas Artes de São Paulo, influenciando novas gerações de artistas. Sua produção reflete uma fase de transição da arte acadêmica para uma estética mais moderna no Brasil.'
					, 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/artistas%2Fartista22.jpg?alt=media&token=009ee7d7-0efc-415e-b2e3-2dfe67329539'
					)
					,
					( 'Pedro Weingärtner'
					, '1853-07-26'
					, '1929-12-26'
					, 'Rio Grande do Sul, Brasil'
					, 'Rio Grande do Sul, Brasil'
					, 'Pedro Weingärtner foi um pintor e gravurista brasileiro de origem alemã, reconhecido por suas cenas históricas, retratos e paisagens. Nascido em Porto Alegre, estudou arte na Europa, onde absorveu influências do realismo e academicismo. Suas obras retratam o cotidiano, temas mitológicos e históricos, sempre com grande atenção aos detalhes e à técnica. Entre suas pinturas mais conhecidas estão "A Partida da Monção" e "Idílio". Weingärtner é considerado um dos grandes artistas brasileiros de sua época, contribuindo para o desenvolvimento da pintura no país.'
					, '"https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/artistas%2Fartista23.jpg?alt=media&token=15fd751e-e56a-4ce1-a2a1-2a541e4c1395"'
					)
					,
					--Artistas IMS
					( 'Claudia Andujar'
					, '1931-06-12'
					, DEFAULT
					, 'Neuchâtel, Suíça'
					, DEFAULT
					, 'Claudia Andujar é uma fotógrafa e ativista nascida na Suíça e naturalizada brasileira, conhecida por seu trabalho com o povo Yanomami. Após sobreviver ao Holocausto, mudou-se para o Brasil nos anos 1950 e iniciou uma carreira na fotografia. Na década de 1970, dedicou-se a documentar a vida e cultura dos Yanomami, utilizando a arte como forma de sensibilizar para a causa indígena. Seu trabalho teve papel crucial na demarcação das terras Yanomami e na defesa de seus direitos, combinando estética inovadora e forte engajamento social.'
					, 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/artistas%2Fartista24.jpg?alt=media&token=e6fa65fe-6021-400b-af0d-b5c220f09f60'
					)
					,
					( 'Caio Reisewitz'
					, '1967-10-11'
					, DEFAULT
					, 'São Paulo, Brasil'
					, DEFAULT
					, 'Caio Reisewitz é um renomado fotógrafo brasileiro, conhecido por suas imagens que exploram a relação entre urbanização e natureza. Nascido em São Paulo, ele estudou fotografia na Alemanha e no Brasil. Suas obras, muitas vezes em grandes formatos, retratam paisagens brasileiras, especialmente a Amazônia, e refletem sobre o impacto da ação humana no meio ambiente. Reisewitz utiliza a fotografia digital e técnicas de colagem, criando imagens que mesclam realidade e intervenção artística. Seu trabalho levanta questões ambientais e culturais, destacando a tensão entre progresso e preservação.'
					, 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/artistas%2Fartista25.jpg?alt=media&token=0816f165-f696-46db-8f48-eef421d99eb4'
					)
					,
					-- Artistas do Ipiranga
					( 'Benedito Calixto de Jesus'
					, '1853-10-14'
					, '1927-05-31'
					, 'São Paulo, Brasil'
					, 'São Paulo, Brasil'
					, 'Benedito Calixto de Jesus foi um importante pintor brasileiro, conhecido por suas paisagens, marinhas e cenas históricas. Nascido em Itanhaém, São Paulo, Calixto se destacou pela precisão técnica e pelo detalhismo em suas representações. Ele pintou importantes cenas da história do Brasil, como "Fundação de São Vicente" e "O Descobrimento do Brasil", além de retratar o cotidiano e as paisagens litorâneas. Calixto também contribuiu para o registro da cultura e arquitetura colonial, tornando-se uma referência na pintura acadêmica e histórica no Brasil.'
					, 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/artistas%2Fartista26.jpg?alt=media&token=7c4938aa-b1a3-44e4-98b7-30e6738b4f58'
					)
					;
					
INSERT INTO artista ( nm_artista
					, dt_nasc_artista
					, dt_falecimento
					, local_nasc 
					, local_morte
					, desc_artista
					, url_imagem
					)
             VALUES ( 'Djanira'
					, '1914-06-20'
					, '1979-05-31'
					, 'São Paulo, Brasil'
					, 'Rio de Janeiro, Brasil'
					, 'Djanira foi uma pintora, desenhista, ilustradora, cartazista, cenógrafa e gravadora brasileira. Ela é conhecida por obras que retratam o cotidiano, costumes e rituais muito brasileiros. Djanira gostava de mergulhar no tema das suas obras e comumente vivia a realidade das pessoas, dos ofícios e das crenças.'
					, 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/artistas%2Fartista27.jpg?alt=media&token=445ae95e-88ef-42ae-97d3-9efc6ac0070f'
					);

INSERT INTO artista ( nm_artista
					, dt_nasc_artista
					, dt_falecimento
					, local_nasc 
					, local_morte
					, desc_artista
					, url_imagem
					)
             VALUES ( 'Henrique Cavalleiro'
					, '1892-03-15'
					, '1975-08-25'
					, 'Rio de Janeiro, Brasil'
					, 'Rio de Janeiro, Brasil'
					, 'Henrique Campos Cavalleiro foi um pintor, desenhista, caricaturista, ilustrador e professor brasileiro. Filho de José e Beatriz Cavalleiro, iniciou sua formação artística na Escola Nacional de Belas Artes em 1907, tendo como mestres Eliseu Visconti e Zeferino da Costa. Recebeu medalhas de prata (1911) e ouro (1912) em pintura e desenho. Em 1918, ganhou um prêmio de viagem à Europa e estudou na Academia Julian de Paris. Expôs na França em 1923 e 1924, e no Brasil a partir de 1925. Casou-se com Yvonne Visconti Cavalleiro em 1938, com quem teve dois filhos, Eliseu e Leonardo Visconti Cavalleiro.'
					, 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/artistas%2Fartista28.jpg?alt=media&token=dac31c11-ae3f-42ca-baf2-28f6407b93e3'
					);
					
INSERT INTO artista ( nm_artista
					, dt_nasc_artista
					, dt_falecimento
					, local_nasc 
					, local_morte
					, desc_artista
					, url_imagem
					)
             VALUES ( 'Georgina de Albuquerque'
					, '1885-02-04'
					, '1962-08-29'
					, 'São Paulo, Brasil'
					, 'Rio de Janeiro, Brasil'
					, 'Libertando-se dos ensinamentos acadêmicos, Georgina foi uma artista de influência impressionista. Pintou todos os gêneros, dando preferência à figura humana e à paisagem. Sua obra revela frequentemente um impulso emotivo.'
					, 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/artistas%2Fartista29.jpg?alt=media&token=316a3ec6-2d2d-4941-be46-4066bf03fc26'
					);

INSERT INTO artista ( nm_artista
					, dt_nasc_artista
					, dt_falecimento
					, local_nasc
					, local_morte
					, desc_artista
					, url_imagem
					)
			 VALUES ( 'Tarsila do Amaral'
					, '1886-10-09'
					, '1973-01-17'
					, 'São Paulo, Brasil'
					, 'São Paulo, Brasil'
					, 'Artista modernista brasileira, figura central do movimento antropofágico.'
					, 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/artistas%2Fartista7.jpg?alt=media&token=50229b56-d52e-4ba3-89c7-bde8b04ff6a8'
					)
					,
					( 'Rodolfo Amoedo'
					, '1857-11-12'
					, '1941-05-31'
					, 'Bahia, Brasil'
					, 'Rio de Janeiro, Brasil'
					, 'Pintor brasileiro, conhecido por obras acadêmicas e simbolistas.'
					, 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/artistas%2Fartista18.jpg?alt=media&token=cdeb5a5d-c105-4dc1-a0df-7d69ccc23fba'
					);


						
INSERT INTO artista ( nm_artista
					, dt_nasc_artista
					, dt_falecimento
					, local_nasc 
					, local_morte
					, desc_artista
					, url_imagem
					)
             VALUES ( 'Paul Michel Dupuy'
					, '1869-03-22'
					, '1949-11-02'
					, 'França'
					, 'Paris, França'
					, 'Paul Michel Dupuy foi um artista francês, destacado como pintor e gravador. Ele é conhecido por seu estilo que combina elementos do impressionismo e do pós-impressionismo, utilizando cores vibrantes e pinceladas expressivas. Dupuy foi influenciado pela luz e pela natureza, frequentemente retratando paisagens e cenas do cotidiano. Além de sua pintura, ele também explorou a gravura, criando obras que refletiam sua sensibilidade estética.'
					, DEFAULT
					);		
				
-----------------
--INSERTS Obra
-----------------
INSERT INTO obra ( ano_inicio
				 , ano_final
				 , desc_obra
				 , nm_obra
				 , id_genero
				 , id_artista
				 , id_museu
				 , url_imagem
				 )
				 --Obras do Dudi Maia Rosa
		  VALUES ( 1973
				 , 1973
				 , 'Neste trabalho, Dudi utiliza resina e fibra de vidro para criar superfícies texturizadas e orgânicas, refletindo um interesse pela decomposição e transformação. A obra evoca o desgaste do tempo, sugerindo fragilidade e impermanência, temas recorrentes em sua produção. Através de formas abstratas e nuances cromáticas, Dudi convida o espectador a refletir sobre o ciclo da vida e a passagem do tempo.'
				 , 'Fim do Primeiro Tempo'
				 , ( SELECT id
				      FROM genero
				     WHERE nm_genero = 'Contemporânea'
				   )
				 , ( SELECT id 
				       FROM artista 
				      WHERE nm_artista = 'Dudi Maia Rosa'
				   )
				 , ( SELECT id 
				       FROM museu
				      WHERE nm_museu LIKE '%MAM%'
				   )
				 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra26.jpg?alt=media&token=581b633c-6593-458b-9c38-1a4e0a251ea0'
				 )
				 ,
				 ( 1995
				 , 1995
				 , '"To Mam" é uma obra de Dudi Maia Rosa em que o artista explora materiais como resina, fibra de vidro e pigmentos para criar superfícies que se situam entre pintura e escultura. Com formas orgânicas e uma paleta de cores sutis, a obra transmite uma sensação de fragilidade e introspecção. Dudi investiga o conceito de memória e transformação, refletindo sobre a condição humana e o processo de desgaste e renovação. A interação entre luz e textura reforça a profundidade emocional da peça, sugerindo camadas ocultas de significado.'
				 , 'To Mam'
				 , ( SELECT id
				       FROM genero 
				      WHERE nm_genero = 'Contemporânea'
				   )
				 , ( SELECT id
				       FROM artista
				      WHERE nm_artista = 'Dudi Maia Rosa'
				   )
				 , ( SELECT id
				       FROM museu
				      WHERE nm_museu LIKE '%MAM%'
				   )
				 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra27.jpg?alt=media&token=c0bb0df2-7928-443f-b8c7-391ed923edc3'
				 )
				 , 
				 ( 1982
				 , 1982
				 , 'A peça evoca a paisagem natural, remetendo ao mar e à areia, mas de maneira abstrata, sugerindo uma conexão íntima com a natureza. As formas suaves e as cores delicadas convidam à contemplação e exploram a impermanência e o desgaste do tempo. Dudi transforma elementos naturais em composições que transmitem quietude e uma sensação de passagem, como uma memória dissolvida no tempo.'
				 , 'Praia do Curral'
				 , ( SELECT id
				       FROM genero 
				      WHERE nm_genero = 'Contemporânea'
				   )
				 , ( SELECT id
				       FROM artista
				      WHERE nm_artista = 'Dudi Maia Rosa'
				   )
				 , ( SELECT id 
				       FROM museu
				      WHERE nm_museu LIKE '%MAM%'
				   )
				 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra28.jpg?alt=media&token=0116f63b-d208-457a-8244-676d2530721c'
				 )
				 ,
				 -- Obras do Almeida Júnior 
				 ( 1899
				 , 1899
				 , 'O Violeiro retrata um homem simples, sentado em uma cadeira, tocando um violão. A pintura destaca a atmosfera serena e introspectiva, com cores suaves e tons terrosos, reforçando o ambiente rural. O violeiro usa roupas modestas, típicas de trabalhadores do campo, com chapéu de palha. A luz suave e o detalhamento naturalista criam uma sensação de tranquilidade, capturando um momento de lazer e conexão com a música, representando a vida cotidiana do interior do Brasil.'
				 , 'O Violeiro'
				 , ( SELECT id 
				       FROM genero
				      WHERE nm_genero = 'Realismo'
				   )
				 , ( SELECT id
				       FROM artista
				      WHERE nm_artista = 'Almeida Júnior'
				   )
				 , ( SELECT id
				       FROM museu
				      WHERE nm_museu LIKE '%MAM%'
				   )
				 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra29.jpg?alt=media&token=0d4b9e86-3c22-4c38-8d73-aa9ba4d22d56'
				 )
				 ,
				 ( 1899
				 , 1899
				 , 'A Estrada é uma pintura que retrata uma cena rural, onde um homem caminha por uma estrada de terra, carregando um cesto. O cenário é envolto por uma vegetação densa e verdejante, típica do interior brasileiro. O artista utiliza uma paleta de cores quentes e iluminadas, transmitindo a sensação de um dia ensolarado. A composição reflete a simplicidade e a tranquilidade da vida no campo, além de capturar a essência do cotidiano rural. A figura humana, em harmonia com a natureza, destaca a conexão entre o homem e seu ambiente.'
				 , 'A Estrada'
				 , ( SELECT id
				       FROM genero
				      WHERE nm_genero = 'Realismo'
				   )
				 , ( SELECT id 
				       FROM artista
				      WHERE nm_artista = 'Almeida Júnior'
				   )
				 , ( SELECT id
				       FROM museu
				      WHERE nm_museu LIKE '%MAM%'
				   )
				 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra30.jpg?alt=media&token=9e8adf8d-3a00-44cf-9293-6ed68014fba6'
				 )
				 ,
				 ( 1891
				 , 1891
				 , 'Cena de Família retrata um momento íntimo de convivência familiar. A obra mostra uma mulher sentada com uma criança no colo, enquanto outra criança brinca ao seu lado. O ambiente é acolhedor, com móveis rústicos e uma iluminação suave que ressalta a ternura da cena. As expressões dos personagens transmitem afeto e proximidade, refletindo a vida cotidiana das famílias da época. A paleta de cores é composta por tons quentes, criando uma atmosfera de carinho e simplicidade. Almeida Júnior captura a essência das relações familiares, enfatizando a importância do lar.'
				 , 'Cena de Família'
				 , ( SELECT id
				       FROM genero
				      WHERE nm_genero = 'Realismo'
				   )
				 , ( SELECT id
				       FROM artista
				      WHERE nm_artista = 'Almeida Júnior'
				   )
				 , ( SELECT id
				       FROM museu
				      WHERE nm_museu LIKE '%Pinacoteca%'
				   )
				 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra31.jpg?alt=media&token=72849108-f00d-4f2b-b434-ede887679f34'
				 )
				 ,
				 ( 1899
				 , 1899
				 , 'Saudade é uma obra que evoca a melancolia e a nostalgia. A pintura retrata uma jovem sentada, com expressão pensativa, segurando um lenço em suas mãos. Ela está posicionada em um ambiente interno, com elementos que sugerem conforto e privacidade, como um sofá e um fundo neutro. A luz suave ilumina seu rosto, acentuando a profundidade de suas emoções. A composição é marcada por uma paleta de cores quentes e sutis, que reforçam a atmosfera introspectiva. A obra captura o sentimento de saudade de maneira sensível, refletindo a fragilidade das memórias e dos afetos.'
				 , 'Saudade'
				 , ( SELECT id
				       FROM genero
				      WHERE nm_genero = 'Realismo'
				   )
				 , ( SELECT id
				       FROM artista
				      WHERE nm_artista = 'Almeida Júnior'
				   )
				 , ( SELECT id
				       FROM museu
				      WHERE nm_museu LIKE '%Pinacoteca%')
				 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra32.jpg?alt=media&token=6ee41159-64b7-428b-b30b-8cf96692ed35'
				 )
				 , 
				 ( 1892
				 , 1892
				 , 'Leitura retrata uma jovem sentada em um ambiente doméstico, imersa na leitura de um livro. A mulher, vestida com roupas simples, está posicionada em uma cadeira, com o corpo ligeiramente inclinado para frente, evidenciando seu envolvimento com a leitura. A iluminação suave destaca seu rosto e os detalhes do ambiente, criando uma atmosfera de tranquilidade e reflexão. O fundo é composto por elementos que sugerem um lar aconchegante, como um vaso de flores e uma mesa. A obra captura a beleza do momento de contemplação, celebrando a importância da leitura na vida cotidiana.'
				 , 'Leitura'
				 , ( SELECT id
				       FROM genero
				      WHERE nm_genero = 'Realismo'
				   )
				 , ( SELECT id
				       FROM artista
				      WHERE nm_artista = 'Almeida Júnior'
				   )
				 , ( SELECT id
				       FROM museu
				      WHERE nm_museu LIKE '%Pinacoteca%'
				   )
				 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra33.jpg?alt=media&token=3f509986-fa94-46b7-b19b-ddab8e42f133'
				 )
				 ,
				 --Obras do Oscar Pereira da Silva
				 ( 1895
				 , 1895
				 , '"Infância de Giotto" retrata uma cena da infância do famoso pintor italiano Giotto di Bondone. No centro, Giotto, ainda criança, é mostrado desenhando no chão com um pedaço de carvão, enquanto alguns pastores observam com interesse. O ambiente é rústico, refletindo a vida simples da época. As expressões dos personagens transmitem curiosidade e admiração, enfatizando a genialidade do jovem artista. Com cores suaves e uma composição harmoniosa, a pintura captura a essência da criatividade e da inspiração que moldaram a arte renascentista.'
				 , 'Infância de Giotto'
				 , ( SELECT id
				       FROM genero
				      WHERE nm_genero = 'Academicismo'
				   )
				 , ( SELECT id
				       FROM artista
				      WHERE nm_artista = 'Oscar Pereira da Silva'
				   )
				 , ( SELECT id
					   FROM museu
					  WHERE nm_museu LIKE '%Pinacoteca%'
					)
				 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra35.jpg?alt=media&token=b5ff095f-728b-4fd6-a1f6-ff3a6542a999'
				 )
				 ,
				 ( 1901
				 , 1901
				 , '"Hora da Música" retrata uma cena íntima e festiva em um ambiente doméstico, onde um grupo de jovens se reúne para tocar e cantar. No centro, uma mulher segura um violão, enquanto outros participantes se envolvem na música, com expressões de alegria e concentração. O ambiente é iluminado por uma luz suave, que destaca as cores vibrantes dos vestidos e os detalhes do cenário. A composição reflete a harmonia das relações sociais e a importância da música na vida cotidiana, capturando um momento de comunhão e celebração da cultura.'
				 , 'Hora da Música'
				 , ( SELECT id 
				       FROM genero
				      WHERE nm_genero = 'Barroco'
				   )
				 , ( SELECT id 
				       FROM artista
				      WHERE nm_artista = 'Oscar Pereira da Silva'
				   )
				 , ( SELECT id 
				       FROM museu
				      WHERE nm_museu LIKE '%Pinacoteca%'
				   )
				 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra36.jpg?alt=media&token=67f33f87-fefd-471c-8ca6-5493316f7396'
				 )
				 ,
				 ( 1922
				 , 1922
				 , 'A obra Desembarque de Pedro Álvares Cabral em Porto Seguro em 1500, retrata o momento histórico da chegada dos portugueses ao Brasil. Pintada com grande atenção aos detalhes, a cena mostra Pedro Álvares Cabral e sua tripulação desembarcando em terras brasileiras, cercados pela natureza exuberante e pela presença de indígenas. O artista utiliza uma paleta de cores vibrantes e composições realistas para destacar o encontro entre os europeus e os nativos, capturando a solenidade e a grandiosidade desse episódio marcante da história do Brasil.'
				 , 'Desembarque de Pedro Álvares Cabral em Porto Seguro em 1500'
				 , ( SELECT id
				       FROM genero
				      WHERE nm_genero = 'Historicismo'
				   )
				 , ( SELECT id
				       FROM artista
				      WHERE nm_artista = 'Oscar Pereira da Silva'
				   )
				 , ( SELECT id
				       FROM museu
				      WHERE nm_museu LIKE '%Ipiranga%'
				   )
				 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra37.jpg?alt=media&token=e34d6406-9ccd-47e0-9c22-dd5899fb7d60'
				 )
				 ,
				 ( 1916
				 , 1916
				 , 'A pintura Tiradentes, apresenta o líder da Inconfidência Mineira como um mártir nacional. Tiradentes é retratado de forma idealizada, com expressões serenas e traços que remetem à iconografia de santos e heróis. O uso de luz e sombra destaca sua figura, conferindo-lhe uma aura de dignidade e sacrifício. A obra visa perpetuar a imagem de Tiradentes como um símbolo da luta pela independência do Brasil, enfatizando sua bravura e o impacto de sua morte para a causa republicana.'
				 , 'Tiradentes'
				 , ( SELECT id
				       FROM genero
				      WHERE nm_genero = 'Historicismo'
				   )
				 , ( SELECT id
				       FROM artista
				      WHERE nm_artista = 'Oscar Pereira da Silva'
				   )
				 , ( SELECT id
				       FROM museu
				      WHERE nm_museu LIKE '%Ipiranga%'
				   )
				 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra38.jpg?alt=media&token=7deb8ced-6283-43e9-889b-31856c4c62b1'
				 )
				 ,
				 -- Obras Pedro Weingärtner
				 ( 1908
				 , 1908
				 , '"A Fazedora de Anjos" retrata uma mulher sentada em um ambiente rústico, concentrada em seu trabalho de modelar anjos de barro. A figura feminina, envolta em um vestido simples, exala uma aura de serenidade e dedicação, enquanto o fundo sugere um ambiente caseiro. Os anjos em sua volta, já moldados, simbolizam a criação e a espiritualidade, refletindo a conexão entre o cotidiano e o divino. A obra destaca a habilidade do artista em capturar a luz e a textura, conferindo um sentido de realismo e intimidade.'
				 , 'A Fazedora de Anjos'
				 , ( SELECT id
				       FROM genero
				      WHERE nm_genero = 'Realismo'
				   )
				 , ( SELECT id 
				       FROM artista 
				      WHERE nm_artista = 'Pedro Weingärtner'
				   )
				 , ( SELECT id 
				       FROM museu
				      WHERE nm_museu LIKE '%Pinacoteca%'
				   )
				 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra39.jpg?alt=media&token=67a0cc9a-bac7-440d-8740-fbcbb6c0d336'
				 )
				 ,
				 ( 1907
				 , 1907
				 , '"Ceifa" é uma obra emblemática do realismo brasileiro. A pintura retrata um trabalhador rural em plena atividade de ceifar trigo, capturando a força e a determinação do homem no campo. O personagem, vestido com roupas simples, se destaca em meio a um vasto campo dourado, com a luz do sol iluminando a cena. A composição é rica em detalhes, com a vegetação e as sombras bem delineadas, evidenciando a maestria de Weingärtner na representação da natureza e da vida rural. A obra evoca um sentido de luta e conexão com a terra, celebrando o trabalho manual e a tradição agrícola.'
				 , 'Ceifa'
				 , ( SELECT id
				       FROM genero
				      WHERE nm_genero = 'Naturalismo'
				   )
				 , ( SELECT id 
				       FROM artista
				      WHERE nm_artista = 'Pedro Weingärtner'
				   )
				  , ( SELECT id
					    FROM museu 
					   WHERE nm_museu LIKE '%Pinacoteca%'
					)
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra40.jpg?alt=media&token=0847c4c6-ec7e-48f7-ad66-70963262fabd'
				  )
				  ,
				  ( 1900
				  , 1900
				  , '"Paisagem", de Pedro Weingärtner, é uma obra que exemplifica a habilidade do artista em capturar a beleza do cenário natural brasileiro. A tela apresenta uma vista panorâmica de um campo sereno, onde as tonalidades vibrantes do verde e do amarelo se misturam harmoniosamente sob um céu azul salpicado de nuvens brancas. Elementos como árvores, colinas e um riacho serpenteante compõem a cena, transmitindo uma sensação de tranquilidade e harmonia. A atenção aos detalhes e o uso da luz ressaltam a atmosfera pacífica do ambiente rural, refletindo a conexão profunda entre o homem e a natureza que permeia a obra.'
				  , 'Paisagem'
				  , ( SELECT id 
					    FROM genero 
					   WHERE nm_genero = 'Naturalismo'
					)
				  , ( SELECT id 
					    FROM artista
					   WHERE nm_artista = 'Pedro Weingärtner'
					)
				  , ( SELECT id 
					    FROM museu
					   WHERE nm_museu LIKE '%Pinacoteca%'
					)
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra41.jpg?alt=media&token=689b517c-57ed-4e86-b60e-2d3e3074f8ea'
				  )
				  ,
				  --Fotografias Claudia Andujar 
				  ( 2014
				  , 2014
				  , 'Aqui, os personagens agridem e são agredidos, todas as máscaras caem, num duro jogo da verdade. É uma sessão de psicodrama, uma técnica de tratamento psiquiátrico em que, orientados por dois terapeutas, os pacientes se libertam da angústia, representando num palco as situações de crise de suas próprias vidas.'
				  , 'Eles procuram a paz (#4)'
				  , ( SELECT id
					    FROM genero
					   WHERE nm_genero = 'Fotografia'
					)
				  , ( SELECT id
					    FROM artista
					   WHERE nm_artista = 'Claudia Andujar'
					)
				  , ( SELECT id 
					    FROM museu
					   WHERE nm_museu LIKE '%IMS%'
					)
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra42.jpg?alt=media&token=06a946e0-4ce4-4652-8104-85a7ca0150ec'
				  )
				  ,
				  ( 1970
				  , 1970
				  , 'A fotografia O Pesadelo (#3) de Claudia Andujar, parte da série Marcados, captura o sofrimento e a vulnerabilidade dos povos Yanomami. Andujar usa a sobreposição de imagens e luzes para transmitir um estado de sonho ou alucinação, refletindo a violência e as ameaças que essa comunidade enfrenta devido à invasão de suas terras. A obra mistura realismo e surrealismo, simbolizando o trauma coletivo dos Yanomami, ao mesmo tempo que destaca a conexão espiritual com a natureza e a luta pela sobrevivência.'
				  , 'O pesadelo (#3)'
				  , ( SELECT id
					    FROM genero
					   WHERE nm_genero = 'Fotografia'
					)
				  , ( SELECT id 
					    FROM artista
					   WHERE nm_artista = 'Claudia Andujar'
					 )
				  , ( SELECT id 
					    FROM museu
					   WHERE nm_museu LIKE '%IMS%'
					)
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra43.jpg?alt=media&token=43ab0a22-d1ed-484c-903d-17dba087c9bc'
				  )
				  ,
				  ( 1970
				  , 1970
				  , 'A fotografia "Rua Direita" captura uma cena da vida urbana de São Paulo na década de 1970. Com um olhar documental, a imagem apresenta o movimento frenético de pedestres na Rua Direita, um dos centros mais movimentados da cidade. A fotografia destaca a densidade da multidão e a sensação de anonimato das pessoas na metrópole. A obra reflete as mudanças urbanas e sociais da época, ressaltando a complexidade e impessoalidade da vida moderna.'
				  , 'Rua Direita'
				  , ( SELECT id 
					    FROM genero
					   WHERE nm_genero = 'Fotografia'
					)
				  , ( SELECT id
					    FROM artista
					   WHERE nm_artista = 'Claudia Andujar'
					)
				  , ( SELECT id
					    FROM museu 
					   WHERE nm_museu LIKE '%IMS%'
					)
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra44.jpg?alt=media&token=2ce6f133-ffc4-4729-826e-ddaa4ed99960'
				  ) 
				  , 
				  --Fotos Caio Reisewitz
				  ( 2013
				  , 2013
				  , 'A fotografia Casa Canoas de Caio Reisewitz captura a essência da arquitetura moderna brasileira, destacando uma residência projetada por Sérgio Rodrigues. A imagem revela a harmonia entre a construção e o ambiente natural que a cerca, enfatizando o uso de materiais como madeira e vidro. Reisewitz utiliza uma composição equilibrada, onde linhas geométricas da casa se integram ao paisagismo exuberante. A luz suave do dia cria uma atmosfera contemplativa, refletindo a relação do ser humano com a natureza. A obra é um convite à reflexão sobre espaço, habitação e sustentabilidade.'
				  , 'Casa Canoas'
				  , ( SELECT id
					    FROM genero
					   WHERE nm_genero = 'Fotografia'
					)
				  , ( SELECT id
					    FROM artista
					   WHERE nm_artista = 'Caio Reisewitz'
					)
				  , ( SELECT id
					    FROM museu
					   WHERE nm_museu LIKE '%IMS%'
					)
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra45.jpg?alt=media&token=6700dd57-51f7-4a81-97f4-86a449f6141d'
				  )
				  ,
				  ( 2009
				  , 2009
				  , 'A fotografia Suiára, retrata uma paisagem impressionante que explora a relação entre a natureza e a presença humana. A imagem destaca uma vasta extensão de vegetação, onde a luz do sol filtra através das árvores, criando um jogo de sombras e reflexos que conferem profundidade à cena. Reisewitz captura a essência do cerrado brasileiro, enfatizando sua beleza e fragilidade. A composição é cuidadosamente equilibrada, evocando um sentimento de tranquilidade e contemplação. A obra convida o espectador a refletir sobre a preservação ambiental e a conexão intrínseca entre homem e natureza.'
				  , 'Suiára'
				  , ( SELECT id 
					    FROM genero 
					   WHERE nm_genero = 'Fotografia'
					)
				  , ( SELECT id
					    FROM artista
					   WHERE nm_artista = 'Caio Reisewitz'
					)
				  , ( SELECT id
					    FROM museu
					   WHERE nm_museu LIKE '%IMS%'
					)
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra46.jpg?alt=media&token=ef598dd3-c2c7-454f-abef-ca06578038d9'
				  )
				  ,
				  ( 2007
				  , 2007
				  , 'A fotografia Jaraguá 22, de Caio Reisewitz, apresenta uma vista panorâmica do Pico do Jaraguá, um dos pontos mais altos da cidade de São Paulo. A imagem captura a exuberância da vegetação nativa e a paisagem urbana ao fundo, criando um contraste entre natureza e urbanização. Reisewitz utiliza uma paleta de cores vibrantes e uma composição que destaca a imensidão do céu e a profundidade da cena. A obra evoca um senso de pertencimento e reflexão sobre a identidade cultural e ambiental da cidade, convidando o espectador a contemplar a interação entre o espaço natural e o construído.'
				  , 'Jaraguá 22'
				  , ( SELECT id
					    FROM genero
					   WHERE nm_genero = 'Fotografia'
					)
				  , ( SELECT id
					    FROM artista
					   WHERE nm_artista = 'Caio Reisewitz'
					)
				  , ( SELECT id
					    FROM museu
					   WHERE nm_museu LIKE '%MAM%'
					 )
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra47.jpg?alt=media&token=b12e2a7e-44cb-4d1d-8517-8c7ec7944ff3'
				  )
				  ,
				  --Obras Benedito Calixto de Jesus
				  ( 1900
				  , 1900
				  , 'A obra "Fundação de São Vicente", pintada por Benedito Calixto de Jesus em 1906, retrata a fundação da primeira cidade do Brasil, São Vicente, ocorrida em 1532. A cena apresenta os primeiros colonizadores portugueses, liderados por Martim Afonso de Sousa, em meio a um exuberante cenário natural. Os personagens, em vestimentas da época, interagem com os nativos, simbolizando o encontro de culturas. A pintura é rica em detalhes, com cores vibrantes que destacam a vegetação e a dinâmica da cena, refletindo a história e a identidade brasileira. A obra é um importante testemunho da arte nacional e do início da colonização.'
				  , 'Fundação de São Vicente'
				  , ( SELECT id
					    FROM genero
					   WHERE nm_genero = 'Historicismo'
					 )
				  , ( SELECT id
					    FROM artista 
					   WHERE nm_artista = 'Benedito Calixto de Jesus'
					)
				  , ( SELECT id
					    FROM museu 
					   WHERE nm_museu LIKE '%Ipiranga%'
					)
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra48.jpg?alt=media&token=7a891f86-18ef-4227-b6fa-5fa30ed31062'
				  )
				  ,
				  ( 1924
				  , 1924
				  , 'A obra Convento de Itanhaém, apresenta uma vista serena e detalhada do convento situado na cidade de Itanhaém, no litoral de São Paulo. A pintura exibe a arquitetura do convento em meio a uma paisagem natural exuberante, com o céu azul e a vegetação litorânea compondo o cenário. A luz suave, característica das obras de Calixto, ilumina tanto o edifício quanto a natureza, destacando a harmonia entre o homem e o ambiente. A pintura transmite um senso de tranquilidade e reverência pelo patrimônio histórico e religioso que o convento representa, evidenciando a importância cultural do local.'
				  , 'Convento de Itanhaém'
				  , ( SELECT id
					    FROM genero
					   WHERE nm_genero = 'Paisagem'
					 )
				  , ( SELECT id
					    FROM artista 
					   WHERE nm_artista = 'Benedito Calixto de Jesus'
					)
				  , ( SELECT id
					    FROM museu 
					   WHERE nm_museu LIKE '%Ipiranga%'
					)
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra49.jpg?alt=media&token=06a8d04d-7554-4782-8cb5-c5d1cbff43e7'
				  )
				  ,
				  ( 1922
				  , 1922
				  , 'A obra Panorama de Santos, retrata uma vista ampla e detalhada da cidade de Santos no final do século XIX. A pintura captura a cidade litorânea com suas construções, o porto movimentado e as embarcações no mar, evidenciando o dinamismo da região. Calixto utiliza uma paleta de cores suaves e detalhamento preciso para destacar a relação entre a urbanização e a natureza ao redor. O céu aberto e a luz suave dão à cena uma atmosfera tranquila, enquanto a perspectiva panorâmica revela a transformação da cidade em um importante centro portuário do Brasil.'
				  , 'Panorama de Santos'
				  , ( SELECT id
					    FROM genero
					   WHERE nm_genero = 'Paisagem'
					)
				  , ( SELECT id
					    FROM artista
					   WHERE nm_artista = 'Benedito Calixto de Jesus'
					)
				  , ( SELECT id 
					    FROM museu
					   WHERE nm_museu LIKE '%Ipiranga%'
					)
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra50.jpg?alt=media&token=56ec38b0-c220-4985-b91a-50347dcd6bce'
				 )
				   ,
				 ( 1882
				 , 1882
				 , '"Amuada" é uma pintura de Rodolfo Amoedo que retrata uma jovem sentada, com expressão fechada e postura introspectiva. A obra captura um momento de melancolia e introspecção, caracterizado pela posição recolhida da figura e o olhar baixo, sugerindo um estado de tristeza ou aborrecimento. A luz suave e os tons delicados reforçam a atmosfera íntima e contemplativa, refletindo a habilidade de Amoedo em explorar emoções humanas de forma sutil e expressiva. A composição é equilibrada e destaca a delicadeza e a serenidade da cena.'
			     , 'Amuada'
				 , ( SELECT id
					   FROM genero
					  WHERE nm_genero = 'Realismo'
				   )
				 , ( SELECT id
				       FROM artista 
				      WHERE nm_artista = 'Rodolfo Amoedo'
				   )
				 , ( SELECT id 
					   FROM museu
					  WHERE nm_museu LIKE '%MNBA%'
					)
				 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra51.jpg?alt=media&token=ec6d1121-9939-4369-bc2f-920c1a41cf8a'
				 )
			     ,
			     ( 1923
			     , 1923
			     , '"Autorretrato (Manteau Rouge)" é uma pintura da artista Tarsila do Amaral, onde ela se retrata de forma elegante e moderna. Vestida com um manto vermelho que cobre seus ombros, Tarsila aparece com uma expressão serena e olhar confiante. A obra reflete a influência da moda e do modernismo europeu, com formas simplificadas e cores vivas. Este autorretrato destaca um momento em que Tarsila estava imersa na cultura parisiense, absorvendo influências que mais tarde combinaria com elementos brasileiros em suas criações.'
			     , 'Autorretrato (Manteau Rouge)'
		         , ( SELECT id
			   	       FROM genero
					  WHERE nm_genero = 'Realismo'
				   )
				 , ( SELECT id
			     	   FROM artista
					  WHERE nm_artista = 'Tarsila do Amaral'
				   )
				 , ( SELECT id
				       FROM museu
				      WHERE nm_museu LIKE '%MNBA%'
				   )
				 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra52.jpg?alt=media&token=a5205e46-944c-483f-bb42-210d0cf2c8de'
				 )
				 , 
				 ( 1955
			     , 1955
			     , 'A obra Igreja de Antônio Dias de Djanira é uma pintura que retrata a fachada da Igreja de São Francisco de Assis, situada no bairro de Antônio Dias, em Ouro Preto, Minas Gerais. Com um estilo simplificado e cores vivas, a artista destaca a arquitetura colonial da igreja, cercada por montanhas e vegetação. A composição transmite uma sensação de tranquilidade e reverência, refletindo a essência do barroco mineiro e a cultura local. Djanira é conhecida por retratar temas populares e religiosos com uma abordagem ingênua e expressiva.'
			     , 'Igreja de Antônio Dias'
			     , ( SELECT id
			     	   FROM genero
					  WHERE nm_genero = 'Paisagem'
				   )
				  , ( SELECT id
					    FROM artista
					   WHERE nm_artista = 'Djanira'
					)
				  , ( SELECT id
					    FROM museu
					   WHERE nm_museu LIKE '%MNBA%'
					)
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra53.jpg?alt=media&token=a849d3df-a0e4-46d7-b256-226596e9b772'
				  )
				  ,
				 ( 1895
			     , 1895
			     , 'Más Notícias retrata uma mulher sentada em uma poltrona, com o olhar direcionado para a frente, encarando quem a observa. O quadro está localizado no Museu Nacional de Belas Artes e caracteriza-se por unir traços realistas de pintura e de outros movimentos nascentes no Brasil, como o simbolismo e o modernismo. A conexão de diversas influências fez com que esse quadro fosse interpretado como especialmente relevante para a história da arte brasileira. Apresentada na Segunda Exposição Geral da Escola Nacional de Belas Artes (ENBA), a obra de Amoedo foi considerada fora dos cânones da pintura mais convencional e acadêmica. Foi celebrada pela crítica especializada por introduzir correntes artísticas novas ao Brasil, já em voga na Europa onde o artista havia estado alguns anos antes do lançamento, e realizar na arte uma investigação da psicologia feminina.'
			     , 'Más Notícias'
			     , ( SELECT id
			     	   FROM genero
					  WHERE nm_genero = 'Historicismo'
				   )
				  , ( SELECT id
					    FROM artista
					   WHERE nm_artista = 'Rodolfo Amoedo'
					)
				  , ( SELECT id
					    FROM museu
					   WHERE nm_museu LIKE '%MNBA%'
					)
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra54.jpg?alt=media&token=f3389710-1cc2-4872-bf83-ce93d4842f07'
				  )
				  ,
				  ( 1920
				  , 1920
				  , '"Jardim de Luxemburgo" de Henrique Cavalleiro é uma pintura que captura a beleza serena e a atmosfera vibrante do famoso parque parisiense. A obra apresenta uma paisagem rica em detalhes, com árvores frondosas, canteiros de flores coloridas e pessoas desfrutando do espaço ao ar livre. Utilizando uma paleta de cores suaves e uma técnica impressionista, Cavalleiro transmite a luminosidade e a tranquilidade do ambiente. A composição reflete não apenas a natureza exuberante, mas também a interação social, destacando a importância do jardim como um espaço de convivência e lazer na vida urbana.'
				  , 'Jardim de Luxemburgo'
				  , ( SELECT id
					    FROM genero
					   WHERE nm_genero = 'Paisagem'
					)
				  , ( SELECT id
					    FROM artista
					   WHERE nm_artista = 'Henrique Cavalleiro'
					)
				  , ( SELECT id
					    FROM museu
					   WHERE nm_museu LIKE '%MNBA%'
					)
                  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra55.jpg?alt=media&token=8efd0f8a-b30e-488d-8ca5-09e14f4dbf6d'
				  )
				  ,
				  ( 1921
				  , 1921
				  , '"Vestido Rosa" é uma obra do pintor Henrique Cavalleiro que retrata uma jovem sentada, usando um vestido rosa elegante. A pintura destaca a delicadeza e suavidade da figura feminina, com traços e cores que remetem ao estilo impressionista. O fundo é sutil e pouco detalhado, permitindo que a atenção se concentre na figura central. As pinceladas suaves e a paleta de cores suaves criam uma atmosfera serena e introspectiva, refletindo a habilidade de Cavalleiro em capturar a essência e a graça de suas personagens.'
				  , 'Vestido Rosa'
				  , ( SELECT id
					    FROM genero
					   WHERE nm_genero = 'Paisagem'
					)
				  , ( SELECT id
					    FROM artista
					   WHERE nm_artista = 'Henrique Cavalleiro'
					)
				  , ( SELECT id
					    FROM museu
					   WHERE nm_museu LIKE '%MNBA%'
					)
                  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra56.jpg?alt=media&token=15176466-6943-4e38-bfa7-930dcb42f75c'
				  )
				  ,
				  ( 1926
				  , 1926
				  , 'Dia de Verão, deixa transparecer o despojamento do desenho com pinceladas soltas, enriquecidas por um romantismo diluído e suave, pela transparência e feminilidade conjugadas aos efeitos de luminosidade.'
				  , 'Dia de Verão'
				  , ( SELECT id
					    FROM genero
					   WHERE nm_genero = 'Impressionista'
					)
				  , ( SELECT id 
					    FROM artista 
					   WHERE nm_artista = 'Georgina de Albuquerque'
					)
				  , ( SELECT id
					    FROM museu
					   WHERE nm_museu LIKE '%MNBA%'
					)
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra57.jpg?alt=media&token=1d36ebb9-663b-4669-89ee-1722f5fb3852'
				  )
				  ,
				  ( 1908
				  , 1908
				  , '"Esquisse de la femme au perroquet" é uma obra do pintor francês Paul Michel Dupuy. A pintura retrata uma mulher elegantemente vestida, com um vestido que exibe um jogo de cores vibrantes e detalhes intrincados. Ela está posicionada de forma a interagir com um exuberante pêroquet que repousa em seu braço. O fundo da obra apresenta uma paleta rica em tons quentes, evocando uma atmosfera tropical. A composição destaca a relação simbólica entre a mulher e o pássaro, sugerindo uma conexão com a natureza e a beleza, típica do estilo impressionista da época.'
				  , 'Esquisse de la femme au perroquet [Esboço de mulher com papagaio]'
				  , ( SELECT id
					    FROM genero
					   WHERE nm_genero = 'Impressionista'
					)
				  , ( SELECT id 
					    FROM artista 
					   WHERE nm_artista = 'Paul Michel Dupuy'
					)
				  , ( SELECT id
					    FROM museu
					   WHERE nm_museu LIKE '%Pinacoteca%'
					)
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra58.jpg?alt=media&token=e6a1a0f7-9754-4993-8384-63096580e883'
				  )
				  ,
				  ( 1898
				  , 1898
				  , '"O Importuno" é uma obra do pintor brasileiro José Ferraz de Almeida Júnior, criada em 1893. Na obra, Almeida Júnior captura um momento específico e cômico que explora a relação entre os personagens, refletindo comportamentos e costumes da sociedade da época. A cena é rica em detalhes, com um ambiente que remete a uma sala de estar do século XIX, evidenciando o talento do artista para capturar expressões faciais e gestos. A obra reflete a crítica social à dinâmica de relacionamentos da época, além de evidenciar o estilo naturalista que caracterizava o trabalho de Almeida Júnior.'
				  , 'O Importuno'
				  , ( SELECT id
					    FROM genero
					   WHERE nm_genero = 'Naturalismo'
					)
				  , ( SELECT id 
					    FROM artista 
					   WHERE nm_artista = 'Almeida Júnior'
					)
				  , ( SELECT id
					    FROM museu
					   WHERE nm_museu LIKE '%Pinacoteca%'
					)
				  , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra59.jpg?alt=media&token=773716a9-a5f8-4a79-a2d2-01a8f2fe9f47'
				  );
			
INSERT INTO obra ( ano_inicio
				 , ano_final
				 , desc_obra
				 , nm_obra
				 , id_genero
				 , id_artista
				 , id_museu
				 , url_imagem
				 )
		 VALUES  ( 1920
				 , 1920
				 , '"A Parisiense" de Henrique Cavalleiro é uma pintura que retrata uma mulher elegante e sofisticada, típica da moda parisiense do início do século XX. Com traços delicados e cores suaves, a obra captura a essência do estilo e da atitude da mulher moderna da época, refletindo a influência da Art Nouveau e do impressionismo. A figura feminina, com um olhar sereno e vestido refinado, simboliza o charme e a elegância da capital francesa, destacando o talento do artista em expressar a beleza e a sofisticação através da arte.'
				 , 'A Parisiense'
				 , ( SELECT id
				       FROM genero
				      WHERE nm_genero = 'Retrato'
				   )
				 , ( SELECT id
			     	   FROM artista
					  WHERE nm_artista = 'Henrique Cavalleiro'
				   )
				 , ( SELECT id
					   FROM museu
					  WHERE nm_museu LIKE '%MNBA%'
					)
                 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra60.jpg?alt=media&token=e851ed75-a2eb-43ae-8c67-24162f57bab0'
				 ); 
				 
INSERT INTO obra ( ano_inicio
				 , ano_final
				 , desc_obra
				 , nm_obra
				 , id_genero
				 , id_artista
				 , id_museu
				 , url_imagem
				 )
		 VALUES  ( 1886
				 , 1886
				 , '"A Noiva" retrata uma jovem em trajes de casamento, sentada e imersa em pensamentos, transmitindo uma sensação de introspecção e serenidade. O jogo de luz e sombra destaca o rosto e o traje, dando profundidade e realçando a delicadeza da personagem. O fundo branco e neutro cria contraste, concentrando o olhar do observador na figura central e no simbolismo da ocasião, com foco nos sentimentos e incertezas que a envolvem.'
				 , 'A Noiva'
				 , ( SELECT id
				       FROM genero
				      WHERE nm_genero = 'Retrato'
				   )
				 , ( SELECT id
			     	   FROM artista
					  WHERE nm_artista = 'Almeida Júnior'
				   )
				 , ( SELECT id
					   FROM museu
					  WHERE nm_museu LIKE '%MAM%'
					)
                 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra62.jpg?alt=media&token=b9a0936c-5f6f-4a85-a14a-f90d2eabe456'
				 ); 

INSERT INTO obra ( ano_inicio
				 , ano_final
				 , desc_obra
				 , nm_obra
				 , id_genero
				 , id_artista
				 , id_museu
				 , url_imagem
				 )
		 VALUES  ( 1910
				 , 1920
				 , 'A obra Paisagem (Da Série Mata), retrata uma cena natural exuberante e detalhada, característica do Brasil. Pintada no início do século XX, a tela exibe a mata atlântica com uma riqueza de tons verdes e ocres, capturando a diversidade da vegetação tropical. A composição apresenta uma harmonia entre luz e sombra, ressaltando a densidade e a textura das árvores, folhagens e solo. Benedito Calixto utiliza pinceladas precisas e uma paleta terrosa para transmitir realismo, revelando um olhar sensível à natureza e à paisagem brasileira.'
				 , 'Paisagem (Da Série Mata)'
				 , ( SELECT id
				       FROM genero
				      WHERE nm_genero = 'Realismo'
				   )
				 , ( SELECT id
			     	   FROM artista
					  WHERE nm_artista = 'Benedito Calixto de Jesus'
				   )
				 , ( SELECT id
					   FROM museu
					  WHERE nm_museu LIKE '%MNBA%'
					)
                 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra63.jpg?alt=media&token=e2bc9fab-13ac-4aec-8d02-aad0940bd80c'
				 ); 

INSERT INTO obra ( ano_inicio
				 , ano_final
				 , desc_obra
				 , nm_obra
				 , id_genero
				 , id_artista
				 , id_museu
				 , url_imagem
				 )
		 VALUES  ( 2010
				 , 2010
				 , 'A fotografia Maranguara apresenta uma densa paisagem tropical da Mata Atlântica brasileira, quase impenetrável, composta por árvores, folhagens e umidade, criando uma atmosfera selvagem e misteriosa. Nessa obra, Reisewitz destaca a exuberância e a complexidade da floresta, sem elementos urbanos visíveis, enfatizando a grandiosidade da natureza. A imagem transmite uma sensação de intocabilidade e isolamento, ao mesmo tempo em que aponta para a importância da preservação das áreas naturais no Brasil.'
				 , 'Maranguara'
				 , ( SELECT id
				       FROM genero
				      WHERE nm_genero = 'Fotografia'
				   )
				 , ( SELECT id
			     	   FROM artista
					  WHERE nm_artista = 'Caio Reisewitz'
				   )
				 , ( SELECT id
					   FROM museu
					  WHERE nm_museu LIKE '%IMS%'
					)
                 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra64.jpg?alt=media&token=462ea0b8-c1d6-480f-bde8-86ba2fa814e0'
				 ); 

INSERT INTO obra ( ano_inicio
				 , ano_final
				 , desc_obra
				 , nm_obra
				 , id_genero
				 , id_artista
				 , id_museu
				 , url_imagem
				 )
		 VALUES  ( 1909
				 , 1909
				 , 'A pintura retrata a sessão de 9 de maio de 1822 das Cortes Constituintes, em Portugal. Encomenda do diretor do Museu Paulista Afonso Taunay, a obra deveria apresentar: uma sessão agitadíssima das cortes em que Antonio Carlos e os deputados brasileiros fazem frente ao partido recolonizador que quer votar medidas opressivas ao Brasil.'
				 , 'Sessão das Cortes de Lisboa'
				 , ( SELECT id
				       FROM genero
				      WHERE nm_genero = 'Historicismo'
				   )
				 , ( SELECT id
			     	   FROM artista
					  WHERE nm_artista = 'Oscar Pereira da Silva'
				   )
				 , ( SELECT id
					   FROM museu
					  WHERE nm_museu LIKE '%Ipiranga%'
					)
                 , 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/obras%2Fobra65.jpg?alt=media&token=560214dc-a2c4-4752-821d-570bb0df4615'
				 ); 


--INSERTS artista_genero
INSERT INTO artista_genero ( id_artista
						   , id_genero
						   )
					VALUES ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Tarsila do Amaral'
							 )
						   , ( SELECT id
							     FROM genero
							    WHERE nm_genero = 'Realismo'
							 )
						   )
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Rodolfo Amoedo'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Realismo'
							 )
						   )	
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Rodolfo Amoedo'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Historicismo'
							 )
						   )	
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Dudi Maia Rosa'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Contemporânea'
							 )
						   )	
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Almeida Júnior'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Realismo'
							 )
						   )	
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Almeida Júnior'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Naturalismo'
							 )
						   )
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Oscar Pereira da Silva'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Historicismo'
							 )
						   )							   
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Oscar Pereira da Silva'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Barroco'
							 )
						   )
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Oscar Pereira da Silva'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Academicismo'
							 )
						   )	
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Pedro Weingärtner'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Realismo'
							 )
						   )
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Pedro Weingärtner'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Naturalismo'
							 )
						   )
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Claudia Andujar'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Fotografia'
							 )
						   )
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Caio Reisewitz'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Fotografia'
							 )
						   )
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Benedito Calixto de Jesus'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Paisagem'
							 )
						   )
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Benedito Calixto de Jesus'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Historicismo'
							 )
						   )
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Djanira'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Paisagem'
							 )
						   )
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Henrique Cavalleiro'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Retrato'
							 )
						   )	
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Henrique Cavalleiro'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Impressionista'
							 )
						   )						   
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Henrique Cavalleiro'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Paisagem'
							 )
						   )			
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Georgina de Albuquerque'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Impressionista'
							 )
						   )
						   ,
						   ( ( SELECT id
							     FROM artista
							    WHERE nm_artista = 'Paul Michel Dupuy'
							 )
						   , ( SELECT id 
							     FROM genero 
							    WHERE nm_genero = 'Impressionista'
							 )
						   );
						   

--INSERTS guia
INSERT INTO guia ( id_museu, titulo_guia, desc_guia, url_imagem ) VALUES 
  (1, 'Realizando História (Do Realismo ao Historicismo)', 'Realizando História (Do Realismo ao Historicismo) é um guia que explora obras de arte que capturam a essência da vida. Através de pinturas detalhadas e cenas encatadoras, mergulhe em representações autênticas de momentos cotidianos.', 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/guias%2Fguia1.jpg?alt=media&token=f0e25e48-4edf-44f1-97db-c98775dfbdef')
, (1, 'Ecos da Modernidade: A Arte Até a Metade do Século XX', 'Esse guia percorre as principais obras do início ao meio do século XX, revelando como os artistas responderam a rápidas transformações culturais. Descubra movimentos, estilos e visões que moldaram o mundo moderno.', 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/guias%2Fguia2.jpg?alt=media&token=615b01d7-d217-411c-9594-bd82db8e712d')
, (2, 'Arte e Técnica: A Realidade na Visão Naturalista e Acadêmica', '"Arte e Técnica: A Realidade na Visão Naturalista e Acadêmica" é um guia que explora obras dos estilos Naturalismo e Academicismo, focados em retratar o mundo com rigor e detalhe. Aprofunde-se nas técnicas e visões que uniram ciência e arte para representar a realidade com precisão.', 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/guias%2Fguia3.jpg?alt=media&token=c48ab1be-995a-424b-ab79-c5fd64ab7e98')
, (2, 'Horizontes Contemporâneos (Arte do Final do Século XXI)', 'Esse guia apresenta as obras mais influentes das últimas décadas do século XXI, refletindo questões sociais e mostrando novas perspectivas.', 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/guias%2Fguia4.jpg?alt=media&token=1f0371ad-7d37-43c6-a474-f0f69cc2c93e')
, (3, 'Coleção Caio Reisewitz', 'A coleção de fotografias de Caio Reisewitz no IMS Paulista captura a interseção entre natureza e urbanidade no Brasil. Com uma estética que mescla realismo e abstração, as imagens revelam a complexidade das paisagens contemporâneas, convidando à reflexão sobre a relação entre o homem e seu entorno. Uma jornada visual instigante.', 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/guias%2Fguia5.jpg?alt=media&token=b88e7a92-182f-4bae-92d4-b47bc1e3f3d4')
, (3, 'Coleção Claudia Andujar', 'A coleção de fotografias de Claudia Andujar no IMS Paulista celebra a cultura e a resistência do povo Yanomami. Suas imagens, repletas de intimidade e respeito, capturam rituais, paisagens e a vida cotidiana, destacando a conexão profunda entre os Yanomami e a floresta, além de mostrar diversas de suas capturas sobre o estado de São Paulo.', 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/guias%2Fguia6.jpg?alt=media&token=1f04443e-df2d-41df-a16d-2910e60ac159')
, (4, 'Arquitetura da Memória (O Historicismo no Museu do Ipiranga)', 'O Museu do Ipiranga convida você a explorar as obras que capturam a essência de épocas passadas. Este guia apresenta as principais manifestações do Historicismo, revelando como essas criações artísticas e arquitetônicas dialogam com a memória e a identidade nacional.', 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/guias%2Fguia7.jpg?alt=media&token=cc52b26e-1bef-4632-a01a-5e65f338c699')
, (4, 'Coleção Oscar Pereira da Silva',	'Coleção Oscar Pereira da Silva apresenta um mergulho nas obras do renomado artista, destacando sua contribuição única à arte brasileira. Neste guia, você descobrirá as principais criações de Oscar, que refletem sua sensibilidade e maestria em retratar paisagens e cenas do cotidiano, revelando a riqueza cultural do Brasil.', 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/guias%2Fguia8.jpg?alt=media&token=4258dde3-e522-470b-80ab-8ce8cfc97513')
, (4, 'Experiência Caiçara', 'Experiência Caiçara é responsável por imergir os visitantes no universo vibrante de Benedito Calixto de Jesus. Este guia destaca suas obras mais emblemáticas, revelando a rica cultura caiçara e as belezas naturais que inspiraram o artista. Venha descobrir como Calixto captura a essência do litoral paulista em cada pincelada.', 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/guias%2Fguia9.jpg?alt=media&token=4f550cb0-0428-4fbc-8554-76a26fdcfb43')
, (5, 'Reflexos do Agora (A Arte Contemporânea no MAM)', 'O MAM convida você a explorar as principais obras da arte contemporânea em nosso museu. Descubra as tendências, estilos e temas que definem a produção artística atual, enquanto se conecta com a criatividade e inovação dos artistas contemporâneos.', 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/guias%2Fguia10.jpg?alt=media&token=a673cccb-f808-441e-adab-8aba3ad3625a')
, (5, 'Coleção Almeida Júnior', 'O guia apresenta uma seleção das obras mais emblemáticas do pintor brasileiro Almeida Júnior. Explorando temas do cotidiano e cenas regionais com realismo e expressividade, o guia busca revelar o talento do artista em capturar a cultura e a identidade do Brasil.', 'https://firebasestorage.googleapis.com/v0/b/leontisfotos.appspot.com/o/guias%2Fguia11.jpg?alt=media&token=a89a3671-cdf0-433e-89ac-e88f8671dc8d');

--INSERTS obra_guia
INSERT INTO obra_guia ( id_guia, id_obra, nr_ordem, desc_localizacao) VALUES
  (1, 25, 1, 'Para encontrar a melancolia da Amuada, siga o corredor principal até ver a mini estátua grega. Vire à esquerda depois da estátua e entre na primeira sala iluminada à direita. O quadro estará na sua frente.')
, (1, 28, 2, 'Depois de adentrar essa sala de obras, continue pelo mesma seção de obras até encontrar "Más Notícias", clássico do "realismo tardio" de Rodolfo Amoedo.')
, (1, 36, 3, 'Ainda na mesma seção, caminhe até achar a representação natural e realista de Benedito Calixto.')
, (2, 34, 1, 'Começando com as obras de Henrique Cavalleiro, vá ao terceiro andar e siga em frente até ver uma área com paredes de um tom azul-escuro. Entre na primeira porta, "A Parisiense" será a primeira obra que você vai ver.')
, (2, 29, 2, 'Continuando no tema da Cidade-Luz, veja a bela representação de um dos principais pontos da cidade logo ao lado da obra anterior.')
, (2, 30, 3, 'A próxima obra que fica na mesma parede é a última de Henrique Cavalleiro nesse guia.')
, (2, 26, 4, 'Vire à esquerda ao sair do terceiro andar. A galeria modernista será a terceira sala à direita, ao entrar você encontrará o autorretrato de uma das figuras centrais do movimento modernista no Brasil.')
, (2, 31, 5, 'Para finalizar esse guia, o museu escolheu "Dia de Verão", uma representação não só de um momento de descanso, mas também uma valorização da vida cotidiana feminina, explorada de forma estética e sentimental por uma das mais importantes artistas brasileiras do início do século XX.')
, (3, 14, 1, 'Siga pelo corredor B3 até o fundo do museu e vire à esquerda. A obra está em uma parede com iluminação baixa contrastando com o tom claro da obra, os assentos são livres uma para apreciação detalhada.')
, (3, 15, 2, 'No térreo do Edifício Pina Estação, siga pelo corredor decorado com pinturas naturalistas. A ""Paisagem"" no final do corredor é o seu destino.')
, (3, 9, 3, 'No primeiro andar, entre pela galeria principal de arte historicista. A pintura estará numa parede no centro da sala, rodeada por outras obras de Oscar Pereira da Silva.')
, (4, 6, 1,	'Vá até a Ala de Arte Nacional. A obra, conhecida pela sua moldura dourada, estará destacada em uma parede isolada, com espaço para que se possa observar os detalhes de perto.')
, (4, 8, 2, 'Siga até a sala 16 “Corpo individual, Corpo coletivo”, "Leitura" estará exposta lá.')
, (4, 7, 3, 'Na mesma sala, Saudade é a representação de uma mulher, que tem seu luto pelo homem amado representado  pelo artista como uma atitude adequada ao repertório moral da época.')
, (4, 9, 4, '"Infância de Giotto" se encontra na sala 17, ao lado do retrato do artista que a fez, evidenciando o convívio lado á lado de telas.')
, (4, 33, 5, 'Dentro da sala 2 (ateliê), está "O Importuno" que retrata uma modelo se escondendo das vistas do visitante indesejado e espia o desenrolar da situação. Nesse jogo de “esconde-esconde”, somos nós, observadores, que dominamos a visão do todo, os verdadeiros importunos.')
, (5, 19, 1, 'Essa fotografia está exposta na Biblioteca de Fotografias, localizada no terceiro andar, corredor 3.')
, (5, 20, 2, 'Essa fotografia está exposta na Biblioteca de Fotografias, localizada no terceiro andar, corredor 3.')
, (5, 37, 3, 'Essa fotografia está exposta na Biblioteca de Fotografias, localizada no terceiro andar, corredor 3.')
, (6, 16, 1, 'Essa fotografia está exposta na Biblioteca de Fotografias, localizada no terceiro andar, corredor 2.')
, (6, 17, 2, 'Essa fotografia está exposta na Biblioteca de Fotografias, localizada no terceiro andar, corredor 2')
, (6, 18, 3, 'Essa fotografia está exposta na Biblioteca de Fotografias, localizada no terceiro andar, corredor 2.')
, (7, 22, 1, 'Essa obra está exposta na Ala Central, localizada no Piso B, corredor 2.')
, (7, 11, 2, 'Essa obra está exposta na Ala Oeste, localizada no Piso B, corredor 1.')
, (7, 12, 3, 'Essa obra está exposta na Ala Oeste, localizada no Piso B, corredor 1.')
, (8, 23, 1, 'Essa obra está exposta na Ala Central, localizada no Piso B, corredor 2. Essa obra mostra o Convento de Itanhaém, mais antiga construção da cidade na qual o próprio Calixto foi responsável pelos vitrais da Igreja, é um importante ponto turístico da cidade até hoje.')
, (8, 22, 2, 'Essa obra está exposta na Ala Central, localizada no Piso B, corredor 2. Como sempre, Calixto representa de forma magnífica o aspecto das cidades caiçaras, com cores vibrantes e águas lindas.')
, (8, 24, 3, 'Essa obra está exposta na Ala Central, localizada no Piso B, corredor 2. Essa pintura foi feita quase que no fim da era de Brasil colônia, mostrando perfeitamente como era a estrutura e figura da cidade de Santos na época.')
, (9, 11, 1, 'Essa pintura está exposta na Ala Oeste, localizada no Piso B, corredor 1.')
, (9, 12, 2, 'Essa pintura está exposta na Ala Oeste, localizada no Piso B, corredor 1.')
, (9, 38, 3, 'Essa pintura está exposta na Ala Oeste, localizada no Piso B, corredor 1.')
, (10, 1, 1, 'Você encontrará a obra na "Sala Contemporânea 2" no canto direito atrás do pilar preto, essa sala fica próxima ao pátio.')
, (10, 3, 2, 'Vá até o canto esquerdo da sala para encontrar mais uma das obras contemporâneas de Dudi Maia Rosa fixada na parede.')
, (10, 2, 3, '"To Mam" está localizada à direita de "Praia do Curral".')
, (11, 5, 1, 'Você encontrará a obra na sala ""Brasil no Século XXI"", localizada no térreo.')
, (11, 4, 2, 'Você encontrará a obra na ""Brasil no Século XXI"", localizada no térreo.')
, (11, 35, 3, 'Você encontrará a obra na ""Brasil no Século XXI"", localizada no térreo.');




-- Excluindo registros da tabela
truncate table artista RESTART IDENTITY CASCADE;
truncate table artista_genero RESTART IDENTITY cascade;
truncate table genero RESTART IDENTITY cascade;
truncate table dia_funcionamento RESTART IDENTITY cascade;
truncate table guia RESTART IDENTITY cascade;
truncate table obra RESTART IDENTITY cascade;
truncate table obra_guia RESTART IDENTITY cascade;
truncate table museu RESTART IDENTITY cascade;
truncate table museu_adm RESTART IDENTITY cascade;
truncate table usuario RESTART IDENTITY cascade;
truncate table usuario_genero RESTART IDENTITY cascade;
truncate table usuario_museu RESTART IDENTITY cascade;
truncate table log_geral RESTART IDENTITY cascade;

-- Visualizando
select * from artista
select * from artista_genero
select * from genero
select * from dia_funcionamento
select * from guia
select * from obra
select * from obra_guia
select * from museu_adm
select * from museu
select * from usuario
select * from usuario_genero
select * from usuario_museu
select * from log_geral

