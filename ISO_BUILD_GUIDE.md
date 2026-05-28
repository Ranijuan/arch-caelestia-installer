# 🎯 Guía de Instalación Automática con ISO

## ✨ ¿Qué es esto?

**Arch Caelestia Installer v2.0** es una **ISO booteable** que instala Arch Linux + Caelestia **100% automáticamente** sin intervención del usuario.

Es similar a:
- **OMarchy** - Instalador automático de Arch
- **EndeavourOS** - ISO con instalación personalizada
- **Manjaro** - ISO con interfaz de instalación

## 🚀 Flujo de instalación

```
1. Arrancas desde ISO
   ↓
2. Sistema detecta hardware automáticamente
   ↓
3. Particiona el disco sin preguntar
   ↓
4. Instala Arch Linux base
   ↓
5. Configura zona horaria, idioma, red
   ↓
6. Instala GRUB (bootloader)
   ↓
7. Instala Caelestia
   ↓
8. Crea usuario automático
   ↓
9. Reinicia → Sistema listo para usar ✅
```

## 📦 Requisitos

- Memoria USB: **8 GB mínimo** (se recomiendan 16 GB)
- RAM: **2 GB mínimo** (se recomiendan 4 GB+)
- Disco: **20 GB mínimo** (se recomiendan 50 GB+)
- Conexión a internet: **Sí, durante la instalación**
- Conocimiento técnico: **0%** (totalmente automático)

## 🔧 Compilar la ISO localmente

### Requisitos previos (en Arch Linux)

```bash
sudo pacman -S archiso git squashfs-tools xorriso libisoburn
```

### Pasos para compilar

```bash
# 1. Clonar el repositorio
git clone https://github.com/Ranijuan/arch-caelestia-installer.git
cd arch-caelestia-installer

# 2. Compilar ISO
sudo chmod +x iso/build-iso.sh
sudo ./iso/build-iso.sh

# 3. Esperar... (10-30 minutos)

# 4. La ISO estará en: ./iso/out/arch-caelestia-auto-*.iso
```

⏱️ **Tiempo estimado:** 10-30 minutos según hardware

## 💾 Grabar ISO en USB

### En Linux/Mac

```bash
# Identificar el USB
lsblk

# Grabar (reemplaza sdX con tu USB, ej: sdb)
sudo dd if=arch-caelestia-auto-2.0.iso of=/dev/sdX bs=4M status=progress
sync
```

### En Windows

