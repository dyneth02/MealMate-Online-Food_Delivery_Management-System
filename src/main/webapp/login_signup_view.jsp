<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="styles/login_signup.css">
    <title>Login Page | Sign Up</title>
    <style>
    
    </style>
</head>

<body>

    <div class="container" id="container">
        <div class="form-container sign-up">
            <form action="registerServletController" method="POST">
                <h1>Create Account</h1>
                <span>Kindly fill your Details</span>
                <input type="email" placeholder="Email" name="email">
                <input type="text" placeholder="User Name" name="username">
                <input type="password" placeholder="Password" name="password"	>
                <input type="tel" placeholder="Phone Number" name="phone">
                <input type="text" placeholder="Address" name="address">
                <input type="submit" name="submit" id="submit" value="Sign Up">
            </form>
        </div>
        <div class="form-container sign-in">
            <form action="loginServletController" method="POST">
                <h1>Sign In</h1>
                <div class="social-icons">
                    <a href="#" class="icon"><i class="fa-brands fa-google-plus-g"></i></a>
                    <a href="#" class="icon"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#" class="icon"><i class="fa-brands fa-github"></i></a>
                    <a href="#" class="icon"><i class="fa-brands fa-linkedin-in"></i></a>
                </div>
                <span>or use your email password</span>
                <input type="email" placeholder="email" name="vemail">
                <input type="password" placeholder="password" name="vpassword">
                <a href="#">Forget Your Password?</a>
                <input type="submit" name="submit" id="submit" value="Sign In">
            </form>
        </div>
        <div class="toggle-container">
            <div class="toggle">
                <div class="toggle-panel toggle-left">
                    <h1>Hello, Friend!</h1>
                    <p>Register with your personal details to use all of site features</p>
                    <button class="hidden" id="login">Sign Up</button>
                </div>
                <div class="toggle-panel toggle-right">
                    <h1>Welcome Back!</h1>
                    <p>Enter your personal details to use all of site features</p>
                    <button class="hidden" id="register">Sign In</button>
                </div>
            </div>
        </div>
    </div>

    <script src="./styles/login_signup.js"></script>
</body>

</html>