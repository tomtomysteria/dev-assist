#!/bin/bash

function pause() {
  read -p "🔁 Appuyez sur Entrée pour continuer..."
}

function main_menu() {
  clear
  echo "🧰 Assistant CLI - Fullstack Dev"
  echo "1) Créer un projet"
  echo "2) Commandes utiles par techno"
  echo "3) Commandes Docker"
  echo "4) Commandes Git"
  echo "5) Générer .env/.gitignore/etc."
  echo "6) Setup CI/CD"
  echo "7) Setup monorepo front+back"
  echo "8) Quitter"
  read -p "👉 Choix : " MAIN

  case $MAIN in
    1) create_project ;;
    2) command_menu ;;
    3) docker_commands ;;
    4) git_commands ;;
    5) generate_common_files ;;
    6) cicd_menu ;;
    7) setup_monorepo ;;
    8) exit 0 ;;
    *) echo "❌ Invalide" && pause && main_menu ;;
  esac
}

function create_project() {
  clear
  echo "📦 Choisissez techno :"
  echo "1) NestJS"
  echo "2) React (Vite)"
  echo "3) Next.js"
  echo "4) Spring Boot"
  echo "5) Symfony"
  echo "6) .NET Core"
  read -p "👉 Choix : " T
  read -p "📁 Nom du projet : " NAME

  case $T in
    1) npm i -g @nestjs/cli && nest new "$NAME" ;;
    2) npm create vite@latest "$NAME" -- --template react-ts && cd "$NAME" && npm install ;;
    3) npx create-next-app@latest "$NAME" --typescript ;;
    4)
      mkdir "$NAME" && cd "$NAME"
      curl https://start.spring.io/starter.zip -d dependencies=web,devtools -d language=java -d type=maven-project -d name="$NAME" -o "$NAME.zip"
      unzip "$NAME.zip" && rm "$NAME.zip"
      ;;
    5) symfony new "$NAME" --webapp ;;
    6) mkdir "$NAME" && cd "$NAME" && dotnet new webapi -n "$NAME" ;;
    *) echo "❌ Choix invalide" ;;
  esac

  pause
  main_menu
}

function command_menu() {
  clear
  echo "📚 Commandes utiles - Choisir techno"
  echo "1) NestJS"
  echo "2) React"
  echo "3) Next.js"
  echo "4) Spring Boot"
  echo "5) Symfony"
  echo "6) .NET Core"
  echo "7) Retour"
  read -p "👉 Choix : " CMD

  case $CMD in
    1) echo "nest g module <name>, nest g service <name>, npm run start:dev" ;;
    2) echo "npm run dev, npm run build, npm run preview" ;;
    3) echo "npm run dev, npm run build, npm start" ;;
    4) echo "./mvnw spring-boot:run, ./mvnw clean install, ./mvnw test" ;;
    5) echo "symfony serve, php bin/console make:controller" ;;
    6) echo "dotnet run, dotnet watch run, dotnet test" ;;
    7) main_menu ;;
    *) echo "❌ Invalide" ;;
  esac

  pause
  command_menu
}

function docker_commands() {
  clear
  echo "🐳 Docker Commands"
  echo "1) Build image             → docker build -t monimage ."
  echo "2) Lancer container        → docker run -p 3000:3000 monimage"
  echo "3) Docker Compose up       → docker-compose up -d"
  echo "4) Docker Compose down     → docker-compose down"
  echo "5) Voir containers         → docker ps"
  echo "6) Bases de données (PostgreSQL, MongoDB, Redis)"
  echo "7) Retour"
  read -p "👉 Choix : " DC

  case $DC in
    1) docker build -t monimage . ;;
    2) docker run -p 3000:3000 monimage ;;
    3) docker-compose up -d ;;
    4) docker-compose down ;;
    5) docker ps ;;
    6) docker_db_menu ;;
    7) main_menu ;;
    *) echo "❌ Invalide" ;;
  esac

  pause
  docker_commands
}

function docker_db_menu() {
  clear
  echo "🗄️ Docker - Bases de données"
  echo "1) PostgreSQL"
  echo "2) MongoDB"
  echo "3) Redis"
  echo "4) Retour"
  read -p "👉 Choix : " DB

  case $DB in
    1)
      mkdir -p docker-postgres && cd docker-postgres
      echo "version: '3.8'
