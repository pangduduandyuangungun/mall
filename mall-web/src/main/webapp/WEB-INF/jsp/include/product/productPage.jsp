
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<title>商品展示 ${p.name}</title>
<div class="categoryPictureInProductPageDiv">
	<img class="categoryPictureInProductPage" src="/static/img/category/2.jpg">
</div>

<div class="productPageDiv">

	<%@include file="imgAndInfo.jsp" %>
	
	<%@include file="productReview.jsp" %>
	
	<%@include file="productDetail.jsp" %>
</div>