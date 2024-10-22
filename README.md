# Leontis
Leontis é um aplicativo em desenvolvimento que será apresentado na Expo Tech 2024. O app permite escanear obras em museus, acessar guias digitais de museus, acompanhar notícias sobre o mundo da arte, entre outros recursos.

## Banco de Dados do Leontis - Modelagem de Dados

### Descrição
Este repositório guarda os scripts SQL utilizados na modelagem dos bancos de dados do aplicativo Leontis. O desenvolvimento abrange os bancos do primeiro e segundo ano do projeto, com ajustes e sincronizações implementadas para assegurar o melhor desempenho e a integridade dos dados do sistema.

#### Informações gerais do banco do primeiro ano:

Contém a versão inicial do banco, sem a normalização. Além da tabela de log e triggers para registras as atividades entre as tabelas.

#### Informações gerais do banco do segundo ano:

Contém a versão do banco já normalizada, com todas as tabelas necessárias. Além de tabelas de log independentes e a tabela de log geral, para registrar todas as atividades entre as tabelas no banco, para possibilitar a sincronização entre bancos através do RPA.

### Estrutura do Repositório
dbLeontis_PrimeiroAnoFinal.sql: Script SQL do banco de dados do primeiro ano, com as alterações mencionadas, incluindo a tabela de logs e triggers associadas.

dbLeontis_SegundoAno.sql: Script SQL do banco de dados do segundo ano, focado na normalização e otimização, com procedures e triggers para sincronização.

### Equipe
❤️ Feito com carinho por:
- [Neife Junior](https://github.com/NeifeJunior)
