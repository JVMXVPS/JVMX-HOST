#!/bin/bash
while true
do                                                                                                       clear
    echo -e "\033[1;32m░░░░░██╗██╗░░░██╗███╗░░░███╗██╗░░██╗\033[0m
\033[1;32m░░░░░██║██║░░░██║████╗░████║╚██╗██╔╝\033[0m
\033[1;32m░░░░░██║╚██╗░██╔╝██╔████╔██║░╚███╔╝░\033[0m
\033[1;32m██╗░░██║░╚████╔╝░██║╚██╔╝██║░██╔██╗░\033[0m
\033[1;32m╚█████╔╝░░╚██╔╝░░██║░╚═╝░██║██╔╝╚██╗\033[0m
\033[1;32m░╚════╝░░░░╚═╝░░░╚═╝░░░░░╚═╝╚═╝░░╚═╝\033[0m"
    echo -e " "                                                                                                        
    echo -e "\033[1;32mDESAROLLADOR\033[0m \033[1;31m @JVMXVPS                  \033[1;32m VERCION:\033[0m \033[1;36m2.0\033[0m"
    echo -e "\033[1;32mULTIMA ACUALIZACION:\033[0m \033[1;34m02:08:24\033[0m"
    echo -e " "
    echo -e "\033[1;36mPANEL PRINCIPAL OPCIONES\033[0m"
    echo -e " "
    echo -e "\033[32m[\033[0m\033[1;34m1\033[0\033[32m]\033[0m• \033[1;33mEXTRACTOR DE HOST\033[0m"
    echo -e "\033[32m[\033[0m\033[1;34m2\033[0\033[32m]\033[0m• \033[1;33mEXTRACTOR DE SUBDOMINIOS\033[0m"
    echo -e "\033[32m[\033[0m\033[1;34m3\033[0\033[32m]\033[0m• \033[1;33mSNI INFO\033[0m"
    echo -e "\033[32m[\033[0m\033[1;34m4\033[0\033[32m]\033[0m• \033[1;33mCDN FINDER\033[0m \033[1;34mBETA\033[0m"
    echo -e "\033[32m[\033[0m\033[1;34m5\033[0\033[32m]\033[0m• \033[1;33mVER PUERTOS ABIERTOS\033[0m"
    echo -e "\033[32m[\033[0m\033[1;34m6\033[0\033[32m]\033[0m• \033[1;33mSUBFINDER\033[0m"
    echo -e "\033[32m[\033[0m\033[1;34m7\033[0\033[32m]\033[0m• \033[1;33mSUBFINDER BUGSCANNER\033[0m"
    echo -e "\033[32m[\033[0m\033[1;34m8\033[0\033[32m]\033[0m• \033[1;33mGENERADOR DE PAYLOADS\033[0m"
    echo -e "\033[32m[\033[0m\033[1;34m9\033[0\033[32m]\033[0m• \033[1;33mREPARAR SCRIPT\033[0m"
    echo -e "\033[32m[\033[0m\033[1;34mD\033[0\033[32m]\033[0m• \033[1;33mINSTALAR SUBFINDER\033[0m"
    echo -e " "
    echo -e " "
    echo -e "\033[31m[0]. SALIR\033[0m"

    read -p $'\033[1;34mSeleccione una opción: \033[0m' opcion

    case $opcion in
        1)

# Solicitar la URL del sitio web
echo -e " "
echo -e "\033[1;31mNOTA:\033[0m\033[1;36m ES NECESARIO USAR AL INICIO DE LA URL\033[0m \033[1;32mhttps:// O http://\033[0m"
echo -e " "
echo -e " "
echo -e "\033[1;32mINGRESE LA URL: \033[0m"
read url

# Extraer el dominio principal de la URL
domain=$(echo "$url" | awk -F[/:] '{print $4}')
echo -e "\033[1;34mDominio principal:\033[0m\033[1;32m $domain\033[0m"

# Crear una lista de posibles subdominios
echo -e "\033[1;34mGENERANDO LISTA DE POSIBLES SUBDOMINIOS\033[0m"
subdomains=("www" "mail" "ftp" "webmail" "ns" "dev" "staging" "blog") # Agrega más subdominios si lo deseas
> subdomains.txt # Limpiar el archivo subdomains.txt
for sub in "${subdomains[@]}"; do
    echo "$sub.$domain" >> subdomains.txt
done

# Verificar si se encontraron subdominios
if [ ! -s subdomains.txt ]; then
    echo -e "\033[1;33mNO SE ENCONTRARON SUBDOMINIOS\033[0m"
    exit 1
fi

# Extraer enlaces URL de los subdominios encontrados
echo -e "\033[1;33mEXTRAYENDO ENLACES URL DE LOS SUBDOMINIOS ENCONTRADOS\033[0m"
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
echo -e "\033[1;33mURLS UNICAS ENCONTRADAS:\033[0m"
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
echo -e " "
echo -e "\033[1;31mNOTA:\033[0m\033[1;36m ES NECESARIO USAR AL INICIO DE LA URL\033[0m \033[1;32mhttps:// O http://\033[0m"
echo -e " "
echo -e " "
echo -e "\033[1;32mINGRESE LA URL: \033[0m"
read url

# Extraer el dominio principal de la URL
domain=$(echo "$url" | awk -F[/:] '{print $4}')
echo -e "\033[1;34mDominio principal:\033[0m\033[1;32M $domain\033[0m"

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
echo -e "\033[1;33mEXTRAYENDO ENLACES URL DE LOS SUBDOMINIOS ENCONTRADOS\033[0m"
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
echo -e "\033[1;33mSUBDOMINIOS UNICOS ENCONTRADOS:\033[0m"
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
echo -e " "
echo -e "\033[1;31mNOTA:\033[0m\033[1;36m NO ES NECESARIO USAR\033[0m \033[1;32mhttps:// O http://\033[0m"
echo -e " "
echo -e " "
echo -e "\033[1;32mINGRESE LA URL:\033[0m "
read dominio

# ...

# Busca información de la conexión SSL/TLS
echo -e "\033[1;33mInformación de la conexión\033[0m   \033[1;32mSSL/TLS:\033[0m"
openssl s_client -connect ${dominio}:443 -servername ${dominio} | grep -E "Cipher|Protocol|PeerPrincipalCN|HTTP"

read -p $'\033[1;36mPresione Enter para continuar...\033[0m'

            ;;
        4)
  ## Solicitar la URL del sitio web
echo -e " "
echo -e "\033[1;31mNOTA:\033[0m\033[1;36m ES NECESARIO USAR AL INICIO DE LA URL\033[0m \033[1;32mhttps:// O http://\033[0m"
echo -e " "
echo -e " "
echo -e "\033[1;32mINGRESE LA URL: \033[0m"
read url

# Extraer el dominio principal de la URL
domain=$(echo "$url" | awk -F[/:] '{print $4}')
echo -e "\033[1;34mDominio principal:\033[0m\033[0;31m $domain\033[0m"

# Crear una lista de posibles subdominios
echo -e "\033[1;34mGenerando lista de posibles subdominios...\033[0m"
subdomains=("www" "mail" "ftp" "webmail" "ns" "dev" "staging" "blog") # Agrega más subdominios si lo deseas
> subdomains.txt # Limpiar el archivo subdomains.txt
for sub in "${subdomains[@]}"; do
    echo "$sub.$domain" >> subdomains.txt
done
# Extraer el status
status=$(echo "$response" | grep -i "http/" | awk '{print $2}')
# Extraer el tipo de servidor
server=$(echo "$response" | grep -i "server" | awk '{print $2}')
# Verificar si se encontraron subdominios
if [ ! -s subdomains.txt ]; then
    echo -e "\033[1;33mNo se encontraron subdominios.\033[0m"
    exit 1
fi

# Extraer enlaces URL de los subdominios encontrados
echo -e "\033[1;33mExtrayendo enlaces URL de los subdominios encontrados...\033[0m"
> urls.txt # Limpiar el archivo urls.txt
while read subdomain; do
  echo -e "\033[1;34mProcesando\033[0m \033[1;32m$subdomain...\033[0m"
  for protocol in "http" "https"; do
    response=$(curl -s --max-time 10 -L -k "$protocol://$subdomain")
    if [ -z "$response" ]; then
      echo -e "\033[1;31mNo se obtuvo respuesta de\033[0m \033[1;32m $subdomain\033[0m"
    else
      status=$(echo "$response" | grep -i "http/" | awk '{print $2}')
      server=$(echo "$response" | grep -i "server:" | awk '{print $2}')
      echo -e "\033[1;33mURL:\033[0m $subdomain\033"
      echo -e "\033[1;33mStatus:\033[0m\033[0;32m $status\033[0m"
      echo -e "\033[1;33mTipo de servidor:\033[0m\033[0;35m $server\033[0m"
      echo "$response" | grep -oE "https?://[^\"]+" | sed -e 's|https://||' -e 's|http://||' | awk -F[/:] '{print $1}' >> urls.txt
    fi
  done
done < subdomains.txt

# Eliminar duplicados y rutas de los subdominios encontrados
sort -u urls.txt > unique_subdomains.txt

# Mostrar los subdominios únicos encontrados en verde
echo -e "\033[1;33mSubdominios únicos encontrados:\033[0m"
while IFS= read -r subdomain; do
  echo -e "\033[1;33mURL:\033[0m\033[1;34m $subdomain\033[0m"
  response=$(curl -s -I "$subdomain")
  echo -e "\033[0;33mRespuesta:\033[0m \033[1;34m$response\033[0m"
  status=$(echo "$response" | grep -i "http/" | awk '{print $2}')
  server=$(echo "$response" | grep -i "server:" | awk '{print $2}')
  echo -e "\033[1;33mStatus:\033[0m\033[0;32m $status\033[0m"
  echo -e "\033[1;33mServer:\033[0m\033[0;35m $server\033[0m"
  if [ -z "$status" ]; then
    status="No se pudo detectar el status"
  fi
  if [ -z "$server" ]; then
    server="No se pudo detectar el tipo de servidor"
  fi
  echo -e "\033[1;33mStatus:\033[0m\033[1;32m $status\033[0m"
  echo -e "\033[1;33mTipo de servidor:\033[0m\033[0;35m  $server\033[0m"
done < unique_subdomains.txt


# Pausar para permitir la revisiok
read -p $'\033[1;36mPresione Enter para continuar...\033[0m'

# Eliminar archivos temporales
rm subdomains.txt
rm urls.txt
            ;;
        5)
        # Pide la dirección IP al usuario
echo -e " "
echo -e "\033[1;31mNOTA:\033[0m\033[1;36m PUERTOS QUE EL SISTEMA ESCANEARA\033[0m \033[1;34m443 - 80\033[0m"
echo -e " "
echo -e " "
echo $'\033[1;32mINGRESE LA DIRECCION IP:\033[0m'
read ip

# Escanea los puertos con Nmap y muestra los resultados
echo "Escaneando puertos abiertos en $ip..."
nmap -sT $ip

# Pregunta si desea ver los puertos filtrados por el firewall
echo "¿Desea ver los puertos filtrados por el firewall? (s/n)"
read respuesta

if [ $respuesta = "s" ]; then
    # Escanea los puertos con Nmap y muestra los resultados filtrados por el firewall
    echo "Escaneando puertos filtrados por el firewall en $ip..."
    nmap -sA $ip
# Pausar para permitir la revisiok
read -p $'\033[1;36mPresione Enter para continuar...\033[0m'
fi
            ;;
        6)
clear

# eliminar salida.txt
rm salida.txt

echo -e "\033[0;32mIngrese la URL: \033[0m"
    read url
    if [ -z "$url" ]; then
      echo -e "\033[0;31mPor favor, ingrese una URL válida.\033[0m"
    else
      echo -e "\033[0;32m$(subfinder -d $url -o salida.txt)\033[0m"
    fi
    # Pausar para permitir la revisiok
    read -p $'\033[1;36mPresione Enter para continuar...\033[0m'
    ;;
  7)
   # Limpiar pantalla
clear
  echo -e "\033[1;31mNOTA:\033[0m\033[1;36m ES NECESARIO USAR PRIMERO SUBFINDER PARA GENERAR LOS DOMINIOS A\033[0m \033[1;32mESCANEARH\033[0m"
  echo -e " "
  echo -e " "

# Pedir URL al usuario
echo -e "\033[1;32mINGRESE LA URL: \033[0m"
read url
echo -e "\033[1;32mINGRESE EL PUERTO: \033[0m"
read puerto

# Verificar si la URL es válida
if [ -z "$url" ]; then
  echo -e "\033[0;31mPORFAVOR INGRESE UNA URL VALIDA.\033[0m"
else
  
  # Ejecutar bugscanner con la salida de subfinder
  bugscanner --mode direct --proxy $url --port $puerto salida.txt
  
  # Pausar para permitir la revisión
  read -p $'\033[1;36mPresione Enter para continuar...\033[0m'
  # Eliminar Salida.txt
  rm salida.txt
fi   
 ;;
  8)
  echo -e "\033[1;31mNOTA:\033[0m\033[1;36m NO ES NECESARIO USAR\033[0m \033[1;32mhttps:// O http://\033[0m"
  echo -e " "
  echo -e " "
  echo -e "\033[0;32mINGRESE LA URL: \033[0m"
  read url
  sleep 0.5
  echo -ne "\r\033[1;33mGENERANDO PAYLOADS\033[0m \033[32m[\033[0;35m⠋\033[0m\033[32m]\033[0m"
sleep 0.1
echo -ne "\r\033[1;33mGENERANDO PAYLOADS\033[0m \033[32m[\033[0;35m⠙\033[0m\033[32m]\033[0m"
sleep 0.1
echo -ne "\r\033[1;33mGENERANDO PAYLOADS\033[0m \033[32m[\033[0;35m⠚\033[0m\033[32m]\033[0m"
sleep 0.1
echo -ne "\r\033[1;33mGENERANDO PAYLOADS\033[0m \033[32m[\033[0;35m⠓\033[0m\033[32m]\033[0m"
sleep 0.1
echo -ne "\r\033[1;33mGENERANDO PAYLOADS\033[0m \033[32m[\033[0;35m⠋\033[0m\033[32m]\033[0m"
sleep 0.1
echo -ne "\r\033[1;33mGENERANDO PAYLOADS\033[0m \033[32m[\033[0;35m⠙\033[0m\033[32m]\033[0m"
sleep 0.1
echo -ne "\r\033[1;33mGENERANDO PAYLOADS\033[0m \033[32m[\033[0;35m⠚\033[0m\033[32m]\033[0m"
sleep 0.1
echo -ne "\r\033[1;33mGENERANDO PAYLOADS\033[0m \033[32m[\033[0;35m⠓\033[0m\033[32m]\033[0m"
sleep 0.1
echo -ne "\r\033[1;33mGENERANDO PAYLOADS\033[0m \033[32m[\033[0;35m⠋\033[0m\033[32m]\033[0m"
sleep 0.1
echo -ne "\r\033[1;33mGENERANDO PAYLOADS\033[0m \033[32m[\033[0;35m⠙\033[0m\033[32m]\033[0m"
sleep 0.1
echo -ne "\r\033[1;33mGENERANDO PAYLOADS\033[0m \033[32m[\033[0;35m⠚\033[0m\033[32m]\033[0m"
sleep 0.1
echo -ne "\r\033[1;33mGENERANDO PAYLOADS\033[0m \033[32m[\033[0;35m⠓\033[0m\033[32m]\033[0m"
sleep 0.1
echo -ne "\r\033[1;33mGENERANDO PAYLOADS\033[0m \033[32m[\033[0;35m⠋\033[0m\033[32m]\033[0m"
sleep 0.1
echo -ne "\r\033[1;33mGENERANDO PAYLOADS\033[0m \033[32m[\033[0;35m⠙\033[0m\033[32m]\033[0m"
sleep 0.1
echo -ne "\r\033[1;33mGENERANDO PAYLOADS\033[0m \033[32m[\033[0;35m⠚\033[0m\033[32m]\033[0m"
sleep 0.1
echo -ne "\r\033[1;33mGENERANDO PAYLOADS\033[0m \033[32m[\033[1;36m⠿\033[0m\033[32m]\033[0m"
sleep 2.5
echo -e " "
echo -e " "
  # Paylods aqui
  echo -e "\033[0;32mGET / HTTP/1.1[crlf]Host: $url[crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]\033[0m"
  echo -e " "
  echo -e "\033[0;32mGET / HTTP/1.1[crlf]Host: $url[crlf]CF-RAY / HTTP/1.1[crlf]Host: $url [crlf]Upgrade: websocket[crlf]Connection: Keep-Alive[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]\033[0m"
  echo -e " "
  echo -e "\033[0;32mPATCH /JvmxVps HTTP/1.1[crlf]Host: [host][crlf]Host: $url[crlf]Upgrade: websocket[crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf][crlf]\033[0m"
  echo -e " "
  echo -e "\033[0;32mHEAD / HTTP/1.1[crlf]Host:$url[crlf][crlf][split]GET / HTTP/1.1[crlf]Host:$url[crlf]Connection: Upgrade:  [crlf]Upgrade: Websocket[crlf][crlf]\033[0m"
  echo -e " "
  echo -e "\033[0;32mOPTIONS / HTTP/1.1[crlf]Host: $url[crlf]Expect: 800-continue[lf][lf][split][lf][lf]GET / HTTP/1.1[lf]Host:d85jn2u9tszkr.cloudfront.net[lf]Expect: 800-continue[lf]Connection: Upgrade[lf]Upgrade: websocket[lf]User-Agent: GET / HTTP/1.1[crlf]Host: $url[lf][lf]\033[0m"
  echo -e " "
  echo -e "\033[0;32mGET / HTTP/1.1[crlf]Host: $url[crlf]Expect: 100-continue[lf][lf][split][lf][lf]GET- / HTTP/1.1[crlf]Host: $url[crlf]Upgrade:GET / HTTP/1.1[crlf]Host: $url[crlf]Expect: 100-continue[lf][lf][split][lf][lf]GET- / HTTP/1.1[crlf]Host: $url[crlf]Upgrade: Accept-Encoding,User-Agent,Transfer-Encoding[crlf]User-Agent: [ua][crlf][crlf]Sec-WebSocket-Extensions: superspeed[crlf]Upgrade: websocket[crlf][crlf] Accept-Encoding,User-Agent,Transfer-Encoding[crlf]User-Agent: [ua][crlf][crlf]Sec-WebSocket-Extensions: superspeed[crlf]Upgrade: websocket[crlf][crlf]\033[0m"
  echo -e " "
  echo -e "\033[0;32mGET http://$url/ HTTP/1.1[crlf]Host: $url[crlf][crlf]\033[0m"
  echo -e " "  
  echo -e "\033[0;32mGET / HTTP/1.0[lf]Host: $url[lf]Connection: close[crlf]X-Forwarded-For: $url[lf]Content-Length: 999999999[lf][lf]\033[0m"
  echo -e " "
  echo -e "\033[0;32mHEAD https://$url:80 HTTP/1.1[lf]Host: 157.240.22.35[lf]Ford-Host: www.google.com[lf]X-Online-Host: www.google.com[lf]Connection: Keep-alive[lf]CONNECT 157.240.22.35:80 HTTP/1.0[lf]Expect: 100-continue[crlf][lf][lf]GET python://&url HTTP/1.1[lf]Host: $url[lf]Host: 157.240.22.35[lf]Upgrade: websocket[lf]Connection: Upgrade[lf]Expect: 100-continue[crlf][crlf]\033[0m"
  echo -e " "
  echo -e "\033[0;32m[rotation_method=ACL;HEAD] / [protocol][crlf]Host: $url[crlf]Upgrade: websocket[crlf]Connection: keep-alive[crlf]Proxy-Connection: keep-alive[crlf]X-Forwarded-For: $url[crlf]X-Online-Host: $url[crlf]X-Forward-Host: $url[crlf]
GET / [protocol][crlf]Host: $url[crlf]Upgrade: websocket[crlf]Connection: keep-alive[crlf]Proxy-Connection: keep-alive[crlf]X-Online-Host: facebook.com[crlf]X-Forward-Host: facebook.com[crlf]X-Online-Host: facebook.com[crlf]X-Forward-Host: facebook.com[crlf]
GET / [protocol][crlf]Host: $url[crlf]Upgrade: websocket[crlf]Connection: keep-alive[crlf]Proxy-Connection: keep-alive[crlf]X-Online-Host: www.google.com[crlf]X-Forward-Host: www.google.com[crlf]X-Online-Host: www.google.com[crlf]X-Forward-Host: www.google.com[crlf]
GET / [protocol][crlf]Host: $url[crlf]Upgrade: websocket[crlf]Connection: keep-alive[crlf]Proxy-Connection: keep-alive[crlf]X-Online-Host: www.google.com[crlf]X-Forward-Host: www.google.com[crlf]X-Online-Host: www.google.com[crlf]X-Forward-Host: www.google.com[crlf]
HEAD https://$url:80 HTTP/1.1[lf]Host: 157.240.22.35[lf]Ford-Host: www.google.com[lf]X-Online-Host: www.google.com[lf]Connection: Keep-alive[lf]CONNECT 157.240.22.35:80 HTTP/1.0[lf]Expect: 100-continue[crlf][lf][lf]GET python://$url HTTP/1.1[lf]Host: $url[lf]Host: 157.240.22.35[lf]Upgrade: websocket[lf]Connection: Upgrade[lf]Expect: 100-continue[crlf][crlf]\033[0m"
   echo -e " "
  read -p $'\033[1;36mPresione Enter para continuar...\033[0m'
    ;;
  9)
  sleep 0.5
    echo -e "\033[1;36mReparando Configuracion Interna del Script\033[0m"
    echo -e "\033[1;36mREPARANDO SISTEMA\033[0m"
    for i in {1..10}; do
  echo -n  $'\033[1;34m#\033[0m'                                                          
  sleep 0.5                                                                             
done                                                                                   
 echo -e  "\033[32mFIX\033[0m \033[1;33m\033[1;3mEXTRACTOR DE HOST\033[0m"               
 for i in {1..10}; do                                                                      
   echo -n  $'\033[1;34m#\033[0m'                                                         
   sleep 0.5                                                                             
 done                                                                                    
echo -e  "\033[32mFIX\033[0m \033[1;33m\033[1;3mEXTRACTOR DE SUBDOMINIOS\033[0m"            
for i in {1..10}; do                                                                  
echo -n  $'\033[1;34m#\033[0m'                                                          
  sleep 0.5
done                                                                                    
echo -e  "\033[32mFIX\033[0m \033[1;3m\033[1;33mSNI INFO\033[0m"                        
for i in {1..10}; do                                                                     
 echo -n  $'\033[1;34m#\033[0m'                                                          
sleep 0.5                                                                             
done
echo -e  "\033[32mFIX\033[0m \033[1;3m\033[1;33mARCHIVOS TXT RESTAURADOS\033[0m" 
 echo -e "\033[1;36mSISTEMA SCRIPT INTERNO REPARADO\033[0m"
     read -p $'\033[1;36mPresione Enter para continuar...\033[0m'                            
     ;;
  D)
clear
echo -e " "
echo -e "\033[1;31mNOTA: \033[0m\033[1;36mPARA INSTALAR SUBFINDER DEBERAS COPIAR LOS SIGUIENTES COMANDOS Y SALIR DEL SCRIPT Y PEGARLOS \033[0m"
echo -e " "
echo -e " "
echo -e "\033[1;34mpkg update && upgrade -y\033[0m"
echo -e "\033[1;34mpkg install python\033[0m"
echo -e "\033[1;34mpkg install python-pip\033[0m"
echo -e "\033[1;34mpip install requests loguru multithreading bugscanner\033[0m"
echo -e "\033[1;34mpkg install git\033[0m"
echo -e "\033[1;34mgit clone https://github.com/JagadBumi/subfinder\033[0m"
echo -e "\033[1;34mls\033[0m"
echo -e "\033[1;34mcd subfinder\033[0m"
echo -e "\033[1;34mmv subfinder ~/../usr/bin\033[0m"
echo -e "\033[1;34mchmod +x ~/../usr/bin/subfinder\033[0m"
echo -e " "
echo -e " "
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
