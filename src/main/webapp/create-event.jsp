<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="ourDate" class="java.util.Date" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <title>Event Form</title>
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

        input[type="text"], input[type="date"], textarea {
            padding: 8px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            width: 100%;
            box-sizing: border-box;
            margin-bottom: 20px;
        }

        textarea {
            height: 100px;
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
    </style>
</head>
<body>
<h1>Event Form</h1>
<form>
    <label for="eventName">Event Name:</label>
    <input type="text" id="eventName" name="eventName" placeholder="Enter event name"><br>

    <label for="eventDescription">Event Description:</label>
    <textarea id="eventDescription" name="eventDescription" placeholder="Enter event description"></textarea><br>

    <label for="eventLocation">Event Location:</label>
    <input type="text" id="eventLocation" name="eventLocation" placeholder="Enter event location"><br>

    <label for="eventDate">Event Date:</label>
    <input type="date" id="eventDate" name="eventDate"><br>

    <input type="submit" value="Submit">
</form>
<script>
    const form = document.querySelector('form');
    form.addEventListener('submit', submitForm);

    function getCookie(name) {
        // Split the cookie string into individual cookies
        var cookies = document.cookie.split(';');

        // Loop through each cookie
        for(var i = 0; i < cookies.length; i++) {
            console.log(cookies[i]);
            var cookie = cookies[i].trim();

            // If the cookie name matches the name we're looking for
            if(cookie.startsWith(name + '=')) {
                // Return the cookie value
                return cookie.substring(name.length + 1);
            }
        }

        // If we didn't find the cookie, return null
        return null;
    }

    // Example usage:
    // var userCookie = getCookie('User');
    // if(userCookie) {
    //     console.log('User cookie value:', userCookie);
    // } else {
    //     console.log('User cookie not found.');
    // }


    function submitForm(event) {
        event.preventDefault();
        const contactNumber = "1234";
        const eventName = document.querySelector('#eventName').value;
        const eventDesc = document.querySelector('#eventDescription').value;
        const eventLocation = document.querySelector('#eventLocation').value;
        const eventDate = document.querySelector('#eventDate').value;
        const noOfVolunteers = 0;

        // let cookies = document.cookie.split(";");
        // let user = cookies.filter((cookie)=>{
        //     return cookie.includes("User")
        // })
        // let userDetail = user[0].split("=");
        // let adminNumber = userDetail[1];

        var eventAdmin = getCookie('User');

        const data = {
            eventAdmin,
            contactNumber,
            eventName,
            eventDesc,
            eventLocation,
            eventDate,
            noOfVolunteers
        };

        fetch('/add-event', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                window.location.href = "/home";

            })
            .catch(error => {
                console.error(error);
                alert('An error occurred while submitting the form.');
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
    }
</script>
</body>
</html>

