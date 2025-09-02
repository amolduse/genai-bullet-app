# genai-bullet-app frontend README

# GenAI Bullet App - Frontend

This is the frontend part of the GenAI Bullet App, which interacts with the backend to generate bullet point answers based on user input.

## Project Structure

- `index.html`: The main HTML file that contains the user interface.
- `script.js`: The JavaScript file that handles user interactions and API requests.

## Getting Started

To run the frontend application, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd genai-bullet-app/frontend
   ```

2. **Open `index.html`**:
   You can open the `index.html` file directly in your web browser. This file does not require a server to run, but for full functionality, it is recommended to serve it through a local server.

3. **Using a Local Server** (optional):
   If you want to run a local server, you can use Python's built-in HTTP server. Navigate to the `frontend` directory and run:
   ```bash
   python -m http.server
   ```
   Then, open your browser and go to `http://localhost:8000`.

## Features

- Input text box for user queries.
- Button to submit the query to the backend.
- Display area for the generated bullet points (up to 10).

## Dependencies

This frontend does not have any external dependencies, but it relies on the backend API to function correctly.

## API Integration

The frontend communicates with the backend Flask application to send user input and receive generated bullet points. Ensure that the backend is running and accessible for the frontend to work properly.

## Deployment

For deployment, you can host the frontend files on any static file hosting service or serve them through the Flask backend. Make sure to configure the API endpoint correctly in `script.js` to point to your backend server.

## License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.