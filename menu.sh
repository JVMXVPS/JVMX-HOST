#!/bin/bash
while true
do                                                                                                       clear
echo -e "\e[36m──────────────────────────────────────\e[0m"
echo -e "\e[36m░░░░░██╗██╗░░░██╗███╗░░░███╗██╗░░██╗\e[0m"
echo -e "\e[36m░░░░░██║██║░░░██║████╗░████║╚██╗██╔╝\e[0m"
echo -e "\e[36m░░░░░██║╚██╗░██╔╝██╔████╔██║░╚███╔╝░\e[0m"
echo -e "\e[36m██╗░░██║░╚████╔╝░██║╚██╔╝██║░██╔██╗░\e[0m"
echo -e "\e[36m╚█████╔╝░░╚██╔╝░░██║░╚═╝░██║██╔╝╚██╗\e[0m"
echo -e "\e[36m░╚════╝░░░░╚═╝░░░╚═╝░░░░░╚═╝╚═╝░░╚═╝\e[0m"
echo -e "\e[36m──────────────────────────────────────\e[0m"
echo -e "\e[33mDESARROLLADOR\033[0m \e[91m@JVMXVPS\e[0m"
echo -e "\e[33mVERCION:\033[0m \e[91m9.0\e[0m"
echo -e "\e[33mULTIMA ACTUALIZACION:\033[0m \e[91m18:08:24\e[0m"
echo -e "\e[36m──────────────────────────────────────\e[0m"
echo -e "\e[32mPANEL SECUNDARIO\e[0m"
echo -e "\e[36m──────────────────────────────────────\e[0m"
echo -e "\e[34mOPCIONES:\e[0m"
echo -e "\e[92m[1]\033[0m SUBLIST3R"
echo -e "\e[92m[2]\033[0m SUBLIST3R + PUERTO"
echo -e "\e[92m[3]\033[0m SUBLIST3R BUGSCANNER + PUERTO"
echo -e "\e[92m[4]\033[0m EXTRAER DNS/dig"
echo -e "\e[92m[5]\033[0m HEADER/URL EXTRACTOR"
echo -e "\e[92m[D]\033[0m INSTALAR SUBLIST3R"
echo -e "\e[36m──────────────────────────────────────\e[0m"
echo -e "\e[92m[0]\033[0m REGRESAR                 \e[92m[H]\033[0m CREDITOS"
read -p  "Seleccione una opción: " opcion
    case $opcion in
         1)
         # nota
         echo -e "\033[1;31mNOTA:\033[0m\033[1;36mNO ES NECESARIO USAR AL INICIO DE LA URL\033[0m \033[1;32mhttps:// O http://\033[0m"
         # borrar salida txt
         rm -rf salidaS3r.txt
         # beta sublist3r
         echo -e "\033[1;32mINGRESE LA URL: \033[0m"
         read url
         sublist3r -d $url -o salidaS3r.txt
         read -p $'\033[1;36mPresione Enter para continuar...\033[0m'
         ;;
         2)
         # borrar salida txt
         rm -rf salidaS3r.txt
         # nota
           echo -e "\033[1;31mNOTA:\033[0m\033[1;36mNO ES NECESARIO USAR AL INICIO DE LA URL\033[0m \033[1;32mhttps:// O http://\033[0m"
         # beta sublist3r puertos
         echo -e "\033[1;32mINGRESE LA URL: \033[0m"
         read url
         echo -e "\033[1;32mINGRESE EL PUERTO: \033[0m"
         read puerto
         sublist3r -p $puerto -d $url -o salidaS3r.txt
         read -p $'\033[1;36mPresione Enter para continuar...\033[0m'
         ;;
         3)
              # betap sublist3r puertos
         echo -e "\033[1;32mINGRESE LA URL: \033[0m"
         read url
         echo -e "\033[1;32mINGRESE EL PUERTO: \033[0m"
         read puerto
         bugscanner --mode direct --proxy $url --port $puerto salidaS3r.txt
         read -p $'\033[1;36mPresione Enter para continuar...\033[0m'
         # borrar salida txt
         rm -rf salidaS3r.txt
         ;;
         4)
         # Ask the user for a URL
         echo -e "\033[1;32mINGRESE LA URL: \033[0m"
         read url

         # Remover los http y https
         url=${url#*://}

         # dns aqui webon
         echo "REGISTROS DNS DE -> $url:"
         dig $url
         # esperar y spectear
         read -p $'\033[1;36mPresione Enter para continuar...\033[0m'
         ;;
         5)
         # borrar txt
         rm -rf urls1.txt

         # Pedir url
         echo -e "\033[1;31mNOTA:\033[0m\033[1;36mNO ES NECESARIO USAR AL INICIO DE LA URL\033[0m \033[1;32mhttps:// O http://\033[0m"
         echo -e "\033[1;32mINGRESE LA URL: \033[0m"
         read host

         # petición HTTP y obtener el header
         header=$(curl -s -I -L -v $host)

         # urls encontradas
         urls=$(echo "$header" | grep -oE '(https?://[^ ]+|www\.[^ ]+|[a-zA-Z0-9.-]+\.com|[a-zA-Z0-9.-]+\.net|[a-zA-Z0-9.-]+\.org)')

         # Guardar aqui
         echo "$urls" > urls1.txt

#ESPERAR
clear
echo -e "\033[1;36mURLS ENCONTRADAS HEADER\033[0m"
echo -e "\033[1;32m"
cat urls1.txt
echo -e "\033[0m"
read -p $'\033[1;36mPresione Enter para continuar...\033[0m'
#borrar al salir
rm -rf urls1.txt
         ;;
         H)
  #Creditos Insanos xd
  clear
  echo -e "\e[91mAVISO!\033[0m \e[92mTodos los creditos van dirigidos hacia mi Jvmx Vps yo me encargue de crear cada fragmento del script desde cero no hay ningun colaborador, yo desarrolle y adapte cada estructura al script\033[0m"
  echo -e "\e[92mDev:\033[0m \e[91m@JVMXVPS\033[0m"
  echo -e "\e[92mOrigen:\033[0m \e[91mMexico\033[0m"
  echo -e "\e[92mScript:\033[0m \e[91mJVMX-HOST\033[0m"
  echo -e "\e[92mVercion:\033[0m \e[91m9.0\033[0m"
  echo -e "\e[92mActualizacion:\033[0m \e[91m18:08:24\033[0m"
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
