<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="ourDate" class="java.util.Date"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "java.io.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Form</title>
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

        input[type="text"], input[type="date"] {
            padding: 8px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            width: 100%;
            box-sizing: border-box;
            margin-bottom: 20px;
        }

        #registerBtn {
            background-color: #4CAF50;
            color: #fff;
            font-size: 16px;
            padding: 10px 0;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }

        #registerBtn:hover {
            background-color: #3e8e41;
        }

        #loginBtn{
            background-color: #af4c4c;
            color: #fff;
            font-size: 16px;
            padding: 10px 0;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            margin-top: 10px;
        }

        #loginBtn:hover {
            background-color: #8e3e3e;
        }

        #contact-error {
            text-align: center;
        }
    </style>
</head>
<body>
<h1>Registration Form</h1>
<form id="myForm" action="/registerUser" method="GET">
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" placeholder="Enter your name"><br>

    <label for="contactNumber">Contact Number:</label>
    <input type="text" id="contactNumber" name="number" placeholder="Enter your contact number"><br>

    <label for="location">Location:</label>
    <input type="text" id="location" name="location" placeholder="Enter your location"><br>

    <label for="DOB">Date of Birth:</label>
    <input type="date" id="DOB" name="date"><br>
<%--    <span id="age-error" style="color: red;"></span>--%>

    <button id="registerBtn" type="submit" value="Register">Register</button>
    <button id="loginBtn">Login</button>
    <p id="contact-error" style="color: red;">${registerFailed}</p>
</form>


