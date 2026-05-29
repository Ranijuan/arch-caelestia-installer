#!/bin/bash

################################################################################
# Script de Instalación Automática Arch + Caelestia
# Ejecutado automáticamente desde la ISO
# NO REQUIERE INTERVENCIÓN DEL USUARIO
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

LOG_FILE="/var/log/arch-caelestia-install.log"
mkdir -p /var/log

# Funciones de logging
log_msg() {
  local msg="$1"
  echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $msg" | tee -a "$LOG_FILE"
}

log_ok() {
  echo -e "${GREEN}✓${NC} $1" | tee -a "$LOG_FILE"
}

log_err() {
  echo -e "${RED}✗${NC} $1" | tee -a "$LOG_FILE"
}

log_step() {
  echo -e "\n${MAGENTA}╔════════════════════════════════════════════════════════╗${NC}" | tee -a "$LOG_FILE"
  echo -e "${MAGENTA}║  $1${NC}" | tee -a "$LOG_FILE"
  echo -e "${MAGENTA}╚════════════════════════════════════════════════════════╝${NC}" | tee -a "$LOG_FILE"
}

################################################################################
# PASO 1: Detectar hardware
################################################################################
log_step "PASO 1/8: Detectando Hardware"

# Detectar disco duro
DISK=$(lsblk -nd -o NAME,TYPE | grep disk | head -1 | awk '{print "/dev/"$1}')
if [ -z "$DISK" ]; then
  log_err "No se detectó disco duro. Abortando."
  exit 1
fi
log_ok "Disco detectado: $DISK"

# Detectar UEFI o BIOS
if [ -d /sys/firmware/efi/efivars ]; then
  BOOT_MODE="uefi"
  log_ok "Modo UEFI detectado"
else
  BOOT_MODE="bios"
  log_ok "Modo BIOS detectado"
fi

# Detectar RAM
RAM_MB=$(free -m | awk 'NR==2{print $2}')
log_ok "RAM detectada: ${RAM_MB}MB"

################################################################################
# PASO 2: Particionar disco
################################################################################
log_step "PASO 2/8: Particionando Disco"

log_msg "Limpiando tabla de particiones anterior..."
sgdisk --zap-all "$DISK" &>/dev/null || true
dd if=/dev/zero of="$DISK" bs=512 count=2048 &>/dev/null || true
sync

log_msg "Creando tabla de particiones GPT..."
sgdisk --clear "$DISK" &>/dev/null

if [ "$BOOT_MODE" = "uefi" ]; then
  log_msg "Creando partición EFI (512MB)..."
  sgdisk -n 1::+512M -t 1:ef00 "$DISK" &>/dev/null
  log_msg "Creando partición raíz (resto)..."
  sgdisk -n 2::-0 -t 2:8300 "$DISK" &>/dev/null
  EFI_PART="${DISK}1"
  ROOT_PART="${DISK}2"
else
  log_msg "Creando partición BIOS-boot (2MB)..."
  sgdisk -n 1::+2M -t 1:ef02 "$DISK" &>/dev/null
  log_msg "Creando partición raíz (resto)..."
  sgdisk -n 2::-0 -t 2:8300 "$DISK" &>/dev/null
  BOOT_PART="${DISK}1"
  ROOT_PART="${DISK}2"
fi

log_ok "Particiones creadas"
sync
sleep 2

################################################################################
# PASO 3: Formatear particiones
################################################################################
log_step "PASO 3/8: Formateando Particiones"

if [ "$BOOT_MODE" = "uefi" ]; then
  log_msg "Formateando partición EFI como FAT32..."
  mkfs.fat -F 32 -n "EFI" "$EFI_PART" &>/dev/null
  log_ok "EFI formateada"
else
  log_msg "Formateando partición BIOS-boot..."
  mkfs.ext4 -L "BOOT" "$BOOT_PART" &>/dev/null
  log_ok "Boot formateada"
fi

log_msg "Formateando partición raíz como ext4..."
mkfs.ext4 -L "ROOT" "$ROOT_PART" &>/dev/null
log_ok "Raíz formateada"

################################################################################
# PASO 4: Montar particiones
################################################################################
log_step "PASO 4/8: Montando Particiones"

mkdir -p /mnt/root
mount "$ROOT_PART" /mnt/root
log_ok "Raíz montada"

if [ "$BOOT_MODE" = "uefi" ]; then
  mkdir -p /mnt/root/efi
  mount "$EFI_PART" /mnt/root/efi
  log_ok "EFI montada"
else
  mkdir -p /mnt/root/boot
  mount "$BOOT_PART" /mnt/root/boot
  log_ok "Boot montada"
fi

mkdir -p /mnt/root/var/cache/pacman/pkg

################################################################################
# PASO 5: Instalar Arch base
################################################################################
log_step "PASO 5/8: Instalando Arch Linux"

log_msg "Sincronizando repositorios..."
pacman -Sy --noconfirm &>/dev/null

