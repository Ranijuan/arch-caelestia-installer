#!/bin/bash

################################################################################
# Arch + Caelestia ISO Builder v2.0
# Crea una ISO booteable con instalación automática
# Uso: sudo ./build-iso.sh
################################################################################

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuración
ISO_NAME="arch-caelestia-auto"
ISO_VERSION="2.0"
WORK_DIR="/tmp/archiso-work"
OUT_DIR="$(pwd)/out"
CONFIG_DIR="$(pwd)/config"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Arch + Caelestia ISO Builder v${ISO_VERSION}                       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"

# Verificar si se ejecuta como root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}✗ Este script DEBE ejecutarse con sudo${NC}"
  exit 1
fi

# Verificar requisitos
echo -e "\n${YELLOW}→ Verificando requisitos...${NC}"

MISSING_DEPS=()
for cmd in mksquashfs mkisofs; do
  if ! command -v $cmd &> /dev/null; then
    MISSING_DEPS+=("$cmd")
  fi
done

if [ ${#MISSING_DEPS[@]} -gt 0 ]; then
  echo -e "${RED}✗ Faltan dependencias: ${MISSING_DEPS[@]}${NC}"
  echo -e "${YELLOW}→ Instálalo con:${NC}"
  echo "  sudo pacman -S libisoburn squashfs-tools xorriso"
  exit 1
fi

# Crear directorios
echo -e "\n${YELLOW}→ Preparando directorios...${NC}"
mkdir -p "$WORK_DIR"
mkdir -p "$OUT_DIR"
rm -rf "$WORK_DIR"/*

# Copiar configuración base de Arch
echo -e "\n${YELLOW}→ Copiando base de Arch...${NC}"
if [ ! -d "/usr/share/archiso/configs/releng" ]; then
  echo -e "${RED}✗ archiso no instalado${NC}"
  echo -e "${YELLOW}→ Instálalo con: sudo pacman -S archiso${NC}"
  exit 1
fi

cp -r /usr/share/archiso/configs/releng "$WORK_DIR/archiso"
cd "$WORK_DIR/archiso"

# Copiar configuración personalizada
echo -e "\n${YELLOW}→ Inyectando configuración Caelestia...${NC}"
if [ -d "$CONFIG_DIR/airootfs" ]; then
  cp -r "$CONFIG_DIR/airootfs"/* airootfs/
fi

# Copiar scripts de instalación
echo -e "\n${YELLOW}→ Agregando script de instalación automática...${NC}"
mkdir -p airootfs/opt
cp "$CONFIG_DIR/opt/caelestia-install.sh" airootfs/opt/ || {
  echo -e "${RED}✗ No se encontró caelestia-install.sh${NC}"
  exit 1
}
chmod +x airootfs/opt/caelestia-install.sh

# Agregar servicio systemd
mkdir -p airootfs/etc/systemd/system
cat > airootfs/etc/systemd/system/caelestia-install.service << 'EOF'
[Unit]
Description=Arch + Caelestia Automatic Installation
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=/opt/caelestia-install.sh
RemainAfterExit=yes
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

ln -sf /etc/systemd/system/caelestia-install.service \
  airootfs/etc/systemd/system/multi-user.target.wants/caelestia-install.service

# Modificar perfil por defecto para auto-login
echo -e "\n${YELLOW}→ Configurando auto-login...${NC}"
mkdir -p airootfs/etc/getty@.service.d
cat > airootfs/etc/getty@.service.d/override.conf << 'EOF'
[Service]
Type=idle
ExecStart=
ExecStart=-/sbin/agetty --autologin root --noclear %I $TERM
EOF

# Compilar ISO
echo -e "\n${YELLOW}→ Compilando ISO (esto puede tardar 10-30 minutos)...${NC}"
sudo ./mkarchiso -v -o "$OUT_DIR" .

# Generar checksums
echo -e "\n${YELLOW}→ Generando checksums...${NC}"
cd "$OUT_DIR"
sha256sum *.iso > CHECKSUMS_SHA256

# Información final
ISO_FILE=$(ls -la *.iso 2>/dev/null | awk '{print $NF}' | head -1)
ISO_SIZE=$(ls -lh "$ISO_FILE" 2>/dev/null | awk '{print $5}')

echo -e "\n${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║          ✅ ISO COMPILADA EXITOSAMENTE ✅                  ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}✓ Archivo:${NC}    $ISO_FILE"
echo -e "${GREEN}✓ Tamaño:${NC}     $ISO_SIZE"
echo -e "${GREEN}✓ Ubicación:${NC}  $OUT_DIR"
echo -e "${GREEN}✓ Versión:${NC}    $ISO_VERSION"
echo ""
echo -e "${YELLOW}Próximos pasos:${NC}"
echo -e "  1. Grabar ISO en USB: ${BLUE}sudo dd if=$OUT_DIR/$ISO_FILE of=/dev/sdX bs=4M${NC}"
echo -e "  2. Reemplazar sdX con tu dispositivo (ej: sdb, sdc)"
echo -e "  3. Arrancar desde USB"
echo -e "  4. Instalación completamente automática"
echo ""
echo -e "${YELLOW}Verificar integridad:${NC}"
echo -e "  ${BLUE}sha256sum -c CHECKSUMS_SHA256${NC}"
echo ""
