<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<script type="text/javascript">
$(document).ready(
		function (){
			setSearchPForm();
});
function setSearchPForm() {
	var q="${q}";
	$("input[name='q']").val(q);
}
function searchSubmit() {
	var $sInput=$("#searchPForm div input[name='q']");
	var q=$sInput.val();
	if (q!='') $('#searchPForm').submit();
	else $sInput.focus();
}
</script>
<nav class="navbar navbar-default">
  <div class="container-fluid">
<div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${pageContext.request.contextPath}">WOODWORK</a>
        </div>
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <form id="searchPForm" action="${pageContext.request.contextPath}/search" class="navbar-form navbar-left" method="GET">
        <div class="form-group">
          <input name="q" type="text" class="form-control" placeholder="Search">
        </div>
        <button onclick="searchSubmit()" type="button" class="btn btn-default">GO</button>
      </form>
      <ul class="nav navbar-nav navbar-right">
      <sec:authorize access="!isAuthenticated()">
      <li><a href="${pageContext.request.contextPath}/login">Log in</a></li>
      <li><a href="${pageContext.request.contextPath}/registration">Sign up</a></li>
      </sec:authorize>
      <sec:authorize access="hasRole('ROLE_ADMIN')">
        <li><a href="${pageContext.request.contextPath}/admin">Admin profile</a></li>
      </sec:authorize>
      <sec:authorize access="isAuthenticated()">
        <li><a href="${pageContext.request.contextPath}/cart">Cart</a></li>
        <li><a onclick="formSubmit()" href="javascript:void(0)">Log out</a></li>
        </sec:authorize>
        
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
<c:url value="/logout" var="logoutUrl" />
			<form action="${logoutUrl}" method="post" id="logoutForm">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
			<script>
				function formSubmit() {
					document.getElementById("logoutForm").submit();
				}
			</script>