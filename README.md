# Laravel-Docker-DEV

## Installation

To install the project using Visual Studio Code (VSC), follow these steps:

1. **Clone the repository:**
    - Open Visual Studio Code.
    - Open the Command Palette (`Ctrl+Shift+P` or `Cmd+Shift+P` on macOS).
    - Type `Git: Clone` and select it.
    - Enter the repository URL: `https://github.com/yourusername/security-company-project.git`.
    - Choose a directory to clone the repository into.
    - Open the cloned repository in VSC.

2. **Install dependencies:**
    - Open a new terminal in VSC (`Ctrl+``).
    - Ensure you are in the project directory.
    - Run:
    ```bash
    npm install
    ```

3. **Set up environment variables:**
    - In the root directory, create a `.env` file.
    - Add the following variables:
    ```plaintext
    DATABASE_URL=your_database_url
    API_KEY=your_api_key
    ```

4. **Run the application:**
    - In the terminal, run:
    ```bash
    npm start
    ```

## Configuration

To modify the project, consider the following:

1. **Database Configuration:**
    Update the `DATABASE_URL` in the `.env` file to point to your database. This URL should include the protocol, username, password, host, port, and database name.

2. **API Keys:**
    Ensure the `API_KEY` in the `.env` file is set to your specific API key. This key is essential for accessing third-party services and APIs.

3. **Port Configuration:**
    To change the default port, update the `PORT` variable in the `.env` file:
    ```plaintext
    PORT=your_desired_port
    ```

4. **Custom Settings:**
    Modify any additional settings in the `config` directory as needed. This may include settings for logging, authentication, and other application-specific configurations.

## Additional Information

For more detailed documentation, refer to the [Wiki](https://github.com/yourusername/security-company-project/wiki). The Wiki contains comprehensive guides on various aspects of the project, including deployment, troubleshooting, and advanced configuration options.

