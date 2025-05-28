# Utiliser le start.bat, puis exécuter depuis ce répertoire cette commande pour compléter la base de données (en wsl bien sûr, à cause d'une petite galère avec le dump) : 

wsl : docker exec -i mysql_evaluation mysql -uroot -pHitema2025 sakila < dump.sql
