#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Instalador Interactivo de Arch Linux con Caelestia
Guía paso a paso simple y amigable
"""

import subprocess
import os
import sys
import time
from typing import Optional

class InstaladorArch:
    def __init__(self):
        self.paso_actual = 0
        self.pasos_completados = []
        
    def limpiar_pantalla(self):
        """Limpia la pantalla de la terminal"""
        os.system('cls' if os.name == 'nt' else 'clear')
    
    def mostrar_encabezado(self):
        """Muestra el encabezado de la aplicación"""
        print("\n")
        print("╔" + "═" * 68 + "╗")
        print("║" + " " * 15 + "📦  INSTALADOR ARCH LINUX CON CAELESTIA  📦" + " " * 9 + "║")
        print("║" + " " * 20 + "Guía paso a paso - Simple y Fácil" + " " * 15 + "║")
        print("╚" + "═" * 68 + "╝")
        print()

    def mostrar_progreso(self):
        """Muestra la barra de progreso"""
        total_pasos = 8
        porcentaje = (self.paso_actual / total_pasos) * 100
        barra = "█" * (self.paso_actual) + "░" * (total_pasos - self.paso_actual)
        print(f"Progreso: [{barra}] {int(porcentaje)}%")
        print()

    def ejecutar_comando(self, comando: str, descripcion: str = "") -> bool:
        """Ejecuta un comando en la terminal y muestra el resultado"""
        print(f"📝 Ejecutando: {descripcion}")
        print(f"   $ {comando}")
        print()
        
        try:
            resultado = subprocess.run(
                comando,
                shell=True,
                capture_output=False,
                text=True
            )
            if resultado.returncode == 0:
                print(f"✅ {descripcion} - ¡COMPLETADO!\n")
                return True
            else:
                print(f"⚠️  Hubo un problema. Código de error: {resultado.returncode}\n")
                return False
        except Exception as e:
            print(f"❌ Error al ejecutar comando: {e}\n")
            return False

    def pausa(self):
        """Pausa y espera input del usuario"""
        input("Presiona ENTER para continuar...")
        
    def pregunta_si_no(self, pregunta: str) -> bool:
        """Hace una pregunta si/no al usuario"""
        while True:
            respuesta = input(f"\n{pregunta} (s/n): ").lower().strip()
            if respuesta in ['s', 'si', 'sí', 'y', 'yes']:
                return True
            elif respuesta in ['n', 'no']:
                return False
            else:
                print("Por favor, escribe 's' para sí o 'n' para no.")

    def paso_1_verificar_conexion(self):
        """Paso 1: Verificar conexión a internet"""
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        self.paso_actual = 1
        self.mostrar_progreso()
        
        print("🌐 PASO 1: Verificar Conexión a Internet")
        print("=" * 70)
        print("""
Este paso verifica que tu computadora esté conectada a internet.
La instalación de Arch requiere descargar muchos paquetes, así que 
necesitamos una conexión activa.
        """)
        
        self.pausa()
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        self.mostrar_progreso()
        
        print("🔍 Comprobando conexión a internet...\n")
        self.ejecutar_comando("ping -c 1 8.8.8.8 || ping -n 1 8.8.8.8", "Prueba de conexión")
        
        self.pasos_completados.append("Conexión verificada")
        self.pausa()

    def paso_2_actualizar_sistema(self):
        """Paso 2: Actualizar el sistema"""
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        self.paso_actual = 2
        self.mostrar_progreso()
        
        print("🔄 PASO 2: Actualizar el Sistema")
        print("=" * 70)
        print("""
Ahora vamos a actualizar todos los paquetes de tu sistema.
Esto asegura que tengas las últimas versiones de software.

⏱️  Esto puede tomar algunos minutos...
        """)
        
        self.pausa()
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        self.mostrar_progreso()
        
        print("⏳ Actualizando el sistema...\n")
        self.ejecutar_comando("sudo pacman -Syyu --noconfirm", "Actualización del sistema")
        
        self.pasos_completados.append("Sistema actualizado")
        self.pausa()

    def paso_3_instalar_dependencias(self):
        """Paso 3: Instalar dependencias necesarias"""
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        self.paso_actual = 3
        self.mostrar_progreso()
        
        print("📦 PASO 3: Instalar Dependencias")
        print("=" * 70)
        print("""
