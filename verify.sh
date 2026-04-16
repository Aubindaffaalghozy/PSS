#!/bin/bash
# Verification script untuk Docker Compose setup
# Jalankan: bash verify.sh

echo "╔════════════════════════════════════════════════════╗"
echo "║   Docker Compose Setup Verification Script        ║"
echo "╚════════════════════════════════════════════════════╝"

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

PASS_COUNT=0
FAIL_COUNT=0
WARN_COUNT=0

# Function to print results
check_pass() {
  echo -e "${GREEN}✓${NC} $1"
  ((PASS_COUNT++))
}

check_fail() {
  echo -e "${RED}✗${NC} $1"
  ((FAIL_COUNT++))
}

check_warn() {
  echo -e "${YELLOW}⚠${NC} $1"
  ((WARN_COUNT++))
}

# 1. Check Docker installation
echo ""
echo "1. Checking Docker Installation..."

if command -v docker &> /dev/null; then
  check_pass "Docker is installed"
  docker_version=$(docker --version)
  echo "   Version: $docker_version"
else
  check_fail "Docker is not installed"
fi

# 2. Check Docker Compose installation
echo ""
echo "2. Checking Docker Compose Installation..."

if command -v docker-compose &> /dev/null; then
  check_pass "Docker Compose is installed"
  compose_version=$(docker-compose --version)
  echo "   Version: $compose_version"
else
  check_fail "Docker Compose is not installed"
fi

# 3. Check Docker daemon
echo ""
echo "3. Checking Docker Daemon..."

if docker ps &> /dev/null; then
  check_pass "Docker daemon is running"
else
  check_fail "Docker daemon is not running"
fi

# 4. Check docker-compose.yml exists
echo ""
echo "4. Checking Configuration Files..."

if [ -f "docker-compose.yml" ]; then
  check_pass "docker-compose.yml exists"
else
  check_fail "docker-compose.yml not found"
fi

if [ -f "README.md" ]; then
  check_pass "README.md exists"
else
  check_warn "README.md not found"
fi

# 5. Check containers status
echo ""
echo "5. Checking Containers..."

RUNNING=$(docker-compose ps --services | wc -l)

if [ $RUNNING -eq 3 ]; then
  check_pass "All 3 services are running"
  
  echo "   Service Status:"
  docker-compose ps --format "table {{.Service}}\t{{.Status}}" | tail -n +2 | while read line; do
    echo "   - $line"
  done
else
  check_warn "Some services are not running (Found: $RUNNING, Expected: 3)"
  docker-compose ps
fi

# 6. Check WordPress connectivity
echo ""
echo "6. Checking WordPress..."

if docker exec wordpress_app test -d /var/www/html 2>/dev/null; then
  check_pass "WordPress directory exists"
  
  if docker exec wordpress_app test -f /var/www/html/wp-config.php 2>/dev/null; then
    check_pass "WordPress config file exists"
  else
    check_warn "WordPress config file not found (normal before installation)"
  fi
else
  check_fail "WordPress directory not accessible"
fi

# 7. Check MySQL connectivity
echo ""
echo "7. Checking MySQL..."

if docker exec mysql_db mysql -u wordpress_user -pwordpress_password -e "SELECT 1" 2>/dev/null | grep -q "1"; then
  check_pass "MySQL is accessible"
  
  # Check if database exists
  if docker exec mysql_db mysql -u wordpress_user -pwordpress_password -e "USE wordpress_db; SELECT 1" 2>/dev/null | grep -q "1"; then
    check_pass "WordPress database exists"
  else
    check_fail "WordPress database not found"
  fi
else
  check_fail "MySQL is not accessible"
fi

# 8. Check Redis connectivity
echo ""
echo "8. Checking Redis..."

if docker exec redis_cache redis-cli ping 2>/dev/null | grep -q "PONG"; then
  check_pass "Redis is accessible (PING successful)"
  
  # Check Redis memory usage
  REDIS_MEMORY=$(docker exec redis_cache redis-cli INFO memory 2>/dev/null | grep used_memory_human | cut -d: -f2 | tr -d '\r')
  if [ -n "$REDIS_MEMORY" ]; then
    echo "   Memory usage: $REDIS_MEMORY"
  fi
