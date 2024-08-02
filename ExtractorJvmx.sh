#!/bin/bash

while true
do
    clear
    echo -e "\033[1;32m░░░░░██╗██╗░░░██╗███╗░░░███╗██╗░░██╗\033[0m
\033[1;32m░░░░░██║██║░░░██║████╗░████║╚██╗██╔╝\033[0m
\033[1;32m░░░░░██║╚██╗░██╔╝██╔████╔██║░╚███╔╝░\033[0m
\033[1;32m██╗░░██║░╚████╔╝░██║╚██╔╝██║░██╔██╗░\033[0m
\033[1;32m╚█████╔╝░░╚██╔╝░░██║░╚═╝░██║██╔╝╚██╗\033[0m
\033[1;32m░╚════╝░░░░╚═╝░░░╚═╝░░░░░╚═╝╚═╝░░╚═╝\033[0m
"
    echo -e "\033[1;32mDESAROLLADOR\033[0m \033[1;31m @JVMXVPS                  \033[1;32m VERCION:\033[0m \033[1;36m 0.1\033[0m"
    echo -e "\033[1;32mULTIMA ACUALIZACION:\033[0m \033[1;34m02:08:24\033[0m"
    echo -e " "
    echo -e "\033[32mPANEL PRINCIPAL OPCIONES\033[0m"
    echo -e " "
    echo -e "\033[32m[\033[0m\033[1;34m1\033[0\033[32m]\033[0m. \033[1;33mEXTRACTOR DE HOST\033[0m"
    echo -e "\033[32m[\033[0m\033[1;34m2\033[0m\033[32m]\033[0m. \033[1;33mEXTRACTOR DE SUBDOMINIOS\033[0m"
    echo -e "\033[32m[\033[0m\033[1;34m3\033[0m\033[32m]\033[0m. \033[1;33mSNI INFO\033[0m"
    echo -e " "
    echo -e " "
    echo -e "\033[31m[0]. SALIR\033[0m"

    read -p $'\033[1;34mSeleccione una opción: \033[0m' opcion

    case $opcion in
        1)
            
# Solicitar la URL del sitio web
echo -e "\033[1;33mIngrese la URL del sitio web (con \033[1;32mhttp://\033[1;33m o \033[1;32mhttps://\033[1;33m): \033[0m"
read url

# Extraer el dominio principal de la URL
domain=$(echo "$url" | awk -F[/:] '{print $4}')
echo -e "\033[1;34mDominio principal:\033[0m $domain"

# Crear una lista de posibles subdominios
echo -e "\033[1;34mGenerando lista de posibles subdominios...\033[0m"
subdomains=("www" "mail" "ftp" "webmail" "ns" "dev" "staging" "blog") # Agrega más subdominios si lo deseas
> subdomains.txt # Limpiar el archivo subdomains.txt
for sub in "${subdomains[@]}"; do
    echo "$sub.$domain" >> subdomains.txt
done

# Verificar si se encontraron subdominios
if [ ! -s subdomains.txt ]; then
    echo -e "\033[1;33mNo se encontraron subdominios.\033[0m"
    exit 1
fi

# Extraer enlaces URL de los subdominios encontrados
echo -e "\033[1;33mExtrayendo enlaces URL de los subdominios encontrados...\033[0m"
> urls.txt # Limpiar el archivo urls.txt
while read subdomain; do
    echo -e "\033[1;34mProcesando\033[0m  \033[1;32m$subdomain...\033[0m"
    for protocol in "http" "https"; do
        response=$(curl -s --max-time 10 -L -k "$protocol://$subdomain")
        if [ -z "$response" ]; then
            echo -e "\033[1;31mNo se obtuvo respuesta de\033[0m \033[1;32m$subdomain\033[0m"
        else
            # Extraer URLs completas (incluyendo ruta) y guardarlas en urls.txt
            echo "$response" | grep -oE "https?://[^\"]+" >> urls.txt
        fi
    done
done < subdomains.txt

# Eliminar duplicados y mostrar URLs únicas
sort -u urls.txt > unique_urls.txt

# Mostrar las URLs únicas con rutas en verde
echo -e "\033[1;33mURLs únicas encontradas:\033[0m"
while IFS= read -r url; do
    echo -e "\033[1;32m$url\033[0m"
done < unique_urls.txt

# Pausar para permitir la revisión
read -p $'\033[1;36mPresione Enter para continuar...\033[0m'

# Eliminar archivos temporales
rm subdomains.txt
rm urls.txt
rm unique_urls.txt





            ;;
        2)
            # Solicitar la URL del sitio web
echo -e "\033[1;33mIngrese la URL del sitio web (con \033[1;32mhttp://\033[1;33m o \033[1;32mhttps://\033[1;33m): \033[0m"
read url

# Extraer el dominio principal de la URL
domain=$(echo "$url" | awk -F[/:] '{print $4}')
echo -e "\033[1;34mDominio principal:\033[0m $domain"

# Crear una lista de posibles subdominios
echo -e "\033[1;34mGenerando lista de posibles subdominios...\033[0m"
subdomains=("www" "mail" "ftp" "webmail" "ns" "dev" "staging" "blog") # Agrega más subdominios si lo deseas
> subdomains.txt # Limpiar el archivo subdomains.txt
for sub in "${subdomains[@]}"; do
    echo "$sub.$domain" >> subdomains.txt
done

# Verificar si se encontraron subdominios
if [ ! -s subdomains.txt ]; then
    echo -e "\033[1;33mNo se encontraron subdominios.\033[0m"
    exit 1
fi

# Extraer enlaces URL de los subdominios encontrados
echo -e "\033[1;33mExtrayendo enlaces URL de los subdominios encontrados...\033[0m"
> urls.txt # Limpiar el archivo urls.txt
while read subdomain; do
    echo -e "\033[1;34mProcesando\033[0m  \033[1;32m$subdomain...\033[0m"
    for protocol in "http" "https"; do
        response=$(curl -s --max-time 10 -L -k "$protocol://$subdomain")
        if [ -z "$response" ]; then
            echo -e  "\033[1;31mNo se obtuvo respuesta de\033[0m \033[1;32m $subdomain\033[0m"
        else
            echo "$response" | grep -oE "https?://[^\"]+" | sed -e 's|https://||' -e 's|http://||' | awk -F[/:] '{print $1}' >> urls.txt
        fi
    done
done < subdomains.txt

# Eliminar duplicados y rutas de los subdominios encontrados
sort -u urls.txt > unique_subdomains.txt

# Mostrar los subdominios únicos encontrados en verde
echo -e "\033[1;33mSubdominios únicos encontrados:\033[0m"
while IFS= read -r subdomain; do
    echo -e "\033[1;32m$subdomain\033[0m"
done < unique_subdomains.txt


# Pausar para permitir la revisiok
read -p $'\033[1;36mPresione Enter para continuar...\033[0m'

# Eliminar archivos temporales
rm subdomains.txt
rm urls.txt

            ;;
        3)
            # Ingresa el dominio a buscar
echo -e "\033[1;33mIngrese el dominio:\033[0m "
read dominio

# ...

# Busca información de la conexión SSL/TLS
echo -e "\033[1;33mInformación de la conexión\033[0m   \033[1;32mSSL/TLS:\033[0m"
openssl s_client -connect ${dominio}:443 -servername ${dominio} | grep -E "Cipher|Protocol|PeerPrincipalCN|HTTP"

read -p $'\033[1;36mPresione Enter para continuar...\033[0m'

            ;;
        0)
            # Salir del script
            exit 0
            ;;
        *)
            echo -e "\033[1;31mOpción inválida. Por favor, seleccione una opción válida.\033[0m"
            ;;
    esac
done
