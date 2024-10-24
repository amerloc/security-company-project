### System Requirements

Before you begin, ensure you have the following installed on your system:

- **Docker**: [Install Docker](https://docs.docker.com/get-docker/)
- **Docker Compose**: [Install Docker Compose](https://docs.docker.com/compose/install/)
- **Git**: [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- **WSL (Windows Subsystem for Linux)** (if you are using Windows): [Install WSL](https://docs.microsoft.com/en-us/windows/wsl/install)

### Step 1: Clone the Repository

1. **Navigate to your desired project directory in WSL**:

   ```bash
   cd /home/amerloc/dev/
   ```

2. **Clone your GitHub repository**:

   ```bash
   git clone https://github.com/amerloc/security-company-project.git
   ```

3. **Navigate into the cloned repository**:

   ```bash
   cd security-company-project
   ```

### Step 2: Set Up Docker

1. **Create or verify your `docker-compose.yml` file** inside the project. If you already have one in your repository, you can skip this step. Otherwise, use this basic setup:

   ```yaml
   services:
      app:
         build:
            context: ./security-company  # Use the 'security-company' folder as the build context
            dockerfile: ../Dockerfile    # Dockerfile is outside the 'security-company' folder
         container_name: security_laravel_app
         restart: unless-stopped
         working_dir: /var/www/html/security-company  # Set working directory inside 'security-company'
         user: "${UID:-1000}:${GID:-1000}"  # Use UID and GID with fallback to 1000
         volumes:
            - ./security-company:/var/www/html/security-company  # Mount the 'security-company' folder
            - ./docker/php/local.ini:/usr/local/etc/php/conf.d/local.ini  # Custom PHP config
         ports:
            - '8000:8000'
         environment:
            APP_ENV: local
            APP_DEBUG: true
            APP_KEY: base64:your_app_key_here  # Set dynamically after installation
            DB_HOST: db
            DB_PORT: 3306
            DB_DATABASE: laravel_db
            DB_USERNAME: laravel_user
            DB_PASSWORD: secret
            UID: "${UID:-1000}"  # Use environment variable UID, default to 1000
            GID: "${GID:-1000}"  # Use environment variable GID, default to 1000
         networks:
            - laravel_network
         depends_on:
            - db
         command: php artisan serve --host=0.0.0.0 --port=8000

      db:
         image: mysql:8.0
         container_name: security_db
         restart: unless-stopped
         environment:
            MYSQL_DATABASE: laravel_db
            MYSQL_USER: laravel_user
            MYSQL_PASSWORD: secret
            MYSQL_ROOT_PASSWORD: rootsecret
         volumes:
            - dbdata:/var/lib/mysql
            - ./docker/mysql/my.cnf:/etc/mysql/my.cnf
         ports:
            - '3306:3306'
         networks:
            - laravel_network
         healthcheck:
            test: ["CMD-SHELL", "mysqladmin ping -h localhost"]
            interval: 10s
            retries: 5
            start_period: 30s
            timeout: 5s

      redis:
         image: redis:6.2-alpine
         container_name: security_redis
         restart: unless-stopped
         networks:
            - laravel_network
         volumes:
            - redisdata:/data
         ports:
            - '6379:6379'

   networks:
      laravel_network:
         name: security-company-project_laravel_network
         driver: bridge

   volumes:
      dbdata:
      redisdata:
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

### Instructions for Running Laravel Commands

To run migrations:

```bash
docker-compose exec app php artisan migrate
```

To generate an application key:

```bash
docker-compose exec app php artisan key:generate
```

Now you’ve set up Laravel with Docker from scratch and connected it to your GitHub repository. Let me know if you encounter any issues!

