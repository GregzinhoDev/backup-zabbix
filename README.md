Backup do Banco de Dados do Zabbix e Armazenamento via FTP
Este repositório contém um script que realiza backup do banco de dados do Zabbix e, em seguida, armazena o backup em um servidor de armazenamento via FTP.

Requisitos
Zabbix Server instalado
Acesso ao banco de dados do Zabbix
Servidor FTP para armazenamento dos backups
Configuração
Clone o repositório:
bash
Copy code
git clone [URL_DO_REPOSITÓRIO]
Navegue até a pasta do projeto:
bash
Copy code
cd [NOME_DA_PASTA_DO_REPOSITÓRIO]
Edite o arquivo config.ini com suas configurações de banco de dados e FTP. Certifique-se de fornecer todos os detalhes corretamente.
ini
Copy code
[DATABASE]
HOST = seu_host
PORT = sua_porta
USER = seu_usuário
PASSWORD = sua_senha
DB_NAME = nome_do_banco

[FTP]
HOST = ftp_host
PORT = ftp_porta
USER = ftp_usuário
PASSWORD = ftp_senha
Torne o script executável:
bash
Copy code
chmod +x backup_zabbix_ftp.sh
Uso
Para executar o script de backup:

bash
Copy code
./backup_zabbix_ftp.sh
O script irá:

Realizar backup do banco de dados do Zabbix.
Compactar o backup.
Transferir o backup compactado para o servidor FTP configurado.
Agendamento
Você pode agendar esse script para ser executado automaticamente em intervalos regulares usando o cron. Por exemplo, para executar o script todos os dias às 2 da manhã, você pode adicionar a seguinte linha ao seu crontab:

bash
Copy code
0 2 * * * /caminho/absoluto/para/backup_zabbix_ftp.sh
Contribuições
Sugestões e contribuições são bem-vindas! Por favor, abra uma issue ou faça um pull request.
