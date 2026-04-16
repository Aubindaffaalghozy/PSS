# 📋 Project Index & Getting Started Guide

## 🎯 Quick Start (< 5 minutes)

**New to this project? Start here:**

```bash
# 1. Navigate to project
cd c:\Users\ASUS\Documents\KULIAH\PSS

# 2. Start all containers
docker-compose up -d

# 3. Wait 5 seconds, then visit
http://localhost:8000

# 4. Complete WordPress installation wizard
# (Use default values: wordpress_db, wordpress_user, wordpress_password)

# 5. Done! Now read further documentation...
```

---

## 📁 File Guide

### 🚀 Getting Started Files

| File | Purpose | Read When |
|------|---------|-----------|
| **README.md** | Complete documentation | First - overview of everything |
| **SETUP.md** | Step-by-step implementation | Step-by-step walkthrough |
| **docker-compose.yml** | Main configuration | Need to understand services |

### 🔧 Configuration & Reference

| File | Purpose | Read When |
|------|---------|-----------|
| **.env.example** | Environment variables template | Need to customize settings |
| **COMMANDS.md** | Quick command reference | Need quick Docker commands |
| **GIT_INSTRUCTIONS.md** | GitHub submission guide | Ready to push to GitHub |

### 🧪 Testing & Troubleshooting

| File | Purpose | Read When |
|------|---------|-----------|
| **TESTING.md** | Detailed testing procedures | Testing or debugging |
| **verify.sh** | Automated verification script | After setup, run for verification |
| **setup-redis.sh** | Redis installation script | Want to enable Redis caching |

### 📝 Assignment Completion

| File | Purpose | Read When |
|------|---------|-----------|
| **ANSWERS.md** | Answer sheet for 4 questions | Before submission |
| **SCREENSHOTS.md** | Screenshot requirements | Taking submission screenshots |
| **INDEX.md** | This file | You're here! |

---

## 🎓 Learning Path

### 1️⃣ Understand the Setup (15 min)
```
Read: README.md
  ↓
Understand:
  - 3 services: WordPress, MySQL, Redis
  - Volumes for persistence
  - Docker networking
```

### 2️⃣ Implement the Setup (10 min)
```
Follow: SETUP.md
  ↓
Execute:
  docker-compose up -d
  ✓ All 3 services running
```

### 3️⃣ Test Everything (15 min)
```
Follow: TESTING.md
  ↓
Verify:
  ✓ WordPress accessible (http://localhost:8000)
  ✓ MySQL connected (create test post)
  ✓ Redis working (PING → PONG)
```

### 4️⃣ Answer Questions (15 min)
```
Read: ANSWERS.md
  ↓
Understand:
  Q1: Why volumes for MySQL?
  Q2: What's depends_on?
  Q3: WordPress ↔ MySQL connection?
  Q4: Redis advantages?
```

### 5️⃣ Take Screenshots (10 min)
```
Follow: SCREENSHOTS.md
  ↓
Capture:
  ✓ WordPress installation
  ✓ WordPress dashboard
  ✓ docker-compose ps
  ✓ Redis PING
  ✓ Test post
```

### 6️⃣ Submit to GitHub (10 min)
```
Follow: GIT_INSTRUCTIONS.md
  ↓
Execute:
  git init
  git add .
  git commit -m "Initial commit"
  git push to GitHub
  ✓ Repository URL ready
```

**Total Time**: ~75 minutes

---

## 🎯 By Task

### "I want to run WordPress quickly"
→ Read: **SETUP.md** (Step 1-4)
→ Run: `docker-compose up -d`
→ Visit: http://localhost:8000

### "I need to test if everything works"
→ Read: **TESTING.md**
→ Run: `bash verify.sh`
→ Follow test procedures

### "I need quick Docker commands"
→ Read: **COMMANDS.md**
→ Copy-paste as needed

### "I need to enable Redis caching"
→ Run: `bash setup-redis.sh`
→ Follow: **README.md** → Redis Setup section

### "I forgot what something does"
→ Read: **ANSWERS.md** (for theory)
→ Read: **README.md** (for concepts)

### "I'm ready to submit"
→ Follow: **GIT_INSTRUCTIONS.md**
→ Capture: **SCREENSHOTS.md**
→ Answer: **ANSWERS.md** prepared

### "Something broke, help!"
→ Read: **TESTING.md** → Troubleshooting section
→ Run: `docker-compose logs`
→ Run: `bash verify.sh`

---

## 📊 Assignment Grading Criteria

| Criteria | Weight | Evidence |
|----------|--------|----------|
| docker-compose.yml correct | 35% | All services configured properly |
| Services running (WordPress accessible) | 25% | Screenshot of working WordPress |
| Data persistence (volumes) | 15% | Data survives container restart |
| Redis integration (bonus) | 10% | Redis cache working |
| Documentation & screenshots | 10% | All files + 5 screenshots |
| Question answers | 5% | 4 questions answered in ANSWERS.md |

**Target Score**: 100% ✓

---

## 🚀 Common Workflows

### Workflow 1: First-Time Setup
```
1. Read: README.md (understand what you're doing)
2. Execute: docker-compose up -d (start services)
3. Wait: 5 seconds
4. Visit: http://localhost:8000
5. Complete: WordPress installation wizard
6. Success! WordPress + MySQL + Redis running
```

### Workflow 2: Daily Development
```
1. Morning: docker-compose start
2. Work: Create posts, modify settings
3. Lunch: docker-compose stop (pause)
4. Work: docker-compose start (resume)
5. Evening: docker-compose stop (stop)
6. Avoid: docker-compose down -v (delete data)
```

