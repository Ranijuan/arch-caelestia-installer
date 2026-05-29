# 🐧 Arch Linux + Caelestia Installer v3.0

Un instalador **100% automático** de Arch Linux con Caelestia en un único ejecutable.

## ⚡ Inicio Rápido (2 Pasos)

```bash
chmod +x arch-caelestia
./arch-caelestia
```

**¡La instalación comienza directamente!**

---

## 📦 Características

✓ **Instalación paso a paso** - Interfaz interactiva en terminal  
✓ **Detección automática** - Hardware y firmware detectados automáticamente  
✓ **Particionamiento inteligente** - Compatible con UEFI y BIOS  
✓ **Caelestia incluida** - Se instala automáticamente tras Arch  
✓ **Bootloader automático** - Configuración automática de GRUB  
✓ **Un único ejecutable** - `./arch-caelestia` hace todo  

---

## 🚀 Métodos de Instalación

### 1. Instalación Directa (Recomendado)
```bash
./arch-caelestia
```
- Instalación paso a paso en terminal
- Requiere estar presente (~30-45 min)
- Ideal para aprender el proceso

### 2. ISO Automática (Alternativa)
```bash
./arch-caelestia --iso
```
- Compila ISO booteable
- Arranca desde USB - 100% automático
- Ideal para instalaciones masivas

---

## 💻 Requisitos del Sistema

- **SO:** Linux (Arch/Debian/Ubuntu recomendado)
- **RAM:** 2GB mínimo (4GB recomendado para ISO)
- **Espacio:** 5GB libre mínimo
- **Internet:** Conexión requerida
- **Acceso:** Root o sudo

---

## 📖 Documentación Completa

- **INICIO_RAPIDO.md** - Comienza aquí
- **README.md** - Este archivo
- **LEEME.md** - Versión en español
- **ISO_AUTOMATICA.md** - Guía detallada de compilación ISO

---

## 🎮 Usos Disponibles

```bash
./arch-caelestia              # Instalación directa (por defecto)
./arch-caelestia --iso        # Compilar ISO
./arch-caelestia --help       # Ver ayuda
./arch-caelestia --version    # Ver versión
```

---

## 📁 Estructura del Proyecto

```
arch-caelestia-installer/
├── arch-caelestia            ← EJECUTABLE UNICO
├── instalador_arch.sh        (utilizado por arch-caelestia)
├── INICIO_RAPIDO.md
├── scripts/
│   ├── build-iso.sh          (compilador ISO)
│   └── install-auto.sh       (script para ISO)
├── docs/
│   ├── README.md
│   ├── LEEME.md
│   └── ISO_AUTOMATICA.md
└── archive/                  (archivos antiguos)
```

---

## 🔧 Instalación Paso a Paso

### Opción 1: Desde el Repositorio
```bash
git clone https://github.com/Ranijuan/arch-caelestia-installer.git
cd arch-caelestia-installer
chmod +x arch-caelestia
./arch-caelestia
```

### Opción 2: Descarga Directa
```bash
# Descargar ejecutable
curl -O https://raw.githubusercontent.com/Ranijuan/arch-caelestia-installer/main/arch-caelestia
chmod +x arch-caelestia
./arch-caelestia
```

---

## ✨ Beneficios de Esta Versión

| Característica | Beneficio |
|---|---|
| **Ejecutable único** | Un comando para todo |
| **Sin menús confusos** | Instalación directa |
| **Completamente automático** | ISO boot sin intervención |
| **Detección inteligente** | Adapta a tu hardware |
| **Caelestia incluida** | Todo-en-uno |
| **Documentación completa** | Guías en español e inglés |

---

## 🆘 Problemas?

### Permiso denegado
```bash
chmod +x arch-caelestia scripts/*.sh
```

### Requisitos no cumplidos
```bash
./arch-caelestia --help    # Ver requisitos
```

### Más ayuda
Consulta la documentación en `docs/` o abre un issue en GitHub.

---

## 📊 Comparación de Métodos

| Método | Instalación | Requisitos | Duración | Ideal Para |
|---|---|---|---|---|
| **CLI Interactivo** | Paso a paso | Acceso terminal | 30-45 min | Aprender |
| **ISO Automática** | USB booteable | PC físico | 30 min total | Producción |

---

## 🌟 Características Principales

- ✅ Instalación 100% interactiva
- ✅ Detección automática de hardware
- ✅ Particionamiento inteligente (UEFI/BIOS)
- ✅ Instalación de Arch Linux
- ✅ Instalación de Caelestia
- ✅ Configuración de bootloader automática
- ✅ Manejo avanzado de errores
- ✅ Multiidioma (Español/Inglés)

---

## 📝 Versión

**Arch + Caelestia Installer v3.0**

Última actualización: 2026-05-29

---

## 📄 Licencia

Proyecto de código abierto. Úsalo libremente.

---

## 🔗 Enlaces Útiles

- **GitHub:** https://github.com/Ranijuan/arch-caelestia-installer
- **Documentación:** Ver carpeta `docs/`
- **Problemas:** Abre un issue en GitHub

---

**¡Comienza ahora!**
```bash
chmod +x arch-caelestia && ./arch-caelestia
```
