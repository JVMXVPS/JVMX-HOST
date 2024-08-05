import subprocess

# Define los comandos a ejecutar
comandos = [
    ["chmod", "+x", "extractjvmx.sh"],
    ["bash", "extractjvmx.sh"]
]

# Ejecuta los comandos utilizando subprocess
for comando in comandos:
    subprocess.run(comando)