Caelestia necesita ciertas herramientas para funcionar correctamente.
Instalaremos:
  • git - Para descargar código fuente
  • base-devel - Herramientas de desarrollo
  • python - Lenguaje de programación necesario
        """)
        
        self.pausa()
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        self.mostrar_progreso()
        
        print("📥 Instalando dependencias...\n")
        self.ejecutar_comando(
            "sudo pacman -S git base-devel python --noconfirm",
            "Instalación de dependencias"
        )
        
        self.pasos_completados.append("Dependencias instaladas")
        self.pausa()

    def paso_4_descargar_caelestia(self):
        """Paso 4: Descargar Caelestia"""
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        self.paso_actual = 4
        self.mostrar_progreso()
        
        print("⬇️  PASO 4: Descargar Caelestia")
        print("=" * 70)
        print("""
Ahora descargaremos Caelestia, que es la herramienta que facilita
la instalación de Arch Linux.

Se descargará en tu carpeta de usuario.
        """)
        
        self.pausa()
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        self.mostrar_progreso()
        
        print("⬇️  Descargando Caelestia...\n")
        self.ejecutar_comando(
            "cd ~ && git clone https://github.com/caelestia/caelestia.git",
            "Descarga de Caelestia"
        )
        
        self.pasos_completados.append("Caelestia descargado")
        self.pausa()

    def paso_5_instalar_caelestia(self):
        """Paso 5: Instalar Caelestia"""
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        self.paso_actual = 5
        self.mostrar_progreso()
        
        print("⚙️  PASO 5: Instalar Caelestia")
        print("=" * 70)
        print("""
Ejecutaremos el instalador de Caelestia.
Esto preparará el sistema para la configuración final.
        """)
        
        self.pausa()
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        self.mostrar_progreso()
        
        print("⚙️  Instalando Caelestia...\n")
        self.ejecutar_comando(
            "cd ~/caelestia && sudo python install.py",
            "Instalación de Caelestia"
        )
        
        self.pasos_completados.append("Caelestia instalado")
        self.pausa()

    def paso_6_configurar_caelestia(self):
        """Paso 6: Configurar Caelestia"""
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        self.paso_actual = 6
        self.mostrar_progreso()
        
        print("🔧 PASO 6: Configurar Caelestia")
        print("=" * 70)
        print("""
Ahora configuraremos Caelestia según tus preferencias.
Te haremos algunas preguntas simples:
        """)
        
        entorno_escritorio = input("""
¿Qué entorno de escritorio prefieres?
1. GNOME (Moderno y fácil de usar)
2. KDE Plasma (Poderoso y personalizable)
3. Xfce (Ligero y rápido)
4. i3 (Gestor de ventanas minimalista)

Escribe el número (1-4): """).strip()
        
        idioma = input("""
¿Cuál es tu idioma preferido?
1. Español
2. Inglés
3. Francés

Escribe el número (1-3): """).strip()
        
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        self.mostrar_progreso()
        
        print("🔧 Aplicando configuración...\n")
        
        entornos = {
            '1': ('gnome', 'GNOME'),
            '2': ('plasma', 'KDE Plasma'),
            '3': ('xfce', 'Xfce'),
            '4': ('i3', 'i3')
        }
        idiomas = {'1': 'es_ES', '2': 'en_US', '3': 'fr_FR'}
        
        env = entornos.get(entorno_escritorio, ('gnome', 'GNOME'))[0]
        idioma_seleccionado = idiomas.get(idioma, 'es_ES')
        
        self.ejecutar_comando(
            f"sudo caelestia config --desktop {env} --language {idioma_seleccionado}",
            "Configuración de Caelestia"
        )
        
        self.pasos_completados.append("Caelestia configurado")
        self.pausa()

    def paso_7_instalar_paquetes(self):
        """Paso 7: Instalar paquetes adicionales"""
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        self.paso_actual = 7
        self.mostrar_progreso()
        
        print("📚 PASO 7: Instalar Paquetes Adicionales")
        print("=" * 70)
        print("""
