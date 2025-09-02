# genai-bullet-app Backend Documentation

## Overview
The `genai-bullet-app` is a web application that utilizes the Google GenAI framework to generate bullet-point answers based on user input. The application is structured into a backend and a frontend, with the backend built using Flask.

## Backend Setup Instructions

### Prerequisites
- Python 3.x
- pip (Python package installer)

### Installation
1. Clone the repository:
   ```
   git clone <repository-url>
   cd genai-bullet-app/backend
   ```

2. Install the required dependencies:
   ```
   pip install -r requirements.txt
   ```

### Running the Flask Server
1. Navigate to the backend directory:
   ```
   cd genai-bullet-app/backend
   ```

2. Start the Flask application:
   ```
   python app.py
   ```

3. The server will run on `http://127.0.0.1:5000` by default.

## API Endpoint
- **POST /generate**
  - Description: Accepts user input text and returns a response in bullet points.
  - Request Body:
    ```json
    {
      "input_text": "Your input text here"
    }
    ```
  - Response:
    ```json
    {
      "bullets": [
        "Bullet point 1",
        "Bullet point 2",
        ...
      ]
    }
    ```

## Configuration
- Ensure that you have the necessary credentials and configurations set up for the Google GenAI framework to function correctly.

## Deployment
To deploy the application on an AWS Ubuntu server, follow these steps:
1. Set up an EC2 instance with Ubuntu.
2. Install Python and pip on the instance.
3. Clone the repository and install dependencies as described above.
4. Configure security groups to allow traffic on port 5000 (or your chosen port).
5. Run the Flask application in a production environment using a WSGI server like Gunicorn.

## Additional Notes
- Ensure that you have the appropriate permissions and API keys for using the Google GenAI framework.
- For production use, consider using a reverse proxy like Nginx to serve the Flask application.