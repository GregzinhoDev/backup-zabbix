#!/bin/bash

source config-script-zabbix.sh

# Comando pg_dump para criar o backup
PGPASSWORD="$DB_PASSWORD" pg_dump --host="$DB_HOST" --username="$DB_USER" --dbname="$DB_NAME" --file="$BACKUP_DIR/$BACKUP_FILE"

# Verificação do resultado do comando pg_dump
if [ $? -eq 0 ]; then
    echo "Backup do banco de dados zabbix realizado com sucesso."
else
    echo "Erro ao fazer o backup do banco de dados zabbix."
    exit 1
fi

# Enviar o arquivo de backup via FTP usando o cliente lftp
lftp -e "set ftp:ssl-allow no; open ftp://$FTP_USER:$FTP_PASSWORD@$FTP_HOST; cd $FTP_DESTINATION; put \"$BACKUP_DIR/$BACKUP_FILE\"; bye"

# Verificação do resultado do comando lftp
if [ $? -eq 0 ]; then
    echo "Backup do banco de dados zabbix exportado via FTP com sucesso."
    # Remover o arquivo de backup do servidor local
    rm "$BACKUP_DIR/$BACKUP_FILE"
    echo "Backup do banco de dados zabbix removido do servidor local."
else
    echo "Erro ao exportar o backup do banco de dados zabbix via FTP."
    exit 1
fi

# Manter somente os últimos 7 backups no servidor FTP
lftp -e "set ftp:ssl-allow no; open ftp://$FTP_USER:$FTP_PASSWORD@$FTP_HOST; cd $FTP_DESTINATION; ls -lt > /tmp/ftp_files.txt; bye"
tail -n +2 /tmp/ftp_files.txt | awk '/\.sql$/ {print $9}' | tail -n +8 | while read file; do
    lftp -e "set ftp:ssl-allow no; open ftp://$FTP_USER:$FTP_PASSWORD@$FTP_HOST; cd $FTP_DESTINATION; rm \"$file\"; bye"
done