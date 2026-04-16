# Git & GitHub Instructions

## 📦 Initialize Git Repository

### Step 1: Initialize Local Repository
```bash
cd c:\Users\ASUS\Documents\KULIAH\PSS

# Initialize git
git init

# Add all files
git add .

# Make initial commit
git commit -m "Initial commit: Docker Compose setup for WordPress + MySQL + Redis"
```

### Step 2: Create GitHub Repository

1. Go to https://github.com/new
2. Fill details:
   - Repository name: `pss-docker-compose` (atau sesuai preference)
   - Description: "Docker Compose setup with WordPress, MySQL, and Redis"
   - Visibility: Public (untuk assignment)
   - Initialize with README: No (sudah ada)
   - Add .gitignore: No (sudah ada)

3. Copy HTTPS URL (e.g., `https://github.com/username/pss-docker-compose.git`)

### Step 3: Connect Local to Remote

```bash
# Add remote origin
git remote add origin https://github.com/username/pss-docker-compose.git

# Verify remote
git remote -v

# Expected output:
# origin  https://github.com/username/pss-docker-compose.git (fetch)
# origin  https://github.com/username/pss-docker-compose.git (push)

# Rename branch to main (if needed)
git branch -M main

# Push ke GitHub
git push -u origin main

# Output should show files being pushed
```

### Step 4: Verify GitHub

1. Refresh GitHub repository page
2. Verify files uploaded:
   - docker-compose.yml ✓
   - README.md ✓
   - COMMANDS.md ✓
   - SETUP.md ✓
   - TESTING.md ✓
   - setup-redis.sh ✓
   - verify.sh ✓
   - .env.example ✓
   - .gitignore ✓

## 📤 Making Changes & Pushing Updates

### Workflow untuk Updates

```bash
# 1. Make changes ke files
# (edit docker-compose.yml, etc)

# 2. Check status
git status

# 3. Add changes
git add .
# atau specific files:
git add docker-compose.yml README.md

# 4. Commit
git commit -m "Fix MySQL volume configuration"

# 5. Push ke GitHub
git push origin main
```

### Example Commits

```bash
# Add Redis testing
git add TESTING.md
git commit -m "Add comprehensive testing procedures for Redis"
git push

# Fix docker-compose config
git add docker-compose.yml
git commit -m "Fix service dependencies and network configuration"
git push

# Add troubleshooting
git add TESTING.md
git commit -m "Add troubleshooting guide for common issues"
git push
```

## 🏷️ Git Best Practices

### Commit Message Format
```
<type>: <subject>
<blank line>
<body>

Types:
- feat: New feature
- fix: Bug fix
- docs: Documentation
- setup: Setup/configuration
- test: Testing related
```

### Example Good Commits
```bash
git commit -m "feat: Add Redis Object Cache configuration"

git commit -m "fix: Correct MySQL password environment variable"

git commit -m "docs: Add troubleshooting guide for volume persistence"

git commit -m "setup: Initial Docker Compose configuration"
```

## 🔍 Checking Repository Status

```bash
# View commit history
git log --oneline

# View current status
git status

# View file changes
git diff docker-compose.yml

# View remote information
git remote -v
```

## 📋 Repository Checklist

- [ ] Git repository initialized locally
- [ ] GitHub repository created
- [ ] Remote origin connected
- [ ] Initial commit pushed
- [ ] All files visible on GitHub
- [ ] README.md readable on GitHub (Markdown rendered)
- [ ] Repository URL copied
- [ ] URL submitted to assignment

## 🔗 Getting Repository URL for Submission

Your GitHub repository URL will be:
```
https://github.com/YOUR_USERNAME/pss-docker-compose
```

To find it:
1. Go to your GitHub profile
2. Find repository `pss-docker-compose`
3. Click "Code" button
4. Copy HTTP link
5. Submit in assignment

## 🚀 Alternative: Using GitLab

If using GitLab instead of GitHub:

```bash
# Create new project on GitLab

# Set remote to GitLab
git remote set-url origin https://gitlab.com/username/pss-docker-compose.git

# Push
git push -u origin main
```

## 📝 Typical GitHub Repository Structure

After successful push, your GitHub should show:

```
pss-docker-compose/
├── docker-compose.yml
├── README.md
├── COMMANDS.md
├── SETUP.md
├── TESTING.md
├── setup-redis.sh
├── verify.sh
└── .env.example
```

With description: "Docker Compose setup with WordPress, MySQL, and Redis"

---

**Note**: The `.env` file should NOT be committed (protected by .gitignore)

---

**Last Updated**: April 16, 2026
