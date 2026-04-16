# WordPress + MySQL + Redis Docker Compose Setup

## 📋 Deskripsi Project

Project ini adalah implementasi multi-container setup menggunakan Docker Compose dengan tiga services:
- **WordPress**: CMS untuk membuat website
- **MySQL**: Database untuk menyimpan data WordPress
- **Redis**: In-memory cache untuk meningkatkan performa WordPress

## 🏗️ Arsitektur

```
┌─────────────────────────────────────────┐
│     Docker Compose Network              │
├─────────────────────────────────────────┤
│                                         │
│  ┌──────────────┐  ┌──────────────┐   │
│  │  WordPress   │  │    MySQL     │   │
│  │  :8000       │  │    :3306     │   │
│  └──────────────┘  └──────────────┘   │
│         │                  │            │
│         └──────────────────┘            │
│                                         │
│  ┌──────────────┐                      │
│  │    Redis     │                      │
│  │   :6379      │                      │
│  └──────────────┘                      │
│                                         │
└─────────────────────────────────────────┘
```

## 📦 Volume Persistence

| Service | Volume | Path | Tujuan |
|---------|--------|------|--------|
| WordPress | wordpress_data | /var/www/html | Menyimpan file WordPress, tema, plugin |
| MySQL | mysql_data | /var/lib/mysql | Menyimpan database |
| Redis | redis_data | /data | Persistence dump RDB |

## 🔗 Service Dependencies

```
WordPress ──depends_on──> MySQL
```

WordPress akan menunggu MySQL ready sebelum starts. Tanpa ini, WordPress akan error saat mencoba connect ke database.

## 🌐 Docker Networking

Service-service berkomunikasi melalui `wordpress_network` (bridge network):
- **WordPress** → **MySQL**: hostname `mysql` (port 3306)
- **WordPress** → **Redis**: hostname `redis` (port 6379)

Tidak perlu menggunakan IP address, Docker DNS otomatis resolve hostname ke IP container.

## 📱 Environment Variables

### WordPress
```
WORDPRESS_DB_HOST: mysql           # Hostname MySQL container
WORDPRESS_DB_NAME: wordpress_db    # Nama database
WORDPRESS_DB_USER: wordpress_user  # Username database
WORDPRESS_DB_PASSWORD: wordpress_password  # Password database
```

### MySQL
```
MYSQL_ROOT_PASSWORD: root_password      # Root password
MYSQL_DATABASE: wordpress_db            # Database untuk WordPress
MYSQL_USER: wordpress_user              # User untuk WordPress
MYSQL_PASSWORD: wordpress_password      # Password user
```

## 🚀 Cara Menjalankan

### Prerequisite
- Docker Desktop installed dan running
- Terminal/Command Prompt

### Step 1: Navigate ke project directory
```bash
cd c:\Users\ASUS\Documents\KULIAH\PSS
```

### Step 2: Start containers
```bash
docker-compose up -d
```

Output yang diharapkan:
```
Creating network "pss_wordpress_network" with driver "bridge"
Creating volume "pss_wordpress_data" with local driver
Creating volume "pss_mysql_data" with local driver
Creating volume "pss_redis_data" with local driver
Creating mysql_db ... done
Creating wordpress_app ... done
Creating redis_cache ... done
```

### Step 3: Check container status
```bash
docker-compose ps
```

Semua 3 services harus dalam status "Up":
```
NAME                COMMAND                  SERVICE             STATUS
mysql_db            "docker-entrypoint.s…"   mysql               Up 2 minutes
redis_cache         "redis-server --appe…"   redis               Up 2 minutes
wordpress_app       "docker-entrypoint.s…"   wordpress           Up 2 minutes
```

### Step 4: Tunggu MySQL siap (2-3 detik)
```bash
docker-compose logs mysql
```

Cari baris yang berisi: `ready for connections`

### Step 5: Akses WordPress
Buka browser ke: http://localhost:8000

