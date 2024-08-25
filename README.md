
# Wordle-SwiftUI

**Autor:** Hernán Rodríguez Garnica  
**Correo:** [hernanrg85@gmail.com](mailto:hernanrg85@gmail.com)

## Descripción del Proyecto

Este proyecto es una implementación del popular juego "Wordle" en SwiftUI para iOS. El objetivo del juego es adivinar una palabra de cinco letras en un número limitado de intentos. La aplicación maneja correctamente palabras en español, incluidas aquellas con tildes, y proporciona una interfaz de usuario interactiva con retroalimentación visual que indica qué letras han sido adivinadas correctamente y cuáles están en la posición correcta o incorrecta.

## Características

- **Compatibilidad con Palabras en Español**: Incluye soporte para palabras con tildes y caracteres especiales como "Ñ".
- **Interfaz de Usuario Interactiva**: Utiliza SwiftUI para crear una experiencia de usuario fluida y visualmente atractiva.
- **Animaciones**: Implementa animaciones para resaltar las filas cuando se valida una palabra.
- **Teclado Personalizado**: Incluye un teclado personalizado en pantalla con soporte para caracteres especiales.
- **Validación de Palabras**: Valida las palabras ingresadas contra una palabra objetivo obtenida de una API externa.
- **Conexión a una API**: El juego se conecta a una API externa para obtener palabras aleatorias de cinco letras en español.

## Estructura del Proyecto

- **`Model.swift`**: Contiene la estructura del modelo de datos, incluyendo `LetterState`, `LetterColor`, y `WordModel`, que maneja la lógica de verificación y comparación de palabras.
- **`GameViewModel.swift`**: Gestiona el estado del juego y maneja la interacción con la UI, utilizando el modelo de datos.
- **`GameController.swift`**: Se encarga de manejar la obtención de palabras objetivo desde una API y de validar las palabras ingresadas.
- **`WordService.swift`**: Realiza las llamadas a la API para obtener palabras de cinco letras en español.
- **Vistas SwiftUI**:
  - **`ContentView.swift`**: La vista principal del juego.
  - **`KeyboardView.swift`**: Maneja la entrada del usuario a través de un teclado personalizado.
  - **`WordGridView.swift`**, **`WordRowView.swift`**, **`LetterCellView.swift`**: Componentes de la UI que muestran la cuadrícula del juego y las celdas de las letras.
  
## Instrucciones de Instalación

1. **Clonar el Repositorio**:
   ```bash
   git clone https://github.com/HerniRG/Wordle-SwiftUI.git
   ```
2. **Abrir el Proyecto en Xcode**:
   - Abre el archivo `Wordle-SwiftUI.xcodeproj` en Xcode.
3. **Ejecutar el Proyecto**:
   - Selecciona un simulador o un dispositivo físico y ejecuta el proyecto.

## Uso

- Al iniciar la aplicación, se cargará una palabra objetivo de cinco letras obtenida desde una API externa.
- El usuario puede ingresar letras utilizando el teclado en pantalla.
- Después de ingresar una palabra completa, se debe presionar "Enter" para validarla.
- La aplicación indicará si las letras son correctas, están en la posición correcta o incorrecta, o si no están en la palabra.
- El juego continuará hasta que el usuario adivine la palabra o se agoten los intentos.

## Contribuciones

Contribuciones, issues y solicitudes de funciones son bienvenidos. Siéntete libre de abrir un issue para discutir cualquier cambio que desees hacer.

## Contacto

Si tienes alguna pregunta o sugerencia, no dudes en ponerte en contacto conmigo:

**Hernán Rodríguez Garnica**  
**Correo:** [hernanrg85@gmail.com](mailto:hernanrg85@gmail.com)
