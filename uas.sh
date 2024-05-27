#!/bin/bash

# Loop utama untuk menampilkan menu dan memproses pilihan pengguna
while true; do
    clear
    echo "===================="
    echo " Menu Konfigurasi Jaringan "
    echo "===================="
    echo "1. Konfigurasi Alamat IP (ifconfig)"
    echo "2. Konfigurasi Alamat IP (ip)"
    echo "3. Konfigurasi DNS (nmcli)"
    echo "4. Keluar"
    echo "===================="
    read -p "Pilih opsi [1-4]: " pilihan

    case $pilihan in
        1)
            read -p "Masukkan nama interface: " interface
            read -p "Masukkan alamat IP baru: " ip_address
            read -p "Masukkan netmask baru: " netmask
            echo "Menjalankan: sudo ifconfig $interface $ip_address netmask $netmask"
            sudo ifconfig $interface $ip_address netmask $netmask
            ;;
        2)
            read -p "Masukkan nama interface: " interface
            read -p "Masukkan alamat IP baru dengan CIDR (contoh: 192.168.1.10/24): " ip_address
            echo "Menjalankan: sudo ip addr add $ip_address dev $interface"
            sudo ip addr add $ip_address dev $interface
            echo "Menjalankan: sudo ip link set $interface up"
            sudo ip link set $interface up
            ;;
        3)
            read -p "Masukkan nama koneksi (contoh: eth0): " connection
            read -p "Masukkan DNS baru (contoh: 8.8.8.8): " dns
            echo "Menjalankan: sudo nmcli con mod $connection ipv4.dns \"$dns\""
            sudo nmcli con mod "$connection" ipv4.dns "$dns"
            echo "Menjalankan: sudo nmcli con up $connection"
            sudo nmcli con up "$connection"
            ;;
        4)
            echo "Keluar dari program..."
            break
            ;;
        *)
            echo "Pilihan tidak valid. Silakan coba lagi."
            ;;
    esac
    echo "Tekan Enter untuk melanjutkan..."
    read
done
