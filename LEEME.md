# 📦 Instalador Arch Linux con Caelestia - Guía de Uso

## ¿Qué es esto?

Una aplicación interactiva **simple y amigable** que te guía paso a paso para instalar **Arch Linux con Caelestia** sin necesidad de conocimientos técnicos.

---

## 🚀 Cómo usar

### Opción 1: En Linux/WSL (Recomendado)

1. **Abre la terminal** en tu sistema Arch Linux o WSL

2. **Navega a la carpeta** donde está el instalador:
   ```bash
   cd ~/Downloads/arch\ caelestia
   ```

3. **Ejecuta el instalador**:
   ```bash
   python instalador_arch.py
   ```

4. **Sigue las instrucciones** en pantalla - es muy simple:
   - Lee cada paso
   - Presiona ENTER para continuar
   - Responde las preguntas (s/n o elige un número)
   - El programa ejecutará automáticamente todos los comandos

### Opción 2: En Windows (si tienes WSL instalado)

1. **Abre PowerShell** o **Windows Terminal**

2. **Entra a WSL**:
   ```powershell
   wsl
   ```

3. **Navega a la carpeta**:
   ```bash
   cd /mnt/c/Users/Ranijuan/Downloads/arch\ caelestia
   ```

4. **Ejecuta**:
   ```bash
   python instalador_arch.py
   ```

---

## 📋 ¿Qué hace el instalador?

El programa ejecuta estos pasos automáticamente:

### ✅ Paso 1: Verificar conexión a internet
Comprueba que tienes conexión para descargar paquetes.

### ✅ Paso 2: Actualizar el sistema
Actualiza todos los paquetes instalados a sus últimas versiones.

### ✅ Paso 3: Instalar dependencias
Instala las herramientas necesarias para que Caelestia funcione:
- Git (para descargar código)
- Herramientas de desarrollo
- Python

### ✅ Paso 4: Descargar Caelestia
Descarga Caelestia desde internet a tu carpeta de usuario.

### ✅ Paso 5: Instalar Caelestia
Ejecuta el instalador de Caelestia.

### ✅ Paso 6: Configurar Caelestia
Aquí **tú eliges**:
- **Entorno de escritorio**: GNOME, KDE Plasma, Xfce o i3
- **Idioma**: Español, Inglés o Francés

### ✅ Paso 7: Instalar paquetes adicionales
Opcionalmente instala:
- Navegador web (Firefox)
- Suite ofimática (LibreOffice)
- Software multimedia (VLC, GIMP)
- Herramientas de desarrollo (VS Code, Git)

### ✅ Paso 8: Finalizar
Limpia archivos temporales y ajusta la configuración final.

---

## ⏱️ ¿Cuánto tarda?

**30-60 minutos** dependiendo de:
- Velocidad de tu internet
- Potencia de tu computadora
- Paquetes adicionales que instales

---

## ⚠️ Requisitos previos

✓ Sistema operativo con Arch Linux o WSL  
✓ Conexión a internet activa  
✓ Al menos 15 GB de espacio libre  
✓ Acceso de administrador (se pedirá contraseña)  
✓ Python 3 instalado (generalmente ya viene)

---

## 🛠️ Solución de problemas

### "No se encuentra python"
Instala Python primero:
```bash
sudo pacman -S python
```

### "Error de conexión"
Verifica tu conexión a internet:
```bash
ping 8.8.8.8
```

### "Acceso denegado"
Algunos comandos necesitan permisos de administrador. Si se pide contraseña, ingresa la contraseña de tu usuario.

### El proceso se interrumpió
Puedes volver a ejecutar el programa desde donde se quedó. La mayoría de pasos son idempotentes (seguros de repetir).

---

## 📞 Soporte

Si hay problemas:
1. Lee el mensaje de error con cuidado
2. Intenta ejecutar nuevamente
3. Verifica que tienes conexión a internet
4. Asegúrate de tener espacio en disco

---

## ✨ Después de la instalación

### 1. Reinicia tu computadora
```bash
sudo reboot
```

### 2. Disfruta tu Arch Linux
Tu sistema estará listo con:
- ✅ Arch Linux actualizado
- ✅ Caelestia configurado
- ✅ Tu entorno de escritorio elegido
- ✅ Paquetes adicionales instalados

---

## 🎯 Tips

💡 **No necesitas conocer comandos** - todo es automático  
💡 **Lee cada paso** antes de continuar para entender qué pasa  
💡 **Mantén la ventana abierta** durante toda la instalación  
💡 **Anota tu contraseña** antes de comenzar (la necesitarás)  
💡 **Paciencia** - algunos pasos tardan unos minutos

---

¡Bienvenido a Arch Linux! 🚀
