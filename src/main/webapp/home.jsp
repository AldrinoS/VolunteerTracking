<%@ include file="common/header.jspf" %>
<%@ include file="common/navigation.jspf" %>

<c:forEach items="${events}" var="event">
    <div class="card">
        <div class="card-body">
            <div class="container text-center">
                <div class="row align-items-center">
                    <div class="col">
                        <h2>${event.eventName}</h2>
                        <p>${event.eventLocation}</p>
                    </div>
                    <div class="col">
                        <p>${event.eventDate}</p>
                        <p>${event.noOfVolunteers}</p>
                    </div>
                    <div class="col">
                        <c:choose>
                            <c:when test="${event.username=='aldrino'}">
                                <a href="#" class="btn disabled">Owner</a>
                            </c:when>
                            <c:when test="${event.volunteers.contains('aldrino')}">
                                <a href="#" class="btn disabled">Volunteered</a>
                            </c:when>
                            <c:when test="${event.username!='aldrino'}">
                                <a href="/volunteer-event?eventId=${event.id}" class="btn btn-warning">Volunteer</a>
                            </c:when>
                            <c:otherwise>

                            </c:otherwise>
                        </c:choose>

<%--                        <c:if test="${event.username=='aldrino'}">--%>
<%--                            <a href="#" class="btn disabled">Owner</a>--%>
<%--                        </c:if>--%>
<%--                        <c:if test="${event.username!='aldrino'}">--%>
<%--                            <a href="/volunteer-event?eventId=${event.id}" class="btn btn-warning">Volunteer</a>--%>
<%--                        </c:if>--%>
<%--                        <c:if test="${event.volunteers.contains('aldrino')}">--%>
<%--                            <a href="#" class="btn disabled">Volunteered</a>--%>
<%--                        </c:if>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:forEach>


<%@ include file="common/footer.jspf" %>