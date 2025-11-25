1. Buat Dockerfile -> sebuah container untuk php + laravel
2. Buat docker-compose.yml 
3. Buat file konfigurasi nginx docker/nginx/default.conf
4. setting .env hapus appkey dan dbhost bukan ke 127.0.0.1

6. Publish dulu ke github.
7. Clone di var/www 
8. cp .env.example .env
5. Lanjut ke VPS 
# Update sistem
sudo apt update && sudo apt upgrade -y

# Install paket pendukung
sudo apt install -y ca-certificates curl gnupg

# Tambah repository Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Optional: biar bisa pakai 'docker' tanpa sudo
sudo usermod -aG docker $USER