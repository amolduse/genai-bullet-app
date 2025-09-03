const apiUrl = '/generate-bullets';

document.getElementById('generate-button').addEventListener('click', async () => {
    const userInput = document.getElementById('user-input').value;
    const responseBox = document.getElementById('response-output');
    responseBox.innerHTML = '';

    if (userInput.trim() === '') {
        responseBox.innerHTML = '<p>Please enter some text.</p>';
        return;
    }

    try {
        const response = await fetch(apiUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ text: userInput }),
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const data = await response.json();
        const bullets = data.bullets.slice(0, 10); // Limit to 10 bullets

        bullets.forEach(bullet => {
            const bulletPoint = document.createElement('li');
            bulletPoint.textContent = bullet;
            responseBox.appendChild(bulletPoint);
        });
    } catch (error) {
        responseBox.innerHTML = `<p>Error: ${error.message}</p>`;
    }
});