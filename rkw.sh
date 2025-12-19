#!/bin/bash
# ==========================================
# STRESS TEST SCRIPT (CPU, RAM, NETWORK)
# ==========================================
# WARNING: JANGAN JALANKAN DI PRODUCTION
# ==========================================

URL="https://onboardcloud.dl.sourceforge.net/project/xampp/XAMPP%20Windows/8.0.30/xampp-windows-x64-8.0.30-0-VS16-installer.exe?viasf=1"
FILE="/tmp/network_stress.bin"
MEMFILE="/tmp/memory_stress.tmp"
LOG="/var/log/stress_test.log"

CPU_WORKERS=2        # jumlah core yang ditekan
MEM_MB=3000          # RAM stress (MB)
DOWNLOAD_RATE=10M    # network limit rate
INTERVAL=10          # detik per cycle

echo "==== Stress Test Started ====" | tee -a $LOG

while true; do
    echo "[$(date)] START" | tee -a $LOG

    # =========================
    # CPU STRESS
    # =========================
    echo "[$(date)] CPU stress" | tee -a $LOG
    for i in $(seq 1 $CPU_WORKERS); do
        timeout 8s sha256sum /dev/zero >/dev/null &
    done

    # =========================
    # MEMORY STRESS
    # =========================
    echo "[$(date)] Memory stress (${MEM_MB}MB)" | tee -a $LOG
    dd if=/dev/zero of=$MEMFILE bs=1M count=$MEM_MB status=none &
    sleep 5
    rm -f $MEMFILE

    # =========================
    # NETWORK STRESS
    # =========================
    echo "[$(date)] Network stress" | tee -a $LOG
    rm -f $FILE
    wget -O $FILE "$URL" --limit-rate=$DOWNLOAD_RATE --timeout=10 --tries=1

    sleep $INTERVAL
    echo "[$(date)] END" | tee -a $LOG
done