Usa herramientas como:
- **Rufus** (https://rufus.ie/)
- **Etcher** (https://www.balena.io/etcher/)
- **Win32 Disk Imager**

## 🎮 Usar la ISO

### Paso a paso

1. **Inserta USB** y reinicia la computadora
2. **Presiona F2, F12 o Delete** (según tu BIOS) para acceder el boot menu
3. **Selecciona la USB** como dispositivo de arranque
4. **Presiona Enter** y deja que la ISO bootee
5. **Mira la barra de progreso** - Se instalará automáticamente
6. El sistema **se reiniciará automáticamente** cuando termine
7. Al reiniciar, **verás el login** con usuario y contraseña listos

### Credenciales por defecto

```
Usuario:    arch
Contraseña: arch
```

> ⚠️ Cámbialas después del primer login por seguridad

## 📊 ¿Qué hace exactamente?

La ISO automáticamente:

### 🔍 Detección
- ✅ Detecta UEFI o BIOS
- ✅ Detecta disco duro automáticamente
- ✅ Detecta cantidad de RAM

### 💾 Particionamiento
- ✅ Crea tabla de particiones GPT
- ✅ Crea partición EFI (UEFI) o Boot (BIOS)
- ✅ Crea partición raíz con resto del espacio

### 📝 Instalación
- ✅ Formatea en ext4 (raíz) y FAT32/ext4 (boot)
- ✅ Instala Arch Linux base
- ✅ Instala kernel Linux y firmware
- ✅ Configura zona horaria (América/Bogotá)
- ✅ Configura idioma (Español/Inglés)
- ✅ Configura hostname: `arch-caelestia`
- ✅ Habilita NetworkManager

### 🅰️ Bootloader
- ✅ Instala GRUB para UEFI o BIOS
- ✅ Configura automáticamente

### 🎨 Caelestia
- ✅ Instala Caelestia (gestor de ventanas/DE)
- ✅ Configura automaticamente

### 👤 Usuario
- ✅ Crea usuario: `arch`
- ✅ Usuario en grupo `wheel` (sudo access)
- ✅ Contraseña: `arch`

## 📋 Línea de tiempo de instalación

```
Tiempo total: 15-45 minutos (según hardware y conexión internet)

Detección hardware:        1-2 minutos
Particionamiento:         1-2 minutos
Formateo:                1-2 minutos
Instalación Arch base:    5-15 minutos
Configuración sistema:     2-3 minutos
Instalación bootloader:    1-2 minutos
Instalación Caelestia:    3-10 minutos
Limpieza y reinicio:      1-2 minutos
                         ─────────────
                    Total: 15-45 minutos
```

## 🆘 Troubleshooting

### La ISO no bootea

**Solución:**
- Verifica que el USB esté correctamente grabado
- Intenta con Rufus o Etcher
- Comprueba el checksum de la ISO
- Prueba en otra computadora

### Se queda en instalación

**Solución:**
- Asegúrate de tener **conexión internet estable**
- Verifica que la ISO no esté corrupta
- Intenta nuevamente

### Después de reiniciar, no aparece pantalla

**Solución:**
- Espera 30-60 segundos (puede estar configurando)
- Presiona Enter para ver el login
- Si sigue sin aparecer, reinicia e intenta de nuevo

### El usuario no se creó

**Solución:**
- Inicia sesión como `root`
- Crea usuario manual:
  ```bash
  useradd -m -G wheel -s /bin/bash tu_usuario
  passwd tu_usuario
  ```

## 🔐 Seguridad

- ✅ ISO sin contraseñas almacenadas
- ✅ Usuario por defecto debe cambiar contraseña
- ✅ Firewall puede habilitarse post-instalación
- ✅ Se recomienda SSH key en lugar de contraseña

## 📦 Comparar métodos

| Característica | ISO Automática | Script CLI | Manual |
|---|---|---|---|
| **Intervención del usuario** | 0% | 30-50% | 100% |
| **Conocimiento técnico requerido** | Ninguno | Mínimo | Avanzado |
| **Tiempo de instalación** | 15-45 min | 30-60 min | 60-180 min |
| **Riesgo de errores** | Mínimo | Bajo | Alto |
| **Ideal para principiantes** | ✅ | ⚠️ | ❌ |
| **Ideal para personalización** | ❌ | ⚠️ | ✅ |

## 🎓 Aprender más

Después de instalar, puedes:

- Instalar escritorio gráfico adicional
- Agregar programas con `pacman -S`
- Usar AUR para más paquetes
- Personalizar configuración de Caelestia
- Ver logs en: `/var/log/caelestia-install.log`

## 🐛 Reportar problemas

Si encuentras un bug:

1. Documenta el problema exacto
2. Toma una foto o screenshot
3. Incluye info del hardware
4. Abre un issue en GitHub: https://github.com/Ranijuan/arch-caelestia-installer/issues

## 📞 Soporte

- **GitHub Issues**: https://github.com/Ranijuan/arch-caelestia-installer/issues
- **Documentación**: Ver README.md y LEEME.md
- **Troubleshooting**: Ver TROUBLESHOOTING.md

## 📝 Versión

- **ISO Version:** 2.0
- **Arch Linux:** Latest
- **Caelestia:** Latest
- **GRUB:** Latest
- **Última actualización:** 2026-05-28

---

**¡Disfrutar de Arch Linux + Caelestia! 🎉**
