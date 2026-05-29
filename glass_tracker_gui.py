#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
glass_tracker_gui.py
Aplicación GUI (Tkinter) para gestionar tareas y mostrar un vaso que se llena por cada tarea completada.
Diseñada para empaquetar con PyInstaller y generar un exe nativo en Windows.
"""

import os
import sys
import json
import shutil

try:
    import tkinter as tk
    from tkinter import simpledialog, messagebox
except Exception:
    tk = None

APP_NAME = "Glass Tracker"
GLASS_SEGMENTS = 12
CANVAS_WIDTH = 240
CANVAS_HEIGHT = 360
FILL_COLOR = "#4da6ff"
BORDER_COLOR = "#333"
BG_COLOR = "#f6f6f6"

# ------------------ Datos (persistencia) ------------------

def get_tasks_path():
    """Determina la ruta donde guardar tasks.json (directorio del usuario).
    Si se ejecuta como exe empacado, intenta inicializar desde un resource bundlado.
    """
    # Preferir carpeta por usuario para persistencia
    if os.name == 'nt':
        base = os.getenv('APPDATA') or os.path.expanduser('~')
        data_dir = os.path.join(base, APP_NAME)
    else:
        data_dir = os.path.join(os.path.expanduser('~'), '.glass_tracker')
    os.makedirs(data_dir, exist_ok=True)
    tasks_path = os.path.join(data_dir, 'tasks.json')

    # Si no existe, copiar ejemplo desde bundle si está disponible
    if not os.path.exists(tasks_path):
        bundle = None
        # PyInstaller coloca archivos en _MEIPASS
        if getattr(sys, '_MEIPASS', None):
            bundle = os.path.join(sys._MEIPASS, 'tasks.json')
        else:
            # archivo local al lado del script
            script_dir = os.path.dirname(os.path.abspath(__file__))
            cand = os.path.join(script_dir, 'tasks.json')
            if os.path.exists(cand):
                bundle = cand
        if bundle and os.path.exists(bundle):
            try:
                shutil.copy(bundle, tasks_path)
            except Exception:
                pass
    return tasks_path


def load_tasks():
    path = get_tasks_path()
    if not os.path.exists(path):
        return []
    try:
        with open(path, 'r', encoding='utf-8') as f:
            return json.load(f)
    except Exception:
        return []


def save_tasks(tasks):
    path = get_tasks_path()
    try:
        with open(path, 'w', encoding='utf-8') as f:
            json.dump(tasks, f, ensure_ascii=False, indent=2)
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo guardar tasks.json: {e}")


def next_id(tasks):
    return max((t.get('id', 0) for t in tasks), default=0) + 1

# ------------------ Interfaz GUI ------------------

class GlassApp:
    def __init__(self, root):
        self.root = root
        root.title(APP_NAME)
        root.geometry('820x480')
        root.configure(bg=BG_COLOR)

        self.tasks = load_tasks()
        self.prev_fill = 0.0

        # Left pane - tasks
        left = tk.Frame(root, bg=BG_COLOR)
        left.pack(side='left', fill='y', padx=12, pady=12)

        tk.Label(left, text='Tareas', bg=BG_COLOR, font=('Segoe UI', 14, 'bold')).pack(anchor='w')
        self.listbox = tk.Listbox(left, width=40, height=20, font=('Segoe UI', 11))
        self.listbox.pack(side='left', fill='y')
        sb = tk.Scrollbar(left, command=self.listbox.yview)
        sb.pack(side='left', fill='y')
        self.listbox.config(yscrollcommand=sb.set)

        btn_frame = tk.Frame(left, bg=BG_COLOR)
        btn_frame.pack(fill='x', pady=8)
        tk.Button(btn_frame, text='Añadir', width=10, command=self.add_task).pack(side='left', padx=4)
        tk.Button(btn_frame, text='Completar', width=10, command=self.toggle_done).pack(side='left', padx=4)
        tk.Button(btn_frame, text='Eliminar', width=10, command=self.remove_task).pack(side='left', padx=4)
        tk.Button(btn_frame, text='Reset', width=10, command=self.reset_tasks).pack(side='left', padx=4)
        tk.Button(btn_frame, text='Guardar', width=10, command=self.save).pack(side='left', padx=4)

        # Right pane - glass
        right = tk.Frame(root, bg=BG_COLOR)
        right.pack(side='left', fill='both', expand=True, padx=12, pady=12)

        self.canvas = tk.Canvas(right, width=CANVAS_WIDTH, height=CANVAS_HEIGHT, bg='white', bd=0, highlightthickness=0)
        self.canvas.pack(pady=8)
        self.status_label = tk.Label(right, text='', bg=BG_COLOR, font=('Segoe UI', 12))
        self.status_label.pack()

        self.listbox.bind('<Double-Button-1>', lambda e: self.toggle_done())
        root.protocol('WM_DELETE_WINDOW', self.on_close)

        self.refresh()

    def refresh(self):
        self.listbox.delete(0, tk.END)
        for t in self.tasks:
            prefix = '✔ ' if t.get('done') else '   '
            self.listbox.insert(tk.END, f"{prefix}{t['title']}")
        total = len(self.tasks)
        done = sum(1 for t in self.tasks if t.get('done'))
        self.status_label.config(text=f"Tareas: {total}   Completadas: {done}")
        self.animate_fill()

    def add_task(self):
        title = simpledialog.askstring("Añadir tarea", "Texto de la tarea:", parent=self.root)
        if title and title.strip():
            self.tasks.append({'id': next_id(self.tasks), 'title': title.strip(), 'done': False})
            self.refresh()

    def toggle_done(self):
        sel = self.listbox.curselection()
        if not sel:
            return
        idx = sel[0]
        self.tasks[idx]['done'] = not self.tasks[idx].get('done', False)
        self.refresh()

    def remove_task(self):
        sel = self.listbox.curselection()
        if not sel:
            return
        idx = sel[0]
        if messagebox.askyesno('Eliminar', f"Eliminar tarea: {self.tasks[idx]['title']}?"):
            del self.tasks[idx]
            self.refresh()

    def reset_tasks(self):
        if messagebox.askyesno('Reset', 'Borrar todas las tareas?'):
            self.tasks = []
            self.refresh()

    def save(self):
        save_tasks(self.tasks)
        messagebox.showinfo('Guardado', 'Tareas guardadas')

    def draw_glass(self, ratio):
        self.canvas.delete('all')
        pad = 20
        left = pad
        right = CANVAS_WIDTH - pad
        top = 20
        bottom = CANVAS_HEIGHT - 40
        self.canvas.create_rectangle(left, top, right, bottom, outline=BORDER_COLOR, width=3)

        full_height = bottom - top
        fill_pixels = int(full_height * ratio)
        water_top = bottom - fill_pixels
        self.canvas.create_rectangle(left+3, water_top, right-3, bottom-3, fill=FILL_COLOR, outline='')

        seg_h = full_height / GLASS_SEGMENTS
        for i in range(GLASS_SEGMENTS):
            y = bottom - i*seg_h
            self.canvas.create_line(left+2, y, right-2, y, fill='#e6f7ff')

        percent = int(round(ratio*100)) if ratio is not None else 0
        self.canvas.create_text(CANVAS_WIDTH/2, top+12, text=f"{percent}% lleno", font=('Segoe UI', 14, 'bold'))

    def animate_fill(self):
        total = len(self.tasks)
        done = sum(1 for t in self.tasks if t.get('done'))
        target = 0.0 if total == 0 else (done / total)
        steps = 12
        start = self.prev_fill
        delta = (target - start) / steps if steps else 0
        def step(i=0):
            nonlocal start, delta
            if i>steps:
                self.prev_fill = target
                return
            ratio = start + delta * i
            if ratio < 0: ratio = 0
            if ratio > 1: ratio = 1
            self.draw_glass(ratio)
            self.root.after(25, lambda: step(i+1))
        step()

    def on_close(self):
        save_tasks(self.tasks)
        self.root.destroy()


def main():
    if tk is None:
        print('Tkinter no disponible. Instale tkinter o ejecute en un entorno que lo tenga.')
        return
    root = tk.Tk()
    app = GlassApp(root)
    root.mainloop()

if __name__ == '__main__':
    main()
