#!/bin/bash

# Nama file
INSTALL_URL="https://raw.githubusercontent.com/rainprem/RainPrem"
INSTALL_SCRIPT="install"
SHC_BINARY="/usr/local/bin/shc"

# Cek root user
if [[ $EUID -ne 0 ]]; then
  echo "Script ini harus dijalankan sebagai root!"
  exit 1
fi

# Update dan install dependensi
echo "Memperbarui paket dan menginstal dependensi..."
apt update && apt install -y wget build-essential gcc

# Periksa apakah shc sudah terinstal
if [[ ! -f "$SHC_BINARY" ]]; then
  echo "shc tidak ditemukan. Mengunduh dan menginstalnya..."
  wget https://github.com/neurobin/shc/archive/refs/heads/master.zip -O shc.zip
  unzip shc.zip && cd shc-master
  make && make install
  cd ..
  rm -rf shc.zip shc-master
  echo "shc berhasil diinstal!"
else
  echo "shc sudah tersedia."
fi

# Unduh dan jalankan script instalasi
echo "Mengunduh script instalasi dari GitHub..."
wget -O "$INSTALL_SCRIPT" "$INSTALL_URL"

if [[ -f "$INSTALL_SCRIPT" ]]; then
  chmod +x "$INSTALL_SCRIPT"
  echo "Menjalankan script instalasi..."
  ./install
  rm -f "$INSTALL_SCRIPT"
else
  echo "Gagal mengunduh script instalasi. Periksa URL atau koneksi Anda."
  exit 1
fi

echo "Proses instalasi selesai!"
