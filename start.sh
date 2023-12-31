#!/bin/bash

# Funktion zum Deaktivieren von Cockpit
disable_cockpit() {
    read -p "Möchten Sie Cockpit DEaktivieren? (y/N): " choice
    if [ "$choice" == "y" ]; then
        echo "Deaktiviere Cockpit..."
        systemctl stop cockpit.socket
        echo "Cockpit wurde deaktiviert."
    else
        echo "Keine Änderung."
    fi
}

# Funktion zum Aktivieren von Cockpit
enable_cockpit() {
    read -p "Möchten Sie die Cockpit aktivieren? (y/N): " choice
    if [ "$choice" == "y" ]; then
        echo "Aktiviere Cockpit..."
        systemctl enable --now cockpit.socket
        echo "Cockpit wurde aktiviert."
    else
        echo "Keine Änderung."
    fi
}

# Funktion zum Aktualisieren von Paketen
update_packages() {
    read -p "Möchten Sie die Paketaktualisierungen durchführen? (y/N): " choice
    if [ "$choice" == "y" ]; then
        echo "Aktualisiere Paketlisten und installiere Updates..."
        apt update && apt upgrade -y && apt dist-upgrade -y && apt autoremove -y
        echo "Paketaktualisierungen wurden durchgeführt."
    else
        echo "Die Paketaktualisierungen werden übersprungen."
    fi
}

# Funktion zum Update und Ausführen von rkhunter (Tool zur Erkennung von Eindringlingen)
updaterun_rkhunter() {
    read -p "Möchten Sie rkhunter aktualieren und ausführen? (y/N): " choice
    if [ "$choice" == "y" ]; then
        echo "Update rkhunter..."
        rkhunter --update
        echo "Ausführen rkhunter..."
        rkhunter --check
        echo "rkhunter wurde aktualisiert und ausgeführt."
    else
        echo "rkhunter wird übersprungen."
    fi
}

# Hauptfunktion
start_server() {
    disable_cockpit
    enable_cockpit
    update_packages
    updaterun_rkhunter
}

# Hauptprogramm
echo "Start-Programm wird gestartet..."
echo "Eingabe-Taste bedeutet NEIN."

# Datei-Abfrage

if [ -f ~/start.sh ]; then

    echo "Möchten Sie das Wartungsscript aktualisieren? [y/N]"
    read -n 1 -s choice
        if [ "$choice" == "y" ];  then
        wget https://github.com/FabiansGithub/serverscripts/raw/main/start.sh -O start.sh
        echo "Bitte geben Sie bash start.sh ein, um das Script zu starten."
        else
        start_server
        fi
echo "Ist OpenSSH aktualisiert worden (>8.9p1)?"
ssh -V
echo "Start-Programm wurde erfolgreich abgeschlossen."
fi
