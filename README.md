# PayphoneTest

Esta es una aplicación de prueba técnica para la gestión de usuarios, desarrollada en Swift 5.9 con el framework SwiftUI, utilizando MVVM+C, Realm 10.42.0 para la persistencia local, Alamofire 5.10.0 para las solicitudes de red, y soporte para iOS 15+.

## Características

- Listar usuarios
- Agregar usuarios
- Eliminar usuarios
- Persistencia local con Realm
- Manejo de errores y validación de formularios
- Navegacion con Coordinator


## Arquitectura

El proyecto sigue la arquitectura **MVVM+C** (Model-View-ViewModel-Coordinator), donde:

- **Model**: Maneja la lógica de datos, persistencia y modelos.
- **View**: Desarrollado con SwiftUI para representar las interfaces de usuario.
- **ViewModel**: Lógica de presentación y validación.
- **Coordinator**: Navegación entre vistas.
- **UseCases**: Maneja los casos de usos de networking.
- **Utilities**: Ubica funcionalidades extras como el manager de CoreLocation.
- **Networking**: Controla la capa de networking y provee servicios 


## Instalación

Para ejecutar este proyecto, sigue los pasos a continuación:

1. Clona el repositorio:
   
   git clone https://github.com/lewhub474/PayphoneTest.git

2. Abrir el archivo PayphoneTest.xcworkspace

## Funcionalidad

1. Encontraras una lista de Usuarios a la cual podrás editar con un swipe a la izquierda para eliminar los usuarios deseados.
2. Encontraras un botón flotante en la parte inferior derecha para agregar nuevos Usuarios.
3. Podrás presionar la celda de los Usuarios para observar su información de detalle.
4. En la vista para añadir nuevos Usuarios encontraras un botón flotante para conocer la localización del dispositivo.
5. La aplicacion cuenta con manejo de errores y te enviará un popup en caso de desconexión a Internet.


