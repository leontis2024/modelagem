# Leontis
Leontis é um aplicativo em desenvolvimento que será apresentado na Expo Tech 2024. O app permite que os usuários explorem museus, conheçam artistas brasileiros, acompanhem notícias sobre o mundo da arte e interajam com guias digitais de museus, entre outros recursos.

## Banco de Dados do Leontis - Modelagem de Dados

### Descrição
Este repositório contém os scripts SQL utilizados para modelar o banco de dados do aplicativo Leontis. A modelagem abrange o banco de dados inicial e sua evolução com normalização e otimizações, além de mecanismos para garantir a integridade e o desempenho do sistema.

### Banco do Primeiro Ano:
Estrutura básica do banco de dados com dados iniciais e triggers para registrar atividades entre as tabelas.
Log de operações fundamentais para rastrear mudanças e interações de usuários no aplicativo.

### Banco do Segundo Ano:
Banco de dados normalizado em até a terceira forma normal (3NF), com tabelas adicionais de log e otimização de consultas.
Procedures e triggers para gerenciar interações entre os usuários e entidades, garantindo integridade e auditabilidade.
Índices estratégicos para melhorar a eficiência das consultas, visando um desempenho ideal.

### Funcionalidades e Estrutura
#### Normalização e Estruturação:
Banco de dados completamente normalizado (3NF) para evitar redundâncias e manter dados organizados e consistentes.
Estrutura robusta para armazenar informações de museus, artistas, obras de arte, e interações dos usuários, como preferências e visitas.

#### Procedures:
Procedures para inserir, atualizar e deletar dados de usuários, verificando a integridade dos dados.
Procedures para gerenciar o acompanhamento de museus e gêneros de arte, oferecendo uma experiência personalizada aos usuários.

#### Triggers e Logs:
Triggers em tabelas principais para registrar automaticamente operações de inserção, atualização e exclusão, permitindo rastreabilidade das atividades.
Tabelas de log para monitoramento específico e uma tabela de log geral para centralizar todas as ações, facilitando auditorias e sincronização de dados entre sistemas.

#### Índices:
Índices foram criados em colunas estratégicas para otimizar o desempenho das consultas, garantindo que o banco de dados suporte o crescimento de usuários e dados sem comprometer a performance.

### Estrutura do Repositório
dbLeontis_PrimeiroAno.sql: Script SQL do banco de dados do primeiro ano, com estrutura inicial, triggers e log de operações.
dbLeontis_SegundoAno.sql: Script SQL do banco de dados do segundo ano, com estrutura normalizada, procedures, triggers otimizadas e índices para melhorar o desempenho.

### Equipe
❤️ Feito com carinho por:

- [Neife Junior](https://github.com/NeifeJunior)
