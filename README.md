# Leontis
Leontis é um aplicativo em desenvolvimento que será apresentado na Expo Tech 2024. O app permite escanear obras em museus, acessar guias digitais de museus, acompanhar notícias sobre o mundo da arte, entre outros recursos.

## Banco de Dados do Leontis - Modelagem de Dados

### Descrição
Este repositório guarda os scripts SQL utilizados na modelagem dos bancos de dados do aplicativo Leontis. O desenvolvimento abrange os bancos do primeiro e segundo ano do projeto, com ajustes e sincronizações implementadas para assegurar o melhor desempenho e a integridade dos dados do sistema.

#### Banco de Dados do Primeiro Ano:
#### Tabela de Logs
No banco do primeiro ano, uma tabela de logs foi criada para rastrear as operações de inserção, atualização e exclusão em várias tabelas. Isso facilita o monitoramento e sincronização de dados entre os bancos do primeiro e segundo ano. As triggers, associadas a essa tabela, são responsáveis por automatizar o registro das operações.

### Triggers:
#### Trigger de Inserção:
Função: Sempre que uma nova linha é inserida em uma das tabelas principais (como museu, obra, etc.), essa trigger entra em ação e registra o evento na tabela de logs, com detalhes da operação, como a data e hora da inserção.

Objetivo: Garantir que toda inserção seja rastreada para sincronização posterior.

#### Trigger de Atualização:
Função: Sempre que uma linha é atualizada em uma tabela monitorada, essa trigger registra os detalhes da operação na tabela de logs, informando a alteração realizada.

Objetivo: Acompanhar mudanças nos dados, para que essas alterações possam ser refletidas no banco do segundo ano.

#### Trigger de Deleção:
Função: Toda vez que uma linha é excluída, essa trigger registra a operação no log, incluindo a identificação do item excluído e a data da deleção.

Objetivo: Garantir que as exclusões sejam registradas e possam ser sincronizadas adequadamente entre os bancos.

#### Banco de Dados do Segundo Ano:
#### Procedures:
As procedures no banco do segundo ano são usadas para automatizar processos e padronizar as operações realizadas no banco de dados.

#### Procedure de Sincronização:
Função: Sincroniza os dados entre o banco do primeiro e o segundo ano. Essa procedure verifica os logs no banco do primeiro ano e atualiza o banco do segundo ano conforme as operações (inserção, atualização, deleção) registradas.

Objetivo: Assegurar que os dois bancos estejam sempre sincronizados, evitando a duplicação ou perda de dados.

#### Procedure de Backup:
Função: Realiza o backup das tabelas principais antes de qualquer operação crítica, como sincronizações ou alterações em massa.

Objetivo: Garantir a segurança dos dados, permitindo a recuperação em caso de falha durante o processo de sincronização.

#### Functions:
As functions no banco do segundo ano são usadas para executar cálculos ou retornos de informações específicos.

#### Function de Validação:
Função: Valida se os dados sincronizados estão consistentes com as regras de negócio, como a verificação de chaves estrangeiras ou a conformidade com valores esperados.

Objetivo: Assegurar que os dados sincronizados mantenham a integridade e consistência.

#### Function de Conversão de Dados:

Função: Converte dados de um formato para outro durante a sincronização, como transformar strings em formatos padronizados ou ajustar tipos de dados (e.g., de varchar para integer).

Objetivo: Garantir que os dados no banco do primeiro ano sejam convertidos corretamente para o formato exigido no banco do segundo ano.

#### Triggers no Banco de Dados do Segundo Ano:
#### Trigger de Atualização Automática:
Função: Quando uma linha em uma tabela monitorada é modificada no banco do segundo ano, essa trigger aciona a sincronização automática de dados com o banco do primeiro ano, garantindo que as mudanças sejam refletidas em ambos os bancos.

Objetivo: Facilitar a integração contínua de dados, permitindo que as alterações sejam propagadas sem necessidade de intervenção manual.

### Destaques do banco do segundo ano:

Triggers e procedures: Implementações focadas na automação de tarefas e na garantia da integridade dos dados.

Functions personalizadas: Suporte a operações específicas do aplicativo, como sincronizações e cálculos.

Sincronização com o primeiro ano: Ferramentas e métodos para garantir a correta integração e transferência de dados entre as diferentes versões do banco.

### Estrutura do Repositório
dbLeontis_PrimeiroAnoFinal.sql: Script SQL do banco de dados do primeiro ano, com as alterações mencionadas, incluindo a tabela de logs e triggers associadas.
dbLeontis_SegundoAno.sql: Script SQL do banco de dados do segundo ano, focado na normalização e otimização, com procedures e triggers para sincronização.

### Equipe
❤️ Feito com carinho por:
- [Neife Junior](https://github.com/NeifeJunior)
