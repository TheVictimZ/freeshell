#!/bin/bash

# URL file binary install3
FILE_URL="https://raw.githubusercontent.com/rainmc0123/RainFree/main/install3"

# Nama file yang disimpan setelah diunduh
DECODED_FILE="/tmp/install3"

# Fungsi untuk mencatat log
log_message() {
  echo "$(date): $1" | tee -a /var/log/install3_install.log
}

# Cek root user
if [[ $EUID -ne 0 ]]; then
  log_message "Script ini harus dijalankan sebagai root!"
  exit 1
fi

# Unduh file binary install3 dari GitHub
log_message "Mengunduh file binary install3 dari $FILE_URL..."
wget -q "$FILE_URL" -O "$DECODED_FILE"

# Cek apakah file berhasil diunduh
if [[ ! -f "$DECODED_FILE" ]]; then
  log_message "Gagal mengunduh file binary install3!"
  exit 1
fi
log_message "File binary install3 berhasil diunduh."

# Berikan izin eksekusi pada file binary
log_message "Memberikan izin eksekusi pada file binary install3..."
chmod +x "$DECODED_FILE"

# Menjalankan file binary install3
log_message "Menjalankan file binary install3..."
"$DECODED_FILE"

log_message "Instalasi selesai!"