else
  check_fail "Redis is not accessible"
fi

# 9. Check volumes
echo ""
echo "9. Checking Volumes..."

VOLUME_COUNT=$(docker volume ls | grep -E "wordpress_data|mysql_data|redis_data" | wc -l)

if [ $VOLUME_COUNT -eq 3 ]; then
  check_pass "All 3 volumes are created"
  echo "   Volumes:"
  docker volume ls | grep -E "wordpress_data|mysql_data|redis_data" | awk '{print "   - " $2}'
else
  check_warn "Some volumes missing (Found: $VOLUME_COUNT, Expected: 3)"
fi

# 10. Check network
echo ""
echo "10. Checking Network..."

if docker network ls | grep -q "wordpress_network"; then
  check_pass "WordPress network exists"
  
  # Check if all containers are in network
  NETWORK_CONTAINERS=$(docker network inspect wordpress_network 2>/dev/null | grep -c "\"Name\": \"wordpress_app\|mysql_db\|redis_cache\"")
  if [ $NETWORK_CONTAINERS -eq 3 ]; then
    check_pass "All containers are in the network"
  else
    check_warn "Some containers not in network"
  fi
else
  check_fail "WordPress network not found"
fi

# 11. Check ports
echo ""
echo "11. Checking Port Availability..."

# Check WordPress port
if netstat -ano 2>/dev/null | grep -q ":8000"; then
  check_pass "WordPress port 8000 is open"
else
  check_warn "WordPress port 8000 may not be listening yet"
fi

# Check Redis port
if netstat -ano 2>/dev/null | grep -q ":6379"; then
  check_pass "Redis port 6379 is open"
else
  check_warn "Redis port 6379 may not be listening yet"
fi

# 12. Check WordPress HTTP connectivity
echo ""
echo "12. Checking WordPress HTTP Connectivity..."

if curl -s -I http://localhost:8000/ | grep -q "HTTP"; then
  check_pass "WordPress is responding to HTTP requests"
  
  # Check WordPress title
  TITLE=$(curl -s http://localhost:8000/ | grep -o "<title>[^<]*</title>" | sed 's/<[^>]*>//g')
  if [ -n "$TITLE" ]; then
    echo "   Page title: $TITLE"
  fi
else
  check_warn "WordPress may not be responding yet (normal during startup)"
fi

# Summary
echo ""
echo "╔════════════════════════════════════════════════════╗"
echo "║   Verification Summary                            ║"
echo "╚════════════════════════════════════════════════════╝"

echo ""
echo -e "${GREEN}Passed:${NC}  $PASS_COUNT"
echo -e "${RED}Failed:${NC}   $FAIL_COUNT"
echo -e "${YELLOW}Warnings:${NC} $WARN_COUNT"

echo ""

if [ $FAIL_COUNT -eq 0 ]; then
  echo -e "${GREEN}✓ All checks passed!${NC}"
  echo ""
  echo "Next steps:"
  echo "1. Visit http://localhost:8000 to access WordPress"
  echo "2. Run WordPress installation wizard"
  echo "3. Create posts/pages to test database"
  echo "4. Check Redis via: docker exec redis_cache redis-cli DBSIZE"
  exit 0
elif [ $FAIL_COUNT -gt 0 ]; then
  echo -e "${RED}✗ Some checks failed. Please fix the issues and try again.${NC}"
  echo ""
  echo "Troubleshooting tips:"
  echo "1. Check logs: docker-compose logs"
  echo "2. Restart containers: docker-compose restart"
  echo "3. Check port conflicts: netstat -ano"
  echo "4. View container details: docker ps -a"
  exit 1
else
  echo -e "${YELLOW}⚠ Verification completed with warnings. You may proceed with caution.${NC}"
  exit 0
fi
