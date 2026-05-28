# 🚀 Instalador Arch Linux con Caelestia

[![GitHub Release](https://img.shields.io/badge/release-v2.0-blue)](https://github.com/Ranijuan/arch-caelestia-installer/releases)
[![ISO Support](https://img.shields.io/badge/ISO-Supported-success)](ISO_BUILD_GUIDE.md)
[![Python](https://img.shields.io/badge/Python_3-3776ab?logo=python&logoColor=fff)](.)
[![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnu-bash&logoColor=fff)](.)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

Una aplicación que proporciona **tres formas** de instalar Arch Linux + Caelestia:

### 🎯 3 Métodos

| 🔴 ISO Automática | 🟡 Script CLI | 🟢 Manual |
|---|---|---|
| **100% automático** | Interactivo | Control total |
| Arranca desde USB | Ejecutar script | Línea por línea |
| 0% intervención | 30-50% intervención | 100% intervención |
| 15-45 minutos | 30-60 minutos | 60-180 minutos |
| ⭐ **Recomendado** | Bueno | Avanzado |

---

## 🔴 ISO Automática v2.0 (NUEVO)

**Instala Arch + Caelestia 100% automático desde USB.**

Similar a: OMarchy, EndeavourOS, Manjaro

### 🚀 Quick Start
```bash
git clone https://github.com/Ranijuan/arch-caelestia-installer.git
cd arch-caelestia-installer

# Compilar ISO (en Arch Linux)
sudo chmod +x iso/build-iso.sh
sudo ./iso/build-iso.sh

# Grabar en USB
sudo dd if=iso/out/arch-caelestia-auto-*.iso of=/dev/sdX bs=4M status=progress

# Arrancar desde USB → Instalación automática ✅
```

👉 **[Guía completa de ISO →](ISO_BUILD_GUIDE.md)**

---

## 🟡 Script CLI v1.0

**Instalador interactivo paso a paso.**

### 🚀 Quick Start
```bash
git clone https://github.com/Ranijuan/arch-caelestia-installer.git
cd arch-caelestia-installer

# Python (recomendado)
python instalador_arch.py

# O Bash
chmod +x instalador_arch.sh
./instalador_arch.sh
```

### 8 Pasos incluidos
1. ✓ Verificación de conexión
2. ✓ Actualización del sistema
3. ✓ Instalación de dependencias
4. ✓ Descarga de Caelestia
5. ✓ Instalación de Caelestia
6. ✓ Configuración (elige DE + idioma)
7. ✓ Paquetes opcionales
8. ✓ Finalización

⏱️ **Tiempo:** 30-60 minutos

👉 **[Guía de uso →](LEEME.md)**

---

## 📋 Documentación

| Archivo | Descripción |
|---------|-------------|
| [README.md](README.md) | Este archivo |
| [ISO_BUILD_GUIDE.md](ISO_BUILD_GUIDE.md) | Cómo compilar y usar la ISO |
| [LEEME.md](LEEME.md) | Guía completa en español |
| [TROUBLESHOOTING.md](TROUBLESHOOTING.md) | Solución de 20+ problemas |
| [INDEX.md](INDEX.md) | Índice de documentación |

---

## ✅ Requisitos

### Para ISO
- USB 8+ GB
- RAM 2+ GB
- Disco 20+ GB
- Internet estable
- Cualquier S.O. (para grabar USB)

### Para Script
- Linux instalado
- Python 3.6+ O Bash 4.0+
- Acceso sudo
- Internet
- 20+ GB libres

---

## 🎯 ¿Cuál elegir?

### Usa **ISO** si:
- ✅ Quieres instalación 100% automática
- ✅ No tienes conocimiento técnico
- ✅ Necesitas instalar en múltiples PCs
- ✅ Quieres experiencia tipo OMarchy

### Usa **Script** si:
- ✅ Ya tienes Linux instalado
- ✅ Necesitas personalización
- ✅ No puedes usar USB
- ✅ Prefieres interfaz interactiva

### Usa **Manual** si:
- ✅ Necesitas control total
- ✅ Eres usuario avanzado
- ✅ Requieres configuración especial

---

## 📖 Empezar

**[→ Ver Guía Completa en INDEX.md](INDEX.md)**

---

## 🆘 Problemas

Consulta **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)** para 20+ soluciones comunes.

---

## 📞 Soporte

- 🐛 **Issues:** https://github.com/Ranijuan/arch-caelestia-installer/issues
- 📖 **Documentación:** [INDEX.md](INDEX.md)
- 💬 **Discussions:** GitHub Discussions

---

## 📝 Versión

- **Versión:** 2.0
- **ISO:** v2.0 (Nueva - Automática)
- **Scripts:** v1.0 (Vigente)
- **Actualización:** 2026-05-28

---

**Hecho con ❤️ para facilitar la instalación de Arch + Caelestia**

⭐ Si te fue útil, considera una estrella en GitHub
