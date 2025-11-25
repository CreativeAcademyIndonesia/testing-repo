1. Buat Dockerfile -> sebuah container untuk php + laravel
2. Buat docker-compose.yml 
3. Buat file konfigurasi nginx docker/nginx/default.conf

6. Publish dulu ke github.
7. Clone di var/www 

8. cp .env.example .env
9. setting env 

CACHE_DRIVER=file
SESSION_DRIVER=file
MARIADB_USER: laravel_user
MARIADB_PASSWORD: secret123 

10. Lanjut ke VPS 
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

11. docker compose up -d --build
12. docker ps
docker exec -it laravel_app composer install --no-dev --optimize-autoloader
docker exec -it laravel_app php artisan key:generate
docker exec -it laravel_app php artisan config:clear
docker exec -it laravel_app php artisan cache:clear
docker exec -it laravel_app php artisan migrate --force
