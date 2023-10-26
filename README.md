
# Script de Backup para o Banco de Dados Zabbix

Este repositório contém scripts para fazer backup do banco de dados Zabbix (PostgreSQL) e exportar o backup via FTP.

## Arquivos

1. `config-script-zabbix.sh`: Define as variáveis de configuração para o banco de dados, local de backup e servidor FTP.
2. `script-zabbix.sh`: Realiza o backup do banco de dados e o envia para um servidor FTP.

## Como usar

1. Modifique o arquivo `config-script-zabbix.sh` com suas informações:
   - Configurações do banco de dados (host, nome, usuário e senha).
   - Diretório temporário para o backup.
   - Configurações do servidor FTP (host, usuário, senha e destino).

2. Execute o script `script-zabbix.sh` para iniciar o processo de backup:
   ```bash
   ./script-zabbix.sh
   ```

## Funcionalidade do Script

1. Realiza o backup do banco de dados Zabbix usando `pg_dump`.
2. Exporta o arquivo de backup para um servidor FTP usando `lftp`.
3. Mantém apenas os últimos 7 backups no servidor FTP, removendo os mais antigos.

---

**Nota**: Certifique-se de ter os programas `pg_dump` e `lftp` instalados em seu servidor e de dar permissões de execução para os scripts.


### Configurando Permissões

#### Permissão somente para o usuário root no arquivo de configuração

Para garantir que somente o usuário `root` tenha acesso ao arquivo de configuração (que contém informações sensíveis como senhas), execute o seguinte comando:

```bash
sudo chown root:root config-script-zabbix.sh
sudo chmod 600 config-script-zabbix.sh
```

O comando acima define o dono e o grupo do arquivo para `root` e configura as permissões para que somente o dono (root) possa ler e escrever no arquivo, enquanto todos os outros não têm permissões.

#### Permissão de execução no arquivo principal

Para dar permissão de execução ao script principal, execute o seguinte comando:

```bash
sudo chmod +x script-zabbix.sh
```

### Criando uma Cron Job para Execução Diária

Para executar o script diariamente, por exemplo, às 2h da manhã, você pode configurar uma tarefa cron. Primeiro, abra o crontab do usuário root com o seguinte comando:

```bash
sudo crontab -e
```

Em seguida, adicione a seguinte linha ao arquivo:

```
0 2 * * * /caminho/absoluto/para/script-zabbix.sh
```

Certifique-se de substituir `/caminho/absoluto/para/` pelo caminho correto onde o seu script está localizado.

Salve e feche o arquivo. A cron job agora está configurada para executar o script todos os dias às 2h da manhã.
