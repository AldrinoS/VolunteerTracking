<%@ include file="common/header.jspf" %>
<%--<%@ include file="common/navigation.jspf" %>--%>

<h1>Create Event</h1>
<div class="container">
<form:form method="POST" modelAttribute="ngoEvent">
    <fieldset class="mb-3">
        <form:label path="contactNumber">Contact Number</form:label>
        <form:input type="text" path="contactNumber" required="required"/>
        <form:errors path="contactNumber" cssClass="text-warning"/>
    </fieldset>

    <fieldset class="mb-3">
        <form:label path="eventName">Event Name</form:label>
        <form:input type="text" path="eventName" required="required"/>
        <form:errors path="eventName" cssClass="text-warning"/>
    </fieldset>

    <fieldset class="mb-3">
        <form:label path="eventDesc">Event Description</form:label>
        <form:input type="text" path="eventDesc" required="required"/>
        <form:errors path="eventDesc" cssClass="text-warning"/>
    </fieldset>

    <fieldset class="mb-3">
        <form:label path="eventLocation">Event Location</form:label>
        <form:input type="text" path="eventLocation" required="required"/>
        <form:errors path="eventLocation" cssClass="text-warning"/>
    </fieldset>

    <fieldset class="mb-3">
        <form:label path="eventDate">Event Date</form:label>
        <form:input type="text" path="eventDate" required="required"/>
        <form:errors path="eventDate" cssClass="text-warning"/>
    </fieldset>
    <input type="submit" class="btn btn-success">
</form:form>
</div>

<%@ include file="common/footer.jspf" %>