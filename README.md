Follow these steps to clone the repository, set up Docker, and configure your Laravel development environment in WSL.

### Step 1: Clone the Repository

1. **Navigate to your desired project directory in WSL**:

   ```bash
   cd /home/amerloc/dev/
   ```

2. **Clone your GitHub repository**:

   ```bash
   git clone https://github.com/amerloc/Laravel-Docker-DEV.git
   ```

3. **Navigate into the cloned repository**:

   ```bash
   cd Laravel-Docker-DEV
   ```

### Step 2: Set Up Docker

1. **Create or verify your `docker-compose.yml` file** inside the project. If you already have one in your repository, you can skip this step. Otherwise, use this basic setup:

   ```yaml
   version: '3.8'

   services:
     app:
       build:
         context: .
         dockerfile: Dockerfile
       container_name: laravel_docker_app
       restart: unless-stopped
       working_dir: /var/www/html
       volumes:
         - ./:/var/www/html
         - ./docker/php/local.ini:/usr/local/etc/php/conf.d/local.ini
       ports:
         - '8000:8000'
       environment:
         APP_ENV: local
         APP_DEBUG: true
         DB_HOST: db
         DB_PORT: 3306
         DB_DATABASE: laravel_db
         DB_USERNAME: laravel_user
         DB_PASSWORD: secret
       depends_on:
         - db

     db:
       image: mysql:8.0
       container_name: laravel_docker_db
       restart: unless-stopped
       environment:
         MYSQL_DATABASE: laravel_db
         MYSQL_USER: laravel_user
         MYSQL_PASSWORD: secret
         MYSQL_ROOT_PASSWORD: rootsecret
       volumes:
         - dbdata:/var/lib/mysql
       ports:
         - '3306:3306'

     redis:
       image: redis:alpine
       container_name: laravel_docker_redis
       restart: unless-stopped
       ports:
         - '6379:6379'

   networks:
     laravel_network:
       driver: bridge

   volumes:
     dbdata:
   ```

### Step 3: Build and Start the Containers

1. **Build the Docker containers**:

   ```bash
   docker-compose up -d --build
   ```

2. **Verify the containers are running**:

   ```bash
   docker ps
   ```

### Step 4: Install Laravel (If Not Already Present)

If Laravel isn't set up in your project folder yet:

1. **Install Laravel using Composer**:

   ```bash
   docker-compose exec app composer create-project --prefer-dist laravel/laravel .
   ```

2. **Set the correct permissions for storage and cache**:

   ```bash
   docker-compose exec app chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache
   ```

3. **Generate an application key**:

   ```bash
   docker-compose exec app php artisan key:generate
   ```

### Step 5: Set Up the `.env` File

If it doesn’t exist, create an `.env` file:

1. **Copy the `.env.example` to `.env`**:

   ```bash
   cp .env.example .env
   ```

2. **Update your `.env` file with the following database information**:

   ```
   DB_CONNECTION=mysql
   DB_HOST=db
   DB_PORT=3306
   DB_DATABASE=laravel_db
   DB_USERNAME=laravel_user
   DB_PASSWORD=secret
   ```

3. **Run the migrations**:

   ```bash
   docker-compose exec app php artisan migrate
   ```

### Step 6: Access the Application

1. **Access the app via the browser**: Open `http://localhost:8000` in your browser.

### Step 7: Push Changes to GitHub

1. **Add your changes to Git**:

   ```bash
   git add .
   ```

2. **Commit the changes**:

   ```bash
   git commit -m "Initial Laravel Docker setup"
   ```

3. **Push to GitHub**:

   ```bash
   git push origin main
   ```

Now you’ve set up Laravel with Docker from scratch and connected it to your GitHub repository. Let me know if you encounter any issues!
