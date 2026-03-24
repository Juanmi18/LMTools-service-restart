# Prueba

Repositorio de prueba para experimentar con GitHub, flujos de trabajo y configuración de OpenClaw.

## Descripción

Este proyecto se utiliza para:

- Probar el flujo de trabajo con Git y GitHub.
- Verificar el acceso mediante SSH al repositorio.
- Hacer pruebas de automatización y agentes (OpenClaw, etc.).

## Requisitos

- Git instalado
- Acceso SSH a GitHub configurado para el usuario `juanmi18colaborador`
- Claves en `~/.ssh` correctamente asociadas a la cuenta de GitHub

## Clonado del repositorio

```bash
git clone git@github.com:Juanmi18/prueba.git
cd prueba
```

Si tienes problemas con el acceso SSH (por ejemplo, `Host key verification failed`), revisa:

1. Que tu llave pública está añadida a GitHub.
2. Que confías en la clave del host de GitHub (entrada en `~/.ssh/known_hosts`).
3. Que estás usando el usuario correcto de GitHub: `juanmi18colaborador`.

## Uso

De momento este repositorio es solo de prueba, así que puedes usarlo para:

- Crear y borrar ramas
- Probar pull requests
- Testear hooks, CI, etc.

## Autor

- Usuario de GitHub: **juanmi18colaborador**  
- Email: **juanmi+colaborador@improvisa.com**
