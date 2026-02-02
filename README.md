# ⚡ PokemonTest - Pokédex Swift

[![Swift Version](https://img.shields.io/badge/Swift-5.9%2B-orange.svg?style=flat&logo=swift)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%2016%2B-blue.svg?style=flat&logo=apple)](https://developer.apple.com/ios/)
[![API](https://img.shields.io/badge/API-PokeAPI-red.svg?style=flat)](https://pokeapi.co/)

> **"Gotta code 'em all! Una implementación moderna de la Pokédex clásica usando Swift."**

`PokemonTest` es un proyecto de exploración técnica que consume la famosa **PokeAPI**. 
El objetivo es mostrar un listado de Pokémon, sus tipos y estadísticas básicas en una interfaz fluida y optimizada para dispositivos iOS.

---

## 🎮 Características (Features)
- **👾 Catálogo Completo:** Carga dinámica de la lista de Pokémon desde la API.
- **🏷️ Tipos y Colores:** Identificación visual de tipos (Fuego, Agua, Planta, etc.).
- **📊 Stats Detalladas:** Visualización de estadísticas de combate y habilidades.
- **🖼️ Image Caching:** Gestión eficiente de imágenes (Sprites) para evitar consumo excesivo de datos.
- **🔍 Búsqueda:** Filtro por nombre para encontrar a tu Pokémon favorito.

---

## 🏗️ Arquitectura y Tecnologías
- **Language:** Swift
- **UI Framework:** SwiftUI / UIKit (Menciona el que uses predominante)
- **Data Fetching:** URLSession + Codable para el parseo de JSON.
- **Architecture:** (Elige una: MVVM / VIPER) para asegurar un código mantenible y desacoplado.

---

## 📸 Screenshots

| Pokedex List | Pokemon Details |
| :---: | :---: |

---

## 📖 Lecciones Aprendidas (Para Estudiantes)
Este proyecto es ideal para practicar conceptos clave de iOS:
1. **JSON Anidado:** PokeAPI tiene una estructura de datos profunda (ej. habilidades dentro de arrays dentro de objetos).
2. **Paginación:** Cómo cargar más Pokémon a medida que el usuario hace scroll (Infinite Scroll).
3. **Optimización de UI:** Renderizar listas largas de elementos con imágenes sin perder fluidez (60 FPS).

---
