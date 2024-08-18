import subprocess

# Define los comandos a ejecutar
comandos = [
    ["chmod", "+x", "jvmxvps.sh"],
    ["bash", "jvmxvps.sh"]
]

# Ejecuta los comandos utilizando subprocess
for comando in comandos:
    subprocess.run(comando)