<script>
    const loginBtn = document.getElementById("loginBtn");
    loginBtn.addEventListener("click", (event)=>{
        event.preventDefault();

        window.location.href="/login";
    })

    window.onload = function() {
        let failMsg = document.getElementById("contact-error").innerText;
        if(failMsg) {
            alert(failMsg)
        }

        var dobInput = document.getElementById('DOB');
        // var ageError = document.getElementById('age-error');

        dobInput.addEventListener('change', function() {
            var dob = new Date(this.value);
            var now = new Date();
            var age = now.getFullYear() - dob.getFullYear();
            var monthDiff = now.getMonth() - dob.getMonth();
            if (monthDiff < 0 || (monthDiff === 0 && now.getDate() < dob.getDate())) {
                age--;
            }

            if (age < 10) {
                // ageError.innerHTML = 'You must be at least 10 years old to register.';
                dobInput.setCustomValidity('You must be at least 10 years old to register.');
            } else {
                // ageError.innerHTML = '';
                dobInput.setCustomValidity('');
            }
        });

        function generateUUID() {
            var d = new Date().getTime();
            if (typeof performance !== 'undefined' && typeof performance.now === 'function'){
                d += performance.now();
            }
            var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
                var r = (d + Math.random()*16)%16 | 0;
                d = Math.floor(d/16);
                return (c=='x' ? r : (r & 0x3 | 0x8)).toString(16);
            });
            return uuid;
        }



        // const form = document.querySelector('form');
        // form.addEventListener('submit', submitForm);
        //
        // function submitForm(event) {
        //     event.preventDefault();
        //     var contactError = document.getElementById('contact-error');
        //     const name = document.querySelector('#name').value;
        //     const number = document.querySelector('#contactNumber').value;
        //     const location = document.querySelector('#location').value;
        //     const date = document.querySelector('#DOB').value;
        //
        //
        //     var password = generateUUID();
        //
        //     const data = {
        //         name: name,
        //         number: number,
        //         location: location,
        //         date: date,
        //         password: password
        //     };
        //
        //     const xhr = new XMLHttpRequest();
        //     const url = "/registerUser";
        //     // const requestBody = {
        //     //     username: "johndoe",
        //     //     password: "password123"
        //     // };
        //
        //     xhr.open("POST", url, true);
        //     xhr.setRequestHeader("Content-Type", "application/json");
        //
        //     xhr.onreadystatechange = function() {
        //         if (xhr.status === 200) {
        //             contactError.innerHTML = '';
        //             console.log("Form Submitted")
        //             window.location.href = xhr.responseURL;
        //             // const xhr2 = new XMLHttpRequest();
        //             // xhr2.open("GET", "/loginRedirect");
        //             // xhr2.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        //             // // xhr2.onload = function() {
        //             // //     if (xhr2.status === 200) {
        //             // //         // handle successful response
        //             // //     } else {
        //             // //
        //             // //     }
        //             // // }
        //             // xhr2.send(JSON.stringify(data));
        //             // window.location.href = "/login?pass="+password;
        //             // window.location.href = "/loginRedirect";
        //
        //         } else {
        //             contactError.innerHTML = 'User with given contact number already exists.';
        //             console.log(xhr.status);
        //             throw new Error('Network response was not ok');
        //         }
        //     };
        //
        //     xhr.send(JSON.stringify(data));
        //
        //
        //     // fetch('/registerUser', {
        //     //     method: 'POST',
        //     //     headers: {
        //     //         'Content-Type': 'application/json'
        //     //     },
        //     //     body: JSON.stringify(data)
        //     // })
        //     //     .then(response => {
        //     //         console.log(response.body);
        //     //         if (!response.ok) {
        //     //
        //     //             contactError.innerHTML = 'User with given contact number already exists.';
        //     //             throw new Error('Network response was not ok');
        //     //         }
        //     //         contactError.innerHTML = '';
        //     //         // alert('Form submitted successfully!');
        //     //         window.location.href = "/login?pass="+password;
        //     //
        //     //     })
        //     //     .catch(error => {
        //     //         console.error(error);
        //     //         console.log('An error occurred while submitting the form.');
        //     //     });
        //
        //     // .then(response => {
        //     //     if (!response.ok) {
        //     //         throw new Error('Network response was not ok');
        //     //     }
        //     //     return response.json();
        //     // })
        //     // .then(data => {
        //     //     console.log(data);
        //     //     alert('Form submitted successfully!');
        //     // })
        //     // .catch(error => {
        //     //     console.error(error);
        //     //     alert('An error occurred while submitting the form.');
        //     // });
        // }
    }
    function generateUUID() {
        var d = new Date().getTime();
        if (typeof performance !== 'undefined' && typeof performance.now === 'function'){
            d += performance.now();
        }
        var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
            var r = (d + Math.random()*16)%16 | 0;
            d = Math.floor(d/16);
            return (c=='x' ? r : (r & 0x3 | 0x8)).toString(16);
        });
        return uuid;
    }
    // function submitForm(event) {
    //     event.preventDefault();
    //     var contactError = document.getElementById('contact-error');
    //     const name = document.querySelector('#name').value;
    //     const number = document.querySelector('#contactNumber').value;
    //     const location = document.querySelector('#location').value;
    //     const date = document.querySelector('#DOB').value;
    //
    //     var password = generateUUID();
    //
    //     const data = {
    //         name: name,
    //         number: number,
    //         location: location,
    //         date: date,
    //         password: password
    //     };
    //
    //     const xhr = new XMLHttpRequest();
    //     const url = "/registerUser";
    //     // const requestBody = {
    //     //     username: "johndoe",
    //     //     password: "password123"
    //     // };
    //
    //     xhr.open("POST", url, true);
    //     xhr.setRequestHeader("Content-Type", "application/json");
    //
    //     xhr.onreadystatechange = function () {
    //         if (xhr.status === 200) {
    //             contactError.innerHTML = '';
    //             window.location.href = "/login?pass="+password;
    //             // window.location.href = "www.google.com";
    //
    //         } else {
    //             contactError.innerHTML = 'User with given contact number already exists.';
    //             console.log(xhr.status);
    //             throw new Error('Network response was not ok');
    //         }
    //     };
    //
    //     xhr.send(JSON.stringify(data));
    // }

    // var form = document.getElementById('myForm');
    //
    // form.addEventListener('submit', function(event) {
    //     event.preventDefault(); // prevent the default form submission
    //     var contactError = document.getElementById('contact-error');
    //     var formData = new FormData(form);
    //     try {
    //         form.submit(); // submit the form
    //         contactError.innerText = "";
    //     }catch (e) {
    //         contactError.innerHTML = 'User with given contact number already exists.';
    //     }
    //
    // });

    // fetch('/registerUser', {
    //     method: 'POST',
    //     headers: {
    //         'Content-Type': 'application/json'
    //     },
    //     body: JSON.stringify(data)
    // })
    //     .then(response => {
    //         console.log(response.body);
    //         if (!response.ok) {
    //
    //             contactError.innerHTML = 'User with given contact number already exists.';
    //             throw new Error('Network response was not ok');
    //         }
    //         contactError.innerHTML = '';
    //         // alert('Form submitted successfully!');
    //         window.location.href = "/login?pass="+password;
    //
    //     })
    //     .catch(error => {
    //         console.error(error);
    //         console.log('An error occurred while submitting the form.');
    //     });

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


</script>
</body>
</html>
