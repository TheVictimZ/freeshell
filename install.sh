#!/bin/bash

# URL file base64 yang mengandung script install2.sh
FILE_URL="https://raw.githubusercontent.com/rainprem/freeshell/main/install2.sh.base64"

# Nama file sementara untuk menyimpan file base64
BASE64_FILE="/tmp/install2.sh.base64"

# Fungsi untuk mencatat log
log_message() {
  echo "$(date): $1" | tee -a /var/log/install2_install.log
}

# Cek root user
if [[ $EUID -ne 0 ]]; then
  log_message "Script ini harus dijalankan sebagai root!"
  exit 1
fi

# Unduh file base64 dari GitHub
log_message "Mengunduh file base64 dari $FILE_URL..."
wget -q "$FILE_URL" -O "$BASE64_FILE"

# Cek apakah file berhasil diunduh
if [[ ! -f "$BASE64_FILE" ]]; then
  log_message "Gagal mengunduh file base64!"
  exit 1
fi
log_message "File base64 berhasil diunduh."

# Mendekode base64 dan menjalankan script dengan bash
log_message "Mendekode file base64 dan menjalankannya..."
cat "$BASE64_FILE" | base64 -d | bash

log_message "Instalasi selesai!"
