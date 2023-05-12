<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Navigation Bar</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }

        nav {
            background-color: #333;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            width: auto;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        nav a {
            color: #fff;
            text-decoration: none;
            margin: 0 20px;
            font-size: 16px;
            text-transform: uppercase;
        }

        nav a:hover {
            color: #ff0;
        }

        nav button {
            background-color: #4caf50;
            color: #fff;
            font-size: 16px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-left: auto;
        }

        nav button:hover {
            background-color: #3e8e41;
        }

        .nav-item {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            padding: 50px;
        }

        .info {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
        }

        .events {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
        }

        .events li {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: space-between;
            transition: transform 0.2s ease-in-out;
            cursor: pointer;
        }

        .events li:hover {
            transform: scale(1.02);
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.2);
        }

        .events li h2 {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
            color: #333333;
        }

        .events li p {
            margin: 0;
            font-size: 16px;
            color: #666666;
        }

        .events li .date {
            font-size: 16px;
            color: #999999;
            margin-left: auto;
        }

        .events li .volunteers {
            font-size: 16px;
            color: #999999;
            /* margin-left: 20px; */
        }

        button {
            background-color: #4c68af;
            color: #fff;
            font-size: 16px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-left: auto;
        }

        button:hover {
            background-color: #3b528a;
        }

        #createEventBtn {
            height: min-content;
            margin: auto 0;
        }

        /* style the popup box */
        .popup-box {
            border-radius: 5px;
            background-color: #fff;
            border: 1px solid #bbb;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            padding: 20px;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            max-width: 90%;
            z-index: 9999;
            font-family: sans-serif;
            font-size: 16px;
            line-height: 1.5;
            color: #333;
        }

        /* style the popup box title */
        .popup-box h2 {
            margin-top: 0;
            font-size: 24px;
            font-weight: bold;
            text-align: center;
            color: #444;
        }

        /* style the popup box content */
        .popup-box label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .popup-box input {
            display: block;
            width: 100%;
            margin-bottom: 15px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        /* style the popup box close button */
        .popup-box button {
            display: block;
            margin: 0 auto;
            padding: 10px 20px;
            background-color: #008000;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<%--<p id="datePara">Date:</p>--%>
<nav>
    <div class="nav-item">
        <a id="myEvents" href="#">My Events</a>
        <a id="volunteeredEvents" href="#">Events Volunteered For</a>
        <a id="upcomingEvents" href="#">Upcoming NGO Events</a>
    </div>
    <!--<button>Create NGO Event</button>-->
    <button onclick="logoutUser()">Logout</button>
</nav>

<div class="info">
    <h1 id="heading">Upcoming Events</h1>
    <button onclick="renderCreateEventPage()" id="createEventBtn">Create new Event</button>
</div>

<ul class="events"></ul>
<div id="popupBox" class="popup-box" style="display: none">
    <h2>Event Information</h2>
    <p id="eventName">Event Name:</p>
    <p id="eventDesc">Event Description:</p>
    <p id="eventLoc">Event Location:</p>
    <p id="eventDate">Event Date:</p>
    <p id="eventVolunteers">Number of Volunteers:</p>
    <button onclick="hidePopup()">Close</button>
</div>
</body>
<script>

    function renderCreateEventPage() {
        window.location.href="/create-event";
    }

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



    // Get a reference to the events list in the HTML template
    var eventsList = document.querySelector(".events");
    var headingTag = document.getElementById("heading");
    // var datePara = document.getElementById("datePara");
    // datePara.innerText = "Date: " + new Date().toISOString();

    var data = [
        {
            id:1,
            eventAdmin:'1',
            contactNumber:'1234',
            eventName:'Sample 1',
            eventDesc:'Sample 1 Desc',
            eventLocation:'Kerala',
            eventDate:'2023-03-18',
            noOfVolunteers:12,
            volunteers:["1232"]
        },
        {
            id:6,
            eventAdmin:'1',
            contactNumber:'1234',
            eventName:'Sample 1',
            eventDesc:'Sample 1 Desc',
            eventLocation:'Kerala',
            eventDate:'2023-03-18',
            noOfVolunteers:0,
            volunteers:[]
        },
        {
            id:6,
            eventAdmin:'1',
            contactNumber:'1234',
            eventName:'Sample 1',
            eventDesc:'Sample 1 Desc',
            eventLocation:'Kerala',
            eventDate:'2023-03-18',
            noOfVolunteers:0,
            volunteers:[]
        },
        {
            id:6,
            eventAdmin:'1',
            contactNumber:'1234',
            eventName:'Sample 1',
            eventDesc:'Sample 1 Desc',
            eventLocation:'Kerala',
            eventDate:'2023-03-18',
            noOfVolunteers:0,
            volunteers:[]
        },
    ];

    getEventData();

    // fetch('/get-events', {
    //     method: 'GET'
    // })
    //     .then(response => {
    //
    //         if (response.ok) {
    //             response.text().then((resp=>{
    //                 console.log(resp)
    //                 var responseData = JSON.parse(resp);
    //                 data = responseData;
    //                 handleMyEvents();
    //             }))
    //         } else {
    //             throw new Error('Network response was not ok');
    //         }
    //
    //     })
    //     .catch(error => {
    //         console.error(error);
    //         alert('An error occurred while submitting the form.');
    //     });

    var myEventsAnchor = document.getElementById("myEvents");
    var volunteeredEventsAnchor = document.getElementById("volunteeredEvents");
    var upcomingEventsAnchor = document.getElementById("upcomingEvents");

    myEventsAnchor.addEventListener("click", () => handleMyEvents(), false);
    volunteeredEventsAnchor.addEventListener(
        "click",
        () => handleVolunteeredEvents(),
        false
    );
    upcomingEventsAnchor.addEventListener(
        "click",
        () => handleUpcomingEvents(),
        false
    );

    function getEventData() {
        // fetch('/get-events', {
        //     method: 'GET'
        // })
        //     .then(response => {
        //
        //         if (response.ok) {
        //             response.text().then((resp=>{
        //                 console.log(resp)
        //                 var responseData = JSON.parse(resp);
        //                 data = responseData;
        //                 handleMyEvents();
        //             }))
        //         } else {
        //             throw new Error('Network response was not ok');
        //         }
        //
        //     })
        //     .catch(error => {
        //         console.error(error);
        //         alert('An error occurred while submitting the form.');
        //     });

        const xhr = new XMLHttpRequest();
        const url = "/get-events";

        xhr.open("GET", url, true);
        xhr.setRequestHeader("Content-Type", "application/json");

        xhr.onreadystatechange = function () {
            if (xhr.status === 200) {
                let resp = xhr.responseText;
                console.log(resp)
                var responseData = JSON.parse(resp);
                data = responseData;
                handleMyEvents();

            } else {
                throw new Error('Network response was not ok');
            }
        };

        xhr.send();
    }


    function handleMyEvents() {
        // getEventData();
        var newData = data.filter(function (d) {
            return d.eventAdmin == getCookie("User");
        });
        var listSelect = document.querySelectorAll("li");
        headingTag.innerText = "My Events";
        removeList(listSelect);
        renderList(newData);
    }

    function handleVolunteeredEvents() {
        // getEventData();
        var newData = data.filter(function (d) {
            return d.volunteers.indexOf(getCookie("User"))!==-1;
        });
        var listSelect = document.querySelectorAll("li");
        headingTag.innerText = "Volunteered Events";
        removeList(listSelect);
        renderList(newData);
    }

    function isFutureDate(inputDate) {
        var inputDateArray = inputDate.split('-');
        var day = parseInt(inputDateArray[2], 10);
        var month = parseInt(inputDateArray[1], 10) - 1; // month starts from 0 in JavaScript Date object
        var year = parseInt(inputDateArray[0], 10);

        var currentDate = new Date(); // current date
        var inputDateObject = new Date(year, month, day); // input date

        return inputDateObject.getTime() > currentDate.getTime();
    }

    function handleUpcomingEvents() {
        // getEventData();
        var newData = data.filter(function (d) {
            return isFutureDate(d.eventDate);
        });
        var listSelect = document.querySelectorAll("li");
        headingTag.innerText = "Upcoming Events";
        removeList(listSelect);
        renderList(newData);
    }

    function removeList(list) {
        list.forEach((l) => {
            l.remove();
        });
    }

    function renderList(data) {
        // Loop through the array of event objects
        data.forEach((item)=>{
            // Create a new list item element
            var listItem = document.createElement("li");

            // Create a new div element for the event details
            var detailsDiv = document.createElement("div");

            // Create a new h2 element for the event name
            var nameHeader = document.createElement("h2");
            nameHeader.textContent = item.eventName;
            detailsDiv.appendChild(nameHeader);

            // Create a new p element for the event location
            var locationParagraph = document.createElement("p");
            locationParagraph.textContent = "Location: " + item.eventLocation;
            detailsDiv.appendChild(locationParagraph);

            // Append the details div to the list item element
            listItem.appendChild(detailsDiv);

            // Create a new div element for the event date and number of volunteers
            var infoDiv = document.createElement("div");

            // Create a new p element for the event date
            var dateParagraph = document.createElement("p");
            dateParagraph.classList.add("date");
            dateParagraph.textContent = "Date: " + item.eventDate;
            infoDiv.appendChild(dateParagraph);

            // Create a new p element for the number of volunteers
            var volunteersParagraph = document.createElement("p");
            volunteersParagraph.classList.add("volunteers");
            volunteersParagraph.textContent =
                "No of Volunteers: " + item.noOfVolunteers;
            infoDiv.appendChild(volunteersParagraph);

            // Append the info div to the list item element
            listItem.appendChild(infoDiv);

            var buttonDiv = document.createElement("div");
            var volunteerButton = document.createElement("button");
            volunteerButton.textContent = "Volunteer";
            var id = item.id;

            if(getCookie("User")==item.eventAdmin) {
                volunteerButton.style.background = "grey";
                volunteerButton.textContent = "Owner";
            } else if(item.volunteers.indexOf(getCookie("User"))!==-1) {
                volunteerButton.style.background = "grey";
                volunteerButton.textContent = "Volunteer Request Sent";
            } else {
                volunteerButton.addEventListener("click",()=>handleVolunteerEvent(item.eventName, id), false);
            }

            buttonDiv.appendChild(volunteerButton);

            infoDiv.addEventListener("click", () => showPopup(id), false);
            listItem.appendChild(buttonDiv);

            // Append the list item to the events list in the HTML template
            eventsList.appendChild(listItem);
        })
    }

    function handleVolunteerEvent(eventName, eventId) {
        console.log("Clicked " + eventName);

        let userId = getCookie("User");
        fetch('/update-event-volunteers?userId='+userId+"&eventId="+eventId, {
            method: 'PATCH'
        })
            .then(response => {
                if(response.ok) {
                    console.log(eventName+" updated")
                    data.forEach((item)=>{
                        if(item.id == eventId) {
                            item.noOfVolunteers = item.noOfVolunteers+1;
                            item.volunteers.push(getCookie("User"))
                            // item.volunteers = [...item.volunteers, getCookie("User")];
                        }
                    });
                    handleUpcomingEvents();
                }
            })
            .catch(error => {
                console.error(error);
            });

    }

    // show the popup box
    function showPopup(index) {
        var popupBox = document.getElementById("popupBox");
        var eventName = document.getElementById("eventName");
        var eventDesc = document.getElementById("eventDesc");
        var eventLoc = document.getElementById("eventLoc");
        var eventDate = document.getElementById("eventDate");
        var eventVolunteers = document.getElementById("eventVolunteers");

        var currentItem = data.filter(function (item) {
            return item.id == index;
        });
        eventName.innerText = "Event Name: " + currentItem[0].eventName;
        eventDesc.innerText = "Event Description: " + currentItem[0].eventDesc;
        eventLoc.innerText = "Event Location: " + currentItem[0].eventLocation;
        eventDate.innerText = "Event Date: " + currentItem[0].eventDate;
        eventVolunteers.innerText =
            "No of Volunteers: " + currentItem[0].noOfVolunteers;
        popupBox.style.display = "block";
    }

    function logoutUser() {
        // fetch('/logoutUser', {
        //     method: 'GET'
        // })
        //     .then(response => {
        //         if(response.ok) {
        //             // console.log("Logged Out")
        //             window.location.href="/login";
        //         }
        //     })
        //     .catch(error => {
        //         console.error(error);
        //     });
        alert("Logged Out Successfully!")
        const xhr = new XMLHttpRequest();
        const url = "/logoutUser";

        xhr.open("GET", url, true);
        xhr.setRequestHeader("Content-Type", "application/json");

        xhr.onreadystatechange = function () {
            if (xhr.status === 200) {

            } else {
                throw new Error('Network response was not ok');
            }
        };

        xhr.send();
    }

    // hide the popup box
    function hidePopup() {
        var popupBox = document.getElementById("popupBox");
        popupBox.style.display = "none";
    }
</script>
</html>

<!-- <p id="eventName">Event Name:</p>
<p id="eventDesc">Event Description:</p>
<p id="eventLoc">Event Location:</p>
<p id="eventDate">Event Date:</p>
<p id="eventVolunteers">Number of Volunteers:</p> -->
