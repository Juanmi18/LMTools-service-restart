# LMTools Restart Service

Script y utilidades para reiniciar de forma controlada el servidor de licencias de Autodesk basado en FlexLM, forzando además la recarga (reread) del archivo de licencias.

## Descripción

El objetivo de este proyecto es facilitar el reinicio del servidor de licencias de Autodesk usando `lmutil` y el servicio de Windows asociado.

El script principal:

- Detiene el servidor de licencias de forma forzada (`lmdown`).
- Espera a que el servidor esté realmente parado.
- Arranca de nuevo el servicio de Windows del servidor de licencias.
- Espera a que el servidor de licencias esté arriba y respondiendo.
- Fuerza un `lmreread` del archivo de licencias.
- Muestra el estado final con `lmstat`.

## Archivos del repositorio

- `LMTools-Restart-Service.ps1`: script principal de PowerShell que realiza todo el proceso.
- `Run-LMTools-Restart-Service.bat`: lanzador en batch para ejecutar el script de PowerShell con la política de ejecución adecuada.

## Requisitos

- Windows con PowerShell.
- Herramientas FlexLM instaladas (`lmutil.exe`).
- Servicio de Windows configurado para el servidor de licencias (por ejemplo, "Flexlm Service 1").
- Acceso al archivo de licencias (`license.lic`).

## Seguridad y política de ejecución de PowerShell

Por defecto, PowerShell puede bloquear la ejecución de scripts por motivos de seguridad.

Para evitar problemas, se recomienda **habilitar la ejecución de scripts firmados o locales** para el usuario actual _antes_ de usar este proyecto:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Si no quieres cambiar la política global, el `.bat` ya utiliza:

```bat
powershell -ExecutionPolicy Bypass -File "LMTools-Restart-Service.ps1"
```

Esto aplica un bypass **solo para esa ejecución concreta**, pero el enfoque más limpio y recomendado es el `RemoteSigned` por usuario.

## Configuración del script

Edita `LMTools-Restart-Service.ps1` y ajusta estas variables al principio del archivo:

```powershell
$lmutil  = "C:\\FlexLM\\lmutil.exe"    # Ruta a lmutil.exe
$licFile = "C:\\FlexLM\\license.lic"  # Ruta al archivo de licencias
$service = "Flexlm Service 1"            # Nombre del servicio de Windows
```

Asegúrate de que:

- La ruta a `lmutil.exe` es correcta.
- El archivo de licencia (`license.lic`) existe y es el que usa tu servidor.
- El nombre del servicio coincide con el configurado en Servicios de Windows.

## Uso

### Opción 1: Usar el .bat (recomendado para usuarios finales)

1. Copia todo el contenido del repositorio a una carpeta, por ejemplo:
   `C:\Herramientas\LMTools-Restart-Service`.
2. Ajusta las rutas en `LMTools-Restart-Service.ps1`.
3. Haz doble clic en `Run-LMTools-Restart-Service.bat`.
4. La ventana mostrará los pasos realizados y se quedará en pausa al final (`pause`).

### Opción 2: Ejecutar directamente el script de PowerShell

```powershell
cd C:\Herramientas\LMTools-Restart-Service

# Si tienes RemoteSigned configurado:
.\LMTools-Restart-Service.ps1

# O bien, en una sola línea desde cualquier sitio:
powershell -ExecutionPolicy Bypass -File "C:\Herramientas\LMTools-Restart-Service\LMTools-Restart-Service.ps1"
```

## Notas

- El script incluye comprobaciones de estado para asegurarse de que el servidor realmente se detiene y se levanta correctamente.
- En caso de error (por ejemplo, no consigue parar/arrancar en el tiempo esperado), el script mostrará un mensaje en rojo y devolverá un código de salida distinto de 0.
