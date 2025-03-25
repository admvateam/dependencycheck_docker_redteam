# Docker Management Scripts

Estos Bash Scripts buildean una imagen y crean un contenedor para DependencyCheck basados en el dockerfile y tambien borran la imagen y el contenedor de DependencyCheck.

## Instalación 

Para clonar el repositorio entero en un entorno linux en el directorio que desees.

```bash
git clone https://github.com/admvateam/dependencycheck_redteam.git
```

## Uso (Local)

Para correr el script que buildea la imagen y el contenedor simplemente ir mediante cd al path del directorio donde esta el archivo .sh de buildeo y correrlo asi:

```bash
./dependency-check-docker-container-builder.sh
```

Para correr el script que destruye la imagen y el contenedor simplemente ir mediante cd al path del directorio donde esta el archivo .sh de destruccion y correrlo asi:

```bash
./dependency-check-docker-container-destroyer.sh
```