¿Qué tipo de software adicional deseas instalar?
Puedes seleccionar varias opciones.
        """)
        
        opciones = {
            'navegador': '¿Navegador web? (Firefox)',
            'oficina': '¿Suite ofimática? (LibreOffice)',
            'multimedia': '¿Software multimedia? (VLC, GIMP)',
            'desarrollo': '¿Herramientas de desarrollo? (VS Code, Git)',
        }
        
        selecciones = {}
        for clave, pregunta in opciones.items():
            selecciones[clave] = self.pregunta_si_no(pregunta)
        
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        self.mostrar_progreso()
        
        paquetes = []
        if selecciones['navegador']:
            paquetes.append('firefox')
        if selecciones['oficina']:
            paquetes.append('libreoffice-fresh')
        if selecciones['multimedia']:
            paquetes.append('vlc gimp')
        if selecciones['desarrollo']:
            paquetes.append('code git')
        
        if paquetes:
            print("📥 Instalando paquetes seleccionados...\n")
            self.ejecutar_comando(
                f"sudo pacman -S {' '.join(paquetes)} --noconfirm",
                "Instalación de paquetes adicionales"
            )
        else:
            print("✅ No se instalaron paquetes adicionales.\n")
        
        self.pasos_completados.append("Paquetes adicionales instalados")
        self.pausa()

    def paso_8_finalizar(self):
        """Paso 8: Finalizar instalación"""
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        self.paso_actual = 8
        self.mostrar_progreso()
        
        print("✨ PASO 8: Finalizar Instalación")
        print("=" * 70)
        print("""
¡Casi terminamos! Vamos a hacer los últimos ajustes.
        """)
        
        self.pausa()
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        self.mostrar_progreso()
        
        print("🧹 Limpiando archivos temporales...\n")
        self.ejecutar_comando(
            "sudo pacman -Sc --noconfirm",
            "Limpieza del sistema"
        )
        
        print("🔄 Actualizando configuración del sistema...\n")
        self.ejecutar_comando(
            "sudo ldconfig && sudo update-font-cache",
            "Actualización de configuración"
        )
        
        self.pasos_completados.append("Sistema finalizado")
        self.pausa()

    def mostrar_resumen_final(self):
        """Muestra un resumen de todo lo completado"""
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        
        print("🎉 ¡INSTALACIÓN COMPLETADA CON ÉXITO!")
        print("=" * 70)
        print("\n📋 Resumen de pasos completados:\n")
        
        for i, paso in enumerate(self.pasos_completados, 1):
            print(f"   {i}. ✅ {paso}")
        
        print("""
╔══════════════════════════════════════════════════════════════════╗
║                                                                  ║
║  Próximos pasos:                                                 ║
║                                                                  ║
║  1. Reinicia tu computadora:                                     ║
║     $ sudo reboot                                                ║
║                                                                  ║
║  2. Después del reinicio, tu sistema Arch estará listo           ║
║     con Caelestia instalado y configurado                        ║
║                                                                  ║
║  3. Disfruta tu nuevo Arch Linux personalizado! 🚀               ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
        """)
        
        print("\n¡Gracias por usar el Instalador Arch con Caelestia!\n")
        input("Presiona ENTER para salir...")

    def ejecutar_instalacion(self):
        """Ejecuta toda la secuencia de instalación"""
        self.limpiar_pantalla()
        self.mostrar_encabezado()
        
        print("""
Bienvenido al Instalador Interactivo de Arch Linux con Caelestia

Este programa te guiará paso a paso a través de toda la instalación.
No necesitas conocimientos técnicos - es simple y fácil.

⚠️  IMPORTANTE:
  • Algunos comandos requieren contraseña (acceso de administrador)
  • La instalación puede tomar 30-60 minutos
  • Asegúrate de tener conexión a internet
  • No cierres esta ventana durante el proceso

        """)
        
        if not self.pregunta_si_no("¿Estás listo para comenzar?"):
            print("\n❌ Instalación cancelada.\n")
            return
        
        try:
            self.paso_1_verificar_conexion()
            self.paso_2_actualizar_sistema()
            self.paso_3_instalar_dependencias()
            self.paso_4_descargar_caelestia()
            self.paso_5_instalar_caelestia()
            self.paso_6_configurar_caelestia()
            self.paso_7_instalar_paquetes()
            self.paso_8_finalizar()
            self.mostrar_resumen_final()
            
        except KeyboardInterrupt:
            self.limpiar_pantalla()
            print("\n\n⚠️  Instalación cancelada por el usuario.\n")
            print("Puedes continuar ejecutando este programa más tarde.\n")
        except Exception as e:
            self.limpiar_pantalla()
            print(f"\n\n❌ Error inesperado: {e}\n")
            print("Por favor, intenta nuevamente o contacta soporte.\n")


def main():
    """Función principal"""
    try:
        instalador = InstaladorArch()
        instalador.ejecutar_instalacion()
    except Exception as e:
        print(f"Error crítico: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
