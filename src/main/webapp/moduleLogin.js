export function handleLoginError() {
    const errorMessage = document.getElementById('error-message');
    if (errorMessage) {
        // Highlight the error message or form
        errorMessage.style.color = 'red';
        errorMessage.style.fontWeight = 'bold';
        
        // Optionally add more UI changes or logic
        console.log("Invalid credentials provided");
    }
}
