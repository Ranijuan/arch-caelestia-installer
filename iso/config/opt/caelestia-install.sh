#!/bin/bash

################################################################################
# Instalación Automática Arch + Caelestia
# Script ejecutado automáticamente desde la ISO
# Este script NO requiere intervención del usuario
################################################################################

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Archivo de log
LOG_FILE="/var/log/caelestia-install.log"
mkdir -p /var/log

log_message() {
  echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $1" | tee -a "$LOG_FILE"
}

log_success() {
  echo -e "${GREEN}✓${NC} $1" | tee -a "$LOG_FILE"
}

log_error() {
  echo -e "${RED}✗${NC} $1" | tee -a "$LOG_FILE"
}

log_step() {
  echo -e "\n${MAGENTA}╔════════════════════════════════════════════════════════════╗${NC}" | tee -a "$LOG_FILE"
  echo -e "${MAGENTA}║  $1${NC}" | tee -a "$LOG_FILE"
  echo -e "${MAGENTA}╚════════════════════════════════════════════════════════════╝${NC}" | tee -a "$LOG_FILE"
}

################################################################################
# PASO 1: Detectar hardware y particiones
################################################################################
log_step "PASO 1/8: Detectando hardware"

DISK=$(lsblk -nd -o NAME,TYPE | grep disk | head -n 1 | awk '{print "/dev/"$1}')
if [ -z "$DISK" ]; then
  log_error "No se detectó disco duro"
  exit 1
fi
log_success "Disco detectado: $DISK"

# Detectar modo UEFI o BIOS
if [ -d /sys/firmware/efi ]; then
  BOOT_MODE="uefi"
  BOOT_SIZE=512
  log_success "Modo UEFI detectado"
else
  BOOT_MODE="bios"
  BOOT_SIZE=2
  log_success "Modo BIOS detectado"
fi

################################################################################
# PASO 2: Limpiar y particionar disco
################################################################################
log_step "PASO 2/8: Particionando disco (${DISK})"

# Limpiar tabla de particiones anterior
log_message "Limpiando particiones anteriores..."
sgdisk --zap-all "$DISK" > /dev/null 2>&1 || true
dd if=/dev/zero of="$DISK" bs=1M count=10 > /dev/null 2>&1 || true

# Crear tabla de particiones GPT
log_message "Creando tabla de particiones GPT..."
sgdisk --clear "$DISK" > /dev/null 2>&1

if [ "$BOOT_MODE" = "uefi" ]; then
  # Partición EFI
  log_message "Creando partición EFI (512MB)..."
  sgdisk -n 1:0:+512M -t 1:ef00 "$DISK" > /dev/null 2>&1
  
  # Partición raíz
  log_message "Creando partición raíz (resto del disco)..."
  sgdisk -n 2:0:0 -t 2:8300 "$DISK" > /dev/null 2>&1
  
  EFI_PART="${DISK}1"
  ROOT_PART="${DISK}2"
else
  # Partición boot BIOS
  log_message "Creando partición boot (2MB)..."
  sgdisk -n 1:0:+2M -t 1:ef02 "$DISK" > /dev/null 2>&1
  
  # Partición raíz
  log_message "Creando partición raíz (resto del disco)..."
  sgdisk -n 2:0:0 -t 2:8300 "$DISK" > /dev/null 2>&1
  
  BOOT_PART="${DISK}1"
  ROOT_PART="${DISK}2"
fi

log_success "Particiones creadas exitosamente"

################################################################################
# PASO 3: Formatear particiones
################################################################################
log_step "PASO 3/8: Formateando particiones"

log_message "Esperando que kernel registre particiones..."
sleep 2

if [ "$BOOT_MODE" = "uefi" ]; then
  log_message "Formateando partición EFI como FAT32..."
  mkfs.fat -F 32 "$EFI_PART" > /dev/null 2>&1
  log_success "Partición EFI formateada"
else
  log_message "Formateando partición boot como ext4..."
  mkfs.ext4 -F "$BOOT_PART" > /dev/null 2>&1
  log_success "Partición boot formateada"
fi

log_message "Formateando partición raíz como ext4..."
mkfs.ext4 -F "$ROOT_PART" > /dev/null 2>&1
log_success "Partición raíz formateada"

################################################################################
# PASO 4: Montar particiones
################################################################################
log_step "PASO 4/8: Montando particiones"

mkdir -p /mnt/root
mount "$ROOT_PART" /mnt/root
log_success "Partición raíz montada en /mnt/root"

if [ "$BOOT_MODE" = "uefi" ]; then
  mkdir -p /mnt/root/efi
  mount "$EFI_PART" /mnt/root/efi
  log_success "Partición EFI montada en /mnt/root/efi"
