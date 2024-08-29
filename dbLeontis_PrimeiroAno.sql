CREATE TABLE genero 
( 
 id INT PRIMARY KEY,  
 nm_genero VARCHAR(100) constraint nm_genero_nulo not null,  
 intro VARCHAR(300) default 'Que pena! Estamos sem essa introdução no momento.' ,  
 desc_genero TEXT constraint desc_genero_nulo not null,
 url_imagem VARCHAR(500) 
); 


CREATE TABLE museu 
( 
 id INT PRIMARY KEY,  
 nm_museu VARCHAR(100) constraint nm_museu_nulo not null,  
 desc_museu TEXT default 'Este museu por tanta coisa! Concorda?',  
 rua VARCHAR(150),
 estado VARCHAR(150),
 cidade VARCHAR(150),
 ponto_referencia VARCHAR(150),
 cep VARCHAR(20),
 dt_inauguracao DATE default current_date, 
 nr_tel_museu VARCHAR(20) default 'Sem telefone!',
 url_imagem VARCHAR(500) 
); 

CREATE TABLE guia 
( 
 id INT PRIMARY KEY,  
 titulo_guia VARCHAR(100) constraint titulo_guia_nulo not null,  
 desc_guia TEXT default 'Este guia irá te guiar por esta sala!',  
 id_museu INT,
 url_imagem VARCHAR(500) 
); 

CREATE TABLE artista 
( 
 id INT PRIMARY KEY,
 nm_artista VARCHAR(100) constraint nm_artista_nulo not null,  
 dt_nasc_artista DATE,  
 dt_falecimento DATE constraint dt_falec_maior check (dt_falecimento>dt_nasc_artista),  
 local_nasc VARCHAR(100),  
 local_morte VARCHAR(100),  
 desc_artista TEXT default 'Poxa! Esse artista está sem descrição no momento.',
 url_imagem VARCHAR(500) 
); 

CREATE TABLE dia_funcionamento
( 
 id SERIAL PRIMARY KEY,
 hr_inicio VARCHAR(20),  
 hr_termino VARCHAR(20),  
 pr_dia_funcionamento FLOAT constraint preco_negativo check(pr_dia_funcionamento>0),  
 dia_semana VARCHAR(20) constraint dia_semana_nulo not null,  
 id_museu INT,
	constraint hr_inicio_termino_nulo check (
        (hr_inicio is null and hr_termino is null) or 
        (hr_inicio is not null and hr_termino is not null)
    )
); 

CREATE TABLE usuario_museu 
(
 id INT PRIMARY KEY,  
 id_museu INT,  
 id_usuario INT
); 

CREATE TABLE obra_guia 
( 
 id INT PRIMARY KEY,  
 nr_ordem INT constraint nr_order_negativo check(nr_ordem>0) ,  
 id_guia INT,  
 id_obra INT  
); 

CREATE TABLE artista_genero 
(
 id INT PRIMARY KEY,
 id_artista INT,  
 id_genero INT 
); 

CREATE TABLE usuario_genero 
( 
 id INT PRIMARY KEY,
 id_usuario INT,  
 id_genero INT
); 

CREATE TABLE obra
( 
 id INT PRIMARY KEY,  
 ano_inicio DATE default current_date,  
 ano_final DATE default current_date constraint ano_final_menor check (ano_final>ano_inicio),  
 desc_obra TEXT default 'Que obra linda! Não é mesmo?',  
 nm_obra VARCHAR(100) constraint nm_obra_nulo not null,  
 id_genero INT,  
 id_artista INT,  
 id_museu INT,
 url_imagem VARCHAR(500) 
); 


CREATE TABLE usuario
( 
 id serial PRIMARY KEY,  
 nm_usuario VARCHAR(100) constraint nm_usuario_nulo not null,  
 sobrenome VARCHAR(100) constraint sobrenome_nulo not null,  
 email_usuario VARCHAR(100) constraint email_usuario_nulo not null,   
 nr_tel_usuario VARCHAR(20) constraint nr_tel_usuario_nulo not null,  
 dt_nasci_usuario DATE default current_date, 
 biografia VARCHAR(280) default 'Oi, eu estou usando o Leontis!',  
 sexo VARCHAR(1) constraint sexo_nulo not null constraint sexo_invalido check(sexo in ('M','F','O')),  
 apelido VARCHAR(100),  
 senha_usuario VARCHAR(100) constraint senha_usuario_nula not null,
 url_imagem VARCHAR(500) 
); 

