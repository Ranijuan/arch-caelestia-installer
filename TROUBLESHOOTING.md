# 🔧 Guía de Solución de Problemas

Aquí encontrarás soluciones para los problemas más comunes durante la instalación.

---

## 🚨 Problemas Generales

### ❌ "Error: No se encontró python"

**Causa:** Python no está instalado en tu sistema.

**Solución:**
```bash
sudo pacman -S python
```

Luego intenta ejecutar nuevamente:
```bash
python instalador_arch.py
```

---

### ❌ "Error: No se encontró git"

**Causa:** Git no está instalado.

**Solución:**
```bash
sudo pacman -S git
```

---

### ❌ "Error de conexión a internet"

**Causa:** No hay conexión activa o es inestable.

**Solución 1: Verificar conexión**
```bash
ping 8.8.8.8
```

Si obtienes respuesta, la conexión está bien.

**Solución 2: Reconectar**
```bash
# Para WiFi
sudo systemctl restart NetworkManager

# O intenta reconectar manualmente desde la interfaz
```

---

### ❌ "Permiso denegado / sudo: comando no encontrado"

**Causa:** No tienes permisos de administrador o sudo no está configurado.

**Solución:**

Si sudo no está instalado:
```bash
pacman -S sudo
```

Luego intenta nuevamente.

---

## 📥 Problemas de Descarga

### ❌ "Error al descargar Caelestia"

**Causa:** Problemas de red o repositorio no disponible.

**Solución:**

1. Verifica tu conexión nuevamente
2. Intenta descargar manualmente:
```bash
cd ~
rm -rf caelestia  # Elimina la carpeta si existe
git clone https://github.com/caelestia/caelestia.git
```

---

### ❌ "Error: El repositorio ya existe"

**Causa:** La carpeta `caelestia` ya está en tu directorio.

**Solución:**

Opción 1: Elimina y descarga nuevamente
```bash
rm -rf ~/caelestia
# Luego ejecuta el instalador nuevamente
```

Opción 2: Actualiza la carpeta existente
```bash
cd ~/caelestia
git pull
```

---

## ⚙️ Problemas de Instalación

### ❌ "Error durante pacman -Syyu"

**Causa:** Los repositorios podrían estar desactualizados o bloqueados.

**Solución 1: Limpiar cache**
```bash
sudo pacman -Sc --noconfirm
```

Solución 2: Actualizar base de datos de repositorios
```bash
sudo pacman -Sy
```

Solución 3: Forzar actualización
```bash
sudo pacman -Syuu
```

---

### ❌ "Error: No hay espacio en disco"

**Causa:** Tu disco está lleno o casi lleno.

**Solución 1: Verificar espacio disponible**
```bash
df -h
```

Solución 2: Limpiar el sistema
```bash
# Eliminar paquetes no utilizados
sudo pacman -Rns $(pacman -Qdtq)

# Limpiar cache de pacman
sudo pacman -Sc
```

---

## 🔄 El Proceso se Interrumpe

### ❌ "Se interrumpió la instalación"

**Causa:** Presionaste Ctrl+C o hubo un error.

**Solución:**

No hay problema, puedes continuar:

```bash
# Intenta ejecutar nuevamente
python instalador_arch.py
```

La mayoría de pasos son **idempotentes** (seguro repetir).

---

## ✅ Checklist de Resolución

Antes de reportar un problema, verifica:

- [ ] ¿Tengo conexión a internet?
- [ ] ¿Tengo espacio en disco (mínimo 15 GB)?
- [ ] ¿Tengo permisos de administrador?
- [ ] ¿Ejecuté el script correcto (Python o Bash)?
- [ ] ¿Leí el mensaje de error completo?
- [ ] ¿Intenté ejecutar nuevamente?
- [ ] ¿Limpié el cache (`sudo pacman -Sc`)?

---

¡Esperamos que esto resuelva tu problema! 🚀