else
  mkdir -p /mnt/root/boot
  mount "$BOOT_PART" /mnt/root/boot
  log_success "Partición boot montada en /mnt/root/boot"
fi

################################################################################
# PASO 5: Instalar Arch Linux
################################################################################
log_step "PASO 5/8: Instalando Arch Linux base"

log_message "Sincronizando repositorios..."
pacman -Sy > /dev/null 2>&1

PACKAGES="base linux linux-firmware networkmanager grub efibootmgr vim nano curl wget git base-devel"

log_message "Instalando paquetes base: $PACKAGES"
pacstrap /mnt/root $PACKAGES > /dev/null 2>&1
log_success "Sistema base instalado"

################################################################################
# PASO 6: Configurar sistema base
################################################################################
log_step "PASO 6/8: Configurando sistema"

log_message "Generando fstab..."
genfstab -U /mnt/root >> /mnt/root/etc/fstab
log_success "fstab generado"

log_message "Configurando zona horaria..."
arch-chroot /mnt/root ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime > /dev/null 2>&1
arch-chroot /mnt/root hwclock --systohc > /dev/null 2>&1
log_success "Zona horaria configurada"

log_message "Configurando idioma..."
sed -i 's/#es_CO.UTF-8/es_CO.UTF-8/' /mnt/root/etc/locale.gen
sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /mnt/root/etc/locale.gen
arch-chroot /mnt/root locale-gen > /dev/null 2>&1
echo "LANG=es_CO.UTF-8" > /mnt/root/etc/locale.conf
log_success "Idioma configurado"

log_message "Configurando hostname..."
echo "arch-caelestia" > /mnt/root/etc/hostname
log_success "Hostname configurado"

log_message "Configurando red..."
arch-chroot /mnt/root systemctl enable NetworkManager > /dev/null 2>&1
log_success "NetworkManager habilitado"

################################################################################
# PASO 7: Instalar y configurar bootloader
################################################################################
log_step "PASO 7/8: Instalando bootloader"

if [ "$BOOT_MODE" = "uefi" ]; then
  log_message "Instalando GRUB para UEFI..."
  arch-chroot /mnt/root grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB > /dev/null 2>&1
  log_success "GRUB instalado para UEFI"
else
  log_message "Instalando GRUB para BIOS..."
  arch-chroot /mnt/root grub-install --target=i386-pc "$DISK" > /dev/null 2>&1
  log_success "GRUB instalado para BIOS"
fi

log_message "Generando configuración GRUB..."
arch-chroot /mnt/root grub-mkconfig -o /boot/grub/grub.cfg > /dev/null 2>&1
log_success "GRUB configurado"

################################################################################
# PASO 8: Instalar Caelestia
################################################################################
log_step "PASO 8/8: Instalando Caelestia"

log_message "Agregando repositorio Caelestia..."
echo "" >> /mnt/root/etc/pacman.conf
echo "[caelestia]" >> /mnt/root/etc/pacman.conf
echo "Server = https://aur.archlinux.org/" >> /mnt/root/etc/pacman.conf

log_message "Instalando Caelestia y dependencias..."
arch-chroot /mnt/root pacman -Sy > /dev/null 2>&1
arch-chroot /mnt/root pacman -S --noconfirm caelestia > /dev/null 2>&1 || {
  log_error "No se pudo instalar Caelestia desde pacman, intentando compilar..."
  arch-chroot /mnt/root bash -c "
    cd /tmp
    git clone https://aur.archlinux.org/caelestia.git
    cd caelestia
    makepkg -si --noconfirm > /dev/null 2>&1
  " || log_error "Fallo la instalación de Caelestia"
}

log_success "Caelestia instalado"

################################################################################
# FINALIZACIÓN
################################################################################
log_step "✅ INSTALACIÓN COMPLETADA"

log_message "Creando usuario automático..."
arch-chroot /mnt/root useradd -m -G wheel,users -s /bin/bash arch > /dev/null 2>&1 || true
echo -e "arch\narch" | arch-chroot /mnt/root passwd arch > /dev/null 2>&1 || true
log_success "Usuario 'arch' creado (contraseña: arch)"

log_message "Desmontando particiones..."
umount -R /mnt/root > /dev/null 2>&1
log_success "Sistema desmontado"

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ✅ INSTALACIÓN COMPLETADA EXITOSAMENTE ✅              ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}El sistema se reiniciará en 10 segundos...${NC}"
echo ""
echo -e "${CYAN}Log de instalación guardado en: $LOG_FILE${NC}"
echo ""

sleep 10
reboot