services:
  db:
    image: postgres:15
    restart: always
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
      POSTGRES_DB: mydb
    ports:
      - \"5432:5432\"
    volumes:
      - pgdata:/var/lib/postgresql/data
volumes:
  pgdata:" > docker-compose.yml
      ;;
    2)
      mkdir -p docker-mongo && cd docker-mongo
      echo "version: '3.8'
services:
  mongo:
    image: mongo
    ports:
      - \"27017:27017\"
    volumes:
      - mongodata:/data/db
volumes:
  mongodata:" > docker-compose.yml
      ;;
    3)
      mkdir -p docker-redis && cd docker-redis
      echo "version: '3.8'
services:
  redis:
    image: redis
    ports:
      - \"6379:6379\"
    volumes:
      - redisdata:/data
volumes:
  redisdata:" > docker-compose.yml
      ;;
    4) docker_commands ;;
    *) echo "❌ Invalide" ;;
  esac

  pause
  docker_db_menu
}

function git_commands() {
  clear
  echo "🔃 Git Commands"
  echo "1) Init repo             → git init"
  echo "2) Add all               → git add ."
  echo "3) Commit                → git commit -m "message""
  echo "4) Add remote            → git remote add origin URL"
  echo "5) Push vers main        → git push origin main"
  echo "6) Retour"
  read -p "👉 Choix : " GIT

  case $GIT in
    1) git init ;;
    2) git add . ;;
    3) read -p "Message : " MSG && git commit -m "$MSG" ;;
    4) read -p "Remote URL : " URL && git remote add origin "$URL" ;;
    5) git push origin main ;;
    6) main_menu ;;
    *) echo "❌ Invalide" ;;
  esac

  pause
  git_commands
}

function generate_common_files() {
  echo "🔧 Génération des fichiers utiles (.env, .gitignore, etc.)"
  echo "# Exemple d'environnement" > .env
  echo "# Exemple d'environnement" > .env.example
  echo "node_modules/
.env
dist/
coverage/" > .gitignore
  echo "root = true

[*]
indent_style = space
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true" > .editorconfig
  echo "✅ Fichiers générés"
  pause
  main_menu
}

function cicd_menu() {
  clear
  echo "🔁 CI/CD - Choisissez votre pipeline"
  echo "1) GitHub Actions (Node.js)"
  echo "2) GitLab CI (Node.js)"
  echo "3) Retour"
  read -p "👉 Choix : " CI

  case $CI in
    1)
      mkdir -p .github/workflows
      echo "name: Node CI
on:
  push:
    branches: [ main ]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci
      - run: npm run build
      - run: npm test" > .github/workflows/node.yml
      ;;
    2)
      echo "stages:
  - install
  - test
  - build

install-deps:
  stage: install
  script:
    - npm ci

test:
  stage: test
  script:
    - npm test

build:
  stage: build
  script:
    - npm run build" > .gitlab-ci.yml
      ;;
    3) main_menu ;;
    *) echo "❌ Invalide" ;;
  esac

  echo "✅ Fichier CI/CD généré"
  pause
  cicd_menu
}

function setup_monorepo() {
  clear
  echo "🧩 Création d’un monorepo front + back avec Docker"
  mkdir -p monorepo/front monorepo/back && cd monorepo

  cd front
  npm create vite@latest . -- --template react-ts && npm install
  echo "VITE_API_URL=http://localhost:3000" > .env
  cd ../back
  npm install -g @nestjs/cli
  nest new . --skip-git
  echo "PORT=3000" > .env
  cd ..

  echo "version: '3.8'
services:
  frontend:
    build: ./front
    ports:
      - '5173:5173'
    volumes:
      - ./front:/app
    working_dir: /app
    command: npm run dev

  backend:
    build: ./back
    ports:
      - '3000:3000'
    volumes:
      - ./back:/app
    working_dir: /app
    command: npm run start:dev" > docker-compose.yml

  echo "✅ Monorepo prêt avec front + back synchronisés"
  pause
  main_menu
}

main_menu