Anda akan melihat halaman WordPress installation wizard.

## 🎯 Testing & Verification

### Test 1: WordPress Installation (5-10 menit)
1. Go to http://localhost:8000
2. Pilih bahasa (Bahasa Indonesia)
3. Isi form:
   - Site Title: "My WordPress Site"
   - Username: "aubindaffa"
   - Password: "Suksesdi2030"
   - Email: "aubindaffaa321@gmail.com"
4. Klik "Install WordPress"
5. Login dengan aubindaffa / Suksesdi2030

### Test 2: Create Post/Page (Verify Database Connection)
1. Login ke WordPress dashboard
2. Go to Posts → Add New
3. Judul: "Test Post"
4. Content: "This is a test post to verify database connection"
5. Publish

**Result**: Jika post berhasil published, berarti WordPress ↔ MySQL connection OK ✓

### Test 3: MySQL Connection dari CLI
```bash
# Access MySQL container
docker exec -it mysql_db mysql -u wordpress_user -p

# Prompt untuk password, ketik: wordpress_password

# Di MySQL CLI, jalankan:
USE wordpress_db;
SELECT * FROM wp_posts;
```

Anda akan melihat post yang tadi dibuat ✓

### Test 4: Redis Connection
```bash
# Access Redis container
docker exec -it redis_cache redis-cli

# Di Redis CLI, jalankan:
PING
```

Expected output: `PONG` ✓

### Test 5: Volume Persistence
1. Buat file test di WordPress container:
```bash
docker exec wordpress_app bash -c "echo 'test' > /var/www/html/test.txt"
```

2. Stop containers:
```bash
docker-compose down
```

3. Start lagi:
```bash
docker-compose up -d
```

4. Check file masih ada:
```bash
docker exec wordpress_app cat /var/www/html/test.txt
```

Output: `test` → Volume persistence working ✓

## 🔧 Redis Object Cache Setup (Bonus)

### Step 1: Install Redis Object Cache Plugin
```bash
# Download plugin
docker exec wordpress_app bash -c "cd /var/www/html/wp-content/plugins && wget https://downloads.wordpress.org/plugin/redis-cache.latest-stable.zip && unzip redis-cache.latest-stable.zip && rm redis-cache.latest-stable.zip"
```

Atau via WordPress Admin:
1. Dashboard → Plugins → Add New
2. Search: "Redis Object Cache"
3. Author: "Till Krüss"
4. Klik Install dan Activate

### Step 2: Update wp-config.php
```bash
docker exec wordpress_app bash -c "cat >> /var/www/html/wp-config.php << 'EOF'

// Redis Object Cache Configuration
define('WP_REDIS_HOST', 'redis');
define('WP_REDIS_PORT', 6379);
define('WP_REDIS_TIMEOUT', 1);
define('WP_REDIS_READ_TIMEOUT', 1);
define('WP_REDIS_DATABASE', 0);
define('WP_CACHE', true);
define('WP_CACHE_KEY_SALT', 'wordpress_');
EOF
"
```

### Step 3: Enable Object Cache
Di WordPress Dashboard:
1. Settings → Redis
2. Klik "Enable Object Cache"
3. Verify connection status

### Step 4: Test Redis Cache
```bash
docker exec redis_cache redis-cli

# Di Redis CLI:
DBSIZE              # Lihat jumlah keys
KEYS *              # Lihat semua keys
GET wp_*            # Lihat cache values
```
## Screenshot ##
1. Screenshot WordPress installation page
Mohon maaf kelupaan, sudah terlanjur bikin akun
2. Screenshot WordPress dashboard
![WordPress Dashboard](Screenshot/wp-dashboard.png)
3. Screenshot docker ps menunjukkan 3 containers running
![Docker PS Output](Screenshot/Container-docker.png)
4. Screenshot Redis CLI ping test
![Redis PING Respon](Screenshot/Redis-ping.png)

