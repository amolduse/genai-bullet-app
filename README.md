# genai-bullet-app

This project is a web application that utilizes the Google GenAI framework to generate bullet-point answers based on user input. The application is structured into a backend and a frontend, allowing for a clear separation of concerns.

## Project Structure

```
genai-bullet-app
├── backend
│   ├── app.py
│   ├── requirements.txt
│   └── README.md
├── frontend
│   ├── index.html
│   ├── script.js
│   └── README.md
└── README.md
```

## Backend

The backend is built using Flask and serves as the API for the application. It processes user input and generates responses using the Google GenAI framework.

### Setup Instructions

1. Navigate to the `backend` directory.
2. Install the required dependencies:
   ```
   pip install -r requirements.txt
   ```
3. Run the Flask application:
   ```
   python app.py
   ```

### API Endpoint

The backend exposes an API endpoint that accepts user input and returns a response formatted in bullet points, limited to 10 bullets.

## Frontend

The frontend is a simple web application that allows users to input text and receive generated bullet points.

### Setup Instructions

1. Open the `frontend/index.html` file in a web browser.
2. Ensure that the backend server is running to process requests.

## Deployment

To deploy this application on an AWS Ubuntu server:

1. Set up an Ubuntu server instance on AWS.
2. Install Python, Flask, and any other necessary dependencies.
3. Clone this repository to the server.
4. Follow the backend setup instructions to run the Flask application.
5. Configure the server to allow traffic on the port used by Flask (default is 5000).
6. Access the application via the server's public IP address.

## License

This project is licensed under the MIT License.