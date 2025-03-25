# Docker Management Scripts

Estos Bash Scripts buildean una imagen y crean un contenedor para DependencyCheck basados en el dockerfile y tambien borran la imagen y el contenedor de DependencyCheck.

## Instalación 

Para clonar el repositorio entero en un entorno linux en el directorio que desees.

```bash
git clone https://github.com/admvateam/dependencycheck_redteam.git
```

## Uso (Local)

Para correr el script de buildeo simplemente ir mediante cd al path del directorio donde esta el archivo .sh y correrlo asi:

```bash
./dependency-check-docker-container-builder.sh
```

Para correr el script de destruccion simplemente ir mediante cd al path del directorio donde esta el archivo .sh y correrlo asi:

```bash
./dependency-check-docker-container-destroyer.sh
```