## ❓ Jawaban Pertanyaan

### 1. Kenapa perlu volume untuk MySQL?
**Jawab**: 
- Container bersifat ephemeral (sementara)
- Tanpa volume, ketika container dihapus, semua data hilang
- Volume memetakan `/var/lib/mysql` dari container ke disk host
- Data tetap persisten meskipun container restart atau dihapus
- Ini memastikan data aplikasi aman dan tidak hilang

### 2. Apa fungsi `depends_on`?
**Jawab**:
- `depends_on` menentukan urutan startup container
- WordPress service akan wait sampai MySQL service started
- Tanpa ini, WordPress mungkin startup lebih dulu sebelum MySQL ready
- MySQL akan error karena PostgreSQL belum running, SQL connection failure
- `depends_on` hanya untuk startup order, bukan untuk "wait until ready"
- Untuk "wait until ready", perlu additional startup script dengan health checks

### 3. Bagaimana cara WordPress container connect ke MySQL?
**Jawab**: 
- WordPress menggunakan environment variable: `WORDPRESS_DB_HOST: mysql`
- Bukan IP address, tapi hostname `mysql` (nama service di compose file)
- Docker DNS internal menyelesaikan hostname ke IP container MySQL
- Network `wordpress_network` memungkinkan containers saling ping by name
- Port 3306 (default MySQL) diakses via internal network, tidak expose ke host

### 4. Apa keuntungan pakai Redis untuk WordPress?
**Jawab**:
- **Performance**: Cache object di memory, lebih cepat dari database
- **Reduce Database Load**: Query results tersimpan di Redis, kurangi query ke MySQL
- **Scalability**: Bisa handle lebih banyak concurrent users
- **Session Storage**: Simpan user sessions di Redis (faster)
- **Page Caching**: Cache halaman yang frequently accessed
- **Typical Result**: Page load time berkurang 50-70%

## 📊 Monitoring

### View logs
```bash
# Semua services
docker-compose logs

# Specific service
docker-compose logs wordpress
docker-compose logs mysql
docker-compose logs redis

# Follow logs (real-time)
docker-compose logs -f wordpress

# Last 100 lines
docker-compose logs --tail=100
```

### View stats
```bash
# CPU dan Memory usage
docker stats
```

## 🛑 Cleanup Commands

```bash
# Stop containers (data preserved)
docker-compose stop

# Start containers again
docker-compose start

# Stop dan remove containers (data preserved via volumes)
docker-compose down

# Stop, remove containers, dan DELETE all volumes
docker-compose down -v

# Remove stopped containers dan unused images
docker system prune

# Full cleanup (containers, volumes, images)
docker system prune -a --volumes
```

## 🐛 Troubleshooting

### WordPress blank page
- Check logs: `docker-compose logs wordpress`
- Verify MySQL running: `docker-compose ps`
- Restart: `docker-compose restart wordpress`

### MySQL connection error
- Check environment variables di docker-compose.yml
- Verify MySQL running: `docker exec mysql_db mysql -u root -p < /dev/null`
- Check network: `docker network ls`

### Redis not working
- Check port: `docker exec redis_cache netstat -tlnp`
- Test connection: `docker exec redis_cache redis-cli ping`

### Port already in use
- Change port in docker-compose.yml
- Dari: `"8000:80"` ke `"8001:80"` atau port lain

### Permission denied errors
- Restart Docker daemon
- Run terminal as Administrator (Windows)

## 📝 File Structure

```
PSS/
├── docker-compose.yml       # Main compose configuration
├── README.md               # This file
└── .env                   # (Optional) Environment variables file
```

## 📚 Referensi

- [WordPress Docker Hub](https://hub.docker.com/_/wordpress)
- [MySQL Docker Hub](https://hub.docker.com/_/mysql)
- [Redis Docker Hub](https://hub.docker.com/_/redis)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Docker Networking](https://docs.docker.com/network/)