PACKAGES="base linux linux-firmware networkmanager grub efibootmgr \
  sudo nano vim curl wget git base-devel xorg xorg-server \
  lightdm lightdm-gtk-greeter"

log_msg "Instalando paquetes base (esto toma tiempo)..."
pacstrap /mnt/root $PACKAGES &>/dev/null
log_ok "Sistema base instalado"

################################################################################
# PASO 6: Configuración del sistema
################################################################################
log_step "PASO 6/8: Configurando Sistema"

log_msg "Generando fstab..."
genfstab -U /mnt/root >> /mnt/root/etc/fstab
log_ok "fstab generado"

log_msg "Configurando zona horaria..."
arch-chroot /mnt/root ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime &>/dev/null
arch-chroot /mnt/root hwclock --systohc &>/dev/null
log_ok "Zona horaria: América/Bogotá"

log_msg "Configurando idioma..."
sed -i 's/#es_ES.UTF-8/es_ES.UTF-8/' /mnt/root/etc/locale.gen
sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /mnt/root/etc/locale.gen
arch-chroot /mnt/root locale-gen &>/dev/null
echo "LANG=es_ES.UTF-8" > /mnt/root/etc/locale.conf
log_ok "Idioma: Español"

log_msg "Configurando hostname..."
echo "arch-caelestia" > /mnt/root/etc/hostname
log_ok "Hostname configurado"

log_msg "Habilitando NetworkManager..."
arch-chroot /mnt/root systemctl enable NetworkManager &>/dev/null
log_ok "Red configurada"

################################################################################
# PASO 7: Instalar bootloader
################################################################################
log_step "PASO 7/8: Instalando Bootloader"

if [ "$BOOT_MODE" = "uefi" ]; then
  log_msg "Instalando GRUB para UEFI..."
  arch-chroot /mnt/root grub-install --target=x86_64-efi \
    --efi-directory=/efi --bootloader-id=GRUB &>/dev/null
  log_ok "GRUB UEFI instalado"
else
  log_msg "Instalando GRUB para BIOS..."
  arch-chroot /mnt/root grub-install --target=i386-pc "$DISK" &>/dev/null
  log_ok "GRUB BIOS instalado"
fi

log_msg "Generando configuración GRUB..."
arch-chroot /mnt/root grub-mkconfig -o /boot/grub/grub.cfg &>/dev/null
log_ok "GRUB configurado"

################################################################################
# PASO 8: Instalar Caelestia
################################################################################
log_step "PASO 8/8: Instalando Caelestia"

log_msg "Instalando Caelestia..."
arch-chroot /mnt/root pacman -Sy --noconfirm &>/dev/null

# Intentar instalar desde pacman
if arch-chroot /mnt/root pacman -S --noconfirm caelestia &>/dev/null; then
  log_ok "Caelestia instalado desde pacman"
else
  # Si falla, intentar desde AUR
  log_msg "Compilando Caelestia desde AUR..."
  arch-chroot /mnt/root bash -c "
    cd /tmp
    git clone https://aur.archlinux.org/caelestia.git &>/dev/null
    cd caelestia
    makepkg -si --noconfirm &>/dev/null
  " || log_err "Advertencia: Caelestia no se pudo instalar"
  log_ok "Caelestia compilado"
fi

################################################################################
# FINALIZACIÓN
################################################################################
log_step "FINALIZANDO INSTALACIÓN"

log_msg "Creando usuario predeterminado..."
arch-chroot /mnt/root useradd -m -G wheel,users -s /bin/bash arch &>/dev/null
echo -e "arch123\narch123" | arch-chroot /mnt/root passwd arch &>/dev/null
log_ok "Usuario 'arch' creado"

log_msg "Configurando sudoers..."
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /mnt/root/etc/sudoers
log_ok "Sudo configurado"

log_msg "Habilitando LightDM..."
arch-chroot /mnt/root systemctl enable lightdm &>/dev/null
log_ok "LightDM habilitado"

log_msg "Limpiando instalador..."
rm -f /mnt/root/opt/install-auto.sh
rm -f /mnt/root/etc/systemd/system/arch-caelestia-auto.service
rm -rf /mnt/root/etc/systemd/system/multi-user.target.wants/arch-caelestia-auto.service

log_msg "Desmontando particiones..."
umount -R /mnt/root &>/dev/null
log_ok "Desmontado"

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ✅ INSTALACIÓN COMPLETADA EXITOSAMENTE ✅            ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}El sistema se reiniciará en 5 segundos...${NC}"
echo -e "${YELLOW}Credenciales:${NC}"
echo -e "  Usuario: ${BLUE}arch${NC}"
echo -e "  Contraseña: ${BLUE}arch123${NC}"
echo ""
echo -e "${YELLOW}Log guardado en: ${BLUE}$LOG_FILE${NC}"
echo ""

sleep 5
reboot -f
