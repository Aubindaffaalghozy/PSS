#!/bin/bash
# Setup script untuk Redis Object Cache di WordPress
# Jalankan dari directory project dengan: bash setup-redis.sh

echo "================================"
echo "Redis Object Cache Setup"
echo "================================"

# Check if containers running
echo ""
echo "1. Checking containers status..."
docker-compose ps

echo ""
echo "2. Installing Redis Object Cache plugin..."

# Download dan extract Redis Object Cache plugin
docker exec wordpress_app bash -c "
  cd /var/www/html/wp-content/plugins
  if [ -d 'redis-cache' ]; then
    echo 'Plugin sudah exists'
  else
    wget -q https://downloads.wordpress.org/plugin/redis-cache.latest-stable.zip
    unzip -q redis-cache.latest-stable.zip
    rm redis-cache.latest-stable.zip
    echo 'Plugin berhasil diinstall'
  fi
"

echo ""
echo "3. Verifying WordPress directory structure..."
docker exec wordpress_app bash -c "
  echo 'WordPress installed at:'
  ls -la /var/www/html/ | head -20
"

echo ""
echo "4. Adding Redis configuration to wp-config.php..."
docker exec wordpress_app bash -c "
  CONFIG_FILE='/var/www/html/wp-config.php'
  
  # Check if Redis config sudah ada
  if grep -q 'WP_REDIS_HOST' \$CONFIG_FILE; then
    echo 'Redis configuration sudah ada'
  else
    cat >> \$CONFIG_FILE << 'REDIS_CONFIG'

// Redis Object Cache Configuration
define('WP_REDIS_HOST', 'redis');
define('WP_REDIS_PORT', 6379);
define('WP_REDIS_TIMEOUT', 1);
define('WP_REDIS_READ_TIMEOUT', 1);
define('WP_REDIS_DATABASE', 0);
define('WP_CACHE', true);
define('WP_CACHE_KEY_SALT', 'wordpress_');
REDIS_CONFIG
    echo 'Redis configuration berhasil ditambahkan'
  fi
"

echo ""
echo "5. Testing Redis connection..."
docker exec redis_cache redis-cli <<< "PING" | grep PONG && echo "✓ Redis connection OK" || echo "✗ Redis connection FAILED"

echo ""
echo "6. Setup Complete!"
echo "================================"
echo "Next steps:"
echo "1. Go to http://localhost:8000/wp-admin"
echo "2. Activate 'Redis Object Cache' plugin"
echo "3. Go to Settings → Redis"
echo "4. Click 'Enable Object Cache'"
echo ""
echo "To verify Redis caching:"
echo "docker exec redis_cache redis-cli DBSIZE"
echo "docker exec redis_cache redis-cli KEYS '*'"
echo "================================"
