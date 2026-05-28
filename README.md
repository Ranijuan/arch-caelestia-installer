# 🚀 Instalador Arch Linux con Caelestia

Una **aplicación interactiva paso a paso** que te guía para instalar Arch Linux con Caelestia de forma **simple, sin tecnicismos**.

![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793d1?logo=arch-linux&logoColor=fff)
![Python 3](https://img.shields.io/badge/Python_3-3776ab?logo=python&logoColor=fff)
![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnu-bash&logoColor=fff)

---

## ⚡ Inicio Rápido

### En Linux/WSL - Opción 1: Python (Recomendado)

```bash
# 1. Abre la terminal
# 2. Navega a la carpeta
cd ~/Downloads/arch\ caelestia

# 3. Ejecuta el instalador
python instalador_arch.py

# 4. ¡Sigue las instrucciones en pantalla!
```

### En Linux/WSL - Opción 2: Bash (Script directo)

```bash
# 1. Haz el script ejecutable
chmod +x instalador_arch.sh

# 2. Ejecuta
./instalador_arch.sh

# 3. ¡Disfruta!
```

---

## 📦 ¿Qué hace?

La aplicación **ejecuta automáticamente** estos pasos:

| Paso | Descripción |
|------|-------------|
| 1️⃣ | Verifica conexión a internet |
| 2️⃣ | Actualiza el sistema completo |
| 3️⃣ | Instala dependencias necesarias |
| 4️⃣ | Descarga Caelestia |
| 5️⃣ | Instala Caelestia |
| 6️⃣ | Configura Caelestia (tú eliges opciones) |
| 7️⃣ | Instala paquetes adicionales |
| 8️⃣ | Finaliza y limpia el sistema |

---

## 🎮 ¿Cómo funciona?

**Súper simple:**

1. 📖 Lee la descripción de cada paso
2. ⌨️ Presiona ENTER para continuar
3. 🎯 Responde preguntas (s/n o elige un número)
4. ✨ **La aplicación hace todo el trabajo automáticamente**

No necesitas escribir comandos - **¡todo es interactivo!**

---

## ⚙️ En el Paso 6, tú eliges:

### 🖥️ Entorno de Escritorio
- **GNOME** - Moderno, bonito, fácil de usar
- **KDE Plasma** - Poderoso, muy personalizable
- **Xfce** - Ligero, rápido (ideal para máquinas lentas)
- **i3** - Minimalista, para expertos

### 🌍 Idioma
- Español
- Inglés
- Francés

---

## 📦 Paquetes Opcionales (Paso 7)

Elige qué instalar:
- 🌐 **Firefox** - Navegador web
- 📄 **LibreOffice** - Procesador de textos, hojas de cálculo
- 🎬 **VLC + GIMP** - Reproductor y editor de imágenes
- 💻 **VS Code + Git** - Para programadores

---

## ⏱️ ¿Cuánto tarda?

**30-60 minutos** (depende de tu internet y computadora)

---

## ✅ Requisitos

✓ Sistema Arch Linux o WSL en Windows  
✓ Conexión a internet activa  
✓ Al menos 15 GB de espacio libre  
✓ Acceso de administrador (se pedirá contraseña)  
✓ Python 3 instalado  

---

## 🔧 Archivos incluidos

```
arch caelestia/
├── instalador_arch.py      ← Versión Python (recomendada)
├── instalador_arch.sh      ← Versión Bash (alternativa)
├── README.md               ← Este archivo
└── LEEME.md               ← Guía detallada en español
```

---

## 🆘 Problemas comunes

### "No se encuentra python"
```bash
sudo pacman -S python
```

### "Error de conexión"
Verifica internet:
```bash
ping 8.8.8.8
```

### "Permiso denegado"
Algunos comandos necesitan `sudo`. Ingresa tu contraseña cuando se pida.

### El proceso se interrumpió
¡Sin problema! Puedes ejecutar nuevamente desde donde se quedó.

---

## 📋 Después de la instalación

### 1. Reinicia tu computadora
```bash
sudo reboot
```

### 2. ¡Disfruta!
Tu Arch Linux estará listo con todo lo que elegiste instalado.

---

## 💡 Tips

- 📖 **Lee cada paso** antes de continuar
- 🖱️ **Mantén la ventana abierta** durante toda la instalación
- 🔐 **Ten tu contraseña a mano** (la necesitarás)
- ⏳ **Paciencia** - algunos pasos tardan minutos
- 📱 **Puedes copiar/pegar comandos** si algo sale mal

---

## 🤝 Contribuciones

¿Encontraste un problema? ¿Tienes sugerencias?
- Reporta en Issues
- Sugiere mejoras
- Comparte tu experiencia

---

## 📄 Licencia

Este proyecto está disponible para uso libre y personal.

---

## 🎯 Características

✨ **Interfaz amigable** - Sin comandos complicados  
✨ **Completamente automático** - No necesitas hacer nada manualmente  
✨ **Personalizable** - Elige tus opciones en el camino  
✨ **Seguro** - Verificaciones en cada paso  
✨ **Educativo** - Aprende qué se está instalando  

---

## 🚀 Comienza ahora

```bash
python instalador_arch.py
```

**¡Bienvenido a Arch Linux!** 🎉

---

*Hecho con ❤️ para hacer la instalación de Arch Linux más fácil*