ALTER TABLE obra ADD FOREIGN KEY(id_genero) REFERENCES genero (id);
ALTER TABLE obra ADD FOREIGN KEY(id_artista) REFERENCES artista (id);
ALTER TABLE obra ADD FOREIGN KEY(id_museu) REFERENCES museu (id);
ALTER TABLE guia ADD FOREIGN KEY(id_museu) REFERENCES museu (id);
ALTER TABLE dia_funcionamento ADD FOREIGN KEY(id_museu) REFERENCES museu (id);
ALTER TABLE usuario_museu ADD FOREIGN KEY(id_museu) REFERENCES museu (id);
ALTER TABLE usuario_museu ADD FOREIGN KEY(id_usuario) REFERENCES usuario (id);
ALTER TABLE obra_guia ADD FOREIGN KEY(id_guia) REFERENCES guia (id);
ALTER TABLE obra_guia ADD FOREIGN KEY(id_obra) REFERENCES obra (id);
ALTER TABLE artista_genero ADD FOREIGN KEY(id_artista) REFERENCES artista (id);
ALTER TABLE artista_genero ADD FOREIGN KEY(id_genero) REFERENCES genero (id);
ALTER TABLE usuario_genero ADD FOREIGN KEY(id_usuario) REFERENCES usuario (id);
ALTER TABLE usuario_genero ADD FOREIGN KEY(id_genero) REFERENCES genero (id);


-- Tabela de Log Geral para registrar ações no banco e auxiliar no RPA de sincronização de Bancos.

CREATE TABLE log_geral (
    id SERIAL PRIMARY KEY,
    tabela VARCHAR(50) NOT NULL,
    id_registro BIGINT NOT NULL,
    operacao VARCHAR(50) NOT NULL,
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_operation()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES (TG_TABLE_NAME, NEW.id, 'INSERT');
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES (TG_TABLE_NAME, NEW.id, 'UPDATE');
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO log_geral (tabela, id_registro, operacao)
        VALUES (TG_TABLE_NAME, OLD.id, 'DELETE');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criando triggers para cada tabela
CREATE TRIGGER trigger_log_artista
AFTER INSERT OR UPDATE OR DELETE ON artista
FOR EACH ROW
EXECUTE FUNCTION log_operation();

CREATE TRIGGER trigger_log_artista_genero
AFTER INSERT OR UPDATE OR DELETE ON artista_genero
FOR EACH ROW
EXECUTE FUNCTION log_operation();

CREATE TRIGGER trigger_log_dia_funcionamento
AFTER INSERT OR UPDATE OR DELETE ON dia_funcionamento
FOR EACH ROW
EXECUTE FUNCTION log_operation();

CREATE TRIGGER trigger_log_genero
AFTER INSERT OR UPDATE OR DELETE ON genero
FOR EACH ROW
EXECUTE FUNCTION log_operation();

CREATE TRIGGER trigger_log_guia
AFTER INSERT OR UPDATE OR DELETE ON guia
FOR EACH ROW
EXECUTE FUNCTION log_operation();

CREATE TRIGGER trigger_log_endereco_museu
AFTER INSERT OR UPDATE OR DELETE ON endereco_museu
FOR EACH ROW
EXECUTE FUNCTION log_operation();

CREATE TRIGGER trigger_log_museu
AFTER INSERT OR UPDATE OR DELETE ON museu
FOR EACH ROW
EXECUTE FUNCTION log_operation();

CREATE TRIGGER trigger_log_obra
AFTER INSERT OR UPDATE OR DELETE ON obra
FOR EACH ROW
EXECUTE FUNCTION log_operation();

CREATE TRIGGER trigger_log_obra_guia
AFTER INSERT OR UPDATE OR DELETE ON obra_guia
FOR EACH ROW
EXECUTE FUNCTION log_operation();




-- Selects Normais

select * from artista 
select * from genero 
select * from guia
select * from museu 
select * from obra
select * from usuario
select * from artista_genero 
select * from dia_funcionamento
select * from obra_guia
select * from usuario_genero
select * from usuario_museu

-- Drops Normais
-- drop table artista cascade;
-- drop table artista_genero cascade;
-- drop table dia_funcionamento cascade;
-- drop table genero cascade;
-- drop table guia cascade;
-- drop table endereco_museu cascade;
-- drop table museu cascade;
-- drop table obra cascade;
-- drop table obra_guia cascade;
-- drop table usuario cascade;
-- drop table usuario_genero cascade;
-- drop table usuario_museu cascade;

















