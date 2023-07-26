#!/bin/bash

# Funktion zum Aktivieren der Firewall
enable_firewall() {
    echo "Aktiviere die Firewall..."
    sudo ufw enable
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    echo "Firewall wurde aktiviert."
}

# Funktion zum Aktualisieren von Paketen
update_packages() {
    echo "Aktualisiere Paketlisten und installiere Updates..."
    sudo apt update
    sudo apt upgrade -y
    echo "Paketaktualisierungen wurden durchgeführt."
}

# Funktion zur Sicherung des /home-Verzeichnisses
backup_home() {
    echo "Erstelle ein Backup des /home-Verzeichnisses..."
    sudo tar czf /var/backups/home_$(date +%Y%m%d).tar.gz /home
    echo "Das Backup wurde unter /var/backups/ gespeichert."
}

# Funktion zur Installation von Fail2Ban (Tool zur Erkennung von Eindringlingen)
install_fail2ban() {
    echo "Installiere Fail2Ban..."
    sudo apt install fail2ban -y
    sudo systemctl enable fail2ban
    sudo systemctl start fail2ban
    echo "Fail2Ban wurde installiert und gestartet."
}

# Hauptfunktion zur Einrichtung des Servers
setup_server() {
    enable_firewall
    update_packages
    backup_home
    install_fail2ban
}

# Hauptprogramm
echo "Server-Einrichtung und Absicherung wird gestartet..."
setup_server
echo "Server-Einrichtung und Absicherung wurde erfolgreich abgeschlossen."