### Workflow 3: New Feature Testing
```
1. Create test post: http://localhost:8000/wp-admin
2. Verify MySQL: docker-compose logs mysql
3. Check Redis: docker exec redis_cache redis-cli PING
4. Test functionality
5. Commit changes: git add . && git commit -m "message"
```

### Workflow 4: Submission Ready
```
1. Final test: docker-compose down -v && docker-compose up -d
2. Take screenshots: Follow SCREENSHOTS.md
3. Review ANSWERS.md: Check all answers complete
4. Push to GitHub: git push origin main
5. Submit URL: Copy repository URL
6. Done! ✓
```

---

## ⚡ Essential Commands Reference

```bash
# View all files
ls -la

# Start services
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs

# Stop services
docker-compose stop

# Remove containers (keep data)
docker-compose down

# Delete everything
docker-compose down -v

# Run verification
bash verify.sh

# Setup Redis
bash setup-redis.sh

# Access WordPress
http://localhost:8000

# Redis CLI
docker exec redis_cache redis-cli

# MySQL CLI
docker exec mysql_db mysql -u wordpress_user -p
# Password: wordpress_password
```

---

## ✅ Pre-Submission Checklist

- [ ] docker-compose.yml created and tested
- [ ] All 3 services (WordPress, MySQL, Redis) running
- [ ] WordPress accessible at http://localhost:8000
- [ ] WordPress installed and dashboard accessible
- [ ] Test post created in WordPress
- [ ] MySQL connection verified
- [ ] Redis connection verified (PING works)
- [ ] Data persists after container restart
- [ ] All documentation files complete (README.md, ANSWERS.md, etc)
- [ ] 5 screenshots taken and stored
- [ ] Git repository created and pushed to GitHub
- [ ] Repository URL ready for submission

**Status**: Ready when all items checked ✅

---

## 🆘 Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| Can't access http://localhost:8000 | Wait 20 sec, check: `docker-compose ps` |
| WordPress connection error | Verify MySQL running: `docker-compose logs mysql` |
| Port 8000 already in use | Change port: edit docker-compose.yml |
| Data disappeared | You used `docker-compose down -v` (was mistake) |
| Redis not working | Check: `docker exec redis_cache redis-cli PING` |
| Forgot password | Check docker-compose.yml for credentials |

**More help**: See **TESTING.md** → Troubleshooting section

---

## 📚 File Dependencies

```
README.md
  ├── docker-compose.yml (referenced)
  ├── ANSWERS.md (theory background)
  └── TESTING.md (testing procedures)

SETUP.md
  ├── docker-compose.yml (step-by-step)
  └── README.md (concepts)

TESTING.md
  ├── docker-compose (testing commands)
  └── COMMANDS.md (reference)

ANSWERS.md
  ├── README.md (background)
  ├── SETUP.md (implementation)
  └── DOCKER-COMPOSE.yml (reference)

GIT_INSTRUCTIONS.md
  ├── All source files (to commit)
  ├── .gitignore (exclude sensitive data)
  └── GitHub account (to push)

SCREENSHOTS.md
  ├── docker-compose.yml (to run)
  ├── README.md (for context)
  └── Browser + Terminal (to capture)
```

---

## 🎯 Success Criteria

Your setup is **successful** when:

✅ **Infrastructure:**
- All 3 containers running
- Custom bridge network created
- 3 volumes for persistence

✅ **Functionality:**
- WordPress dashboard accessible
- Database connected (posts saveable)
- Redis responding to PING
- Data persists after restart

✅ **Documentation:**
- README.md complete
- ANSWERS.md with 4 answers
- 5 screenshots captured
- Scripts working (verify.sh, setup-redis.sh)

✅ **Submission:**
- GitHub repository created
- All files pushed
- URL submitted

---

## 📞 Getting Help

1. **Check documentation**:
   - README.md (overview)
   - TESTING.md (debugging)
   - ANSWERS.md (concepts)

2. **Run verification**:
   ```bash
   bash verify.sh
   ```

3. **Check logs**:
   ```bash
   docker-compose logs
   docker-compose logs wordpress
   docker-compose logs mysql
   docker-compose logs redis
   ```

4. **Test manually**:
   - WordPress: http://localhost:8000
   - MySQL: `docker exec mysql_db mysql -u wordpress_user -p`
   - Redis: `docker exec redis_cache redis-cli PING`

---

## 🎓 Learning Outcomes

After completing this assignment, you will understand:

1. **Docker & Docker Compose**
   - Services, containers, images
   - Networking and volumes
   - Environment variables

2. **Multi-Container Architecture**
   - Service dependencies
   - Inter-service communication
   - Data persistence strategies

3. **WordPress Deployment**
   - WordPress with MySQL
   - WordPress configuration
   - Performance optimization (Redis)

4. **DevOps Practices**
   - Infrastructure as Code (docker-compose.yml)
   - Container orchestration
   - Testing and verification
   - Version control (Git)

---

## 📈 Next Steps After Assignment

1. **Explore Advanced Docker**:
   - Docker networking deep dive
   - Docker volumes advanced
   - Health checks

2. **Production Deployment**:
   - Deploy to cloud (AWS, GCP, Azure)
   - SSL/TLS certificates
   - Database backups

3. **WordPress Advanced**:
   - Custom themes
   - Custom plugins
   - Performance optimization

4. **DevOps Skills**:
   - Kubernetes (container orchestration)
   - CI/CD pipelines
   - Infrastructure monitoring

---

**🎉 You're ready to get started!**

**Start here**: 
1. Read: `README.md`
2. Execute: `docker-compose up -d`
3. Visit: `http://localhost:8000`
4. Continue reading documentation for instructions...

---

**Last Updated**: April 16, 2026  
**Version**: 1.0  
**Status**: Complete & Ready for Deployment ✅
