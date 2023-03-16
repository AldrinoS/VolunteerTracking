<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }

        h1 {
            font-size: 24px;
            text-align: center;
            margin-bottom: 30px;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            max-width: 500px;
            margin: 0 auto;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input[type="text"], input[type="password"] {
            padding: 8px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            width: 100%;
            box-sizing: border-box;
            margin-bottom: 20px;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: #fff;
            font-size: 16px;
            padding: 10px 0;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #3e8e41;
        }

        #registerBtn {
            margin-top: 10px;
            background-color: #af4c4c;
            color: #fff;
            font-size: 16px;
            padding: 10px 0;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }
        #registerBtn:hover {
            background-color: #8e3e3e;
        }

        #userReg {
            /*display: none;*/
        }
        #userRegInd{
            text-align: center;
        }
        #uuidInd {
            text-align: center;
        }
        #wrongCred {
            text-align: center;
            display: none;
        }
    </style>
</head>
<body>
<h1>Login</h1>
<form>
    <label for="contactNumber">Contact Number:</label>
    <input type="text" id="contactNumber" name="contactNumber" placeholder="Enter your contact number"><br>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" placeholder="Enter your password"><br>

    <input type="submit" value="Login">
    <button id="registerBtn">Create new Account</button>

    <div id="userReg">
        <p id="userRegInd">User registered successfully</p>
        <p id="uuidInd">Use temporary password: ${password}</p>
    </div>

    <div id="wrongCred">
        <p>Incorrect Username or Password!</p>
    </div>
</form>



<script>

    // Get the URL parameters as an object
    function getParams() {
        let search = window.location.search;
        let params = new URLSearchParams(search);
        let obj = {};
        for (let key of params.keys()) {
            obj[key] = params.get(key);
        }
        return obj;
    }

    // Display the parameters on the page
    function displayParams() {
        let params = getParams();
        const userRegDiv = document.getElementById("userReg");
        // let output = document.getElementById('output');
        // if(params["password"]) {
        //     console.log(params["password"]);
        //     userRegDiv.style.display = "block";
        // } else {
        //     userRegDiv.style.display = "none";
        // }
    }

    // Call the displayParams function when the page is loaded
    // window.onload = displayParams;


    const registerBtn = document.getElementById("registerBtn");
    registerBtn.addEventListener("click", (event)=>{
        event.preventDefault();

        window.location.href="/register";
    })

    window.onload = function() {
        displayParams();
    const form = document.querySelector('form');
    form.addEventListener('submit', submitForm);



    function submitForm(event) {
        event.preventDefault();
        // var contactError = document.getElementById('contact-error');
        const number = document.querySelector('#contactNumber').value;
        const password = document.querySelector('#password').value;

        const data = {
            number,
            password
        };

        console.log(data);
        const wrongCredDiv = document.getElementById("wrongCred");
        // Make a request to the backend to get the JWT token as a cookie
        fetch('/signin', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
            .then(response => {

                if(response.ok) {
                    wrongCredDiv.style.display = "none";
                    window.location.href = '/home';
                } else {
                    wrongCredDiv.style.display = "block";
                }
            })
            .catch(error => {
                console.error(error);
            });

        // .then(response => {
        //     if (!response.ok) {
        //         throw new Error('Network response was not ok');
        //     }
        //     return response.json();
        // })
        // .then(data => {
        //     console.log(data);
        //     alert('Form submitted successfully!');
        // })
        // .catch(error => {
        //     console.error(error);
        //     alert('An error occurred while submitting the form.');
        // });
    }}
</script>
</body>
</html>

