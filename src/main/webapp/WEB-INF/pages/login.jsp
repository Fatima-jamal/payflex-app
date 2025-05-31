<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login - Digital Payment Portal</title>
<style>
    body {
        background-color: #f4f4f4;
        font-family: Arial, sans-serif;
    }

    .container {
        width: 400px;
        margin: 100px auto;
        padding: 30px;
        background-color: white;
        box-shadow: 0px 0px 10px rgba(0,0,0,0.2);
        border-radius: 10px;
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
        color: #333;
    }

    .error {
        color: red;
        text-align: center;
        margin-bottom: 10px;
    }

    label {
        display: block;
        margin: 10px 0 5px;
    }

    input[type="text"], input[type="password"] {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .btn-group {
        margin-top: 20px;
        text-align: center;
    }

    input[type="submit"], input[type="reset"] {
        padding: 10px 20px;
        border: none;
        background-color: #007BFF;
        color: white;
        margin: 0 10px;
        border-radius: 5px;
        cursor: pointer;
    }

    input[type="submit"]:hover, input[type="reset"]:hover {
        background-color: #0056b3;
    }

    .register-link {
        text-align: center;
        margin-top: 15px;
    }

    .register-link a {
        color: #007BFF;
        text-decoration: none;
    }

    .register-link a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>

<div class="container">
    <h2>Login to Your Account</h2>

    <c:if test="${not empty errorMessage}">
        <div class="error">${errorMessage}</div>
    </c:if>

    <form method="post" action="login">
        <label for="userName">Username:</label>
        <input type="text" name="userName" id="userName" required />

        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required />

        <div class="btn-group">
            <input type="submit" value="Login" />
            <input type="reset" value="Reset" />
        </div>

        <div class="register-link">
            New user? <a href="register">Register Here</a>
        </div>
    </form>
</div>

</body>
</html>
