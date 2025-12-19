#!/bin/bash

URL="https://onboardcloud.dl.sourceforge.net/project/xampp/XAMPP%20Windows/8.0.30/xampp-windows-x64-8.0.30-0-VS16-installer.exe?viasf=1"
FILENAME="xampp-test.bin"
MEM_FILE="/tmp/mem_test.tmp"
LOG="/var/log/zabbix_test_load.log"

while true; do
    echo "[$(date)] === START CYCLE ===" | tee -a $LOG

    # =========================
    # CPU LOAD (±1 core)
    # =========================
    echo "[$(date)] Generating CPU load" | tee -a $LOG
    timeout 8s sha256sum /dev/zero >/dev/null &

    # =========================
    # MEMORY LOAD (±200MB)
    # =========================
    echo "[$(date)] Generating Memory load" | tee -a $LOG
    dd if=/dev/zero of=$MEM_FILE bs=1M count=200 status=none &
    sleep 5
    rm -f $MEM_FILE

    # =========================
    # NETWORK LOAD
    # =========================
    sleep 4

    if [ -f "$FILENAME" ]; then
        echo "[$(date)] Deleting file" | tee -a $LOG
        rm -f "$FILENAME"
    fi

    echo "[$(date)] Downloading file" | tee -a $LOG
    wget -O "$FILENAME" "$URL" --limit-rate=5M

    sleep 1
    echo "[$(date)] === END CYCLE ===" | tee -a $LOG
done
