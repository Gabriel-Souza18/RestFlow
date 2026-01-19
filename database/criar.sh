# Criar banco + executar script em uma linha
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS restoflow_mvp;"
mysql -u root -p restoflow_mvp < init.sql
