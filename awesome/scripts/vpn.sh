#!/bin/bash

# Путь к конфигурационному файлу WireGuard
CONFIG_FILE="/etc/wireguard/main.conf"

# Проверка аргумента командной строки
if [[ $# -ne 1 ]]; then
    echo "Usage: vpn.sh [up | down]"
    exit 1
fi

# Функция для активации VPN
activate_vpn() {
    sudo wg-quick up "$CONFIG_FILE"
    echo "VPN activated"
}

# Функция для отключения VPN
deactivate_vpn() {
    sudo wg-quick down "$CONFIG_FILE"
    echo "VPN deactivated"
}

# Проверка аргумента и вызов соответствующей функции
case "$1" in
    "up") activate_vpn ;;
    "down") deactivate_vpn ;;
    *) echo "Unknown option: $1" ;;
esac
