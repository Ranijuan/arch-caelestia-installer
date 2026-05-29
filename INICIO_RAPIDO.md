# 🎯 INICIO RÁPIDO - Arch + Caelestia Installer v3.0

## ⚡ 2 Pasos para Comenzar

### Paso 1: Permisos
```bash
chmod +x arch-caelestia
chmod +x scripts/*.sh
```

### Paso 2: Ejecutar
```bash
./arch-caelestia
```

**¡Eso es todo! La instalación comienza directamente.**

---

## 📦 Lo que Tienes

| Archivo | Función |
|---------|---------|
| **arch-caelestia** | Ejecutable maestro único |
| instalador_arch.sh | Instalador CLI (usado por arch-caelestia) |
| scripts/ | Scripts auxiliares (build-iso.sh, install-auto.sh) |
| docs/ | Documentación (README, LEEME, ISO_AUTOMATICA) |

---

## 🚀 Método de Instalación

### Principal: Instalación Directa
```bash
./arch-caelestia
```
- Inicia instalación automáticamente
- Paso a paso interactivo en terminal
- Requiere estar presente durante la instalación
- Duración: 30-45 minutos

### Alternativa: Compilar ISO
```bash
./arch-caelestia --iso
```
- Compila ISO booteable automática
- Mete en USB y arranca - TODO automático
- Duración: 10 min compilación + 20 min instalación

---

## 🎮 Usos Disponibles

```bash
./arch-caelestia              # INSTALACION DIRECTA (por defecto)
./arch-caelestia --iso        # Compilar ISO automática
./arch-caelestia --help       # Ver ayuda
./arch-caelestia --version    # Ver versión
```

---

## 📚 Documentación

- **README.md** - Descripción completa
- **LEEME.md** - Versión en español
- **ISO_AUTOMATICA.md** - Guía de compilación ISO

---

## 🎯 COMO COMENZAR:

```bash
1. chmod +x arch-caelestia scripts/*.sh
2. ./arch-caelestia
   ¡La instalación comienza inmediatamente!
```

---

**Versión:** 3.0  
**Estado:** ✅ Un único ejecutable  
**Métodos:** 2 (CLI interactivo + ISO automática)
